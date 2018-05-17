// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import '../../data/models/models.dart';
import '../../keys.dart';
import '../../ui/product/product_list_vm.dart';

class ProductHome extends StatelessWidget {
  ProductHome() : super(key: NinjaKeys.productHome);

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
      body: FilteredProducts(),
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
