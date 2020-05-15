import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/constants.dart';

class CreditPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      CreditFields.creditNumber,
      CreditFields.client,
      CreditFields.amount,
      CreditFields.status,
      CreditFields.date,
      CreditFields.balance,
      EntityFields.state,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final credit = entity as InvoiceEntity;

    switch (field) {
      case CreditFields.status:
        return Text(localization.lookup(kQuoteStatuses[credit.statusId]));
      case CreditFields.creditNumber:
        return Text(credit.number);
      case CreditFields.client:
        return Text((state.clientState.map[credit.clientId] ??
                ClientEntity(id: credit.clientId))
            .listDisplayName);
      case CreditFields.date:
        return Text(formatDate(credit.date, context));
      case CreditFields.amount:
        return Text(formatNumber(credit.amount, context));
      case CreditFields.balance:
        return Text(formatNumber(credit.balance, context));
    }

    return super.getField(field: field, context: context);
  }
}
