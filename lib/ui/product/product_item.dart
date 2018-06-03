import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/utils/localization.dart';

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
          //key: NinjaKeys.productItemCheckbox(product.id),
          value: true,
          //onChanged: onCheckboxChanged,
          onChanged: (value) {
            return true;
          },
        ),
        */
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            product.isDeleted
                ? Chip(
                    label: Text(AppLocalization.of(context).deleted,
                        style: TextStyle(color: Colors.white, fontSize: 12.0)),
                    backgroundColor: Colors.red,
                  )
                : product.isArchived()
                    ? Chip(
                        label: Text(AppLocalization.of(context).archived,
                            style: TextStyle(color: Colors.white, fontSize: 12.0)),
                        backgroundColor: Colors.orange,
                      )
                    : Container(),
            //SizedBox(width: 12.0),
            //Text(product.cost.toStringAsFixed(2)),
          ],
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  product.productKey,
                  //key: NinjaKeys.productItemProductKey(product.id),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
          ),
        ),
        subtitle: Text(product.notes),
      ),
      background: product.isDeleted ? Container(
          color: Colors.blue,
          child: const ListTile(
              leading:
              const Icon(Icons.restore, color: Colors.white, size: 36.0)),
      ) : Container(
          color: Colors.red,
          child: const ListTile(
              leading:
                  const Icon(Icons.delete, color: Colors.white, size: 36.0))),
      secondaryBackground: product.isArchived() || product.isDeleted ? Container(
        color: Colors.blue,
        child: const ListTile(
            trailing:
            const Icon(Icons.restore, color: Colors.white, size: 36.0)),
      ) : Container(
          color: Colors.orange,
          child: const ListTile(
              trailing:
                  const Icon(Icons.archive, color: Colors.white, size: 36.0))),
    );
  }
}
