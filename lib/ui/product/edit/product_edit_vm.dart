import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/redux/ui/ui_actions.dart';
import 'package:invoiceninja/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja/ui/product/product_screen.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/product/edit/product_edit.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/app/snackbar_row.dart';

class ProductEditScreen extends StatelessWidget {
  static const String route = '/product/edit';
  const ProductEditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductEditVM>(
      converter: (Store<AppState> store) {
        return ProductEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return ProductEdit(
          viewModel: vm,
        );
      },
    );
  }
}

class ProductEditVM {
  final CompanyEntity company;
  final ProductEntity product;
  final ProductEntity origProduct;
  final Function(ProductEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function onBackPressed;
  final bool isSaving;
  final bool isDirty;

  ProductEditVM({
    @required this.company,
    @required this.product,
    @required this.origProduct,
    @required this.onChanged,
    @required this.onSavePressed,
    @required this.onBackPressed,
    @required this.onActionSelected,
    @required this.isSaving,
    @required this.isDirty,
  });

  factory ProductEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final product = state.productUIState.editing;

    return ProductEditVM(
        company: state.selectedCompany,
        isSaving: state.isSaving,
        isDirty: product.isNew,
        product: product,
        origProduct: state.productState.map[product.id],
        onChanged: (ProductEntity product) {
          store.dispatch(UpdateProduct(product));
        },
        onBackPressed: () {
          store.dispatch(UpdateCurrentRoute(ProductScreen.route));
        },
        onSavePressed: (BuildContext context) {
          final Completer<Null> completer = new Completer<Null>();
          store.dispatch(
              SaveProductRequest(completer: completer, product: product));
          return completer.future.then((_) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: SnackBarRow(
                  message: product.isNew
                      ? AppLocalization.of(context).successfullyCreatedProduct
                      : AppLocalization.of(context).successfullyUpdatedProduct,
                )));
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final Completer<Null> completer = new Completer<Null>();
          var message = '';
          switch (action) {
            case EntityAction.archive:
              store.dispatch(ArchiveProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyArchivedProduct;
              break;
            case EntityAction.delete:
              store.dispatch(DeleteProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyDeletedProduct;
              break;
            case EntityAction.restore:
              store.dispatch(RestoreProductRequest(completer, product.id));
              message = AppLocalization.of(context).successfullyRestoredProduct;
              break;
          }
          return completer.future.then((_) {
            if ([EntityAction.archive, EntityAction.delete].contains(action)) {
              Navigator.of(context).pop(message);
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: SnackBarRow(
                    message: message,
                  )
              ));
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
  }
}
