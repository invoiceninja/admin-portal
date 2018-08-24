import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/invoice_item_view.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit_items_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class QuoteEditItems extends StatefulWidget {
  const QuoteEditItems({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final QuoteEditItemsVM viewModel;

  @override
  _QuoteEditItemsState createState() => _QuoteEditItemsState();
}

class _QuoteEditItemsState extends State<QuoteEditItems> {
  InvoiceItemEntity selectedQuoteItem;

  void _showQuoteItemEditor(
      InvoiceItemEntity quoteItem, BuildContext context) {
    showDialog<ItemEditDetails>(
        context: context,
        builder: (BuildContext context) {
          final viewModel = widget.viewModel;
          final quote = viewModel.quote;

          return ItemEditDetails(
            viewModel: viewModel,
            key: Key(quoteItem.entityKey),
            quoteItem: quoteItem,
            index: quote.invoiceItems.indexOf(
                quote.invoiceItems.firstWhere((i) => i.id == quoteItem.id)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final quote = viewModel.quote;
    final quoteItem = quote.invoiceItems.contains(viewModel.quoteItem)
        ? viewModel.quoteItem
        : null;

    if (quoteItem != null && quoteItem != selectedQuoteItem) {
      selectedQuoteItem = quoteItem;
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        _showQuoteItemEditor(quoteItem, context);
      });
    }

    if (quote.invoiceItems.isEmpty) {
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

    final quoteItems =
        quote.invoiceItems.map((quoteItem) => InvoiceItemListTile(
              invoice: quote,
              invoiceItem: quoteItem,
              onTap: () => _showQuoteItemEditor(quoteItem, context),
            ));

    return ListView(
      children: quoteItems.toList(),
    );
  }
}

class ItemEditDetails extends StatefulWidget {
  const ItemEditDetails({
    Key key,
    @required this.index,
    @required this.quoteItem,
    @required this.viewModel,
  }) : super(key: key);

  final int index;
  final InvoiceItemEntity quoteItem;
  final QuoteEditItemsVM viewModel;

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

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_controllers.isNotEmpty) {
      return;
    }

    final quoteItem = widget.quoteItem;
    _productKeyController.text = quoteItem.productKey;
    _notesController.text = quoteItem.notes;
    _costController.text = formatNumber(quoteItem.cost, context,
        formatNumberType: FormatNumberType.input);
    _qtyController.text = formatNumber(quoteItem.qty, context,
        formatNumberType: FormatNumberType.input);
    _discountController.text = formatNumber(quoteItem.discount, context,
        formatNumberType: FormatNumberType.input);
    _custom1Controller.text = quoteItem.customValue1;
    _custom2Controller.text = quoteItem.customValue2;

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
    final quoteItem = widget.quoteItem.rebuild((b) => b
      ..productKey = _productKeyController.text.trim()
      ..notes = _notesController.text.trim()
      ..cost = parseDouble(_costController.text)
      ..qty = parseDouble(_qtyController.text)
      ..discount = parseDouble(_discountController.text)
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim());
    if (quoteItem != widget.quoteItem) {
      widget.viewModel.onChangedQuoteItem(quoteItem, widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final quoteItem = widget.quoteItem;
    final company = viewModel.company;

    void _confirmDelete() {
      showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              semanticLabel: localization.areYouSure,
              title: Text(localization.areYouSure),
              actions: <Widget>[
                FlatButton(
                    child: Text(localization.cancel.toUpperCase()),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                FlatButton(
                    child: Text(localization.ok.toUpperCase()),
                    onPressed: () {
                      widget.viewModel.onRemoveQuoteItemPressed(widget.index);
                      Navigator.pop(context); // confirmation dialog
                      Navigator.pop(context); // quote item editor
                    })
              ],
            ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // stay clear of the keyboard
      ),
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
                  onPressed: _confirmDelete,
                ),
                SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  icon: Icons.check_circle,
                  label: localization.done,
                  onPressed: () {
                    viewModel.onDoneQuoteItemPressed();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            TextFormField(
              autocorrect: false,
              controller: _productKeyController,
              decoration: InputDecoration(
                labelText: localization.product,
              ),
            ),
            TextFormField(
              autocorrect: false,
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: localization.description,
              ),
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
            TextFormField(
              controller: _costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: localization.unitCost,
              ),
            ),
            company.hasInvoiceField('quantity')
                ? TextFormField(
                    controller: _qtyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localization.quantity,
                    ),
                  )
                : Container(),
            company.hasInvoiceField('discount')
                ? TextFormField(
                    controller: _discountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localization.discount,
                    ),
                  )
                : Container(),
            company.enableInvoiceTaxes
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) => viewModel.onChangedQuoteItem(
                        quoteItem.applyTax(taxRate), widget.index),
                    labelText: localization.tax,
                    initialTaxName: quoteItem.taxName1,
                    initialTaxRate: quoteItem.taxRate1,
                  )
                : Container(),
            company.enableInvoiceTaxes && company.enableSecondTaxRate
                ? TaxRateDropdown(
                    taxRates: company.taxRates,
                    onSelected: (taxRate) => viewModel.onChangedQuoteItem(
                        quoteItem.applyTax(taxRate), widget.index),
                    labelText: localization.tax,
                    initialTaxName: quoteItem.taxName2,
                    initialTaxRate: quoteItem.taxRate2,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
