import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/keys.dart';

class ProductItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  //final ValueChanged<bool> onCheckboxChanged;
  final ProductEntity product;

  ProductItem({
    @required this.onDismissed,
    @required this.onTap,
    //@required this.onCheckboxChanged,
    @required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: NinjaKeys.productItem(product.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        /*
        leading: Checkbox(
          key: NinjaKeys.productItemCheckbox(product.id),
          value: true,
          onChanged: onCheckboxChanged,
        ),
        */
        trailing: Text(product.cost.toStringAsFixed(2)),
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            product.productKey,
            //key: NinjaKeys.productItemProductKey(product.id),
            style: Theme.of(context).textTheme.title,
          ),
        ),
        subtitle: Text(product.notes),
      ),
      background: new Container(
          color: Colors.red,
          child: const ListTile(
              leading: const Icon(Icons.delete, color: Colors.white, size: 36.0)
          )
      ),
      secondaryBackground: new Container(
          color: Colors.orange,
          child: const ListTile(
              trailing: const Icon(Icons.archive, color: Colors.white, size: 36.0)
          )
      ),
    );
  }
}
