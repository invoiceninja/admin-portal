import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class ProductListItem extends StatelessWidget {
  final UserEntity user;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  //final ValueChanged<bool> onCheckboxChanged;
  final ProductEntity product;
  final String filter;
  
  static final productItemKey = (int id) => Key('__product_item_${id}__');

  const ProductListItem({
    @required this.user,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onLongPress,
    //@required this.onCheckboxChanged,
    @required this.product,
    @required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final filterMatch = filter != null && filter.isNotEmpty
        ? product.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch ?? product.notes;

    return DismissibleEntity(
      user: user,
      entity: product,
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        /*
        leading: Checkbox(
          //key: NinjaKeys.productItemCheckbox(product.id),
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
                  product.productKey,
                  //key: NinjaKeys.clientItemClientKey(client.id),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(formatNumber(product.cost, context),
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
            EntityStateLabel(product),
          ],
        ),
      ),
    );
  }
}
