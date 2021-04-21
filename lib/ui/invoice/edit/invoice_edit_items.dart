import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_item_view.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditItems extends StatefulWidget {
  const InvoiceEditItems({
    Key key,
    @required this.viewModel,
    @required this.entityViewModel,
  }) : super(key: key);

  final EntityEditItemsVM viewModel;
  final EntityEditVM entityViewModel;

  @override
  _InvoiceEditItemsState createState() => _InvoiceEditItemsState();
}

class _InvoiceEditItemsState extends State<InvoiceEditItems> {
  int selectedItemIndex;

  void _showInvoiceItemEditor(int lineItemIndex, BuildContext context) {
    showDialog<ItemEditDetails>(
        context: context,
        builder: (BuildContext context) {
          final viewModel = widget.viewModel;
          final invoice = viewModel.invoice;

          return ItemEditDetails(
            viewModel: viewModel,
            entityViewModel: widget.entityViewModel,
            key: ValueKey('__${lineItemIndex}__'),
            invoiceItem: invoice.lineItems[lineItemIndex],
            index: lineItemIndex,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final itemIndex = viewModel.invoiceItemIndex;

    final invoiceItem =
        itemIndex != null && invoice.lineItems.length > itemIndex
            ? invoice.lineItems[itemIndex]
            : null;

    if (invoiceItem != null && itemIndex != selectedItemIndex) {
      viewModel.clearSelectedInvoiceItem();
      WidgetsBinding.instance.addPostFrameCallback((duration) async {
        _showInvoiceItemEditor(itemIndex, context);
      });
    }

    if (invoice.lineItems.isEmpty) {
      return HelpText(localization.clickPlusToAddItem);
    }

    return ScrollableListView(
      children: [
        for (int i = 0; i < invoice.lineItems.length; i++)
          InvoiceItemListTile(
            invoice: invoice,
            invoiceItem: invoice.lineItems[i],
            onTap: () => _showInvoiceItemEditor(i, context),
          )
      ],
    );
  }
}

class ItemEditDetails extends StatefulWidget {
  const ItemEditDetails({
    Key key,
    @required this.index,
    @required this.invoiceItem,
    @required this.viewModel,
    @required this.entityViewModel,
  }) : super(key: key);

  final int index;
  final InvoiceItemEntity invoiceItem;
  final EntityEditItemsVM viewModel;
  final EntityEditVM entityViewModel;

  @override
  ItemEditDetailsState createState() => ItemEditDetailsState();
}

class ItemEditDetailsState extends State<ItemEditDetails> {
  final _productKeyController = TextEditingController();
  final _notesController = TextEditingController();
  final _costController = TextEditingController();
  final _qtyController = TextEditingController();
  final _discountController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  TaxRateEntity _taxRate1;
  TaxRateEntity _taxRate2;
  TaxRateEntity _taxRate3;

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    if (_controllers.isNotEmpty) {
      return;
    }

    final invoiceItem = widget.invoiceItem;
    _productKeyController.text = invoiceItem.productKey;
    _notesController.text = invoiceItem.notes;
    _costController.text = formatNumber(invoiceItem.cost, context,
        formatNumberType: FormatNumberType.inputMoney);
    _qtyController.text = formatNumber(invoiceItem.quantity, context,
        formatNumberType: FormatNumberType.inputAmount);
    _discountController.text = formatNumber(invoiceItem.discount, context,
        formatNumberType: FormatNumberType.inputMoney);
    _custom1Controller.text = invoiceItem.customValue1;
    _custom2Controller.text = invoiceItem.customValue2;
    _custom3Controller.text = invoiceItem.customValue3;
    _custom4Controller.text = invoiceItem.customValue4;

    _controllers = [
      _productKeyController,
      _notesController,
      _costController,
      _qtyController,
      _discountController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
    ];

    _controllers.forEach(
        (dynamic controller) => controller.addListener(_onTextChanged));

    _taxRate1 =
        TaxRateEntity(name: invoiceItem.taxName1, rate: invoiceItem.taxRate1);
    _taxRate2 =
        TaxRateEntity(name: invoiceItem.taxName2, rate: invoiceItem.taxRate2);
    _taxRate3 =
        TaxRateEntity(name: invoiceItem.taxName3, rate: invoiceItem.taxRate3);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onTextChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onTextChanged() {
    _debouncer.run(() {
      _onChanged();
    });
  }

  void _onChanged() {
    var invoiceItem = widget.invoiceItem.rebuild((b) => b
      ..productKey = _productKeyController.text.trim()
      ..notes = _notesController.text
      ..cost = parseDouble(_costController.text)
      ..quantity = parseDouble(_qtyController.text)
      ..discount = parseDouble(_discountController.text)
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim());

    if (_taxRate1 != null && !_taxRate1.isEmpty) {
      invoiceItem = invoiceItem.applyTax(_taxRate1);
    }
    if (_taxRate2 != null && !_taxRate2.isEmpty) {
      invoiceItem = invoiceItem.applyTax(_taxRate2, isSecond: true);
    }
    if (_taxRate3 != null && !_taxRate3.isEmpty) {
      invoiceItem = invoiceItem.applyTax(_taxRate3, isThird: true);
    }

    if (invoiceItem != widget.invoiceItem) {
      widget.viewModel.onChangedInvoiceItem(invoiceItem, widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    return AlertDialog(
      actions: [
        TextButton(
          child: Text(localization.remove.toUpperCase()),
          onPressed: () => confirmCallback(
              context: context,
              callback: () {
                widget.viewModel.onRemoveInvoiceItemPressed(widget.index);
                Navigator.of(context).pop();
              }),
        ),
        TextButton(
          child: Text(localization.done.toUpperCase()),
          onPressed: () {
            viewModel.clearSelectedInvoiceItem();
            Navigator.of(context).pop();
          },
        )
      ],
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DecoratedFormField(
              label: localization.product,
              controller: _productKeyController,
              onSavePressed: widget.entityViewModel.onSavePressed,
            ),
            DecoratedFormField(
              keyboardType: TextInputType.multiline,
              label: localization.description,
              controller: _notesController,
              maxLines: 4,
            ),
            CustomField(
              controller: _custom1Controller,
              field: widget.invoiceItem.isTask
                  ? CustomFieldType.task1
                  : CustomFieldType.product1,
              onSavePressed: widget.entityViewModel.onSavePressed,
              value: _custom1Controller.text,
            ),
            CustomField(
              controller: _custom2Controller,
              field: widget.invoiceItem.isTask
                  ? CustomFieldType.task2
                  : CustomFieldType.product2,
              onSavePressed: widget.entityViewModel.onSavePressed,
              value: _custom2Controller.text,
            ),
            CustomField(
              controller: _custom3Controller,
              field: widget.invoiceItem.isTask
                  ? CustomFieldType.task3
                  : CustomFieldType.product3,
              onSavePressed: widget.entityViewModel.onSavePressed,
              value: _custom3Controller.text,
            ),
            CustomField(
              controller: _custom4Controller,
              field: widget.invoiceItem.isTask
                  ? CustomFieldType.task4
                  : CustomFieldType.product4,
              onSavePressed: widget.entityViewModel.onSavePressed,
              value: _custom4Controller.text,
            ),
            DecoratedFormField(
              label: localization.unitCost,
              controller: _costController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSavePressed: widget.entityViewModel.onSavePressed,
            ),
            company.enableProductQuantity
                ? DecoratedFormField(
                    label: localization.quantity,
                    controller: _qtyController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onSavePressed: widget.entityViewModel.onSavePressed,
                  )
                : Container(),
            company.enableProductDiscount
                ? DecoratedFormField(
                    label: localization.discount,
                    controller: _discountController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onSavePressed: widget.entityViewModel.onSavePressed,
                  )
                : Container(),
            if (company.enableFirstItemTaxRate || _taxRate1.name.isNotEmpty)
              TaxRateDropdown(
                onSelected: (taxRate) {
                  setState(() {
                    _taxRate1 = taxRate;
                    _onChanged();
                  });
                },
                labelText: localization.tax,
                initialTaxName: _taxRate1.name,
                initialTaxRate: _taxRate1.rate,
              ),
            if (company.enableSecondItemTaxRate || _taxRate2.name.isNotEmpty)
              TaxRateDropdown(
                onSelected: (taxRate) {
                  setState(() {
                    _taxRate2 = taxRate;
                    _onChanged();
                  });
                },
                labelText: localization.tax,
                initialTaxName: _taxRate2.name,
                initialTaxRate: _taxRate2.rate,
              ),
            if (company.enableThirdItemTaxRate || _taxRate3.name.isNotEmpty)
              TaxRateDropdown(
                onSelected: (taxRate) {
                  setState(() {
                    _taxRate3 = taxRate;
                    _onChanged();
                  });
                },
                labelText: localization.tax,
                initialTaxName: _taxRate3.name,
                initialTaxRate: _taxRate3.rate,
              ),
          ],
        ),
      ),
    );
  }
}
