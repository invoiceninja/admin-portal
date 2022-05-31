import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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
                right: kMobileDialogPadding / 2,
                bottom: kMobileDialogPadding,
                left: kMobileDialogPadding),
            children: [
              Text(
                localization.details,
                style: Theme.of(context).textTheme.headline6,
              ),
              if (client.vatNumber.isNotEmpty)
                Text('${localization.vatNumber}: ${client.vatNumber}'),
            ],
          ),
        ),
        Expanded(
            child: FormCard(
          isLast: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.only(
              top: kMobileDialogPadding,
              right: kMobileDialogPadding / 2,
              bottom: kMobileDialogPadding,
              left: kMobileDialogPadding / 2),
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
                  (state.prefState.isPreviewVisible ? 1 : 2),
              bottom: kMobileDialogPadding,
              left: kMobileDialogPadding / 2),
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
                    left: kMobileDialogPadding / 2),
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
