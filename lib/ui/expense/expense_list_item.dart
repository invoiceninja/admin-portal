import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseListItem extends StatefulWidget {
  const ExpenseListItem({
    @required this.userCompany,
    @required this.onTap,
    @required this.expense,
    @required this.client,
    @required this.vendor,
    @required this.filter,
    @required this.hasDocuments,
    this.onEntityAction,
    this.onLongPress,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserCompanyEntity userCompany;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final ValueChanged<bool> onCheckboxChanged;
  final ExpenseEntity expense;
  final ClientEntity client;
  final bool isChecked;
  final VendorEntity vendor;
  final String filter;
  final bool hasDocuments;

  static final expenseItemKey = (int id) => Key('__expense_item_${id}__');

  @override
  _ExpenseListItemState createState() => _ExpenseListItemState();
}

class _ExpenseListItemState extends State<ExpenseListItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final expenseUIState = uiState.expenseUIState;

    final filterMatch = widget.filter != null && widget.filter.isNotEmpty
        ? widget.expense.matchesFilterValue(widget.filter)
        : null;

    final company = state.selectedCompany;
    final category = company.expenseCategoryMap[widget.expense.categoryId];

    String subtitle = '';
    if (filterMatch != null) {
      subtitle = filterMatch;
    } else if (widget.client != null ||
        widget.vendor != null ||
        category != null) {
      if (category != null) {
        subtitle += category.name;
        if (widget.vendor != null || widget.client != null) {
          subtitle += ' • ';
        }
      }
      if (widget.vendor != null) {
        subtitle += widget.vendor.name;
        if (widget.client != null) {
          subtitle += ' • ';
        }
      }
      if (widget.client != null) {
        subtitle += widget.client.displayName;
      }
    }
    if (widget.hasDocuments) {
      if (subtitle.isNotEmpty) {
        subtitle += '  ';
      }
      subtitle += '📎';
    }
    final listUIState = expenseUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = widget.onCheckboxChanged != null || isInMultiselect;

    if (isInMultiselect) {
      _multiselectCheckboxAnimController.forward();
    } else {
      _multiselectCheckboxAnimController.animateBack(0.0);
    }

    return DismissibleEntity(
      isSelected: widget.expense.id ==
          (uiState.isEditing
              ? expenseUIState.editing.id
              : expenseUIState.selectedId),
      userCompany: widget.userCompany,
      entity: widget.expense,
      onEntityAction: widget.onEntityAction,
      child: ListTile(
        onTap: isInMultiselect
            ? () => widget.onEntityAction(EntityAction.toggleMultiselect)
            : widget.onTap,
        onLongPress: widget.onLongPress,
        leading: showCheckbox
            ? FadeTransition(
                opacity: _multiselectCheckboxAnim,
                child: IgnorePointer(
                  ignoring: listUIState.isInMultiselect(),
                  child: Checkbox(
                    //key: NinjaKeys.expenseItemCheckbox(task.id),
                    value: widget.isChecked,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) => widget.onCheckboxChanged(value),
                    activeColor: Theme.of(context).accentColor,
                  ),
                ),
              )
            : null,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.expense.publicNotes.isNotEmpty
                      ? widget.expense.publicNotes
                      : formatDate(widget.expense.expenseDate, context),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(
                  formatNumber(widget.expense.amountWithTax, context,
                      currencyId: widget.expense.expenseCurrencyId),
                  style: Theme.of(context).textTheme.title)
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
                        .lookup('expense_status_${widget.expense.statusId}'),
                    style: TextStyle(
                      color:
                          ExpenseStatusColors.colors[widget.expense.statusId],
                    )),
              ],
            ),
            EntityStateLabel(widget.expense),
          ],
        ),
      ),
    );
  }

  Animation _multiselectCheckboxAnim;
  AnimationController _multiselectCheckboxAnimController;

  @override
  void initState() {
    super.initState();
    _multiselectCheckboxAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _multiselectCheckboxAnim = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_multiselectCheckboxAnimController);
  }

  @override
  void dispose() {
    _multiselectCheckboxAnimController.dispose();
    super.dispose();
  }
}
