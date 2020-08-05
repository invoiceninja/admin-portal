import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

class ProductViewScreen extends StatelessWidget {
  const ProductViewScreen({
    Key key,
    this.isFilter = false,
  }) : super(key: key);
  final bool isFilter;
  static const String route = '/product/view';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductViewVM>(
      //distinct: true,
      converter: (Store<AppState> store) {
        return ProductViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ProductView(
          viewModel: vm,
          isFilter: isFilter,
        );
      },
    );
  }
}

class ProductViewVM {
  ProductViewVM({
    @required this.state,
    @required this.product,
    @required this.company,
    @required this.onEntityAction,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onRefreshed,
    @required this.onUploadDocument,
    @required this.onDeleteDocument,
  });

  factory ProductViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final product = state.productState.map[state.productUIState.selectedId] ??
        ProductEntity(id: state.productUIState.selectedId);

    /*
    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadProduct(
          completer: completer,
          productId: product.id,));
      return completer.future;
    }
    */

    return ProductViewVM(
      state: state,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: product.isNew,
      product: product,
      company: state.company,
      onRefreshed: null,
      /*
      onRefreshed: (context) =>
          _handleRefresh(context),
          */
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions(context, [product], action, autoPop: true),
      onUploadDocument: (BuildContext context, String filePath) {
        final Completer<DocumentEntity> completer = Completer<DocumentEntity>();
        store.dispatch(SaveProductDocumentRequest(
            filePath: filePath, product: product, completer: completer));
        completer.future.then((client) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).uploadedDocument,
          )));
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
      onDeleteDocument: (BuildContext context, DocumentEntity document) {
        final completer = snackBarCompleter<Null>(
            context, AppLocalization.of(context).deletedDocument);
        /*
        completer.future.then<Null>(
                (value) => store.dispatch(LoadProduct(product: product.id)));                
         */
        store.dispatch(DeleteDocumentRequest(completer, [document.id]));
      },
    );
  }

  final AppState state;
  final ProductEntity product;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext) onRefreshed;
  final Function(BuildContext, String) onUploadDocument;
  final Function(BuildContext, DocumentEntity) onDeleteDocument;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;

  @override
  bool operator ==(dynamic other) =>
      product == other.product && company == other.company;

  @override
  int get hashCode => product.hashCode ^ company.hashCode;
}
