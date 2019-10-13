import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewProductList implements PersistUI {
  ViewProductList({@required this.context, this.force = false});

  final BuildContext context;
  final bool force;
}

class ViewProduct implements PersistUI {
  ViewProduct(
      {@required this.productId, @required this.context, this.force = false});

  final String productId;
  final BuildContext context;
  final bool force;
}

class EditProduct implements PersistUI {
  EditProduct(
      {@required this.product,
      @required this.context,
      this.completer,
      this.force = false});

  final ProductEntity product;
  final BuildContext context;
  final Completer completer;
  final bool force;
}

class UpdateProduct implements PersistUI {
  UpdateProduct(this.product);

  final ProductEntity product;
}

class LoadProducts {
  LoadProducts({this.completer, this.force = false});

  final Completer completer;
  final bool force;
}

class LoadProductsRequest implements StartLoading {}

class LoadProductsFailure implements StopLoading {
  LoadProductsFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadProductsFailure{error: $error}';
  }
}

class LoadProductsSuccess implements PersistData, StopLoading {
  LoadProductsSuccess(this.products);

  final BuiltList<ProductEntity> products;

  @override
  String toString() {
    return 'LoadProductsSuccess{products: $products}';
  }
}

class SaveProductRequest implements StartSaving {
  SaveProductRequest({this.product, this.completer});

  final Completer completer;
  final ProductEntity product;
}

class SaveProductSuccess implements StopSaving, PersistData, PersistUI {
  SaveProductSuccess(this.product);

  final ProductEntity product;
}

class AddProductSuccess implements StopSaving, PersistData, PersistUI {
  AddProductSuccess(this.product);

  final ProductEntity product;
}

class SaveProductFailure implements StopSaving {
  SaveProductFailure(this.error);

  final Object error;
}

class ArchiveProductRequest implements StartSaving {
  ArchiveProductRequest(this.completer, this.productId);

  final Completer completer;
  final String productId;
}

class ArchiveProductSuccess implements StopSaving, PersistData {
  ArchiveProductSuccess(this.product);

  final ProductEntity product;
}

class ArchiveProductFailure implements StopSaving {
  ArchiveProductFailure(this.product);

  final ProductEntity product;
}

class DeleteProductRequest implements StartSaving {
  DeleteProductRequest(this.completer, this.productId);

  final Completer completer;
  final String productId;
}

class DeleteProductSuccess implements StopSaving, PersistData {
  DeleteProductSuccess(this.product);

  final ProductEntity product;
}

class DeleteProductFailure implements StopSaving {
  DeleteProductFailure(this.product);

  final ProductEntity product;
}

class RestoreProductRequest implements StartSaving {
  RestoreProductRequest(this.completer, this.productId);

  final Completer completer;
  final String productId;
}

class RestoreProductSuccess implements StopSaving, PersistData {
  RestoreProductSuccess(this.product);

  final ProductEntity product;
}

class RestoreProductFailure implements StopSaving {
  RestoreProductFailure(this.product);

  final ProductEntity product;
}

class FilterProducts {
  FilterProducts(this.filter);

  final String filter;
}

class SortProducts implements PersistUI {
  SortProducts(this.field);

  final String field;
}

class FilterProductsByState implements PersistUI {
  FilterProductsByState(this.state);

  final EntityState state;
}

class FilterProductsByCustom1 implements PersistUI {
  FilterProductsByCustom1(this.value);

  final String value;
}

class FilterProductsByCustom2 implements PersistUI {
  FilterProductsByCustom2(this.value);

  final String value;
}

class FilterProductDropdown {
  FilterProductDropdown(this.filter);

  final String filter;
}

void handleProductAction(
    BuildContext context, List<BaseEntity> products, EntityAction action) {
  assert(
      [
            EntityAction.restore,
            EntityAction.archive,
            EntityAction.delete,
            EntityAction.toggleMultiselect
          ].contains(action) ||
          products.length == 1,
      'Cannot perform this action on more than one product');
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final product = products[0];

  switch (action) {
    case EntityAction.newInvoice:
      final item =
          convertProductToInvoiceItem(context: context, product: product);
      store.dispatch(EditInvoice(
          context: context,
          invoice: InvoiceEntity(company: state.selectedCompany)
              .rebuild((b) => b..invoiceItems.add(item))));
      break;
    case EntityAction.edit:
      store.dispatch(EditProduct(context: context, product: product));
      break;
    case EntityAction.clone:
      store.dispatch(EditProduct(
          context: context, product: (product as ProductEntity).clone));
      break;
    case EntityAction.restore:
      store.dispatch(RestoreProductRequest(
          snackBarCompleter(context, localization.restoredProduct),
          product.id));
      break;
    case EntityAction.archive:
      store.dispatch(ArchiveProductRequest(
          snackBarCompleter(context, localization.archivedProduct),
          product.id));
      break;
    case EntityAction.delete:
      store.dispatch(DeleteProductRequest(
          snackBarCompleter(context, localization.deletedProduct), product.id));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.productListState.isInMultiselect()) {
        store.dispatch(StartMultiselect(context: context));
      }

      if (products.isEmpty) {
        break;
      }

      for (final product in products) {
        if (!store.state.productListState.isSelected(product)) {
          store.dispatch(AddToMultiselect(context: context, entity: product));
        } else {
          store.dispatch(
              RemoveFromMultiselect(context: context, entity: product));
        }
      }
      break;
  }
}

class StartMultiselect {
  StartMultiselect({@required this.context});

  final BuildContext context;
}

class AddToMultiselect {
  AddToMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class RemoveFromMultiselect {
  RemoveFromMultiselect({@required this.context, @required this.entity});

  final BuildContext context;
  final BaseEntity entity;
}

class ClearMultiselect {
  ClearMultiselect({@required this.context});

  final BuildContext context;
}
