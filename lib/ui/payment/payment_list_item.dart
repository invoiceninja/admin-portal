import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentListItem extends StatelessWidget {
  const PaymentListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.payment,
    @required this.filter,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final PaymentEntity payment;
  final String filter;

  static final paymentItemKey = (int id) => Key('__payment_${id}__');

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final invoice = paymentInvoiceSelector(payment.id, state);
    final client = paymentClientSelector(payment.id, state);

    final localization = AppLocalization.of(context);
    final filterMatch = filter != null && filter.isNotEmpty
        ? payment.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch ??
        invoice.invoiceNumber +
            ' • ' +
            formatDate(invoice.invoiceDate, context);

    return DismissibleEntity(
      user: user,
      entity: payment,
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  client.displayName,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(formatNumber(payment.amount, context),
                  style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: subtitle != null && subtitle.isNotEmpty
                      ? Text(
                          subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container(),
                ),
                Text(
                    localization
                        .lookup('payment_status_${payment.paymentStatusId}'),
                    style: TextStyle(
                      color:
                          PaymentStatusColors.colors[payment.paymentStatusId],
                    )),
              ],
            ),
            EntityStateLabel(payment),
          ],
        ),
      ),
    );
  }
}
