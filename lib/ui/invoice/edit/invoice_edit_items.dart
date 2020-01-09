import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_item_view.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class InvoiceEditItems extends StatefulWidget {
  const InvoiceEditItems({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditItemsVM viewModel;

  @override
  _InvoiceEditItemsState createState() => _InvoiceEditItemsState();
}

class _InvoiceEditItemsState extends State<InvoiceEditItems> {
  InvoiceItemEntity selectedInvoiceItem;

  void _showInvoiceItemEditor(
      InvoiceItemEntity invoiceItem, BuildContext context) {
    showDialog<ItemEditDetails>(
        context: context,
        builder: (BuildContext context) {
          final viewModel = widget.viewModel;
          final invoice = viewModel.invoice;

          return ItemEditDetails(
            viewModel: viewModel,
            key: Key(invoiceItem.entityKey),
            invoiceItem: invoiceItem,
            index: invoice.invoiceItems.indexOf(
                invoice.invoiceItems.firstWhere((i) => i.id == invoiceItem.id)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final invoiceItem = invoice.invoiceItems.contains(viewModel.invoiceItem)
        ? viewModel.invoiceItem
        : null;

    if (invoiceItem != null && invoiceItem != selectedInvoiceItem) {
      selectedInvoiceItem = invoiceItem;
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        _showInvoiceItemEditor(invoiceItem, context);
      });
    }

    if (invoice.invoiceItems.isEmpty) {
      return Center(
        child: Text(
          localization.clickPlusToAddItem,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          ),
        ),
      );
    }

    final invoiceItems =
        invoice.invoiceItems.map((invoiceItem) => InvoiceItemListTile(
              invoice: invoice,
              invoiceItem: invoiceItem,
              onTap: () => _showInvoiceItemEditor(invoiceItem, context),
            ));

    return ListView(
      children: invoiceItems.toList(),
    );
  }
}

class ItemEditDetails extends StatefulWidget {
  const ItemEditDetails({
    Key key,
    @required this.index,
    @required this.invoiceItem,
    @required this.viewModel,
  }) : super(key: key);

  final int index;
  final InvoiceItemEntity invoiceItem;
  final EntityEditItemsVM viewModel;

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

  TaxRateEntity _taxRate1;
  TaxRateEntity _taxRate2;

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    if (_controllers.isNotEmpty) {
      return;
    }

    final invoiceItem = widget.invoiceItem;
    _productKeyController.text = invoiceItem.productKey;
    _notesController.text = invoiceItem.notes;
    _costController.text = formatNumber(invoiceItem.cost, context,
        formatNumberType: FormatNumberType.input);
    _qtyController.text = formatNumber(invoiceItem.qty, context,
        formatNumberType: FormatNumberType.input);
    _discountController.text = formatNumber(invoiceItem.discount, context,
        formatNumberType: FormatNumberType.input);
    _custom1Controller.text = invoiceItem.customValue1;
    _custom2Controller.text = invoiceItem.customValue2;

    _controllers = [
      _productKeyController,
      _notesController,
      _costController,
      _qtyController,
      _discountController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    var invoiceItem = widget.invoiceItem.rebuild((b) => b
      ..productKey = _productKeyController.text.trim()
      ..notes = _notesController.text
      ..cost = parseDouble(_costController.text)
      ..qty = parseDouble(_qtyController.text)
      ..discount = parseDouble(_discountController.text)
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim());

    if (_taxRate1 != null) {
      invoiceItem = invoiceItem.applyTax(_taxRate1);
    }
    if (_taxRate2 != null) {
      invoiceItem = invoiceItem.applyTax(_taxRate2, isSecond: true);
    }

    if (invoiceItem != widget.invoiceItem) {
      widget.viewModel.onChangedInvoiceItem(invoiceItem, widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoiceItem = widget.invoiceItem;
    final company = viewModel.company;

    return ResponsivePadding(
      child: SingleChildScrollView(
        child: FormCard(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  color: Colors.red,
                  icon: Icons.delete,
                  label: localization.remove,
                  onPressed: () {
                    widget.viewModel.onRemoveInvoiceItemPressed(widget.index);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  icon: Icons.check_circle,
                  label: localization.done,
                  onPressed: () {
                    viewModel.onDoneInvoiceItemPressed();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            DecoratedFormField(
              label: localization.product,
              controller: _productKeyController,
            ),
            DecoratedFormField(
              label: localization.description,
              controller: _notesController,
              maxLines: 4,
            ),
            CustomField(
              controller: _custom1Controller,
              labelText: company.getCustomFieldLabel(CustomFieldType.product1),
              options: company.getCustomFieldValues(CustomFieldType.product1),
            ),
            CustomField(
              controller: _custom2Controller,
              labelText: company.getCustomFieldLabel(CustomFieldType.product2),
              options: company.getCustomFieldValues(CustomFieldType.product2),
            ),
            DecoratedFormField(
              label: localization.unitCost,
              controller: _costController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            company.hasInvoiceField('quantity')
                ? DecoratedFormField(
                    label: localization.quantity,
                    controller: _qtyController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  )
                : Container(),
            company.hasInvoiceField('discount')
                ? DecoratedFormField(
                    label: localization.discount,
                    controller: _discountController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  )
                : Container(),
            company.enableInvoiceItemTaxes
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) {
                      _taxRate1 = taxRate;
                      _onChanged();
                    },
                    labelText: localization.tax,
                    initialTaxName: invoiceItem.taxName1,
                    initialTaxRate: invoiceItem.taxRate1,
                  )
                : Container(),
            company.enableInvoiceItemTaxes && company.enableSecondTaxRate
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) {
                      _taxRate2 = taxRate;
                      _onChanged();
                    },
                    labelText: localization.tax,
                    initialTaxName: invoiceItem.taxName2,
                    initialTaxRate: invoiceItem.taxRate2,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
