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

  ProductEdit({
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

  var _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      _productKeyController,
      _notesController,
      _costController,
    ];

    _controllers.forEach((dynamic controller) => controller.removeListener(_onChanged));

    var product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
    _notesController.text = product.notes;
    _costController.text = formatNumber(product.cost, widget.viewModel.state, formatNumberType: FormatNumberType.input);

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
    var product = widget.viewModel.product.rebuild((b) => b
      ..productKey = _productKeyController.text.trim()
      ..notes = _notesController.text.trim()
      ..cost = double.tryParse(_costController.text) ?? 0.0
    );
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final product = viewModel.product;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.product.isNew
              ? AppLocalization.of(context).newProduct
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
                      labelText: AppLocalization.of(context).product,
                    ),
                    validator: (val) => val.isEmpty || val.trim().length == 0
                        ? AppLocalization.of(context).pleaseEnterAProductKey
                        : null,
                  ),
                  TextFormField(
                    key: Key(ProductKeys.productEditNotesFieldKeyString),
                    controller: _notesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: AppLocalization.of(context).notes,
                    ),
                  ),
                  TextFormField(
                    key: Key(ProductKeys.productEditCostFieldKeyString),
                    autocorrect: false,
                    controller: _costController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: AppLocalization.of(context).cost,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
