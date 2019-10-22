import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/settings/products_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
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
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  final _firstNameController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [_firstNameController];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    /*
    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
      */

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final settings = viewModel.settings;

    return SettingsScaffold(
      title: localization.productSettings,
      onSavePressed: viewModel.onSavePressed,
      body: AppForm(
        formKey: _formKey,
        children: <Widget>[
          FormCard(
            children: <Widget>[
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.fillProducts),
                value: settings.fillProducts ?? false,
                subtitle: Text(localization.fillProductsHelp),
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..fillProducts = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.updateProducts),
                value: settings.updateProducts ?? true,
                subtitle: Text(localization.updateProductsHelp),
                onChanged: (value) => viewModel.onSettingsChanged(
                    settings.rebuild((b) => b..updateProducts = value)),
              ),
              SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text(localization.convertProducts),
                value: settings.convertProductExchangeRate ?? false,
                subtitle: Text(localization.convertProductsHelp),
                onChanged: (value) => viewModel.onSettingsChanged(settings
                    .rebuild((b) => b..convertProductExchangeRate = value)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
