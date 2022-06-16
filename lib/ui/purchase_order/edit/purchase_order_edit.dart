import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/edit/purchase_order_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';

class PurchaseOrderEdit extends StatefulWidget {
  const PurchaseOrderEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final PurchaseOrderEditVM viewModel;

  @override
  _PurchaseOrderEditState createState() => _PurchaseOrderEditState();
}

class _PurchaseOrderEditState extends State<PurchaseOrderEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_purchaseOrderEdit');

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      // STARTER: array - do not remove comment
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    // STARTER: read value - do not remove comment
    //_purchase_ordersController.text = purchase_order.purchase_orders;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    //
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final purchaseOrder = viewModel.invoice;

    return EditScaffold(
      title: purchaseOrder.isNew
          ? localization.newPurchaseOrder
          : localization.editPurchaseOrder,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        /*
          setState(() {
            _autoValidate = !isValid;
          });
          */

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[],
                ),
              ],
            );
          })),
    );
  }
}
