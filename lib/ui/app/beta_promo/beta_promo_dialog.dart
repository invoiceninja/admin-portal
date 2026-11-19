// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_controller.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_strings.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_widgets.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/move_support.dart';
import 'package:invoiceninja_flutter/utils/app_review.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

enum BetaPlatform { ios, macos, android, windows, linux }

/// The platform the new app would be installed on, which on the web is the
/// one the browser is running on
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

/// Where the new app is installed from on [platform], one link each
String? newAppUrl(BetaPlatform? platform) {
  switch (platform) {
    case BetaPlatform.ios:
      return kMoveAppUrlIos;
    case BetaPlatform.macos:
      return kMoveAppUrlMac;
    case BetaPlatform.android:
      // The FOSS build is the one installed from F-Droid
      return AppReview.isStoreBuild ? kMoveAppUrlAndroid : kBetaFDroidUrl;
    case BetaPlatform.windows:
      return kMoveAppUrlWindows;
    case BetaPlatform.linux:
      return kBetaAppImageUrl;
    case null:
      return null;
  }
}

/// Where a device too old for the new app uses it instead: the web app, which
/// for a selfhosted account is on its own server
String newAppWebUrl(AppState state) =>
    state.isSelfHosted && cleanApiUrl(state.authState.url).isNotEmpty
    ? cleanApiUrl(state.authState.url)
    : kMoveWebAppUrl;

/// Opens [url] outside the app. The default mode opens store links inside an
/// in-app browser on mobile, which can't hand off to the store.
Future<bool> launchMoveUrl(String url) async {
  try {
    return await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  } catch (error) {
    return false;
  }
}

/// A mail to us, for feedback on the move
String get moveContactUrl =>
    'mailto:$kBetaContactEmail?subject=${Uri.encodeComponent('Invoice Ninja Legacy')}';

/// [date] written out in full, in the language [strings] uses for [key]
String formatMoveDate(DateTime date, BetaPromoStrings strings, BetaStr key) {
  try {
    return DateFormat.yMMMMd(strings.localeOf(key)).format(date);
  } catch (error) {
    return DateFormat.yMMMMd('en').format(date);
  }
}

/// Labels which name something elsewhere in the app, so they use its words.
/// The rest of the dialog has its own, a few of the app's are mistranslated.
class BetaPromoLabels {
  const BetaPromoLabels({required this.email, required this.setPassword});

  final String email;
  final String setPassword;
}

/// Asks the user to move to the new app before this one is retired. Opened
/// by [BetaPromoController] once the account has loaded, and by hand from the
/// sidebar, the dashboard, the about dialog and anywhere this app used to
/// sell a plan.
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
  final isAfterSunset = !DateTime.now().isBefore(kSunsetDate);

  // Before anything is awaited, so it can't also open itself meanwhile
  controller.markShown();

  void copy(String value) {
    Clipboard.setData(ClipboardData(text: value));

    final preview = value.length > 30 ? '${value.substring(0, 30)}...' : value;
    showToast(
      localization.copiedToClipboard.replaceFirst(':value', '"$preview"'),
    );
  }

  final belowFloor = deviceIsBelowNewAppFloor();

  // Decoded up front so the screenshots are there on the first frame
  await Future.wait([
    for (final asset in betaPromoHeroAssets(isDark))
      precacheImage(AssetImage(asset), context),
  ]);

  final isBelowFloor = await belowFloor;

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
        isDark: isDark,
        isManual: isManual,
        email: user.email,
        serverUrl: state.isSelfHosted ? cleanApiUrl(state.authState.url) : '',
        needsPassword: !user.hasPassword && user.oauthProvider.isNotEmpty,
        hasEngaged: controller.hasEngaged,
        isBelowFloor: isBelowFloor,
        webAppUrl: newAppWebUrl(state),
        sunsetDate: formatMoveDate(
          kSunsetDate,
          strings,
          isAfterSunset ? BetaStr.bothBodyAfter : BetaStr.bothBody,
        ),
        isAfterSunset: isAfterSunset,
        // Their v1 Play subscription can't be moved, the server cancels and
        // refunds it once they buy in the new app
        showPlayRefund:
            isAndroid() && AppReview.isStoreBuild && state.account.hasIapPlan,
        onLaunch: launchMoveUrl,
        onCopy: copy,
        onEngaged: controller.markEngaged,
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

/// The prompt itself. Takes plain values rather than reading the store so it
/// can be rendered on its own.
class BetaPromoDialog extends StatefulWidget {
  const BetaPromoDialog({
    Key? key,
    required this.strings,
    required this.labels,
    required this.devicePlatform,
    required this.showPlatformChips,
    required this.showOtherPlatforms,
    required this.showQr,
    required this.isDark,
    required this.isManual,
    required this.email,
    required this.serverUrl,
    required this.needsPassword,
    required this.hasEngaged,
    required this.isBelowFloor,
    required this.webAppUrl,
    required this.sunsetDate,
    required this.isAfterSunset,
    required this.showPlayRefund,
    required this.onLaunch,
    required this.onCopy,
    required this.onEngaged,
    required this.onSetPassword,
  }) : super(key: key);

  final BetaPromoStrings strings;
  final BetaPromoLabels labels;
  final BetaPlatform? devicePlatform;
  final bool showPlatformChips;
  final bool showOtherPlatforms;
  final bool showQr;
  final bool isDark;

  /// Opened by the user rather than shown to them
  final bool isManual;
  final String email;

  /// Empty for a hosted account
  final String serverUrl;
  final bool needsPassword;

  /// Opened again after starting to install, what's left is to sign in
  final bool hasEngaged;

  /// This device's OS is older than the new app supports, so the button
  /// opens [webAppUrl] instead of the store
  final bool isBelowFloor;
  final String webAppUrl;

  /// [kSunsetDate], formatted
  final String sunsetDate;
  final bool isAfterSunset;

  /// Says what happens to their Google Play subscription
  final bool showPlayRefund;
  final Future<bool> Function(String url) onLaunch;
  final void Function(String value) onCopy;

  /// The user has started to install
  final VoidCallback onEngaged;
  final VoidCallback onSetPassword;

  @override
  State<BetaPromoDialog> createState() => _BetaPromoDialogState();
}

enum _Step { pitch, signIn }

class _BetaPromoDialogState extends State<BetaPromoDialog> {
  static const Map<BetaPlatform, String> _platformNames = {
    BetaPlatform.ios: 'iPhone',
    BetaPlatform.macos: 'Mac',
    BetaPlatform.android: 'Android',
    BetaPlatform.windows: 'Windows',
    BetaPlatform.linux: 'Linux',
  };

  Timer? _armTimer;
  BetaPlatform? _platform;
  _Step _step = _Step.pitch;
  bool _isArmed = false;
  bool _hasEngaged = false;
  String? _failedUrl;
  int _qrOption = 0;

  @override
  void initState() {
    super.initState();

    _platform = widget.devicePlatform;

    if (widget.hasEngaged) {
      _hasEngaged = true;
      _step = _Step.signIn;
    }

    // A click aimed at the screen underneath shouldn't close the prompt or
    // follow one of its links
    _armTimer = Timer(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _isArmed = true);
      }
    });
  }

  @override
  void dispose() {
    _armTimer?.cancel();
    super.dispose();
  }

  String _text(BetaStr key) => widget.strings.get(key);

  // Only the device's own platform can be too old, on the web someone may be
  // picking another one
  bool get _usesBrowser =>
      widget.isBelowFloor && _platform == widget.devicePlatform;

  String? get _storeUrl =>
      _usesBrowser ? widget.webAppUrl : newAppUrl(_platform);

  String? get _installedName {
    switch (_platform) {
      case BetaPlatform.ios:
      case BetaPlatform.android:
        return _usesBrowser ? null : kBetaAppNameMobile;
      case BetaPlatform.windows:
        return kBetaAppNameWindows;
      case BetaPlatform.macos:
      case BetaPlatform.linux:
      case null:
        return null;
    }
  }

  IconData _iconFor(BetaPlatform platform) {
    if (_usesBrowser) {
      return Icons.open_in_browser;
    }

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

  void _close() {
    // Escape and the back button come through here as well as taps
    if (!_isArmed) {
      return;
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

  void _setPassword() {
    Navigator.of(context).pop();
    widget.onSetPassword();
  }

  void _getNewApp() {
    final storeUrl = _storeUrl;

    if (storeUrl != null) {
      _open(storeUrl, next: _Step.signIn);
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
      // Without a mail app there's nothing to open, the address is offered
      // to copy instead
      _failedUrl = isOpen
          ? null
          : url.startsWith('mailto:')
          ? kBetaContactEmail
          : url;
      if (next != null && isOpen) {
        _step = next;
      }
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
        url: kMoveAppUrlIos,
        caption: _text(BetaStr.qrCaptionApple),
      );
    }

    return BetaPromoQrCard(
      url: _qrOption == 0 ? kMoveAppUrlIos : kMoveAppUrlAndroid,
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
    required Widget? closeButton,
  }) {
    final padding = isWide ? 32.0 : 22.0;
    final String title;
    final String? subtitle;
    final List<Widget> body;

    switch (_step) {
      case _Step.pitch:
        title = _text(BetaStr.moveTitle);
        subtitle = null;
        body = _pitch(palette);
        break;
      case _Step.signIn:
        title = _text(BetaStr.stepTitle);
        subtitle = _text(BetaStr.signInSub);
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
                      label: _text(BetaStr.pillNew).toUpperCase(),
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

  // The same four points every surface about the move makes, in this order
  List<Widget> _pitch(BetaPromoPalette palette) {
    final isSelfHosted = widget.serverUrl.isNotEmpty;
    final both =
        (widget.isAfterSunset
                ? _text(BetaStr.bothBodyAfter)
                : _text(BetaStr.bothBody))
            .replaceFirst(':date', widget.sunsetDate);

    return [
      // Shown before they leave for the store, they may not come back here
      if (widget.needsPassword) ...[
        _passwordNotice(palette),
        SizedBox(height: 16),
      ],
      BetaPromoFeatureRow(
        icon: Icons.cloud_done_outlined,
        title: _text(BetaStr.dataTitle),
        body: isSelfHosted
            ? _text(BetaStr.dataBodySelfHosted)
            : _text(BetaStr.dataBody),
        palette: palette,
      ),
      BetaPromoFeatureRow(
        icon: Icons.devices_outlined,
        title: _text(BetaStr.newAppTitle),
        body: [
          _text(BetaStr.newAppBody),
          if (isSelfHosted) _text(BetaStr.newAppSelfHosted),
        ].join(' '),
        palette: palette,
      ),
      BetaPromoFeatureRow(
        icon: Icons.compare_arrows,
        title: _text(BetaStr.bothTitle),
        body: [
          both,
          // A selfhosted server has no plan of ours
          if (!isSelfHosted) _text(BetaStr.planBody),
          if (widget.showPlayRefund) _text(BetaStr.playRefund),
        ].join(' '),
        palette: palette,
      ),
      BetaPromoFeatureRow(
        icon: Icons.chat_bubble_outline,
        title: _text(BetaStr.feedbackTitle),
        body: _text(BetaStr.feedbackBody),
        palette: palette,
        action: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: _linkButton(
            _text(BetaStr.contactUs),
            palette,
            icon: Icons.mail_outline,
            onPressed: () => _open(moveContactUrl),
          ),
        ),
      ),
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
    final host = Uri.tryParse(url)?.host ?? '';

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _caption(_text(BetaStr.launchFailed), palette),
          SizedBox(height: 6),
          BetaPromoCopyRow(
            // An email address has no host
            label: host.isEmpty ? _text(BetaStr.contactUs) : host,
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
  // the web may want the new app for a different device
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

  Widget _footer(BetaPromoPalette palette) {
    switch (_step) {
      case _Step.pitch:
        return _pitchFooter(palette);
      case _Step.signIn:
        final storeUrl = _storeUrl;
        final String reopenLabel;
        if (_usesBrowser) {
          reopenLabel = _text(BetaStr.openInBrowser);
        } else if (_platform == BetaPlatform.linux) {
          reopenLabel = _text(BetaStr.getNewApp);
        } else {
          reopenLabel = _text(BetaStr.openAgain);
        }

        return Row(
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: storeUrl == null
                    ? _linkButton(
                        _text(BetaStr.back),
                        palette,
                        onPressed: () => setState(() {
                          _step = _Step.pitch;
                          _failedUrl = null;
                        }),
                      )
                    : _linkButton(
                        reopenLabel,
                        palette,
                        onPressed: () => _open(storeUrl),
                      ),
              ),
            ),
            SizedBox(width: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 140),
              child: _primaryButton(
                label: _text(BetaStr.done),
                onPressed: _close,
              ),
            ),
          ],
        );
    }
  }

  Widget _pitchFooter(BetaPromoPalette palette) {
    final platform = _platform;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.showPlatformChips) _platformPicker(palette),
        if (platform != null) ...[
          _primaryButton(
            label: _usesBrowser
                ? _text(BetaStr.openInBrowser)
                : _text(BetaStr.getNewApp),
            icon: _iconFor(platform),
            onPressed: _getNewApp,
          ),
          if (_usesBrowser) ...[
            SizedBox(height: 8),
            Text(
              _text(BetaStr.belowFloor),
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
              widget.isManual
                  ? _text(BetaStr.close)
                  : _text(BetaStr.remindLater),
              palette,
              onPressed: _close,
            ),
          ],
        ),
      ],
    );
  }

  Widget _primaryButton({
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
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
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 20), SizedBox(width: 8)],
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
