import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditItemsDesktop extends StatefulWidget {
  const InvoiceEditItemsDesktop({
    @required this.viewModel,
    @required this.entityViewModel,
    @required this.isTasks,
  });

  final EntityEditItemsVM viewModel;
  final EntityEditVM entityViewModel;
  final bool isTasks;

  @override
  _InvoiceEditItemsDesktopState createState() =>
      _InvoiceEditItemsDesktopState();
}

class _InvoiceEditItemsDesktopState extends State<InvoiceEditItemsDesktop> {
  int _updatedAt;
  String _filter = '';

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
    final productIds = memoizedDropdownProductList(
        productState.map, productState.list, state.userState.map);

    if (lineItems.where((item) => item.isEmpty).isEmpty) {
      lineItems.add(InvoiceItemEntity());
    }

    int lastIndex = 4;
    lastIndex += company.numberOfItemTaxRates ?? 0;
    if (company.enableProductQuantity || widget.isTasks) {
      lastIndex++;
    }
    if (company.enableProductDiscount) {
      lastIndex++;
    }
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
            if ((company.numberOfItemTaxRates ?? 0) >= 1)
              TableHeader(localization.tax),
            if ((company.numberOfItemTaxRates ?? 0) >= 2)
              TableHeader(localization.tax),
            if ((company.numberOfItemTaxRates ?? 0) >= 3)
              TableHeader(localization.tax),
            TableHeader(
                widget.isTasks ? localization.rate : localization.unitCost,
                isNumeric: true),
            if (company.enableProductQuantity || widget.isTasks)
              TableHeader(
                  widget.isTasks ? localization.hours : localization.quantity,
                  isNumeric: true),
            if (company.enableProductDiscount)
              TableHeader(localization.discount, isNumeric: true),
            TableHeader(localization.lineTotal, isNumeric: true),
            TableHeader(''),
          ]),
          for (var index = 0; index < lineItems.length; index++)
            if ((lineItems[index].typeId == InvoiceItemEntity.TYPE_TASK &&
                    widget.isTasks) ||
                (lineItems[index].typeId != InvoiceItemEntity.TYPE_TASK &&
                    !widget.isTasks) ||
                lineItems[index].isEmpty)
              TableRow(
                  key: ValueKey(
                      '__line_item_${index}_${lineItems[index].createdAt}__'),
                  children: [
                    /*
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: Autocomplete<ProductEntity>(
                        //key: ValueKey('__line_item_${index}_name__'),
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          final options = productIds
                              .map((productId) => productState.map[productId])
                              .where((product) => product.productKey
                                  .toLowerCase()
                                  .contains(_filter.toLowerCase()))
                              .toList();
/*
                          if (options.length == 1 &&
                              options[0].productKey.toLowerCase() ==
                                  _filter.toLowerCase()) {
                            return <ProductEntity>[];
                          }
                          */

                          return options;
                        },
                        displayStringForOption: (product) => product.productKey,
                        onSelected: (product) {
                          final item = lineItems[index];
                          final client =
                              state.clientState.get(invoice.clientId);
                          final currency =
                              state.staticState.currencyMap[client.currencyId];

                          double cost = product.price;
                          if (company.convertProductExchangeRate &&
                              invoice.clientId != null &&
                              client.currencyId != company.currencyId) {
                            cost = round(cost * invoice.exchangeRate,
                                currency.precision);
                          }

                          final updatedItem = item.rebuild((b) => b
                            ..productKey = product.productKey
                            ..notes = item.isTask ? item.notes : product.notes
                            ..cost =
                                item.isTask && item.cost != 0 ? item.cost : cost
                            ..quantity = item.isTask
                                ? item.quantity
                                : item.quantity == 0 &&
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
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          return DecoratedFormField(
                            showClear: false,
                            autofocus: false,
                            controller: textEditingController,
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                            onChanged: (value) {
                              _filter = value;
                              viewModel.onChangedInvoiceItem(
                                  lineItems[index]
                                      .rebuild((b) => b..productKey = value),
                                  index);
                            },
                          );
                        },
                      ),
                    ),
                    */
                    Padding(
                        padding: const EdgeInsets.only(right: kTableColumnGap),
                        child: TypeAheadFormField<String>(
                          key: ValueKey('__line_item_${index}_name__'),
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
                                  title: Text(
                                      productState.map[productId].productKey),
                                ),
                              ),
                              onPointerDown: (_) {
                                if (!kIsWeb) {
                                  return;
                                }
                                final item = lineItems[index];
                                final product = productState.map[productId];
                                final client =
                                    state.clientState.get(invoice.clientId);
                                final currency = state
                                    .staticState.currencyMap[client.currencyId];

                                double cost = product.price;
                                if (company.convertProductExchangeRate &&
                                    invoice.clientId != null &&
                                    client.currencyId != company.currencyId) {
                                  cost = round(cost * invoice.exchangeRate,
                                      currency.precision);
                                }

                                final updatedItem = item.rebuild((b) => b
                                  ..productKey = product.productKey
                                  ..notes =
                                      item.isTask ? item.notes : product.notes
                                  ..cost = item.isTask && item.cost != 0
                                      ? item.cost
                                      : cost
                                  ..quantity = item.isTask
                                      ? item.quantity
                                      : item.quantity == 0 &&
                                              viewModel
                                                  .state.company.defaultQuantity
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
                                viewModel.onChangedInvoiceItem(
                                    updatedItem, index);
                                _updateTable();
                              },
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            if (kIsWeb) {
                              return;
                            }
                            final item = lineItems[index];
                            final product = productState.map[suggestion];
                            final client =
                                state.clientState.get(invoice.clientId);

                            double cost = product.price;
                            if (company.convertProductExchangeRate &&
                                invoice.clientId != null &&
                                client.currencyId != company.currencyId) {
                              cost = round(
                                  cost * invoice.exchangeRate,
                                  state
                                      .staticState
                                      .currencyMap[client?.currencyId ??
                                          company.currencyId]
                                      .precision);
                            }

                            final updatedItem = item.rebuild((b) => b
                              ..productKey = product.productKey
                              ..notes = item.isTask ? item.notes : product.notes
                              ..cost = item.isTask && item.cost != 0
                                  ? item.cost
                                  : cost
                              ..quantity = item.isTask
                                  ? item.quantity
                                  : item.quantity == 0 &&
                                          viewModel
                                              .state.company.defaultQuantity
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
                              TextFieldConfiguration(onChanged: (value) {
                            viewModel.onChangedInvoiceItem(
                                lineItems[index]
                                    .rebuild((b) => b..productKey = value),
                                index);
                          }),
                          autoFlipDirection: true,
                          animationStart: 1,
                          debounceDuration: Duration(seconds: 0),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: TextFormField(
                        key: ValueKey('__line_item_${index}_description__'),
                        initialValue: lineItems[index].notes,
                        onChanged: (value) => viewModel.onChangedInvoiceItem(
                            lineItems[index].rebuild((b) => b..notes = value),
                            index),
                        keyboardType: TextInputType.multiline,
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
                          onSavePressed: widget.entityViewModel.onSavePressed,
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
                          onSavePressed: widget.entityViewModel.onSavePressed,
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
                          onSavePressed: widget.entityViewModel.onSavePressed,
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
                          onSavePressed: widget.entityViewModel.onSavePressed,
                        ),
                      ),
                    if ((company.numberOfItemTaxRates ?? 0) >= 1)
                      Padding(
                        padding: const EdgeInsets.only(right: kTableColumnGap),
                        child: TaxRateDropdown(
                          onSelected: (taxRate) =>
                              viewModel.onChangedInvoiceItem(
                                  lineItems[index].rebuild((b) => b
                                    ..taxName1 = taxRate.name
                                    ..taxRate1 = taxRate.rate),
                                  index),
                          labelText: null,
                          initialTaxName: lineItems[index].taxName1,
                          initialTaxRate: lineItems[index].taxRate1,
                        ),
                      ),
                    if ((company.numberOfItemTaxRates ?? 0) >= 2)
                      Padding(
                        padding: const EdgeInsets.only(right: kTableColumnGap),
                        child: TaxRateDropdown(
                          onSelected: (taxRate) =>
                              viewModel.onChangedInvoiceItem(
                                  lineItems[index].rebuild((b) => b
                                    ..taxName2 = taxRate.name
                                    ..taxRate2 = taxRate.rate),
                                  index),
                          labelText: null,
                          initialTaxName: lineItems[index].taxName2,
                          initialTaxRate: lineItems[index].taxRate2,
                        ),
                      ),
                    if ((company.numberOfItemTaxRates ?? 0) >= 3)
                      Padding(
                        padding: const EdgeInsets.only(right: kTableColumnGap),
                        child: TaxRateDropdown(
                          onSelected: (taxRate) =>
                              viewModel.onChangedInvoiceItem(
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
                      child: DecoratedFormField(
                        key: ValueKey('__line_item_${index}_cost__'),
                        textAlign: TextAlign.right,
                        initialValue: formatNumber(
                            lineItems[index].cost, context,
                            formatNumberType: FormatNumberType.inputMoney,
                            clientId: invoice.clientId),
                        onChanged: (value) => viewModel.onChangedInvoiceItem(
                            lineItems[index]
                                .rebuild((b) => b..cost = parseDouble(value)),
                            index),
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        onSavePressed: widget.entityViewModel.onSavePressed,
                      ),
                    ),
                    if (company.enableProductQuantity || widget.isTasks)
                      Padding(
                        padding: const EdgeInsets.only(right: kTableColumnGap),
                        child: DecoratedFormField(
                          key: ValueKey('__line_item_${index}_quantity__'),
                          textAlign: TextAlign.right,
                          initialValue: formatNumber(
                              lineItems[index].quantity, context,
                              formatNumberType: FormatNumberType.inputAmount,
                              clientId: invoice.clientId),
                          onChanged: (value) => viewModel.onChangedInvoiceItem(
                              lineItems[index].rebuild(
                                  (b) => b..quantity = parseDouble(value)),
                              index),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          onSavePressed: widget.entityViewModel.onSavePressed,
                        ),
                      ),
                    if (company.enableProductDiscount)
                      Padding(
                        padding: const EdgeInsets.only(right: kTableColumnGap),
                        child: DecoratedFormField(
                          key: ValueKey('__line_item_${index}_discount__'),
                          textAlign: TextAlign.right,
                          initialValue: formatNumber(
                              lineItems[index].discount, context,
                              formatNumberType: FormatNumberType.inputAmount,
                              clientId: invoice.clientId),
                          onChanged: (value) => viewModel.onChangedInvoiceItem(
                              lineItems[index].rebuild(
                                  (b) => b..discount = parseDouble(value)),
                              index),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          onSavePressed: widget.entityViewModel.onSavePressed,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: kTableColumnGap),
                      child: TextFormField(
                        key: ValueKey(
                            '__total_${index}_${lineItems[index].total}_${invoice.clientId}__'),
                        readOnly: true,
                        enabled: false,
                        initialValue: formatNumber(
                            lineItems[index].total, context,
                            clientId: invoice.clientId),
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
