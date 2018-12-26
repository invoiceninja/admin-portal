import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    @required this.user,
    @required this.onTap,
    @required this.product,
    @required this.filter,
    this.onEntityAction,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
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
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: onCheckboxChanged != null ? Checkbox(
          //key: NinjaKeys.productItemCheckbox(task.id),
          value: isChecked,
          onChanged: (value) => onCheckboxChanged(value),
          activeColor: Theme.of(context).accentColor,
        ) : null,
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
            subtitle != null && subtitle.isNotEmpty
                ? Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
            EntityStateLabel(product),
          ],
        ),
      ),
    );
  }

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  //final ValueChanged<bool> onCheckboxChanged;
  final ProductEntity product;
  final String filter;

  static final productItemKey = (int id) => Key('__product_item_${id}__');
}
