import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/ui/product/product_details_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class ProductDetails extends StatelessWidget {
  final ProductDetailsVM viewModel;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _productKeyKey =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _notesKey =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _costKey =
  GlobalKey<FormFieldState<String>>();

  ProductDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.product.id == null
            ? AppLocalization.of(context).newProduct
            : viewModel
                .product.productKey), // Text(localizations.productDetails),
        actions: [
          /*
          IconButton(
            //tooltip: localizations.deleteProduct,
            //key: ArchSampleKeys.deleteProductButton,
            icon: Icon(Icons.delete),
            onPressed: () {
            },
          )
          */
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(children: [
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(0.0),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      key: _productKeyKey,
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
                      key: _notesKey,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: AppLocalization.of(context).notes,
                      ),
                    ),
                    TextFormField(
                      initialValue: viewModel.product.cost == null || viewModel.product.cost == 0.0
                          ? null
                          : viewModel.product.cost.toStringAsFixed(2),
                      key: _costKey,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        //border: InputBorder.none,
                        labelText: AppLocalization.of(context).cost,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new Builder(builder: (BuildContext context) {
            return viewModel.product.isDeleted ? Container() : ProgressButton(
              label: AppLocalization.of(context).save.toUpperCase(),
              isLoading: viewModel.isLoading,
              isDirty: viewModel.isDirty,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }

                viewModel.onSaveClicked(
                    viewModel.product.rebuild((b) => b
                      ..productKey = _productKeyKey.currentState.value
                      ..notes = _notesKey.currentState.value
                      ..cost = double.tryParse(_costKey.currentState.value) ?? 0.0),
                    context);
              },
            );
          }),
        ]),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.editProductFab,
        tooltip: localizations.editProduct,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EditProduct(
                  product: product,
                );
              },
            ),
          );
        },
      ),
      */
    );
  }
}
