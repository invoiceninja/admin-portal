// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/product/edit/product_edit.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class ProductEditScreen extends StatelessWidget {
  const ProductEditScreen({Key? key}) : super(key: key);

  static const String route = '/product/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductEditVM>(
      converter: (Store<AppState> store) {
        return ProductEditVM.fromStore(store);
      },
      builder: (context, vm) {
        return ProductEdit(
          viewModel: vm,
          key: ValueKey(vm.product.id),
        );
      },
    );
  }
}

class ProductEditVM {
  ProductEditVM({
    required this.state,
    required this.company,
    required this.product,
    required this.origProduct,
    required this.onChanged,
    required this.onSavePressed,
    required this.onCancelPressed,
    required this.onEntityAction,
    required this.isSaving,
    required this.isDirty,
  });

  factory ProductEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final product = state.productUIState.editing!;

    return ProductEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isDirty: product.isNew,
      product: product,
      origProduct: state.productState.map[product.id],
      onChanged: (ProductEntity product) {
        store.dispatch(UpdateProduct(product));
      },
      onCancelPressed: (BuildContext context) {
        createEntity(entity: ProductEntity(), force: true);
        store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
      },
      onSavePressed: (BuildContext context) {
        Debouncer.runOnComplete(() {
          final product = store.state.productUIState.editing;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          final Completer<ProductEntity> completer =
              new Completer<ProductEntity>();
          store.dispatch(
              SaveProductRequest(completer: completer, product: product));
          return completer.future.then((savedProduct) {
            showToast(product!.isNew
                ? localization!.createdProduct
                : localization!.updatedProduct);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(ProductViewScreen.route));
              if (product.isNew) {
                navigator!.pushReplacementNamed(ProductViewScreen.route);
              } else {
                navigator!.pop(savedProduct);
              }
            } else {
              viewEntity(entity: savedProduct);
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
      onEntityAction: (BuildContext context, EntityAction action) {
        // TODO Add view page for products
        // Prevent duplicate global key error
        if (action == EntityAction.clone) {
          Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((duration) {
            handleProductAction(context, [product], action);
          });
        } else {
          handleProductAction(context, [product], action);
        }
      },
    );
  }

  final AppState state;
  final CompanyEntity? company;
  final ProductEntity product;
  final ProductEntity? origProduct;
  final Function(ProductEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Function(BuildContext, EntityAction) onEntityAction;
  final bool isSaving;
  final bool isDirty;
}
