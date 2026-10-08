// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_controller.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_strings.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_widgets.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

enum BetaPlatform { ios, macos, android, windows, linux }

/// The platform the beta would be installed on, which on the web is the one
/// the browser is running on
BetaPlatform? currentBetaPlatform() {
  if (isIOS()) {
    return BetaPlatform.ios;
  } else if (isMacOS()) {
    return BetaPlatform.macos;
  } else if (isAndroid()) {
    return BetaPlatform.android;
  } else if (isWindows()) {
    return BetaPlatform.windows;
  } else if (isLinux()) {
    return BetaPlatform.linux;
  }

  switch (getNativePlatform()) {
    case kPlatformiPhone:
      return BetaPlatform.ios;
    case kPlatformMacOS:
      return BetaPlatform.macos;
    case kPlatformAndroid:
      return BetaPlatform.android;
    case kPlatformWindows:
      return BetaPlatform.windows;
    case kPlatformLinux:
      return BetaPlatform.linux;
  }

  // The user agent is only there when the server adds it to the page
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      return BetaPlatform.ios;
    case TargetPlatform.macOS:
      return BetaPlatform.macos;
    case TargetPlatform.android:
      return BetaPlatform.android;
    case TargetPlatform.windows:
      return BetaPlatform.windows;
    case TargetPlatform.linux:
      return BetaPlatform.linux;
    case TargetPlatform.fuchsia:
      return null;
  }
}

class BetaFeature {
  const BetaFeature(this.icon, this.title, this.body);

  final IconData icon;
  final BetaStr title;
  final BetaStr body;
}

/// The strongest reasons to switch for this user, most convincing first
List<BetaFeature> betaPromoFeatures({
  required bool isPhone,
  required bool hasTasks,
  required bool hasExpenses,
  required bool hasDesigner,
  required int count,
}) {
  const offline = BetaFeature(
    Icons.cloud_off_outlined,
    BetaStr.offlineTitle,
    BetaStr.offlineBody,
  );
  const dashboard = BetaFeature(
    Icons.dashboard_customize_outlined,
    BetaStr.dashboardTitle,
    BetaStr.dashboardBody,
  );
  const tasks = BetaFeature(
    Icons.calendar_month_outlined,
    BetaStr.tasksTitle,
    BetaStr.tasksBody,
  );
  const big = BetaFeature(
    Icons.bolt_outlined,
    BetaStr.bigTitle,
    BetaStr.bigBody,
  );

  final features = isPhone
      ? [
          offline,
          dashboard,
          if (hasExpenses)
            const BetaFeature(
              Icons.receipt_long_outlined,
              BetaStr.receiptTitle,
              BetaStr.receiptBody,
            ),
          const BetaFeature(
            Icons.phone_in_talk_outlined,
            BetaStr.callsTitle,
            BetaStr.callsBody,
          ),
          if (hasTasks) tasks,
          big,
        ]
      : [
          offline,
          dashboard,
          // Saving a design is part of the pro plan
          if (hasDesigner)
            const BetaFeature(
              Icons.design_services_outlined,
              BetaStr.designerTitle,
              BetaStr.designerBody,
            ),
          if (hasTasks) tasks,
          const BetaFeature(Icons.tab, BetaStr.tabsTitle, BetaStr.tabsBody),
          big,
        ];

  return features.take(count).toList();
}

/// Labels which name something elsewhere in the app, so they use its words.
/// The rest of the dialog has its own, a few of the app's are mistranslated.
class BetaPromoLabels {
  const BetaPromoLabels({required this.email, required this.setPassword});

  final String email;
  final String setPassword;
}

/// Invites the user to the beta of the new app. Opened by
/// [BetaPromoController] once the account has loaded, and by hand from the
/// sidebar, the dashboard and the about dialog.
Future<void> showBetaPromoDialog({bool isManual = false}) async {
  // Always the app's own navigator. The sidebar wraps its rows in a theme of
  // its own, which a dialog opened from one of them would inherit.
  final context = navigatorKey.currentContext;
  if (context == null) {
    return;
  }

  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final user = state.user;
  final localization = AppLocalization.of(context)!;
  final controller = BetaPromoController.instance;
  final strings = BetaPromoStrings(localization.localeCode);
  final isDark = state.prefState.enableDarkMode;
  final platform = currentBetaPlatform();
  // The switch has to hold on the web too, where the browser may be Android's
  final devicePlatform =
      platform == BetaPlatform.android && !kBetaPromoEnabledOnAndroid
      ? null
      : platform;

  // Before anything is awaited, so it can't also open itself meanwhile
  controller.markShown();

  void copy(String value) {
    Clipboard.setData(ClipboardData(text: value));

    final preview = value.length > 30 ? '${value.substring(0, 30)}...' : value;
    showToast(
      localization.copiedToClipboard.replaceFirst(':value', '"$preview"'),
    );
  }

  // The default mode opens store links inside an in-app browser on mobile,
  // which can't hand off to TestFlight or Google Play
  Future<bool> launch(String url) async {
    try {
      return await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } catch (error) {
      return false;
    }
  }

  // Goes through the contact us endpoint, which the server emails to us with
  // the user set as the reply-to. Leaving out send_logs keeps a selfhosted
  // server from attaching its logs.
  Future<bool> requestWindowsAccess(String email) async {
    try {
      await WebClient().post(
        '${state.credentials.url}/support/messages/send',
        state.credentials.token,
        data: json.encode({
          'message':
              '[Windows beta access] Please add this Microsoft account to the Windows beta: $email',
          'platform': getPlatformLetter(),
          'version': state.appVersion,
        }),
      );
    } catch (error) {
      return false;
    }

    controller.saveWindowsEmail(user.email, email);
    return true;
  }

  // Decoded up front so the screenshots are there on the first frame
  await Future.wait([
    for (final asset in betaPromoHeroAssets(isDark))
      precacheImage(AssetImage(asset), context),
  ]);

  if (!context.mounted) {
    return;
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final dialog = BetaPromoDialog(
        strings: strings,
        labels: BetaPromoLabels(
          email: localization.email,
          setPassword: localization.setPassword,
        ),
        devicePlatform: devicePlatform,
        showPlatformChips: kIsWeb,
        // Apple rejects apps which mention other platforms
        showOtherPlatforms: !isApple(),
        showQr: [
          BetaPlatform.macos,
          BetaPlatform.windows,
          BetaPlatform.linux,
        ].contains(devicePlatform),
        isSnap: isInvoiceNinjaSnap(),
        isDark: isDark,
        isManual: isManual,
        email: user.email,
        serverUrl: state.isSelfHosted ? cleanApiUrl(state.authState.url) : '',
        needsPassword: !user.hasPassword && user.oauthProvider.isNotEmpty,
        hasTasks: state.company.isModuleEnabled(EntityType.task),
        hasExpenses: state.company.isModuleEnabled(EntityType.expense),
        hasDesigner: state.isProPlan || state.isTrial,
        hasEngaged: controller.hasEngaged,
        isLastReminder: controller.isLastReminder,
        windowsEmail: controller.windowsEmailFor(user.email),
        onLaunch: launch,
        onRequestWindowsAccess: requestWindowsAccess,
        onCopy: copy,
        onSnooze: controller.snooze,
        onEngaged: controller.markEngaged,
        onFinish: controller.finish,
        // Without the user the form edits whichever one settings last held,
        // which is a blank one until settings has been opened
        onSetPassword: () => store.dispatch(
          ViewSettings(
            section: kSettingsUserDetails,
            user: store.state.user,
            company: store.state.company,
          ),
        ),
      );

      return PointerInterceptor(
        // Copy which falls back to English reads left to right
        child: strings.isTranslated
            ? dialog
            : Directionality(textDirection: TextDirection.ltr, child: dialog),
      );
    },
  );
}

/// The invitation itself. Takes plain values rather than reading the store so
/// it can be rendered on its own.
class BetaPromoDialog extends StatefulWidget {
  const BetaPromoDialog({
    Key? key,
    required this.strings,
    required this.labels,
    required this.devicePlatform,
    required this.showPlatformChips,
    required this.showOtherPlatforms,
    required this.showQr,
    required this.isSnap,
    required this.isDark,
    required this.isManual,
    required this.email,
    required this.serverUrl,
    required this.needsPassword,
    required this.hasTasks,
    required this.hasExpenses,
    required this.hasDesigner,
    required this.hasEngaged,
    required this.isLastReminder,
    required this.windowsEmail,
    required this.onLaunch,
    required this.onRequestWindowsAccess,
    required this.onCopy,
    required this.onSnooze,
    required this.onEngaged,
    required this.onFinish,
    required this.onSetPassword,
  }) : super(key: key);

  final BetaPromoStrings strings;
  final BetaPromoLabels labels;
  final BetaPlatform? devicePlatform;
  final bool showPlatformChips;
  final bool showOtherPlatforms;
  final bool showQr;
  final bool isSnap;
  final bool isDark;

  /// Opened by the user rather than shown to them, so closing it isn't
  /// counted against the number of times it comes back
  final bool isManual;
  final String email;

  /// Empty for a hosted account
  final String serverUrl;
  final bool needsPassword;
  final bool hasTasks;
  final bool hasExpenses;
  final bool hasDesigner;

  /// Opened again after starting to install, what's left is to sign in
  final bool hasEngaged;

  /// It won't show itself again after this, so it doesn't offer to
  final bool isLastReminder;

  /// The address an invite was already requested for, empty if none
  final String windowsEmail;
  final Future<bool> Function(String url) onLaunch;
  final Future<bool> Function(String email) onRequestWindowsAccess;
  final void Function(String value) onCopy;
  final VoidCallback onSnooze;

  /// The user has started to install, which is the end of the reminders
  final VoidCallback onEngaged;
  final VoidCallback onFinish;
  final VoidCallback onSetPassword;

  @override
  State<BetaPromoDialog> createState() => _BetaPromoDialogState();
}

enum _Step { pitch, install, signIn }

class _BetaPromoDialogState extends State<BetaPromoDialog> {
  static const Map<BetaPlatform, String> _platformNames = {
    BetaPlatform.ios: 'iPhone',
    BetaPlatform.macos: 'Mac',
    BetaPlatform.android: 'Android',
    BetaPlatform.windows: 'Windows',
    BetaPlatform.linux: 'Linux',
  };

  // Loose on what an address is, strict on what could turn into markup in the
  // email the server builds from it
  static final RegExp _emailPattern = RegExp(
    r'''^[^\s@<>"']+@[^\s@<>"']+\.[^\s@<>"']+$''',
  );

  late final TextEditingController _emailController;
  Timer? _armTimer;
  BetaPlatform? _platform;
  _Step _step = _Step.pitch;
  bool _isArmed = false;
  bool _hasEngaged = false;
  bool _isSending = false;
  bool _isSent = false;
  bool _hasSendFailed = false;
  String? _emailError;
  String? _failedUrl;
  int _qrOption = 0;

  @override
  void initState() {
    super.initState();

    _platform = widget.devicePlatform;
    _isSent = widget.windowsEmail.isNotEmpty;
    _emailController = TextEditingController(
      text: _isSent ? widget.windowsEmail : widget.email,
    );

    if (widget.hasEngaged) {
      _hasEngaged = true;

      if (_platform == BetaPlatform.windows && kBetaWindowsInviteOnly) {
        _step = _isSent ? _Step.install : _Step.pitch;
      } else {
        _step = _Step.signIn;
      }
    }

    // A click aimed at the screen underneath shouldn't close the invitation
    // or follow one of its links
    _armTimer = Timer(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _isArmed = true);
      }
    });
  }

  @override
  void dispose() {
    _armTimer?.cancel();
    _emailController.dispose();
    super.dispose();
  }

  String _text(BetaStr key) => widget.strings.get(key);

  String? get _storeUrl {
    switch (_platform) {
      case BetaPlatform.ios:
      case BetaPlatform.macos:
        return kBetaTestFlightUrl;
      case BetaPlatform.android:
        return kBetaGooglePlayUrl;
      case BetaPlatform.windows:
        return kBetaWindowsUrl;
      case BetaPlatform.linux:
        return kBetaAppImageUrl;
      case null:
        return null;
    }
  }

  // Whether installing is a single link, the others get a step of their own
  bool get _opensStore {
    switch (_platform) {
      case BetaPlatform.ios:
      case BetaPlatform.macos:
      case BetaPlatform.android:
        return true;
      case BetaPlatform.windows:
        return !kBetaWindowsInviteOnly;
      case BetaPlatform.linux:
      case null:
        return false;
    }
  }

  BetaStr? get _buttonCaption {
    switch (_platform) {
      case BetaPlatform.ios:
      case BetaPlatform.macos:
        return BetaStr.captionApple;
      case BetaPlatform.android:
        return BetaStr.captionAndroid;
      case BetaPlatform.windows:
        return kBetaWindowsInviteOnly ? BetaStr.captionWindows : null;
      case BetaPlatform.linux:
        return BetaStr.captionLinux;
      case null:
        return null;
    }
  }

  String? get _installedName {
    switch (_platform) {
      case BetaPlatform.ios:
      case BetaPlatform.android:
        return kBetaAppNameMobile;
      case BetaPlatform.windows:
        return kBetaAppNameWindows;
      case BetaPlatform.macos:
      case BetaPlatform.linux:
      case null:
        return null;
    }
  }

  IconData _iconFor(BetaPlatform platform) {
    switch (platform) {
      case BetaPlatform.ios:
      case BetaPlatform.macos:
        return MdiIcons.apple;
      case BetaPlatform.android:
        return Icons.android;
      case BetaPlatform.windows:
        return MdiIcons.microsoftWindows;
      case BetaPlatform.linux:
        return MdiIcons.linux;
    }
  }

  // Installing this way replaces this app rather than sitting beside it
  bool get _replacesThisApp =>
      widget.isSnap && widget.devicePlatform == BetaPlatform.linux;

  void _close() {
    // Escape and the back button come through here as well as taps, and a
    // stray one of those shouldn't use up a reminder either
    if (!_isArmed) {
      return;
    }

    if (!_hasEngaged && !widget.isManual) {
      widget.onSnooze();
    }

    Navigator.of(context).pop();
  }

  // Reported at once rather than on close, the store can take this app out
  // of memory while the user is in it
  void _engage() {
    if (!_hasEngaged) {
      _hasEngaged = true;
      widget.onEngaged();
    }
  }

  void _finish() {
    widget.onFinish();
    Navigator.of(context).pop();
  }

  void _setPassword() {
    Navigator.of(context).pop();
    widget.onSetPassword();
  }

  void _goTo(_Step step) {
    setState(() {
      _step = step;
      _failedUrl = null;
    });
  }

  void _getBeta() {
    final storeUrl = _storeUrl;

    if (_opensStore && storeUrl != null) {
      _open(storeUrl, next: _Step.signIn);
    } else {
      _goTo(_Step.install);
    }
  }

  Future<void> _open(String url, {_Step? next}) async {
    final isOpen = await widget.onLaunch(url);

    if (!mounted) {
      return;
    }

    if (next != null && isOpen) {
      _engage();
    }

    setState(() {
      // A mail link has nothing worth copying, the address is offered beside it
      _failedUrl = isOpen || url.startsWith('mailto:') ? null : url;
      if (next != null && isOpen) {
        _step = next;
      }
    });
  }

  Future<void> _requestWindowsAccess() async {
    final email = _emailController.text.trim();

    if (!_emailPattern.hasMatch(email)) {
      setState(() => _emailError = _text(BetaStr.winInvalid));
      return;
    }

    setState(() {
      _emailError = null;
      _hasSendFailed = false;
      _isSending = true;
    });

    final isSent = await widget.onRequestWindowsAccess(email);

    if (!mounted) {
      return;
    }

    if (isSent) {
      _engage();
    }

    setState(() {
      _isSending = false;
      _isSent = isSent;
      _hasSendFailed = !isSent;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = BetaPromoPalette(widget.isDark);
    final mediaQuery = MediaQuery.of(context);
    final inset = mediaQuery.size.width < kMobileLayoutWidth
        ? kMobileDialogPadding
        : 32.0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        // The app's own pops arrive here too, only the back button is ours
        if (!didPop) {
          _close();
        }
      },
      child: CallbackShortcuts(
        bindings: {const SingleActivator(LogicalKeyboardKey.escape): _close},
        child: Focus(
          autofocus: true,
          child: AbsorbPointer(
            absorbing: !_isArmed,
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _close,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      inset,
                      inset,
                      inset,
                      inset + mediaQuery.viewInsets.bottom,
                    ),
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) =>
                            _card(constraints, palette),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // The layout follows the space there is, isMobile() reports a preference
  Widget _card(BoxConstraints constraints, BetaPromoPalette palette) {
    final isWide = constraints.maxWidth >= 760 && constraints.maxHeight >= 520;
    // The app has its own text size setting, larger text gets a larger card
    final scale = MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 1.5);
    final hasHero = isWide || (constraints.maxHeight >= 620 && scale <= 1.2);
    final contentWidth = 440 + (scale - 1) * 220;
    final fourFeatureHeight = (widget.showPlatformChips ? 690 : 650) * scale;

    final closeButton = hasHero
        // Sits on the screenshots, which can be any colour
        ? Material(
            color: Colors.black38,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: IconButton(
              tooltip: _text(BetaStr.close),
              icon: Icon(Icons.close, size: 20),
              color: Colors.white,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 36, height: 36),
              onPressed: _close,
            ),
          )
        : IconButton(
            tooltip: _text(BetaStr.close),
            icon: Icon(Icons.close),
            color: palette.muted,
            onPressed: _close,
          );
    final hero = BetaPromoHero(
      isDark: widget.isDark,
      isWide: isWide,
      closeButton: closeButton,
      overlay: isWide ? _qrCard() : null,
    );
    final content = _content(
      palette,
      isWide: isWide,
      // Three reasons fit a short window without scrolling, four need more
      featureCount: isWide && constraints.maxHeight >= fourFeatureHeight
          ? 4
          : 3,
      closeButton: hasHero ? null : closeButton,
    );

    return GestureDetector(
      // Keeps a tap on the card from reaching the barrier behind it
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Material(
        color: palette.surface,
        elevation: 24,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isWide
                ? contentWidth + 500
                // A phone on its side has the width for fewer, longer lines
                : (constraints.maxHeight < 520 ? 620 : 460),
            maxHeight: isWide ? 700 * scale : double.infinity,
          ),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: contentWidth, child: content),
                    Expanded(child: hero),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (hasHero) SizedBox(height: 156, child: hero),
                    Flexible(child: content),
                  ],
                ),
        ),
      ),
    );
  }

  Widget? _qrCard() {
    if (!widget.showQr || _step != _Step.pitch) {
      return null;
    } else if (!widget.showOtherPlatforms) {
      return BetaPromoQrCard(
        url: kBetaTestFlightUrl,
        caption: _text(BetaStr.qrCaptionApple),
      );
    }

    return BetaPromoQrCard(
      url: _qrOption == 0 ? kBetaTestFlightUrl : kBetaGooglePlayUrl,
      caption: _text(BetaStr.qrCaption),
      options: [
        _platformNames[BetaPlatform.ios]!,
        if (kBetaPromoEnabledOnAndroid) _platformNames[BetaPlatform.android]!,
      ],
      selectedOption: _qrOption,
      onOptionSelected: (index) => setState(() => _qrOption = index),
    );
  }

  Widget _content(
    BetaPromoPalette palette, {
    required bool isWide,
    required int featureCount,
    required Widget? closeButton,
  }) {
    final padding = isWide ? 32.0 : 22.0;
    final String title;
    final String? subtitle;
    final List<Widget> body;

    switch (_step) {
      case _Step.pitch:
        title = _text(BetaStr.headline);
        subtitle = _replacesThisApp
            ? _text(BetaStr.sub)
            : '${_text(BetaStr.sub)} ${_text(BetaStr.subKeep)}';
        body = _pitch(palette, featureCount);
        break;
      case _Step.install:
        title = _text(BetaStr.getBeta);
        subtitle = null;
        body = _install(palette);
        break;
      case _Step.signIn:
        title = _text(BetaStr.stepTitle);
        subtitle = _text(BetaStr.stepSub);
        body = _signIn(palette);
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: isWide ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Flexible(
          fit: isWide ? FlexFit.tight : FlexFit.loose,
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.fromSTEB(
              padding,
              closeButton == null ? padding : 10,
              closeButton == null ? padding : 10,
              8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BetaPromoPill(
                      label: '${_text(BetaStr.pillNew).toUpperCase()} · BETA',
                      palette: palette,
                    ),
                    Spacer(),
                    if (closeButton != null) closeButton,
                  ],
                ),
                SizedBox(height: 14),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: closeButton == null ? 0 : padding - 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: palette.text,
                          fontSize: isWide ? 28 : 23,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                          letterSpacing: -.3,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 10),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: palette.muted,
                            fontSize: 14.5,
                            height: 1.4,
                          ),
                        ),
                      ],
                      SizedBox(height: 20),
                      ...body,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            padding,
            8,
            padding,
            isWide ? 16 : 10,
          ),
          child: _footer(palette),
        ),
      ],
    );
  }

  List<Widget> _pitch(BetaPromoPalette palette, int featureCount) {
    final features = betaPromoFeatures(
      isPhone:
          _platform == BetaPlatform.ios || _platform == BetaPlatform.android,
      hasTasks: widget.hasTasks,
      hasExpenses: widget.hasExpenses,
      hasDesigner: widget.hasDesigner,
      // The notice takes the room of one reason
      count: widget.needsPassword ? featureCount - 1 : featureCount,
    );

    return [
      // Shown before they leave for the store, they may not come back here
      if (widget.needsPassword) ...[
        _passwordNotice(palette),
        SizedBox(height: 16),
      ],
      for (final feature in features)
        BetaPromoFeatureRow(
          icon: feature.icon,
          title: _text(feature.title),
          body: _text(feature.body),
          palette: palette,
        ),
      if (_failedUrl != null) _failedLink(palette),
    ];
  }

  List<Widget> _install(BetaPromoPalette palette) {
    return [
      if (_platform == BetaPlatform.windows)
        ..._windowsPanel(palette)
      else
        ..._linuxPanel(palette),
      if (_failedUrl != null) _failedLink(palette),
    ];
  }

  List<Widget> _signIn(BetaPromoPalette palette) {
    final name = _installedName;

    return [
      BetaPromoCopyRow(
        label: widget.labels.email,
        value: widget.email,
        copyTooltip: _text(BetaStr.copy),
        onCopy: () => widget.onCopy(widget.email),
        palette: palette,
      ),
      if (widget.serverUrl.isNotEmpty) ...[
        BetaPromoCopyRow(
          label: _text(BetaStr.serverUrl),
          value: widget.serverUrl,
          copyTooltip: _text(BetaStr.copy),
          onCopy: () => widget.onCopy(widget.serverUrl),
          palette: palette,
        ),
        _caption(_text(BetaStr.apiSecret), palette),
        SizedBox(height: 10),
      ],
      if (name != null) ...[
        _caption(_text(BetaStr.appName).replaceFirst(':name', name), palette),
        SizedBox(height: 14),
      ],
      if (widget.needsPassword) _passwordNotice(palette),
      if (_failedUrl != null) _failedLink(palette),
    ];
  }

  Widget _caption(String text, BetaPromoPalette palette) {
    return Text(
      text,
      style: TextStyle(color: palette.muted, fontSize: 12.5, height: 1.35),
    );
  }

  Widget _body(String text, BetaPromoPalette palette) {
    return Text(
      text,
      style: TextStyle(color: palette.text, fontSize: 14, height: 1.4),
    );
  }

  Widget _passwordNotice(BetaPromoPalette palette) {
    return BetaPromoNotice(
      icon: Icons.key_outlined,
      text: _text(BetaStr.passwordHint),
      palette: palette,
      action: _linkButton(
        widget.labels.setPassword,
        palette,
        onPressed: _setPassword,
      ),
    );
  }

  Widget _failedLink(BetaPromoPalette palette) {
    final url = _failedUrl!;

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _caption(_text(BetaStr.launchFailed), palette),
          SizedBox(height: 6),
          BetaPromoCopyRow(
            label: Uri.parse(url).host,
            value: url,
            copyTooltip: _text(BetaStr.copy),
            onCopy: () => widget.onCopy(url),
            palette: palette,
          ),
        ],
      ),
    );
  }

  // The browser can't always tell which platform it is on, and someone on
  // the web may want the beta for a different device
  Widget _platformPicker(BetaPromoPalette palette) {
    final platform = _platform;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            _text(BetaStr.chipsLabel),
            style: TextStyle(color: palette.muted, fontSize: 13),
          ),
          SizedBox(width: 8),
          PopupMenuButton<BetaPlatform>(
            tooltip: '',
            initialValue: platform,
            onSelected: (value) => setState(() {
              _platform = value;
              _failedUrl = null;
            }),
            itemBuilder: (context) => [
              for (final value in BetaPlatform.values)
                if (value != BetaPlatform.android || kBetaPromoEnabledOnAndroid)
                  PopupMenuItem<BetaPlatform>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(_iconFor(value), size: 18),
                        SizedBox(width: 10),
                        Text(_platformNames[value]!),
                      ],
                    ),
                  ),
            ],
            child: Container(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 4, 6),
              decoration: BoxDecoration(
                border: Border.all(color: palette.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    platform == null ? Icons.devices : _iconFor(platform),
                    size: 16,
                    color: palette.accent,
                  ),
                  SizedBox(width: 6),
                  Text(
                    platform == null ? '' : _platformNames[platform]!,
                    style: TextStyle(color: palette.text, fontSize: 13),
                  ),
                  Icon(Icons.arrow_drop_down, size: 20, color: palette.muted),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _windowsPanel(BetaPromoPalette palette) {
    if (_isSent) {
      return [
        BetaPromoNotice(
          icon: Icons.check_circle_outline,
          text: _text(BetaStr.winSent).replaceFirst(':email', widget.email),
          palette: palette,
          action: _linkButton(
            _text(BetaStr.winChange),
            palette,
            onPressed: () => setState(() => _isSent = false),
          ),
        ),
        // Their own server sent it, and one set up to log or drop mail says
        // it went
        if (widget.serverUrl.isNotEmpty) ...[
          SizedBox(height: 8),
          _caption(
            _text(
              BetaStr.winSelfHosted,
            ).replaceFirst(':contact', kBetaContactEmail),
            palette,
          ),
        ],
        SizedBox(height: 16),
        // Not the main button, the listing stays closed until we've added them
        _secondaryButton(
          palette,
          label: _text(BetaStr.winOpenStore),
          icon: MdiIcons.microsoftWindows,
          onPressed: () => _open(kBetaWindowsUrl, next: _Step.signIn),
        ),
        SizedBox(height: 8),
        Center(
          child: _linkButton(
            _text(BetaStr.demo),
            palette,
            icon: Icons.open_in_new,
            onPressed: () => _open(kBetaDemoUrl),
          ),
        ),
      ];
    }

    return [
      _body(_text(BetaStr.winIntro), palette),
      SizedBox(height: 16),
      // An address reads left to right in every locale
      Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(
          controller: _emailController,
          enabled: !_isSending,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: palette.text, fontSize: 14.5),
          decoration: InputDecoration(
            labelText: _text(BetaStr.winField),
            errorText: _emailError,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onSubmitted: (_) => _requestWindowsAccess(),
        ),
      ),
      SizedBox(height: 12),
      _primaryButton(
        label: _text(BetaStr.winRequest),
        isBusy: _isSending,
        onPressed: _requestWindowsAccess,
      ),
      if (_hasSendFailed) ...[
        SizedBox(height: 12),
        BetaPromoNotice(
          icon: Icons.error_outline,
          text: _text(
            BetaStr.winFailed,
          ).replaceFirst(':contact', kBetaContactEmail),
          palette: palette,
          action: Wrap(
            spacing: 16,
            children: [
              _linkButton(
                _text(BetaStr.winOpenEmail),
                palette,
                onPressed: () => _open(_mailtoUrl),
              ),
              _linkButton(
                _text(BetaStr.copy),
                palette,
                onPressed: () => widget.onCopy(kBetaContactEmail),
              ),
            ],
          ),
        ),
      ],
    ];
  }

  String get _mailtoUrl {
    final subject = Uri.encodeComponent('Windows beta access');
    final body = Uri.encodeComponent(
      'Microsoft account email: ${_emailController.text.trim()}',
    );

    return 'mailto:$kBetaContactEmail?subject=$subject&body=$body';
  }

  List<Widget> _linuxPanel(BetaPromoPalette palette) {
    Widget command(String value) => BetaPromoCommandBox(
      command: value,
      copyTooltip: _text(BetaStr.copy),
      onCopy: () {
        _engage();
        widget.onCopy(value);
      },
    );

    // Beside the command rather than on a step after it, copying the address
    // there would replace the command on the clipboard
    final thenSignIn = [
      _body(
        _text(BetaStr.thenSignIn).replaceFirst(':email', widget.email),
        palette,
      ),
      if (widget.serverUrl.isNotEmpty)
        _body('${_text(BetaStr.serverUrl)}: ${widget.serverUrl}', palette),
    ];

    // Only this install can be told apart, on the web it could be either
    if (_replacesThisApp) {
      return [
        _body(_text(BetaStr.snapIntro), palette),
        SizedBox(height: 4),
        command(kBetaSnapRefreshCommand),
        ...thenSignIn,
        SizedBox(height: 14),
        _caption(_text(BetaStr.snapNote), palette),
        command(kBetaSnapRevertCommand),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: _linkButton(
            _text(BetaStr.keepBoth),
            palette,
            onPressed: () => _open(kBetaAppImageUrl),
          ),
        ),
      ];
    }

    return [
      _primaryButton(
        label: _text(BetaStr.appImage),
        icon: Icons.download,
        onPressed: () => _open(kBetaAppImageUrl, next: _Step.signIn),
      ),
      SizedBox(height: 8),
      _caption(_text(BetaStr.appImageCaption), palette),
      SizedBox(height: 20),
      _body(_text(BetaStr.orSnap), palette),
      SizedBox(height: 4),
      command(kBetaSnapInstallCommand),
      ...thenSignIn,
    ];
  }

  Widget _footer(BetaPromoPalette palette) {
    switch (_step) {
      case _Step.pitch:
        return _pitchFooter(palette);
      case _Step.install:
        final back = _linkButton(
          _text(BetaStr.back),
          palette,
          onPressed: () => _goTo(_Step.pitch),
        );

        // The Windows steps carry their own buttons
        if (_platform != BetaPlatform.linux) {
          return Align(
            alignment: AlignmentDirectional.centerStart,
            child: back,
          );
        }

        return Row(
          children: [
            back,
            SizedBox(width: 16),
            Expanded(
              child: _primaryButton(
                label: _text(BetaStr.done),
                onPressed: _finish,
              ),
            ),
          ],
        );
      case _Step.signIn:
        final storeUrl = _storeUrl;
        final canReopen = storeUrl != null && _platform != BetaPlatform.linux;

        return Row(
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: _linkButton(
                  canReopen ? _text(BetaStr.openAgain) : _text(BetaStr.back),
                  palette,
                  onPressed: canReopen
                      ? () => _open(storeUrl)
                      : () => _goTo(_Step.install),
                ),
              ),
            ),
            SizedBox(width: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 140),
              child: _primaryButton(
                label: _text(BetaStr.done),
                onPressed: _finish,
              ),
            ),
          ],
        );
    }
  }

  Widget _pitchFooter(BetaPromoPalette palette) {
    final platform = _platform;
    final caption = _buttonCaption;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.showPlatformChips) _platformPicker(palette),
        if (platform != null) ...[
          _primaryButton(
            label: _text(BetaStr.getBeta),
            icon: _iconFor(platform),
            onPressed: _getBeta,
          ),
          if (caption != null) ...[
            SizedBox(height: 8),
            Text(
              _text(caption),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: palette.muted,
                fontSize: 12.5,
                height: 1.35,
              ),
            ),
          ],
          SizedBox(height: 4),
        ],
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _linkButton(
              _text(BetaStr.demo),
              palette,
              icon: Icons.open_in_new,
              onPressed: () => _open(kBetaDemoUrl),
            ),
            _linkButton(
              widget.isManual || widget.isLastReminder
                  ? _text(BetaStr.close)
                  : _text(BetaStr.remindLater),
              palette,
              onPressed: _close,
            ),
          ],
        ),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: palette.muted,
              minimumSize: const Size(0, 28),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _finish,
            child: Text(
              _text(BetaStr.dontShow),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _primaryButton({
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
    bool isBusy = false,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kBetaPromoBrandColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Stays lit while it works rather than greying out
        onPressed: isBusy ? () {} : onPressed,
        child: isBusy
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      // Set here so the theme's font family is kept
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _secondaryButton(
    BetaPromoPalette palette, {
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.accent,
          side: BorderSide(color: palette.border),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 20), SizedBox(width: 8)],
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _linkButton(
    String label,
    BetaPromoPalette palette, {
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: palette.accent,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        minimumSize: const Size(0, 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          if (icon != null) ...[SizedBox(width: 4), Icon(icon, size: 15)],
        ],
      ),
    );
  }
}
