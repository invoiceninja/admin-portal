import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/dismissible_entity.dart';
import 'package:invoiceninja/utils/localization.dart';

class ProductItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  //final ValueChanged<bool> onCheckboxChanged;
  final ProductEntity product;

  static final productItemKey = (int id) => Key('__product_item_${id}__');

  ProductItem({
    @required this.onDismissed,
    @required this.onTap,
    //@required this.onCheckboxChanged,
    @required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return DismissibleEntity(
      entity: product,
      onDismissed: onDismissed,
      onTap: onTap,
      child: ListTile(
        onTap: onTap,
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
            ],
          ),
        ),
        subtitle: Text(product.notes,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            product.isDeleted
                ? Chip(
              label: Text(AppLocalization.of(context).deleted,
                  style: TextStyle(color: Colors.white, fontSize: 11.0)),
              backgroundColor: Colors.red,
            )
                : product.isArchived()
                ? Chip(
              label: Text(AppLocalization.of(context).archived,
                  style: TextStyle(color: Colors.white, fontSize: 11.0)),
              backgroundColor: Colors.orange,
            )
                : Container(),
            SizedBox(width: 12.0),
            Text(product.cost.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}
