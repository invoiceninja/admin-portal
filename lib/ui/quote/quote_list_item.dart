import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class QuoteListItem extends StatefulWidget {
  const QuoteListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.invoice,
    @required this.client,
    @required this.filter,
    @required this.hasDocuments,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final QuoteEntity invoice;
  final ClientEntity client;
  final String filter;
  final bool hasDocuments;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  @override
  _QuoteListItemState createState() => _QuoteListItemState();
}

class _QuoteListItemState extends State<QuoteListItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final quoteUIState = uiState.quoteUIState;
    final listUIState = quoteUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = widget.onCheckboxChanged != null || isInMultiselect;

    if (isInMultiselect) {
      _multiselectCheckboxAnimController.forward();
    } else {
      _multiselectCheckboxAnimController.animateBack(0.0);
    }

    final localization = AppLocalization.of(context);
    final filterMatch = widget.filter != null && widget.filter.isNotEmpty
        ? (widget.invoice.matchesFilterValue(widget.filter) ??
            widget.client.matchesFilterValue(widget.filter))
        : null;

    final invoiceStatusId = (widget.invoice.quoteInvoiceId ?? '').isNotEmpty
        ? kQuoteStatusApproved
        : widget.invoice.invoiceStatusId;

    return DismissibleEntity(
      isSelected: widget.invoice.id ==
          (uiState.isEditing
              ? quoteUIState.editing.id
              : quoteUIState.selectedId),
      userCompany: state.userCompany,
      entity: widget.invoice,
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
                    //key: NinjaKeys.quoteItemCheckbox(task.id),
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
                  widget.client.displayName,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(
                  formatNumber(
                      widget.invoice.balance > 0
                          ? widget.invoice.balance
                          : widget.invoice.amount,
                      context,
                      clientId: widget.invoice.clientId),
                  style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: filterMatch == null
                      ? Text((widget.invoice.invoiceNumber +
                              ' • ' +
                              formatDate(
                                  widget.invoice.dueDate.isNotEmpty
                                      ? widget.invoice.dueDate
                                      : widget.invoice.invoiceDate,
                                  context) +
                              (widget.hasDocuments ? '  📎' : ''))
                          .trim())
                      : Text(
                          filterMatch,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
                Text(
                    widget.invoice.isPastDue
                        ? localization.pastDue
                        : localization
                            .lookup('invoice_status_$invoiceStatusId'),
                    style: TextStyle(
                      color: widget.invoice.isPastDue
                          ? Colors.red
                          : QuoteStatusColors.colors[invoiceStatusId],
                    )),
              ],
            ),
            EntityStateLabel(widget.invoice),
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
