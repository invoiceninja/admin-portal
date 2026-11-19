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
import 'package:invoiceninja_flutter/ui/app/beta_promo/move_support.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

/// Decides when the prompt to move to the new app is shown and remembers
/// what the user did with it. Shown on a schedule counting down to
/// [kSunsetDate] (see [isMovePromptDue]), and never turned off for good: the
/// date is the reason to keep reminding.
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

  /// The user has started installing, so the prompt opens on the sign-in
  /// details
  bool hasEngaged = false;

  SharedPreferences? _prefs;
  StreamSubscription<AppState>? _subscription;
  Timer? _timer;
  DateTime? _lastShown;
  int? _settledAt;
  bool _isStarted = false;
  bool _wasShown = false;

  static bool get isAvailable {
    if (!kBetaPromoEnabled) {
      return false;
    } else if (kIsWeb && !kBetaPromoEnabledOnWeb) {
      return false;
    } else if (isApple() && !kBetaPromoEnabledOnApple) {
      return false;
    } else if (isAndroid() && !kBetaPromoEnabledOnAndroid) {
      return false;
    }

    return true;
  }

  // White-labeled installs included, they are retired along with the rest
  static bool allowsState(AppState state) => !state.isDemo && !Config.DEMO_MODE;

  bool showsEntryFor(AppState state) => showEntry.value && allowsState(state);

  Future<void> start(Store<AppState> store) async {
    if (_isStarted || !isAvailable) {
      return;
    }
    _isStarted = true;

    try {
      final prefs = _prefs = await SharedPreferences.getInstance();
      final shownAt = prefs.getInt(kSharedPrefMovePromoShownAt);
      _lastShown = shownAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(shownAt);
      hasEngaged = prefs.getBool(kSharedPrefMovePromoEngaged) ?? false;
    } catch (error) {
      print('## ERROR: failed to load the move promo state - $error');
      return;
    }

    showEntry.value = true;

    if (!_isDue) {
      return;
    }

    _subscription = store.onChange.listen((_) => _check(store));
    _check(store);
  }

  bool get _isDue =>
      !_wasShown &&
      isMovePromptDue(
        now: DateTime.now(),
        lastShown: _lastShown,
        sunset: kSunsetDate,
      );

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

  /// The prompt is on screen, whether it opened itself or the user opened it,
  /// and won't open itself again until the schedule says so. Saved now rather
  /// than when it closes, the store can take this app out of memory.
  void markShown() {
    _wasShown = true;
    _stop();

    final now = DateTime.now();
    _lastShown = now;

    _save(
      (prefs) =>
          prefs.setInt(kSharedPrefMovePromoShownAt, now.millisecondsSinceEpoch),
    );
  }

  /// The user started installing, so the prompt opens on the sign-in details
  /// from now on
  void markEngaged() {
    if (hasEngaged) {
      return;
    }

    hasEngaged = true;

    _save((prefs) => prefs.setBool(kSharedPrefMovePromoEngaged, true));
  }

  // On the web a full localStorage makes the write throw
  Future<void> _save(Future<void> Function(SharedPreferences) write) async {
    try {
      await write(_prefs ??= await SharedPreferences.getInstance());
    } catch (error) {
      print('## ERROR: failed to save the move promo state - $error');
    }
  }
}
