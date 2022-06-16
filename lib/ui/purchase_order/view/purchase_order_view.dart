import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/purchase_order/view/purchase_order_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';

class PurchaseOrderView extends StatefulWidget {
  const PurchaseOrderView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final PurchaseOrderViewVM viewModel;
  final bool isFilter;

  @override
  _PurchaseOrderViewState createState() => new _PurchaseOrderViewState();
}

class _PurchaseOrderViewState extends State<PurchaseOrderView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final purchaseOrder = viewModel.purchaseOrder;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: purchaseOrder,
      body: ScrollableListView(
        children: <Widget>[],
      ),
    );
  }
}
