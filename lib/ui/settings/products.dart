import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/products_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

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

    return WillPopScope(
      onWillPop: () async {
        //viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: isMobile(context),
          title: Text(localization.userDetails),
          actions: <Widget>[
            if (!isMobile(context))
              FlatButton(
                child: Text(
                  localization.cancel,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => viewModel.onCancelPressed(context),
              ),
            ActionIconButton(
              icon: Icons.cloud_upload,
              tooltip: localization.save,
              isVisible: true,
              isDirty: true,
              isSaving: false,
              //isVisible: !client.isDeleted,
              //isDirty: client.isNew || client != viewModel.origClient,
              //isSaving: viewModel.isSaving,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                viewModel.onSavePressed(context);
              },
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              FormCard(
                children: <Widget>[
                  DecoratedFormField(
                    label: localization.firstName,
                    controller: _firstNameController,
                    validator: (val) => val.isEmpty || val.trim().isEmpty
                        ? localization.pleaseEnterAFirstName
                        : null,
                    autovalidate: autoValidate,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
