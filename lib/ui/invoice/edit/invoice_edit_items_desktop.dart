import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class InvoiceEditItemsDesktop extends StatefulWidget {
  const InvoiceEditItemsDesktop({
    this.viewModel,
  });

  final EntityEditItemsVM viewModel;

  @override
  _InvoiceEditItemsDesktopState createState() =>
      _InvoiceEditItemsDesktopState();
}

class _InvoiceEditItemsDesktopState extends State<InvoiceEditItemsDesktop> {
  int _updatedAt;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _addBlankRow();
  }

    /*
  final Map<int, FocusNode> _focusNodes = {};

  @override
  void didChangeDependencies() {
    _focusNodes.values.forEach((node) => node.dispose());

    final lineItems = widget.viewModel.invoice.lineItems;
    for (var index = 0; index < lineItems.length; index++) {
      _focusNodes[index] = FocusNode()
        ..addListener(() => _onFocusChange(index));
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNodes.values.forEach((node) => node.dispose());
    super.dispose();
  }

  void _onFocusChange(int index) {
    setState(() {});
  }
  */

  void _addBlankRow() {
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    if (invoice.lineItems.where((item) => item.isEmpty).isEmpty) {
      viewModel.addLineItem();
    }
  }

  void _updateTable() {
    setState(() {
      _updatedAt = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final lineItems = invoice.lineItems;
    final productState = viewModel.state.productState;
    final productIds =
        memoizedDropdownProductList(productState.map, productState.list);

    return FormCard(
      padding: const EdgeInsets.symmetric(horizontal: kMobileDialogPadding),
      child: Table(
        defaultColumnWidth: FixedColumnWidth(150),
        columnWidths: {
          0: FixedColumnWidth(200),
          1: FlexColumnWidth(),
          5: FixedColumnWidth(50),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        key: ValueKey('__datatable_${_updatedAt}__'),
        children: [
          TableRow(children: [
            TableHeader(localization.item),
            TableHeader(localization.description),
            TableHeader(localization.unitCost, isNumeric: true),
            TableHeader(localization.quantity, isNumeric: true),
            TableHeader(localization.lineTotal, isNumeric: true),
            TableHeader(''),
          ]),
          for (var index = 0; index < lineItems.length; index++)
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(right: kTableColumnGap),
                child: TypeAheadFormField<String>(
                  initialValue: lineItems[index].productKey,
                  noItemsFoundBuilder: (context) => SizedBox(),
                  suggestionsCallback: (pattern) {
                    return productIds
                        .where((productId) =>
                            productState.map[productId].matchesFilter(pattern))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(productState.map[suggestion].productKey),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    final item = lineItems[index];
                    final product = productState.map[suggestion];
                    final updatedItem = item.rebuild((b) => b
                      ..productKey = product.productKey
                      ..notes = product.notes
                      ..cost = product.price
                      ..quantity = item.quantity == 0 &&
                              viewModel.state.company.defaultQuantity
                          ? 1
                          : item.quantity);
                    viewModel.onChangedInvoiceItem(updatedItem, index);
                    viewModel.addLineItem();
                    _updateTable();
                  },
                  textFieldConfiguration:
                      TextFieldConfiguration<String>(onChanged: (value) {
                    viewModel.onChangedInvoiceItem(
                        lineItems[index].rebuild((b) => b..productKey = value),
                        index);
                    _addBlankRow();
                  }),
                  autoFlipDirection: true,
                  direction: AxisDirection.up,
                  animationStart: 1,
                  debounceDuration: Duration(seconds: 0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: kTableColumnGap),
                child: TextFormField(
                  initialValue: lineItems[index].notes,
                  onChanged: (value) {
                    viewModel.onChangedInvoiceItem(
                        lineItems[index].rebuild((b) => b..notes = value),
                        index);
                    _addBlankRow();
                  },
                  minLines: 1,
                  maxLines: 6,
                  //maxLines: _focusNodes[index].hasFocus ? 6 : 1,
                  //focusNode: _focusNodes[index],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: kTableColumnGap),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  initialValue: formatNumber(lineItems[index].cost, context,
                      formatNumberType: FormatNumberType.input),
                  onChanged: (value) {
                    viewModel.onChangedInvoiceItem(
                        lineItems[index]
                            .rebuild((b) => b..cost = parseDouble(value)),
                        index);
                    _addBlankRow();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: kTableColumnGap),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  initialValue: formatNumber(lineItems[index].quantity, context,
                      formatNumberType: FormatNumberType.input),
                  onChanged: (value) {
                    viewModel.onChangedInvoiceItem(
                        lineItems[index]
                            .rebuild((b) => b..quantity = parseDouble(value)),
                        index);
                    _addBlankRow();
                  },
                ),
              ),
              TextFormField(
                key: ValueKey('__total_${index}_${lineItems[index].total}__'),
                readOnly: true,
                enabled: false,
                initialValue: formatNumber(lineItems[index].total, context),
                textAlign: TextAlign.right,
              ),
              lineItems[index].isEmpty
                  ? SizedBox()
                  : IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        viewModel.onRemoveInvoiceItemPressed(index);
                        _updateTable();
                      },
                    ),
            ])
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader(this.label, {this.isNumeric = false});

  final String label;
  final bool isNumeric;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        textAlign: isNumeric ? TextAlign.right : TextAlign.left,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
