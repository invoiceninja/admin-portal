// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ViewProductList implements PersistUI {
  ViewProductList({
    this.force = false,
    this.page = 0,
  });

  final bool force;
  final int? page;
}

class ViewProduct implements PersistUI, PersistPrefs {
  ViewProduct({required this.productId, this.force = false});

  final String? productId;
  final bool force;
}

class EditProduct implements PersistUI, PersistPrefs {
  EditProduct({required this.product, this.completer, this.force = false});

  final ProductEntity product;
  final Completer? completer;
  final bool force;
}

class UpdateProduct implements PersistUI {
  UpdateProduct(this.product);

  final ProductEntity product;
}

class LoadProductRequest implements StartLoading {}

class LoadProduct {
  LoadProduct({this.completer, this.productId});

  final Completer? completer;
  final String? productId;
}

class LoadProductSuccess implements StopLoading, PersistData {
  LoadProductSuccess(this.product);

  final ProductEntity product;

  @override
  String toString() {
    return 'LoadProductSuccess{product: $product}';
  }
}

class LoadProductFailure implements StopLoading {
  LoadProductFailure(this.error);

  final dynamic error;

  @override
  String toString() {
    return 'LoadProductFailure{error: $error}';
  }
}

class LoadProducts {
  LoadProducts({this.completer, this.page = 1});

  final Completer? completer;
  final int page;
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

class LoadProductsSuccess implements StopLoading {
  LoadProductsSuccess(this.products);

  final BuiltList<ProductEntity> products;

  @override
  String toString() {
    return 'LoadProductsSuccess{products: $products}';
  }
}

class SaveProductRequest implements StartSaving {
  SaveProductRequest({this.product, this.completer});

  final Completer? completer;
  final ProductEntity? product;
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

class ArchiveProductsRequest implements StartSaving {
  ArchiveProductsRequest(this.completer, this.productIds);

  final Completer completer;
  final List<String> productIds;
}

class ArchiveProductsSuccess implements StopSaving, PersistData {
  ArchiveProductsSuccess(this.products);

  final List<ProductEntity> products;
}

class ArchiveProductsFailure implements StopSaving {
  ArchiveProductsFailure(this.products);

  final List<ProductEntity?> products;
}

class DeleteProductsRequest implements StartSaving {
  DeleteProductsRequest(this.completer, this.productIds);

  final Completer completer;
  final List<String> productIds;
}

class DeleteProductsSuccess implements StopSaving, PersistData {
  DeleteProductsSuccess(this.products);

  final List<ProductEntity> products;
}

class DeleteProductsFailure implements StopSaving {
  DeleteProductsFailure(this.products);

  final List<ProductEntity?> products;
}

class RestoreProductsRequest implements StartSaving {
  RestoreProductsRequest(this.completer, this.productIds);

  final Completer completer;
  final List<String> productIds;
}

class RestoreProductsSuccess implements StopSaving, PersistData {
  RestoreProductsSuccess(this.products);

  final List<ProductEntity> products;
}

class RestoreProductsFailure implements StopSaving {
  RestoreProductsFailure(this.products);

  final List<ProductEntity?> products;
}

class SetTaxCategoryProductsRequest implements StartSaving {
  SetTaxCategoryProductsRequest(
      {this.completer, this.productIds, this.taxCategoryId});

  final Completer? completer;
  final List<String>? productIds;
  final String? taxCategoryId;
}

class SetTaxCategoryProductsSuccess implements StopSaving, PersistData {
  SetTaxCategoryProductsSuccess(this.products);

  final List<ProductEntity> products;
}

class SetTaxCategoryProductsFailure implements StopSaving {
  SetTaxCategoryProductsFailure(this.error);

  final dynamic error;
}

class FilterProducts implements PersistUI {
  FilterProducts(this.filter);

  final String? filter;
}

class SortProducts implements PersistUI, PersistPrefs {
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

class FilterProductsByCustom3 implements PersistUI {
  FilterProductsByCustom3(this.value);

  final String value;
}

class FilterProductsByCustom4 implements PersistUI {
  FilterProductsByCustom4(this.value);

  final String value;
}

class FilterProductDropdown {
  FilterProductDropdown(this.filter);

  final String? filter;
}

void handleProductAction(
    BuildContext? context, List<BaseEntity> products, EntityAction? action) {
  if (products.isEmpty) {
    return;
  }

  final store = StoreProvider.of<AppState>(context!);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final productIds = products.map((product) => product.id).toList();
  final product = products.first;

  switch (action) {
    case EntityAction.newInvoice:
      final invoice = InvoiceEntity(state: state);
      createEntity(
        entity: invoice.rebuild(
          (b) => b
            ..lineItems.addAll(
              productIds.map(
                (productId) => convertProductToInvoiceItem(
                  company: state.company,
                  invoice: invoice,
                  product: state.productState.map[productId],
                  currencyMap: state.staticState.currencyMap,
                ),
              ),
            ),
        ),
      );
      break;
    case EntityAction.newPurchaseOrder:
      final invoice =
          InvoiceEntity(state: state, entityType: EntityType.purchaseOrder);
      createEntity(
        entity: invoice.rebuild(
          (b) => b
            ..lineItems.addAll(
              productIds.map(
                (productId) => convertProductToInvoiceItem(
                  company: state.company,
                  invoice: invoice,
                  product: state.productState.map[productId],
                  currencyMap: state.staticState.currencyMap,
                ),
              ),
            ),
        ),
      );
      break;
    case EntityAction.edit:
      editEntity(entity: product);
      break;
    case EntityAction.clone:
      createEntity(entity: (product as ProductEntity).clone);
      break;
    case EntityAction.restore:
      final message = productIds.length > 1
          ? localization!.restoredProducts
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', productIds.length.toString())
          : localization!.restoredProduct;
      store.dispatch(
          RestoreProductsRequest(snackBarCompleter<Null>(message), productIds));
      break;
    case EntityAction.archive:
      final message = productIds.length > 1
          ? localization!.archivedProducts
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', productIds.length.toString())
          : localization!.archivedProduct;
      store.dispatch(
          ArchiveProductsRequest(snackBarCompleter<Null>(message), productIds));
      break;
    case EntityAction.delete:
      final message = productIds.length > 1
          ? localization!.deletedProducts
              .replaceFirst(':value', ':count')
              .replaceFirst(':count', productIds.length.toString())
          : localization!.deletedProduct;
      store.dispatch(
          DeleteProductsRequest(snackBarCompleter<Null>(message), productIds));
      break;
    case EntityAction.toggleMultiselect:
      if (!store.state.productListState.isInMultiselect()) {
        store.dispatch(StartProductMultiselect());
      }

      if (products.isEmpty) {
        break;
      }

      for (final product in products) {
        if (!store.state.productListState.isSelected(product.id)) {
          store.dispatch(AddToProductMultiselect(entity: product));
        } else {
          store.dispatch(RemoveFromProductMultiselect(entity: product));
        }
      }
      break;
    case EntityAction.more:
      showEntityActionsDialog(
        entities: [product],
      );
      break;
    case EntityAction.documents:
      final documentIds = <String>[];
      for (var product in products) {
        for (var document in (product as ProductEntity).documents) {
          documentIds.add(document.id);
        }
      }
      if (documentIds.isEmpty) {
        showMessageDialog(message: localization!.noDocumentsToDownload);
      } else {
        store.dispatch(
          DownloadDocumentsRequest(
            documentIds: documentIds,
            completer: snackBarCompleter<Null>(
              localization!.exportedData,
            ),
          ),
        );
      }
      break;
    case EntityAction.setTaxCategory:
      showDialog<void>(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text(localization!.setTaxCategory),
              children: kTaxCategories.keys.map((taxCategoryId) {
                final taxCategory = kTaxCategories[taxCategoryId];
                return SimpleDialogOption(
                  child: Text(localization.lookup(taxCategory)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    store.dispatch(SetTaxCategoryProductsRequest(
                        productIds: productIds,
                        taxCategoryId: taxCategoryId,
                        completer: snackBarCompleter<Null>(
                            productIds.length == 1
                                ? localization.updatedTaxCategory
                                : localization.updatedTaxCategories)));
                  },
                );
              }).toList(),
            );
          });
      break;
    default:
      print('## ERROR: unhandled action $action in product_actions');
      break;
  }
}

class StartProductMultiselect {}

class AddToProductMultiselect {
  AddToProductMultiselect({required this.entity});

  final BaseEntity? entity;
}

class RemoveFromProductMultiselect {
  RemoveFromProductMultiselect({required this.entity});

  final BaseEntity? entity;
}

class ClearProductMultiselect {}

class SaveProductDocumentRequest implements StartSaving {
  SaveProductDocumentRequest({
    required this.completer,
    required this.multipartFiles,
    required this.product,
    required this.isPrivate,
  });

  final Completer completer;
  final List<MultipartFile> multipartFiles;
  final ProductEntity product;
  final bool isPrivate;
}

class SaveProductDocumentSuccess implements StopSaving, PersistData, PersistUI {
  SaveProductDocumentSuccess(this.document);

  final DocumentEntity document;
}

class SaveProductDocumentFailure implements StopSaving {
  SaveProductDocumentFailure(this.error);

  final Object error;
}

class UpdateProductTab implements PersistUI {
  UpdateProductTab({this.tabIndex});

  final int? tabIndex;
}

class UpdateClientTab implements PersistUI {
  UpdateClientTab({this.tabIndex});

  final int? tabIndex;
}
