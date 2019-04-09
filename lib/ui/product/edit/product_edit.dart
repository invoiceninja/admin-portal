import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/forms/custom_field.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/tax_rate_dropdown.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/product/edit/product_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
import 'package:invoiceninja_flutter/utils/keys.dart';

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
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

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

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
    _notesController.text = product.notes;
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

    super.dispose();
  }

  void _onChanged() {
    final product = widget.viewModel.product.rebuild((b) => b
      ..productKey = _productKeyController.text.trim()
      ..notes = _notesController.text.trim()
      ..cost = parseDouble(_costController.text)
      ..customValue1 = _custom1Controller.text.trim()
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final product = viewModel.product;
    final company = viewModel.company;
    final user = company.user;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.product.isNew
              ? localization.newProduct
              : localization.editProduct),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              if (!user.canEditEntity(product)) {
                return Container();
              }

              return ActionIconButton(
                icon: Icons.cloud_upload,
                tooltip: localization.save,
                isVisible: !product.isDeleted,
                isSaving: viewModel.isSaving,
                isDirty: product.isNew || product != viewModel.origProduct,
                onPressed: () {
                  final bool isValid = _formKey.currentState.validate();

                  setState(() {
                    autoValidate = !isValid;
                  });

                  if (!isValid) {
                    return;
                  }

                  viewModel.onSavePressed(context);
                },
              );
            }),
            product.isNew || !user.canCreate(EntityType.product)
                ? Container()
                : ActionMenuButton(
                    user: viewModel.company.user,
                    entity: viewModel.product,
                    onSelected: viewModel.onActionSelected,
                    entityActions: product.getEntityActions(user: user),
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
                    key: Key(ProductKeys.productKey),
                    controller: _productKeyController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: localization.product,
                    ),
                    validator: (val) => val.isEmpty || val.trim().isEmpty
                        ? localization.pleaseEnterAProductKey
                        : null,
                    autovalidate: autoValidate,
                  ),
                  TextFormField(
                    key: Key(ProductKeys.notes),
                    controller: _notesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: localization.notes,
                    ),
                  ),
                  CustomField(
                    controller: _custom1Controller,
                    labelText:
                        company.getCustomFieldLabel(CustomFieldType.product1),
                    options:
                        company.getCustomFieldValues(CustomFieldType.product1),
                  ),
                  CustomField(
                    controller: _custom2Controller,
                    labelText:
                        company.getCustomFieldLabel(CustomFieldType.product2),
                    options:
                        company.getCustomFieldValues(CustomFieldType.product2),
                  ),
                  TextFormField(
                    key: Key(ProductKeys.cost),
                    controller: _costController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: localization.cost,
                    ),
                  ),
                  company.enableInvoiceItemTaxes
                      ? TaxRateDropdown(
                          taxRates: company.taxRates,
                          onSelected: (taxRate) =>
                              viewModel.onChanged(product.rebuild((b) => b
                                ..taxRate1 = taxRate.rate
                                ..taxName1 = taxRate.name)),
                          labelText: localization.tax,
                          initialTaxName: product.taxName1,
                          initialTaxRate: product.taxRate1,
                        )
                      : Container(),
                  company.enableInvoiceItemTaxes && company.enableSecondTaxRate
                      ? TaxRateDropdown(
                          taxRates: company.taxRates,
                          onSelected: (taxRate) =>
                              viewModel.onChanged(product.rebuild((b) => b
                                ..taxRate2 = taxRate.rate
                                ..taxName2 = taxRate.name)),
                          labelText: localization.tax,
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
