// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_controller.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_strings.dart';
import 'package:invoiceninja_flutter/ui/app/beta_promo/beta_promo_widgets.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

/// The way back to the invitation from the sidebar, kept until the user has
/// installed the beta or asked not to see it
class BetaPromoSidebarTile extends StatelessWidget {
  const BetaPromoSidebarTile({Key? key}) : super(key: key);

  void _open(BuildContext context) {
    // On the mobile layout the sidebar is a drawer, which would otherwise
    // stay open underneath
    if (isMobile(context)) {
      Navigator.of(context).pop();
    }

    showBetaPromoDialog(isManual: true);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: BetaPromoController.instance.showEntry,
      builder: (context, _, __) {
        final state = StoreProvider.of<AppState>(context).state;

        if (!BetaPromoController.instance.showsEntryFor(state)) {
          return SizedBox();
        }

        final title = BetaPromoStrings(
          AppLocalization.of(context)!.localeCode,
        ).get(BetaStr.entryTitle);

        return Material(
          child: Tooltip(
            message: state.isMenuCollapsed ? title : '',
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 12),
              tileColor: kBetaPromoBrandColor,
              leading: IconButton(
                onPressed: () => _open(context),
                icon: Icon(Icons.rocket_launch, color: Colors.white),
              ),
              title: state.isMenuCollapsed
                  ? SizedBox()
                  : Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
              onTap: () => _open(context),
            ),
          ),
        );
      },
    );
  }
}

/// The same way back on the dashboard, for the mobile layout where the
/// sidebar is usually closed
class BetaPromoDashboardCard extends StatelessWidget {
  const BetaPromoDashboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: BetaPromoController.instance.showEntry,
      builder: (context, _, __) {
        final state = StoreProvider.of<AppState>(context).state;

        if (!BetaPromoController.instance.showsEntryFor(state)) {
          return SizedBox();
        }

        final strings = BetaPromoStrings(
          AppLocalization.of(context)!.localeCode,
        );

        // One target with nothing else in the row, on a narrow phone buttons
        // would leave the sentence a few words per line
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: FormCard(
            child: InkWell(
              onTap: () => showBetaPromoDialog(isManual: true),
              child: Row(
                children: [
                  Icon(Icons.rocket_launch, color: kBetaPromoBrandColor),
                  SizedBox(width: 12),
                  Expanded(child: Text(strings.get(BetaStr.cardBody))),
                  SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
