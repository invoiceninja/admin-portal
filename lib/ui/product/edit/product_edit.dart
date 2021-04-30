import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/product/edit/product_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductEdit extends StatefulWidget {
  const ProductEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProductEditVM viewModel;

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_productEdit');
  final FocusScopeNode _focusNode = FocusScopeNode();
  bool _autoValidate = false;

  final _productKeyController = TextEditingController();
  final _notesController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _costController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();
  final _custom3Controller = TextEditingController();
  final _custom4Controller = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _productKeyController,
      _notesController,
      _priceController,
      _quantityController,
      _costController,
      _custom1Controller,
      _custom2Controller,
      _custom3Controller,
      _custom4Controller,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
    _notesController.text = product.notes;
    _priceController.text = formatNumber(product.price, context,
        formatNumberType: FormatNumberType.inputMoney);
    _quantityController.text = formatNumber(product.quantity, context,
        formatNumberType: FormatNumberType.inputAmount);
    _costController.text = formatNumber(product.cost, context,
        formatNumberType: FormatNumberType.inputMoney);
    _custom1Controller.text = product.customValue1;
    _custom2Controller.text = product.customValue2;
    _custom3Controller.text = product.customValue3;
    _custom4Controller.text = product.customValue4;

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
    _focusNode.dispose();

    super.dispose();
  }

  void _onChanged() {
    final product = widget.viewModel.product.rebuild((b) => b
      ..productKey = _productKeyController.text.trim()
      ..notes = _notesController.text.trim()
      ..price = parseDouble(_priceController.text)
      ..quantity = parseDouble(_quantityController.text)
      ..cost = parseDouble(_costController.text)
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
      ..customValue3 = _custom3Controller.text.trim()
      ..customValue4 = _custom4Controller.text.trim());
    if (product != widget.viewModel.product) {
      _debouncer.run(() {
        widget.viewModel.onChanged(product);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final product = viewModel.product;
    final company = viewModel.company;

    return EditScaffold(
      entity: product,
      title: viewModel.product.isNew
          ? localization.newProduct
          : localization.editProduct,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        setState(() {
          _autoValidate = !isValid;
        });

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        child: ScrollableListView(
          key: ValueKey(widget.viewModel.product.id),
          children: <Widget>[
            FormCard(
              children: <Widget>[
                DecoratedFormField(
                  autofocus: true,
                  label: localization.product,
                  controller: _productKeyController,
                  validator: (val) => val.isEmpty || val.trim().isEmpty
                      ? localization.pleaseEnterAProductKey
                      : null,
                  autovalidate: _autoValidate,
                  onSavePressed: viewModel.onSavePressed,
                ),
                DecoratedFormField(
                  keyboardType: TextInputType.multiline,
                  label: localization.description,
                  controller: _notesController,
                  maxLines: 6,
                ),
                DecoratedFormField(
                  label: localization.price,
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSavePressed: viewModel.onSavePressed,
                ),
                if (company.enableProductQuantity)
                  DecoratedFormField(
                    label: localization.quantity,
                    controller: _quantityController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onSavePressed: viewModel.onSavePressed,
                  ),
                if (company.enableProductCost)
                  DecoratedFormField(
                    label: localization.cost,
                    controller: _costController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onSavePressed: viewModel.onSavePressed,
                  ),
                if (company.enableFirstItemTaxRate ||
                    product.taxName1.isNotEmpty)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onChanged(product.rebuild((b) => b
                          ..taxRate1 = taxRate.rate
                          ..taxName1 = taxRate.name)),
                    labelText: localization.tax,
                    initialTaxName: product.taxName1,
                    initialTaxRate: product.taxRate1,
                  ),
                if (company.enableSecondItemTaxRate ||
                    product.taxName2.isNotEmpty)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onChanged(product.rebuild((b) => b
                          ..taxRate2 = taxRate.rate
                          ..taxName2 = taxRate.name)),
                    labelText: localization.tax,
                    initialTaxName: product.taxName2,
                    initialTaxRate: product.taxRate2,
                  ),
                if (company.enableThirdItemTaxRate ||
                    product.taxName3.isNotEmpty)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onChanged(product.rebuild((b) => b
                          ..taxRate3 = taxRate.rate
                          ..taxName3 = taxRate.name)),
                    labelText: localization.tax,
                    initialTaxName: product.taxName3,
                    initialTaxRate: product.taxRate3,
                  ),
                CustomField(
                  controller: _custom1Controller,
                  field: CustomFieldType.product1,
                  value: product.customValue1,
                  onSavePressed: viewModel.onSavePressed,
                ),
                CustomField(
                  controller: _custom2Controller,
                  field: CustomFieldType.product2,
                  value: product.customValue2,
                  onSavePressed: viewModel.onSavePressed,
                ),
                CustomField(
                  controller: _custom3Controller,
                  field: CustomFieldType.product3,
                  value: product.customValue3,
                  onSavePressed: viewModel.onSavePressed,
                ),
                CustomField(
                  controller: _custom4Controller,
                  field: CustomFieldType.product4,
                  value: product.customValue4,
                  onSavePressed: viewModel.onSavePressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
