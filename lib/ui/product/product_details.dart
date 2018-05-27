import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:invoiceninja/containers/edit_product.dart';
import 'package:invoiceninja/data/models/models.dart';

class DetailsScreen extends StatelessWidget {
  final ProductEntity product;
  final Function onDelete;
  final Function(ProductEntity) onSaveClicked;

  DetailsScreen({
    Key key,
    @required this.product,
    @required this.onDelete,
    @required this.onSaveClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final localizations = ArchSampleLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.productKey), // Text(localizations.productDetails),
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
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        //onSaved: (value) => product.toBuilder((b) => b.)
                        initialValue: product.productKey,
                        decoration: InputDecoration(
                          //border: InputBorder.none,
                          labelText: 'Product',
                        ),
                      ),
                      TextFormField(
                        initialValue: product.notes,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Notes',
                        ),
                      ),
                      TextFormField(
                        initialValue: product.cost.toStringAsFixed(2),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          //border: InputBorder.none,
                          labelText: 'Cost',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                child: Text('SAVE'),
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                color: Colors.lightBlueAccent,
                textColor: Colors.white,
                elevation: 4.0,
                onPressed: () {
                  //ProductEntity product = ProductEntity(this.product.id)
                  //  ..productKey = 'test';
                  this.onSaveClicked(product);
                }
              ),
            ),
          ],
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
