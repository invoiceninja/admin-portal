import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class InvoicePresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
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
  String getField({String field, BuildContext context}) {
    final state = StoreProvider.of<AppState>(context).state;
    final invoice = entity as InvoiceEntity;

    switch (field) {
      case InvoiceFields.invoiceNumber:
        return invoice.number;
      case InvoiceFields.client:
        return (state.clientState.map[invoice.clientId] ??
                ClientEntity(id: invoice.clientId))
            .listDisplayName;
      case InvoiceFields.invoiceDate:
        return formatDate(invoice.date, context);
      case InvoiceFields.amount:
        return formatNumber(invoice.amount, context);
      case InvoiceFields.balance:
        return formatNumber(invoice.balance, context);
      case InvoiceFields.dueDate:
        return formatDate(invoice.dueDate, context);
    }

    return super.getField(field: field, context: context);
  }
}
