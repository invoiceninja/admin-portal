import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class PaymentListItem extends StatelessWidget {
  final UserEntity user;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  //final ValueChanged<bool> onCheckboxChanged;
  final PaymentEntity payment;
  final String filter;
  
  static final paymentItemKey = (int id) => Key('__payment_item_${id}__');

  const PaymentListItem({
    @required this.user,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onLongPress,
    //@required this.onCheckboxChanged,
    @required this.payment,
    @required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final filterMatch = filter != null && filter.isNotEmpty
        ? payment.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch ?? payment.transactionReference;

    return DismissibleEntity(
      user: user,
      entity: payment,
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        /*
        leading: Checkbox(
          //key: NinjaKeys.paymentItemCheckbox(payment.id),
          value: true,
          //onChanged: onCheckboxChanged,
          onChanged: (value) {
            return true;
          },
        ),
        */
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  payment.transactionReference,
                  //key: NinjaKeys.clientItemClientKey(client.id),
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
            subtitle != null && subtitle.isNotEmpty ?
            Text(
              subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ) : Container(),
            EntityStateLabel(payment),
          ],
        ),
      ),
    );
  }
}
