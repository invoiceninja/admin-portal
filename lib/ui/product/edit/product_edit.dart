import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/ui/product/edit/product_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

import '../../app/save_icon_button.dart';

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

  String _productKey;
  String _notes;
  double _cost;

  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;

    return Scaffold(
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

                _formKey.currentState.save();

                viewModel.onSaveClicked(
                    context,
                    viewModel.product.rebuild((b) => b
                      ..productKey = _productKey
                      ..notes = _notes
                      ..cost = _cost));
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
                  autocorrect: false,
                  onSaved: (value) {
                    _productKey = value;
                  },
                  initialValue: viewModel.product.productKey,
                  decoration: InputDecoration(
                    //border: InputBorder.none,
                    labelText: AppLocalization.of(context).product,
                  ),
                  validator: (val) => val.isEmpty || val.trim().length == 0
                      ? AppLocalization.of(context).pleaseEnterAProductKey
                      : null,
                ),
                TextFormField(
                  initialValue: viewModel.product.notes,
                  onSaved: (value) {
                    _notes = value;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).notes,
                  ),
                ),
                TextFormField(
                  initialValue: viewModel.product.cost == null ||
                          viewModel.product.cost == 0.0
                      ? null
                      : viewModel.product.cost.toStringAsFixed(2),
                  onSaved: (value) {
                    _cost = double.tryParse(value) ?? 0.0;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    //border: InputBorder.none,
                    labelText: AppLocalization.of(context).cost,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
