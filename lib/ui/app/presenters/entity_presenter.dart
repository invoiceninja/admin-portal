import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityPresenter {
  BaseEntity entity;
  BuildContext context;

  void initialize({BaseEntity entity, BuildContext context}) {
    this.entity = entity;
    this.context = context;
  }

  static List<String> getBaseFields() {
    return [
      EntityFields.createdAt,
      EntityFields.updatedAt,
      EntityFields.archivedAt,
      EntityFields.assignedTo,
      EntityFields.createdBy,
      EntityFields.state,
    ];
  }

  Widget getField({String field, BuildContext context}) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    switch (field) {
      case EntityFields.createdAt:
        return Text(formatDate(
            convertTimestampToDateString(entity.createdAt), context,
            showTime: true));
      case EntityFields.updatedAt:
        return Text(formatDate(
            convertTimestampToDateString(entity.updatedAt), context,
            showTime: true));
      case EntityFields.archivedAt:
        return Text(formatDate(
            convertTimestampToDateString(entity.archivedAt), context,
            showTime: true));
      case EntityFields.state:
        return Text(entity.isActive
            ? localization.active
            : entity.isArchived ? localization.archived : localization.deleted);
      case EntityFields.createdBy:
        return Text(
            state.userState.map[entity.createdUserId]?.listDisplayName ?? '');
      case EntityFields.assignedTo:
        return Text(
            state.userState.map[entity.assignedUserId]?.listDisplayName ?? '');
    }

    return Text('Error: $field not found');
  }

  static bool isFieldNumeric(String field) => [
        'balance',
        'paid_to_date',
        'amount',
        'quantity',
        'price',
        'cost',
        'line_total',
        'discount',
        'profit',
        'total',
        'invoice_amount',
        'invoice_balance',
        'client_balance',
        'credit_balance',
        'tax_rate',
        'tax_amount',
        'tax_paid',
        'payment_amount',
        'net_amount',
        'net_balance',
      ].contains(field);
}
