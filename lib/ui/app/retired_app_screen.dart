// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_strings.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_widgets.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/move_support.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

/// Covers the whole app once one of our hosted servers no longer supports
/// this version (see `appRetired` in web_client.dart), at sign-in or over a
/// restored session. Never shown because of a date, or by a selfhosted
/// server.
///
/// Sits above the navigator, so nothing here may need an Overlay: no
/// tooltips, menus or dialogs. There's no Restore button, the server refuses
/// this version's requests by now. English and left to right in every
/// locale, like the rest of the move copy.
class RetiredAppScreen extends StatefulWidget {
  const RetiredAppScreen({Key? key}) : super(key: key);

  @override
  State<RetiredAppScreen> createState() => _RetiredAppScreenState();
}

class _RetiredAppScreenState extends State<RetiredAppScreen> {
  bool _isBelowFloor = false;
  String? _failedUrl;

  @override
  void initState() {
    super.initState();

    deviceIsBelowNewAppFloor().then((value) {
      if (mounted && value) {
        setState(() => _isBelowFloor = true);
      }
    });
  }

  // Leaves the session and the data on this device. The screen stays, the
  // server that retired the app would refuse a new sign-in anyway.
  void _signOut(Store<AppState> store) {
    store.dispatch(UserLogout());
  }

  // Signs out and uncovers the login page, where another server can be
  // entered. A hosted one puts this screen back on the first request.
  void _changeServer(Store<AppState> store) {
    if (store.state.authState.isAuthenticated) {
      store.dispatch(UserLogout());
    }

    appRetired.value = false;
  }

  Future<void> _open(String url) async {
    final isOpen = await launchMoveUrl(url);

    if (mounted) {
      setState(() => _failedUrl = isOpen ? null : url);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Rebuilt on every change, signing out takes the account away
    return StoreBuilder<AppState>(
      builder: (context, store) => Directionality(
        textDirection: TextDirection.ltr,
        child: _build(store),
      ),
    );
  }

  Widget _build(Store<AppState> store) {
    final state = store.state;
    const strings = BetaPromoStrings();
    final palette = BetaPromoPalette(state.prefState.enableDarkMode);
    final platform = currentBetaPlatform();
    // The web app, which is always ours and https: only a hosted server
    // retires this app. On the web there's no store to send anyone to.
    final usesWebApp = kIsWeb || _isBelowFloor;
    final appUrl = usesWebApp ? kMoveWebAppUrl : newAppUrl(platform);
    final isSignedIn = state.authState.isAuthenticated;
    final isSelfHosted = isSignedIn && state.isSelfHosted;
    // The account isn't loaded yet at sign-in, so the plan isn't mentioned,
    // but a subscriber can still reach the store's page for it
    final canManage = isInAppStoreBuild() && !isSelfHosted;
    final hasIapPlan = isSignedIn && !isSelfHosted && state.account.hasIapPlan;
    final bodyText = [
      isSelfHosted
          ? strings.get(BetaStr.retiredBodySelfHosted)
          : strings.get(BetaStr.retiredBody),
      if (hasIapPlan) strings.get(BetaStr.retiredPlan),
    ].join(' ');

    final body = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.rocket_launch_outlined, size: 48, color: palette.accent),
        SizedBox(height: 20),
        Text(
          strings.get(BetaStr.retiredTitle),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: palette.text,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        SizedBox(height: 12),
        Text(
          bodyText,
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.muted, fontSize: 15, height: 1.4),
        ),
        SizedBox(height: 28),
        if (appUrl != null) ...[
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kBetaPromoBrandColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => _open(appUrl),
              child: Text(
                kIsWeb
                    ? strings.get(BetaStr.openWebApp)
                    : _isBelowFloor
                    ? strings.get(BetaStr.openInBrowser)
                    : strings.get(BetaStr.getNewApp),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (_isBelowFloor && !kIsWeb) ...[
            SizedBox(height: 8),
            Text(
              strings.get(BetaStr.belowFloor),
              textAlign: TextAlign.center,
              style: TextStyle(color: palette.muted, fontSize: 12.5),
            ),
          ],
          SizedBox(height: 12),
        ],
        if (canManage) ...[
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: palette.accent,
                side: BorderSide(color: palette.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: openStoreSubscriptions,
              child: Text(
                strings.get(BetaStr.manageSubscription),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
        ],
        TextButton(
          style: TextButton.styleFrom(foregroundColor: palette.accent),
          onPressed: () => _open(moveContactUrl),
          child: Text(strings.get(BetaStr.contactUs)),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            if (isSignedIn)
              TextButton(
                style: TextButton.styleFrom(foregroundColor: palette.muted),
                onPressed: () => _signOut(store),
                child: Text(strings.get(BetaStr.signOut)),
              ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: palette.muted),
              onPressed: () => _changeServer(store),
              child: Text(strings.get(BetaStr.changeServer)),
            ),
          ],
        ),
        if (_failedUrl != null) ...[
          SizedBox(height: 12),
          Text(
            strings.get(BetaStr.launchFailed),
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.muted, fontSize: 12.5),
          ),
          SizedBox(height: 4),
          // Plain text, selecting it would need an Overlay
          Text(
            _failedUrl!.startsWith('mailto:') ? kBetaContactEmail : _failedUrl!,
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.text, fontSize: 13),
          ),
        ],
      ],
    );

    return Material(
      color: palette.surface,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
