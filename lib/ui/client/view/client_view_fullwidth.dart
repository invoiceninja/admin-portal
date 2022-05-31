import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientViewFullwidth extends StatelessWidget {
  const ClientViewFullwidth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final client = state.uiState.filterEntity as ClientEntity;
    ;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: FormCard(
            isLast: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.only(
                top: kMobileDialogPadding,
                right: kMobileDialogPadding / 3,
                bottom: kMobileDialogPadding,
                left: kMobileDialogPadding),
            children: [
              Text(
                localization.details,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 4),
              if (client.idNumber.isNotEmpty)
                CopyToClipboard(
                  value: client.idNumber,
                  prefix: localization.idNumber,
                ),
              if (client.vatNumber.isNotEmpty)
                CopyToClipboard(
                  value: client.vatNumber,
                  prefix: localization.vatNumber,
                ),
              if (client.phone.isNotEmpty)
                CopyToClipboard(
                  value: client.phone,
                  prefix: localization.phone,
                ),
              if (client.website.isNotEmpty)
                OutlinedButton(
                    onPressed: () => launch(client.website),
                    child: IconText(
                        text: client.website, icon: MdiIcons.openInNew)),
            ],
          ),
        ),
        Expanded(
            child: FormCard(
          isLast: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.only(
              top: kMobileDialogPadding,
              right: kMobileDialogPadding / 3,
              bottom: kMobileDialogPadding,
              left: kMobileDialogPadding / 3),
          children: [
            Text(
              localization.address,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        )),
        Expanded(
            child: FormCard(
          isLast: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: EdgeInsets.only(
              top: kMobileDialogPadding,
              right: kMobileDialogPadding /
                  (state.prefState.isPreviewVisible ? 1 : 3),
              bottom: kMobileDialogPadding,
              left: kMobileDialogPadding / 3),
          children: [
            Text(
              localization.contacts,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        )),
        if (!state.prefState.isPreviewVisible)
          Expanded(
              flex: 2,
              child: FormCard(
                isLast: true,
                crossAxisAlignment: CrossAxisAlignment.start,
                padding: const EdgeInsets.only(
                    top: kMobileDialogPadding,
                    right: kMobileDialogPadding,
                    bottom: kMobileDialogPadding,
                    left: kMobileDialogPadding / 3),
                children: [
                  Text(
                    '', //localization.standing,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              )),
      ],
    );
  }
}
