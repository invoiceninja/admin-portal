import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:invoiceninja/containers/edit_product.dart';
import 'package:invoiceninja/data/models/models.dart';

class DetailsScreen extends StatelessWidget {
  final ProductEntity product;
  final Function onDelete;
  final Function(bool) toggleCompleted;

  DetailsScreen({
    Key key,
    @required this.product,
    @required this.onDelete,
    @required this.toggleCompleted,
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
            tooltip: localizations.deleteProduct,
            key: ArchSampleKeys.deleteProductButton,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context, product);
            },
          )
          */
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: TextEditingController(text: product.productKey),
                        decoration: InputDecoration(
                          //border: InputBorder.none,
                          labelText: 'Product',
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(text: product.notes),
                        maxLines: 4,
                        decoration: InputDecoration(
                          //border: InputBorder.none,
                          labelText: 'Notes',
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(text: product.cost.toStringAsFixed(2)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                        //border: InputBorder.none,
                        labelText: 'Cost',
                      ),
                      ),
                    ],
                  ),
                ),
              ],
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
