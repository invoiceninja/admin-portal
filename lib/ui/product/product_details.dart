import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/ui/product/product_details_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class ProductDetails extends StatelessWidget {
  final ProductDetailsVM viewModel;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProductDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _productKey;
    String _notes;
    double _cost;

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.product.id == null ? AppLocalization.of(context).newProduct : viewModel.product.productKey), // Text(localizations.productDetails),
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
        child: ListView(
          children: [
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
                        onSaved: (value) => _productKey = value,
                        initialValue: viewModel.product.productKey,
                        decoration: InputDecoration(
                          //border: InputBorder.none,
                          labelText: AppLocalization.of(context).product,
                        ),
                      ),
                      TextFormField(
                        initialValue: viewModel.product.notes,
                        onSaved: (value) => _notes = value,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: AppLocalization.of(context).notes,
                        ),
                      ),
                      TextFormField(
                        initialValue: viewModel.product.cost == null ? null : viewModel.product.cost.toStringAsFixed(2),
                        onSaved: (value) => _cost = double.tryParse(value) ?? 0.0,
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
            new Builder(
              builder: (BuildContext context) {
                return ProgressButton(
                  label: AppLocalization.of(context).save.toUpperCase(),
                  isLoading: viewModel.isLoading,
                  isDirty: viewModel.isDirty,
                  onPressed: () {
                    _formKey.currentState.save();
                    viewModel.onSaveClicked(viewModel.product.rebuild((b) => b
                      ..productKey = _productKey.trim()
                      ..notes = _notes.trim()
                      ..cost = _cost
                    ), context);
                  },
                );
              }
            ),
          ]
        ),
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
