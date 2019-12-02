import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class InvoiceEditItemsDesktop extends StatefulWidget {
  const InvoiceEditItemsDesktop({this.viewModel});

  final EntityEditItemsVM viewModel;

  @override
  _InvoiceEditItemsDesktopState createState() =>
      _InvoiceEditItemsDesktopState();
}

class _InvoiceEditItemsDesktopState extends State<InvoiceEditItemsDesktop> {
  int _updatedAt;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final productState = viewModel.state.productState;
    final productIds =
        memoizedDropdownProductList(productState.map, productState.list);

    return FormCard(
      padding: const EdgeInsets.symmetric(horizontal: kMobileDialogPadding),
      child: DataTable(
        key: ValueKey('__datatable_${_updatedAt}__'),
        columns: [
          DataColumn(
            label: Text(localization.item),
          ),
          DataColumn(
            label: Text(localization.description),
          ),
          DataColumn(
            label: Text(localization.unitCost),
            numeric: true,
          ),
          DataColumn(
            label: Text(localization.quantity),
            numeric: true,
          ),
          DataColumn(
            label: Text(localization.lineTotal),
            numeric: true,
          ),
        ],
        rows: invoice.lineItems.map((item) {
          final index = invoice.lineItems.indexOf(item);
          return DataRow(
            cells: [
              DataCell(TypeAheadField<String>(
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
                  setState(() {
                    _updatedAt = DateTime.now().millisecondsSinceEpoch;
                  });
                },
                autoFlipDirection: true,
                direction: AxisDirection.up,
                animationStart: 1,
              )),
              DataCell(TextFormField(
                initialValue: item.notes,
                onChanged: (value) => viewModel.onChangedInvoiceItem(
                    item.rebuild((b) => b..notes = value), index),
              )),
              DataCell(TextFormField(
                textAlign: TextAlign.right,
                initialValue: formatNumber(item.cost, context,
                    formatNumberType: FormatNumberType.input),
                onChanged: (value) => viewModel.onChangedInvoiceItem(
                    item.rebuild((b) => b..cost = parseDouble(value)), index),
              )),
              DataCell(TextFormField(
                textAlign: TextAlign.right,
                initialValue: formatNumber(item.quantity, context,
                    formatNumberType: FormatNumberType.input),
                onChanged: (value) => viewModel.onChangedInvoiceItem(
                    item.rebuild((b) => b..quantity = parseDouble(value)),
                    index),
              )),
              DataCell(Text(
                formatNumber(item.total, context),
                textAlign: TextAlign.right,
              )),
            ],
          );
        }).toList(),
      ),
    );
  }
}
