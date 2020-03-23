import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    @required this.userCompany,
    @required this.onTap,
    @required this.product,
    @required this.filter,
    this.onEntityAction,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserCompanyEntity userCompany;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  //final ValueChanged<bool> onCheckboxChanged;
  final ProductEntity product;
  final String filter;

  static final productItemKey = (int id) => Key('__product_item_${id}__');

  @override
  Widget build(BuildContext context) {
    final filterMatch = filter != null && filter.isNotEmpty
        ? product.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch ?? product.notes;
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final productUIState = uiState.productUIState;
    final listUIState = productUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    return DismissibleEntity(
      isSelected: product.id ==
          (uiState.isEditing
              ? productUIState.editing.id
              : productUIState.selectedId),
      userCompany: userCompany,
      entity: product,
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: showCheckbox
            ? IgnorePointer(
                ignoring: listUIState.isInMultiselect(),
                child: Checkbox(
                  value: isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) => onCheckboxChanged(value),
                  activeColor: Theme.of(context).accentColor,
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  product.productKey,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(formatNumber(product.price, context),
                  style: Theme.of(context).textTheme.headline6),
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
}
