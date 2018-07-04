import 'package:invoiceninja/data/models/entities.dart';
import 'package:invoiceninja/ui/app/forms/custom_field.dart';
import 'package:invoiceninja/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/ui/product/edit/product_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/buttons/save_icon_button.dart';
import 'package:invoiceninja/utils/keys.dart';

class ProductEdit extends StatefulWidget {
  final ProductEditVM viewModel;

  const ProductEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _productKeyController = TextEditingController();
  final _notesController = TextEditingController();
  final _costController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      _productKeyController,
      _notesController,
      _costController,
      _custom1Controller,
      _custom2Controller,
    ];

    _controllers.forEach((dynamic controller) => controller.removeListener(_onChanged));

    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
    _notesController.text = product.notes;
    _costController.text = formatNumber(product.cost, widget.viewModel.state, formatNumberType: FormatNumberType.input);
    _custom1Controller.text = product.customValue1;
    _custom2Controller.text = product.customValue2;

    _controllers.forEach((dynamic controller) => controller.addListener(_onChanged));

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
    final product = widget.viewModel.product.rebuild((b) => b
      ..productKey = _productKeyController.text.trim()
      ..notes = _notesController.text.trim()
      ..cost = double.tryParse(_costController.text) ?? 0.0
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim()
    );
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final product = viewModel.product;
    final company = viewModel.state.selectedCompany;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.product.isNew
              ? localization.newProduct
              : viewModel.origProduct.productKey),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return SaveIconButton(
                isVisible: !product.isDeleted,
                isLoading: viewModel.isLoading,
                isDirty: product.isNew || product != viewModel.origProduct,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  viewModel.onSavePressed(context);
                },
              );
            }),
            viewModel.product.isNew
                ? Container()
                : ActionMenuButton(
                    entity: viewModel.product,
                    onSelected: viewModel.onActionSelected,
                  )
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  TextFormField(
                    key: Key(ProductKeys.productEditProductFieldKeyString),
                    controller: _productKeyController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      //border: InputBorder.none,
                      labelText: localization.product,
                    ),
                    validator: (val) => val.isEmpty || val.trim().isEmpty
                        ? localization.pleaseEnterAProductKey
                        : null,
                  ),
                  TextFormField(
                    key: Key(ProductKeys.productEditNotesFieldKeyString),
                    controller: _notesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: localization.notes,
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
                    key: Key(ProductKeys.productEditCostFieldKeyString),
                    controller: _costController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localization.cost,
                    ),
                  ),
                  company.enableInvoiceItemTaxes
                      ? TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onChanged(product.rebuild((b) => b
                          ..taxRate1 = taxRate.rate
                          ..taxName1 = taxRate.name)),
                    labelText: localization.tax,
                    state: viewModel.state,
                    initialTaxName: product.taxName1,
                    initialTaxRate: product.taxRate1,
                  )
                      : Container(),
                  company.enableInvoiceItemTaxes && company.enableSecondTaxRate
                      ? TaxRateDropdown(
                    onSelected: (taxRate) =>
                        viewModel.onChanged(product.rebuild((b) => b
                          ..taxRate2 = taxRate.rate
                          ..taxName2 = taxRate.name)),
                    labelText: localization.tax,
                    state: viewModel.state,
                    initialTaxName: product.taxName2,
                    initialTaxRate: product.taxRate2,
                  )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
