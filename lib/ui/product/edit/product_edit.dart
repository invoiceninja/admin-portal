import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/ui/product/edit/product_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/save_icon_button.dart';

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

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    var product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
    _notesController.text = product.notes;
    _costController.text = product.cost?.toStringAsFixed(2) ?? '';

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  _onChanged() {
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
    var viewModel = widget.viewModel;

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackClicked();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.product.isNew()
              ? AppLocalization.of(context).newProduct
              : viewModel.product.productKey),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return SaveIconButton(
                isLoading: viewModel.isLoading,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  viewModel.onSaveClicked(context);
                },
              );
            }),
            viewModel.product.isNew()
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
                    controller: _notesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: AppLocalization.of(context).notes,
                    ),
                  ),
                  TextFormField(
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
