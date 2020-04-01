import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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

  void _updateTable() {
    setState(() {
      _updatedAt = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = state.company;
    final invoice = viewModel.invoice;
    final lineItems = invoice.lineItems.toList();
    final productState = state.productState;
    final productIds =
        memoizedDropdownProductList(productState.map, productState.list);

    if (lineItems.where((item) => item.isEmpty).isEmpty) {
      lineItems.add(InvoiceItemEntity());
    }

    int lastIndex = 5;
    lastIndex += company.settings.numberOfItemTaxRates ?? 0;
    if (company.hasCustomField(CustomFieldType.product1)) {
      lastIndex++;
    }
    if (company.hasCustomField(CustomFieldType.product2)) {
      lastIndex++;
    }
    if (company.hasCustomField(CustomFieldType.product3)) {
      lastIndex++;
    }
    if (company.hasCustomField(CustomFieldType.product4)) {
      lastIndex++;
    }

    return FormCard(
      padding: const EdgeInsets.symmetric(horizontal: kMobileDialogPadding),
      child: Table(
        defaultColumnWidth: FixedColumnWidth(100),
        columnWidths: {
          0: FractionColumnWidth(.15),
          1: FractionColumnWidth(.25),
          lastIndex: FixedColumnWidth(kMinInteractiveDimension),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        key: ValueKey('__datatable_${_updatedAt}__'),
        children: [
          TableRow(children: [
            TableHeader(localization.item),
            TableHeader(localization.description),
            if (company.hasCustomField(CustomFieldType.product1))
              TableHeader(
                  company.getCustomFieldLabel(CustomFieldType.product1)),
            if (company.hasCustomField(CustomFieldType.product2))
              TableHeader(
                  company.getCustomFieldLabel(CustomFieldType.product2)),
            if (company.hasCustomField(CustomFieldType.product3))
              TableHeader(
                  company.getCustomFieldLabel(CustomFieldType.product3)),
            if (company.hasCustomField(CustomFieldType.product4))
              TableHeader(
                  company.getCustomFieldLabel(CustomFieldType.product4)),
            if ((company.settings.numberOfItemTaxRates ?? 0) >= 1)
              TableHeader(localization.tax),
            if ((company.settings.numberOfItemTaxRates ?? 0) >= 2)
              TableHeader(localization.tax),
            if ((company.settings.numberOfItemTaxRates ?? 0) >= 3)
              TableHeader(localization.tax),
            TableHeader(localization.unitCost, isNumeric: true),
            TableHeader(localization.quantity, isNumeric: true),
            TableHeader(localization.lineTotal, isNumeric: true),
            TableHeader(''),
          ]),
          for (var index = 0; index < lineItems.length; index++)
            TableRow(
                key: ValueKey(
                    '__line_item_${index}_${lineItems[index].createdAt}__'),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: kTableColumnGap),
                    child: TypeAheadFormField<String>(
                      initialValue: lineItems[index].productKey,
                      noItemsFoundBuilder: (context) => SizedBox(),
                      suggestionsCallback: (pattern) {
                        return productIds
                            .where((productId) => productState
                                .map[productId].productKey
                                .toLowerCase()
                                .contains(pattern.toLowerCase()))
                            .toList();
                        /*
                        return productIds
                            .where((productId) => productState.map[productId]
                                .matchesFilter(pattern))
                            .toList();                            
                         */
                      },
                      itemBuilder: (context, productId) {
                        // TODO fix this
                        /*
                        return ListTile(
                          title: Text(productState.map[suggestion].productKey),
                        );
                         */
                        return Listener(
                          child: Container(
                            color: Theme.of(context).cardColor,
                            child: ListTile(
                              title:
                                  Text(productState.map[productId].productKey),
                            ),
                          ),
                          onPointerDown: (_) {
                            if (!kIsWeb) {
                              return;
                            }
                            final item = lineItems[index];
                            final product = productState.map[productId];
                            final updatedItem = item.rebuild((b) => b
                              ..productKey = product.productKey
                              ..notes = product.notes
                              ..cost = product.price
                              ..quantity = item.quantity == 0 &&
                                      viewModel.state.company.defaultQuantity
                                  ? 1
                                  : item.quantity
                              ..customValue1 = product.customValue1
                              ..customValue2 = product.customValue2
                              ..customValue3 = product.customValue3
                              ..customValue4 = product.customValue4
                              ..taxRate1 = product.taxRate1
                              ..taxName1 = product.taxName1
                              ..taxRate2 = product.taxRate2
                              ..taxName2 = product.taxName2
                              ..taxRate3 = product.taxRate3
                              ..taxName3 = product.taxName3);
                            viewModel.onChangedInvoiceItem(updatedItem, index);
                            _updateTable();
                          },
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
                              : item.quantity
                          ..customValue1 = product.customValue1
                          ..customValue2 = product.customValue2
                          ..customValue3 = product.customValue3
                          ..customValue4 = product.customValue4
                          ..taxRate1 = product.taxRate1
                          ..taxName1 = product.taxName1
                          ..taxRate2 = product.taxRate2
                          ..taxName2 = product.taxName2
                          ..taxRate3 = product.taxRate3
                          ..taxName3 = product.taxName3);
                        viewModel.onChangedInvoiceItem(updatedItem, index);
                        _updateTable();
                      },
                      textFieldConfiguration:
                          TextFieldConfiguration<String>(onChanged: (value) {
                        viewModel.onChangedInvoiceItem(
                            lineItems[index]
                                .rebuild((b) => b..productKey = value),
                            index);
                      }),
                      autoFlipDirection: true,
                      //direction: AxisDirection.up,
                      animationStart: 1,
                      debounceDuration: Duration(seconds: 0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: kTableColumnGap),
                    child: TextFormField(
                      initialValue: lineItems[index].notes,
                      onChanged: (value) => viewModel.onChangedInvoiceItem(
                          lineItems[index].rebuild((b) => b..notes = value),
                          index),
                      minLines: 1,
                      maxLines: 6,
                      //maxLines: _focusNodes[index].hasFocus ? 6 : 1,
                      //focusNode: _focusNodes[index],
                    ),
                  ),
                  if (company.hasCustomField(CustomFieldType.product1))
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: CustomField(
                        field: CustomFieldType.product1,
                        value: lineItems[index].customValue1,
                        hideFieldLabel: true,
                        onChanged: (value) => viewModel.onChangedInvoiceItem(
                            lineItems[index]
                                .rebuild((b) => b..customValue1 = value),
                            index),
                      ),
                    ),
                  if (company.hasCustomField(CustomFieldType.product2))
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: CustomField(
                        field: CustomFieldType.product2,
                        value: lineItems[index].customValue2,
                        hideFieldLabel: true,
                        onChanged: (value) => viewModel.onChangedInvoiceItem(
                            lineItems[index]
                                .rebuild((b) => b..customValue2 = value),
                            index),
                      ),
                    ),
                  if (company.hasCustomField(CustomFieldType.product3))
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: CustomField(
                        field: CustomFieldType.product3,
                        value: lineItems[index].customValue3,
                        hideFieldLabel: true,
                        onChanged: (value) => viewModel.onChangedInvoiceItem(
                            lineItems[index]
                                .rebuild((b) => b..customValue3 = value),
                            index),
                      ),
                    ),
                  if (company.hasCustomField(CustomFieldType.product4))
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: CustomField(
                        field: CustomFieldType.product4,
                        value: lineItems[index].customValue4,
                        hideFieldLabel: true,
                        onChanged: (value) => viewModel.onChangedInvoiceItem(
                            lineItems[index]
                                .rebuild((b) => b..customValue4 = value),
                            index),
                      ),
                    ),
                  if ((company.settings.numberOfItemTaxRates ?? 0) >= 1)
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: TaxRateDropdown(
                        onSelected: (taxRate) => viewModel.onChangedInvoiceItem(
                            lineItems[index].rebuild((b) => b
                              ..taxName1 = taxRate.name
                              ..taxRate1 = taxRate.rate),
                            index),
                        labelText: null,
                        initialTaxName: lineItems[index].taxName1,
                        initialTaxRate: lineItems[index].taxRate1,
                      ),
                    ),
                  if ((company.settings.numberOfItemTaxRates ?? 0) >= 2)
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: TaxRateDropdown(
                        onSelected: (taxRate) => viewModel.onChangedInvoiceItem(
                            lineItems[index].rebuild((b) => b
                              ..taxName2 = taxRate.name
                              ..taxRate2 = taxRate.rate),
                            index),
                        labelText: null,
                        initialTaxName: lineItems[index].taxName2,
                        initialTaxRate: lineItems[index].taxRate2,
                      ),
                    ),
                  if ((company.settings.numberOfItemTaxRates ?? 0) >= 3)
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: TaxRateDropdown(
                        onSelected: (taxRate) => viewModel.onChangedInvoiceItem(
                            lineItems[index].rebuild((b) => b
                              ..taxName3 = taxRate.name
                              ..taxRate3 = taxRate.rate),
                            index),
                        labelText: null,
                        initialTaxName: lineItems[index].taxName3,
                        initialTaxRate: lineItems[index].taxRate3,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(right: kTableColumnGap),
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      initialValue: formatNumber(lineItems[index].cost, context,
                          formatNumberType: FormatNumberType.input),
                      onChanged: (value) => viewModel.onChangedInvoiceItem(
                          lineItems[index]
                              .rebuild((b) => b..cost = parseDouble(value)),
                          index),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: kTableColumnGap),
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      initialValue: formatNumber(
                          lineItems[index].quantity, context,
                          formatNumberType: FormatNumberType.input),
                      onChanged: (value) => viewModel.onChangedInvoiceItem(
                          lineItems[index]
                              .rebuild((b) => b..quantity = parseDouble(value)),
                          index),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: kTableColumnGap),
                    child: TextFormField(
                      key: ValueKey(
                          '__total_${index}_${lineItems[index].total}__'),
                      readOnly: true,
                      enabled: false,
                      initialValue:
                          formatNumber(lineItems[index].total, context),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    tooltip: localization.remove,
                    onPressed: lineItems[index].isEmpty
                        ? null
                        : () {
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
      padding:
          EdgeInsets.only(bottom: 8, right: isNumeric ? kTableColumnGap : 0),
      child: Text(
        label,
        textAlign: isNumeric ? TextAlign.right : TextAlign.left,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
