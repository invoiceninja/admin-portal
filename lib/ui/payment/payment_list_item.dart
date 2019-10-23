import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_state_label.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/dismissible_entity.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentListItem extends StatefulWidget {
  const PaymentListItem({
    @required this.user,
    @required this.onEntityAction,
    @required this.onTap,
    @required this.onLongPress,
    @required this.payment,
    @required this.filter,
    this.onCheckboxChanged,
    this.isChecked = false,
  });

  final UserEntity user;
  final Function(EntityAction) onEntityAction;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final PaymentEntity payment;
  final String filter;
  final Function(bool) onCheckboxChanged;
  final bool isChecked;

  static final paymentItemKey = (int id) => Key('__payment_${id}__');

  @override
  _PaymentListItemState createState() => _PaymentListItemState();
}

class _PaymentListItemState extends State<PaymentListItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final uiState = state.uiState;
    final paymentUIState = uiState.paymentUIState;
    final listUIState = paymentUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final showCheckbox = widget.onCheckboxChanged != null || isInMultiselect;

    if (isInMultiselect) {
      _multiselectCheckboxAnimController.forward();
    } else {
      _multiselectCheckboxAnimController.animateBack(0.0);
    }

    final invoice = paymentInvoiceSelector(widget.payment.id, state);
    final client = paymentClientSelector(widget.payment.id, state);

    final localization = AppLocalization.of(context);
    final filterMatch = widget.filter != null && widget.filter.isNotEmpty
        ? widget.payment.matchesFilterValue(widget.filter)
        : null;
    final subtitle = filterMatch ??
        invoice.invoiceNumber +
            ' • ' +
            formatDate(invoice.invoiceDate, context);

    return DismissibleEntity(
      isSelected: widget.payment.id ==
          (uiState.isEditing
              ? paymentUIState.editing.id
              : paymentUIState.selectedId),
      userCompany: state.userCompany,
      entity: widget.payment,
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
                    //key: NinjaKeys.productItemCheckbox(task.id),
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
                  client.displayName,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(formatNumber(widget.payment.amount, context),
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
                  child: subtitle != null && subtitle.isNotEmpty
                      ? Text(
                          subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container(),
                ),
                Text(
                    localization.lookup(
                        'payment_status_${widget.payment.paymentStatusId}'),
                    style: TextStyle(
                      color: PaymentStatusColors
                          .colors[widget.payment.paymentStatusId],
                    )),
              ],
            ),
            EntityStateLabel(widget.payment),
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
