import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/settings/product_settings_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductSettings extends StatefulWidget {
  const ProductSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ProductSettingsVM viewModel;

  @override
  _ProductSettingsState createState() => _ProductSettingsState();
}

class _ProductSettingsState extends State<ProductSettings> {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_productSettings');
  FocusScopeNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    return EditScaffold(
      title: localization.productSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.showProductDiscount),
                value: company.enableProductDiscount,
                subtitle: Text(localization.showProductDiscountHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..enableProductDiscount = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.showProductCost),
                value: company.enableProductCost,
                subtitle: Text(localization.showCostHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..enableProductCost = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.showProductQuantity),
                value: company.enableProductQuantity,
                subtitle: Text(localization.showProductQuantityHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..enableProductQuantity = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.defaultQuantity),
                value: company.defaultQuantity,
                subtitle: Text(localization.defaultQuantityHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..defaultQuantity = value)),
              ),
            ],
          ),
          FormCard(
            children: <Widget>[
              /*
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.showProductDetails),
                value: company.showProductDetails,
                subtitle: Text(localization.showProductDetailsHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..showProductDetails = value)),
              ),
               */
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.fillProducts),
                value: company.fillProducts,
                subtitle: Text(localization.fillProductsHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..fillProducts = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.updateProducts),
                value: company.updateProducts,
                subtitle: Text(localization.updateProductsHelp),
                onChanged: (value) => viewModel.onCompanyChanged(
                    company.rebuild((b) => b..updateProducts = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.convertProducts),
                value: company.convertProductExchangeRate ?? false,
                subtitle: Text(localization.convertProductsHelp),
                onChanged: (value) => viewModel.onCompanyChanged(company
                    .rebuild((b) => b..convertProductExchangeRate = value)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
