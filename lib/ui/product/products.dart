// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/keys.dart';
import 'package:invoiceninja/ui/product/product_list_vm.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen() : super(key: NinjaKeys.productHome);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          //FilterSelector(visible: activeTab == AppTab.products),
          //ExtraActionsContainer(),
        ],
      ),
      body: ProductListVM(),
      /*
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addProductFab,
        onPressed: () {
          Navigator.pushNamed(context, ArchSampleRoutes.addProduct);
        },
        child: Icon(Icons.add),
        tooltip: ArchSampleLocalizations.of(context).addProduct,
      ),
      */
    );
  }
}
