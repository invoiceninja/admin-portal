import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class EntityStatusChip extends StatelessWidget {
  const EntityStatusChip({
    @required this.entityType,
    @required this.statusId,
  });

  final EntityType entityType;
  final String statusId;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    String label = '';
    Color color;

    switch (entityType) {
      case EntityType.payment:
        label = kPaymentStatuses[statusId];
        color = PaymentStatusColors.colors[statusId];
        break;
      case EntityType.invoice:
        label = kInvoiceStatuses[statusId];
        color = InvoiceStatusColors.colors[statusId];
        break;
      case EntityType.quote:
        label = kQuoteStatuses[statusId];
        color = QuoteStatusColors.colors[statusId];
        break;
      case EntityType.credit:
        label = kCreditStatuses[statusId];
        color = CreditStatusColors.colors[statusId];
        break;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: 100,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            localization.lookup(label).toUpperCase(),
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
