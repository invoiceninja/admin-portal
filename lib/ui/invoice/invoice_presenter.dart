import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoicePresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      InvoiceFields.status,
      InvoiceFields.invoiceNumber,
      InvoiceFields.client,
      InvoiceFields.invoiceDate,
      InvoiceFields.amount,
      InvoiceFields.balance,
      InvoiceFields.dueDate,
      EntityFields.state,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final invoice = entity as InvoiceEntity;

    switch (field) {
      case InvoiceFields.status:
        return Text(
          invoice.isPastDue
              ? localization.pastDue
              : localization.lookup(kInvoiceStatuses[invoice.statusId]),
        );
      case InvoiceFields.invoiceNumber:
        return Text(invoice.number);
      case InvoiceFields.client:
        return Text((state.clientState.map[invoice.clientId] ??
                ClientEntity(id: invoice.clientId))
            .listDisplayName);
      case InvoiceFields.invoiceDate:
        return Text(formatDate(invoice.date, context));
      case InvoiceFields.amount:
        return Text(formatNumber(invoice.amount, context));
      case InvoiceFields.balance:
        return Text(formatNumber(invoice.balance, context));
      case InvoiceFields.dueDate:
        return Text(formatDate(invoice.dueDate, context));
    }

    return super.getField(field: field, context: context);
  }
}
