// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityPresenter {
  EntityPresenter initialize(
    BaseEntity entity,
    BuildContext context,
  ) {
    this.entity = entity;
    this.context = context;

    return this;
  }

  late BaseEntity entity;
  late BuildContext context;

  String? title({bool isNarrow = false}) {
    final localization = AppLocalization.of(context)!;
    final type = localization.lookup('${entity.entityType}');
    var name = entity.listDisplayName;

    // TODO replace with this: https://github.com/flutter/flutter/issues/45336
    if (name.isEmpty) {
      name = localization.pending;
    }

    if ([
          EntityType.company,
          EntityType.client,
          EntityType.vendor,
          EntityType.project,
          EntityType.user,
          EntityType.product,
          EntityType.transaction,
          EntityType.document,
          EntityType.paymentLink,
        ].contains(entity.entityType) ||
        isNarrow) {
      return name;
    } else {
      return '$type: $name';
    }
  }

  static List<String> getBaseFields() {
    return [
      EntityFields.createdAt,
      EntityFields.updatedAt,
      EntityFields.archivedAt,
      EntityFields.assignedTo,
      EntityFields.createdBy,
      EntityFields.state,
      EntityFields.isDeleted,
    ];
  }

  Widget getField({String? field, required BuildContext context}) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    switch (field) {
      case EntityFields.createdAt:
        return Text(formatDate(
            convertTimestampToDateString(entity.createdAt), context,
            showTime: true));
      case EntityFields.updatedAt:
        return Text(entity.updatedAt == 0
            ? ''
            : formatDate(
                convertTimestampToDateString(entity.updatedAt), context,
                showTime: true));
      case EntityFields.archivedAt:
        return Text(entity.archivedAt == 0
            ? ''
            : formatDate(
                convertTimestampToDateString(entity.archivedAt), context,
                showTime: true));
      case EntityFields.state:
        return Text(entity.isActive
            ? localization!.active
            : entity.isArchived
                ? localization!.archived
                : localization!.deleted);
      case EntityFields.createdBy:
        final user = state.userState.get(entity.createdUserId!);
        return LinkTextRelatedEntity(entity: user, relation: entity);
      case EntityFields.assignedTo:
        final user = state.userState.get(entity.assignedUserId!);
        return LinkTextRelatedEntity(entity: user, relation: entity);
      case EntityFields.isDeleted:
        return Text(entity.isDeleted! ? localization!.yes : localization!.no);
    }

    return Text('Error: $field not found');
  }

  static bool isFieldLocalized(String? field) => [
        'status',
      ].contains(field);

  static bool isFieldAmount(String? field) {
    return [
      'quantity',
      'stock_quantity',
      'documents',
    ].contains(field);
  }

  static bool isFieldNumeric(String field) {
    if (field.startsWith('converted_')) {
      return true;
    }

    final value = [
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
      'payment',
      'expense',
      'invoice_amount',
      'invoice_balance',
      'client_balance',
      'credit_balance',
      'payment_balance',
      'tax_rate',
      'tax_amount',
      'tax_amount1',
      'tax_amount2',
      'tax_amount3',
      'tax_paid',
      'payment_amount',
      'net_balance',
      'rate',
      'calculated_rate',
      'duration',
      'net_amount',
      'net_total',
      'age_group_0',
      'age_group_30',
      'age_group_60',
      'age_group_90',
      'age_group_120',
      'stock_quantity',
      'notification_threshold',
      'partial',
      'withdrawal',
      'deposit',
      'documents',
    ].contains(field);

    return value;
  }

  String? presentCustomField(BuildContext context, String value) {
    if (['yes', 'no'].contains(value)) {
      final localization = AppLocalization.of(context)!;
      return localization.lookup(value);
    } else if (RegExp('^\\d{4}-\\d{2}-\\d{2}\$').hasMatch(value)) {
      return formatDate(value, context);
    }

    return value;
  }
}

class TableTooltip extends StatelessWidget {
  const TableTooltip({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Text(
        message,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
