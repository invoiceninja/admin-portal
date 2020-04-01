import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyGatewayListItem extends StatelessWidget {
  const CompanyGatewayListItem({
    Key key,
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.companyGateway,
    @required this.filter,
    this.onRemovePressed,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  }) : super(key: key);

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final CompanyGatewayEntity companyGateway;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final Function onRemovePressed;
  final bool isChecked;

  static final companyGatewayItemKey =
      (int id) => Key('__company_gateway_item_${id}__');

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final filterMatch = filter != null && filter.isNotEmpty
        ? companyGateway.matchesFilterValue(filter)
        : null;
    final subtitle = filterMatch;
    final listUIState = state.uiState.companyGatewayUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = onCheckboxChanged != null || isInMultiselect;

    return DismissibleEntity(
      userCompany: state.userCompany,
      entity: companyGateway,
      isSelected: false,
      onEntityAction: onEntityAction,
      child: ListTile(
        onTap: isInMultiselect
            ? () => onEntityAction(EntityAction.toggleMultiselect)
            : onTap,
        onLongPress: onLongPress,
        trailing: onRemovePressed == null
            ? null
            : FlatButton(
                child: Text(AppLocalization.of(context).remove),
                onPressed: onRemovePressed,
              ),
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
            : Icon(Icons.drag_handle),
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  companyGateway.gateway.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(formatNumber(companyGateway.listDisplayAmount, context),
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
            EntityStateLabel(companyGateway),
          ],
        ),
      ),
    );
  }
}
