import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/dismissible_entity.dart';

import '../app/entity_state_label.dart';

class ProductItem extends StatelessWidget {
  final AppState state;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  //final ValueChanged<bool> onCheckboxChanged;
  final ProductEntity product;
  final String filter;
  
  static final productItemKey = (int id) => Key('__product_item_${id}__');

  const ProductItem({
    @required this.state,
    @required this.onDismissed,
    @required this.onTap,
    //@required this.onCheckboxChanged,
    @required this.product,
    @required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final searchMatch = filter != null && filter.isNotEmpty
        ? product.matchesSearchValue(filter)
        : null;

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
              Text(formatNumber(product.cost, context),
                  style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              searchMatch ?? product.notes,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            EntityStateLabel(product),
          ],
        ),
      ),
    );
  }
}
