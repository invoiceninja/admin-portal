// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_dialog.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/app_review.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

/// The invitation is closed at most this many times before it stops returning
const int kBetaPromoMaxCloses = 3;

/// How long the invitation stays away after its nth close, null once it has
/// been closed often enough to stop
Duration? betaPromoSnooze(int closes) {
  switch (closes) {
    case 1:
      return const Duration(days: 7);
    case 2:
      return const Duration(days: 30);
  }

  return null;
}

/// Decides when the invitation to the beta of the new app is shown and
/// remembers what the user did with it.
///
/// The state lives in SharedPreferences rather than PrefState so it survives a
/// logout without touching the generated serializers, and can be deleted along
/// with this folder once the new app replaces this one.
class BetaPromoController {
  BetaPromoController._();

  static final BetaPromoController instance = BetaPromoController._();

  // The invitation belongs to the start of a session. Once the account has
  // been loaded for this long the moment has passed, and showing it then
  // would interrupt whatever the user has since started.
  static const Duration _startupWindow = Duration(seconds: 45);

  /// Whether the sidebar row and the dashboard card are offered
  final ValueNotifier<bool> showEntry = ValueNotifier<bool>(false);

  /// The user has started installing, so the invitation opens on the sign-in
  /// details and no longer shows itself
  bool hasEngaged = false;

  SharedPreferences? _prefs;
  StreamSubscription<AppState>? _subscription;
  Timer? _timer;
  int _closes = 0;
  int _nextAt = 0;
  int? _settledAt;
  String _windowsRequest = '';
  bool _isDone = false;
  bool _isStarted = false;
  bool _wasShown = false;

  static bool get isAvailable {
    if (!kBetaPromoEnabled || DateTime.now().isAfter(kBetaPromoEndDate)) {
      return false;
    } else if (kIsWeb && !kBetaPromoEnabledOnWeb) {
      return false;
    } else if (isApple() && !kBetaPromoEnabledOnApple) {
      return false;
    } else if (isAndroid() &&
        (!kBetaPromoEnabledOnAndroid || !AppReview.isStoreBuild)) {
      // The beta isn't published on F-Droid, which is where the FOSS build of
      // this app is installed from
      return false;
    }

    return true;
  }

  static bool allowsState(AppState state) =>
      !state.isDemo && !Config.DEMO_MODE && !state.isWhiteLabeled;

  bool showsEntryFor(AppState state) => showEntry.value && allowsState(state);

  /// Closing it this time is the last time it shows itself
  bool get isLastReminder => _closes >= kBetaPromoMaxCloses - 1;

  Future<void> start(Store<AppState> store) async {
    if (_isStarted || !isAvailable) {
      return;
    }
    _isStarted = true;

    try {
      final prefs = _prefs = await SharedPreferences.getInstance();
      _closes = prefs.getInt(kSharedPrefBetaPromoCloses) ?? 0;
      _nextAt = prefs.getInt(kSharedPrefBetaPromoNextAt) ?? 0;
      _isDone = prefs.getBool(kSharedPrefBetaPromoDone) ?? false;
      hasEngaged = prefs.getBool(kSharedPrefBetaPromoEngaged) ?? false;
      _windowsRequest = prefs.getString(kSharedPrefBetaPromoWindowsEmail) ?? '';
    } catch (error) {
      print('## ERROR: failed to load the beta promo state - $error');
      return;
    }

    showEntry.value = !_isDone;

    if (!_isDue) {
      return;
    }

    _subscription = store.onChange.listen((_) => _check(store));
    _check(store);
  }

  bool get _isDue =>
      !_wasShown &&
      !_isDone &&
      _closes < kBetaPromoMaxCloses &&
      DateTime.now().millisecondsSinceEpoch >= _nextAt;

  // The account is loaded and the user isn't in the middle of something
  bool _isIdle(AppState state) {
    final uiState = state.uiState;

    return allowsState(state) &&
        _isLoaded(state) &&
        state.isUserConfirmed &&
        !state.isSaving &&
        !uiState.isEditing &&
        !uiState.isEmailing &&
        !(uiState.isInSettings && uiState.settingsUIState.isChanged);
  }

  bool _isLoaded(AppState state) =>
      state.authState.isAuthenticated && state.isLoaded && !state.isLoading;

  // Timed from when the account first finishes loading rather than from
  // launch, a large account can take longer than the window to load
  bool _hasMissedStartup(AppState state) {
    final now = DateTime.now().millisecondsSinceEpoch;

    if (_settledAt == null && _isLoaded(state)) {
      _settledAt = now;
    }

    return now - (_settledAt ?? now) > _startupWindow.inMilliseconds;
  }

  // The app pops whichever route is on top once a save completes, so the
  // invitation is only shown over a page, never over another dialog. The
  // pages shown before the app itself don't count: the main screen is pushed
  // over them a frame later and would bury it.
  bool get _isTopRouteAppPage {
    Route<dynamic>? topRoute;
    navigatorKey.currentState?.popUntil((route) {
      topRoute = route;
      return true;
    });

    final name = topRoute?.settings.name;

    return topRoute is PageRoute &&
        name != Navigator.defaultRouteName &&
        name != LoginScreen.route;
  }

  void _check(Store<AppState> store) {
    if (_timer != null) {
      return;
    } else if (!_isDue || _hasMissedStartup(store.state)) {
      _stop();
      return;
    } else if (!_isIdle(store.state)) {
      return;
    }

    _timer = Timer(const Duration(milliseconds: 600), () {
      _timer = null;

      if (!_isDue || !_isIdle(store.state) || !_isTopRouteAppPage) {
        // The next change to the store checks again
        return;
      }

      showBetaPromoDialog();
    });
  }

  void _stop() {
    _subscription?.cancel();
    _subscription = null;
    _timer?.cancel();
    _timer = null;
  }

  /// The invitation is on screen, whether it opened itself or the user opened
  /// it, and won't open itself again this session
  void markShown() {
    _wasShown = true;
    _stop();
  }

  /// The invitation was closed without being acted on
  void snooze() {
    _closes++;
    final delay = betaPromoSnooze(_closes);
    _nextAt = delay == null
        ? 0
        : DateTime.now().add(delay).millisecondsSinceEpoch;

    _save((prefs) async {
      await prefs.setInt(kSharedPrefBetaPromoCloses, _closes);
      await prefs.setInt(kSharedPrefBetaPromoNextAt, _nextAt);
    });
  }

  /// The user started installing. Saved straight away rather than when the
  /// invitation closes, the store can take this app out of memory. The
  /// sidebar row stays for the sign-in details.
  void markEngaged() {
    if (hasEngaged) {
      return;
    }

    hasEngaged = true;
    _closes = kBetaPromoMaxCloses;

    _save((prefs) async {
      await prefs.setBool(kSharedPrefBetaPromoEngaged, true);
      await prefs.setInt(kSharedPrefBetaPromoCloses, _closes);
    });
  }

  /// The user installed the beta or asked not to be shown it again
  void finish() {
    _isDone = true;
    showEntry.value = false;

    _save((prefs) => prefs.setBool(kSharedPrefBetaPromoDone, true));
  }

  /// The Microsoft account an invite was requested for by [accountEmail],
  /// empty if none. Kept per account, this device may be shared.
  String windowsEmailFor(String accountEmail) {
    final parts = _windowsRequest.split('\n');

    return parts.length == 2 && parts.first == accountEmail ? parts.last : '';
  }

  void saveWindowsEmail(String accountEmail, String email) {
    _windowsRequest = '$accountEmail\n$email';

    _save(
      (prefs) =>
          prefs.setString(kSharedPrefBetaPromoWindowsEmail, _windowsRequest),
    );
  }

  // On the web a full localStorage makes the write throw
  Future<void> _save(Future<void> Function(SharedPreferences) write) async {
    try {
      await write(_prefs ??= await SharedPreferences.getInstance());
    } catch (error) {
      print('## ERROR: failed to save the beta promo state - $error');
    }
  }
}
