import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
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
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
    _notesController.text = product.notes;
    _priceController.text = formatNumber(product.price, context,
        formatNumberType: FormatNumberType.input);
    _quantityController.text = formatNumber(product.quantity, context,
        formatNumberType: FormatNumberType.input);
    _costController.text = formatNumber(product.cost, context,
        formatNumberType: FormatNumberType.input);
    _custom1Controller.text = product.customValue1;
    _custom2Controller.text = product.customValue2;

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
    _debouncer.run(() {
      final product = widget.viewModel.product.rebuild((b) => b
        ..productKey = _productKeyController.text.trim()
        ..notes = _notesController.text.trim()
        ..price = parseDouble(_priceController.text)
        ..quantity = parseDouble(_quantityController.text)
        ..cost = parseDouble(_costController.text)
        ..customValue1 = _custom1Controller.text.trim()
        ..customValue2 = _custom2Controller.text.trim());
      if (product != widget.viewModel.product) {
        widget.viewModel.onChanged(product);
      }
    });
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
        child: ListView(
          key: ValueKey(widget.viewModel.product.id),
          children: <Widget>[
            FormCard(
              children: <Widget>[
                DecoratedFormField(
                  autofocus: kIsWeb,
                  label: localization.product,
                  controller: _productKeyController,
                  validator: (val) => val.isEmpty || val.trim().isEmpty
                      ? localization.pleaseEnterAProductKey
                      : null,
                  autovalidate: _autoValidate,
                ),
                DecoratedFormField(
                  label: localization.description,
                  controller: _notesController,
                  maxLines: 4,
                ),
                CustomField(
                  controller: _custom1Controller,
                  field: CustomFieldType.product1,
                  value: product.customValue1,
                ),
                CustomField(
                  controller: _custom2Controller,
                  field: CustomFieldType.product2,
                  value: product.customValue2,
                ),
                DecoratedFormField(
                  label: localization.price,
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                if (company.enableProductQuantity)
                  DecoratedFormField(
                    label: localization.quantity,
                    controller: _quantityController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                if (company.enableProductCost)
                  DecoratedFormField(
                    label: localization.cost,
                    controller: _costController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                if (company.settings.enableFirstItemTaxRate)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onChanged(product.rebuild((b) => b
                          ..taxRate1 = taxRate.rate
                          ..taxName1 = taxRate.name)),
                    labelText: localization.tax,
                    initialTaxName: product.taxName1,
                    initialTaxRate: product.taxRate1,
                  ),
                if (company.settings.enableSecondItemTaxRate)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onChanged(product.rebuild((b) => b
                          ..taxRate2 = taxRate.rate
                          ..taxName2 = taxRate.name)),
                    labelText: localization.tax,
                    initialTaxName: product.taxName2,
                    initialTaxRate: product.taxRate2,
                  ),
                if (company.settings.enableThirdItemTaxRate)
                  TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onChanged(product.rebuild((b) => b
                          ..taxRate3 = taxRate.rate
                          ..taxName3 = taxRate.name)),
                    labelText: localization.tax,
                    initialTaxName: product.taxName3,
                    initialTaxRate: product.taxRate3,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
