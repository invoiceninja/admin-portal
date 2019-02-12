import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/product/product_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/product/edit/product_edit.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class ProductEditScreen extends StatelessWidget {
  const ProductEditScreen({Key key}) : super(key: key);

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
        );
      },
    );
  }
}

class ProductEditVM {
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
          if (state.uiState.currentRoute.contains(ProductScreen.route)) {
            store.dispatch(UpdateCurrentRoute(ProductScreen.route));
          }
        },
        onSavePressed: (BuildContext context) {
          store.dispatch(SaveProductRequest(
              completer: snackBarCompleter(
                  context,
                  product.isNew
                      ? AppLocalization.of(context).createdProduct
                      : AppLocalization.of(context).updatedProduct),
              product: product));
        },
        onActionSelected: (BuildContext context, EntityAction action) {
          final localization = AppLocalization.of(context);
          switch (action) {
            case EntityAction.newInvoice:
              final item =
              convertProductToInvoiceItem(context: context, product: product);
              store.dispatch(EditInvoice(
                  context: context,
                  invoice: InvoiceEntity(company: state.selectedCompany)
                      .rebuild((b) => b..invoiceItems.add(item))));
              break;
            case EntityAction.archive:
              store.dispatch(ArchiveProductRequest(
                  popCompleter(context, localization.archivedProduct),
                  product.id));
              break;
            case EntityAction.delete:
              store.dispatch(DeleteProductRequest(
                  popCompleter(context, localization.deletedProduct),
                  product.id));
              break;
            case EntityAction.restore:
              store.dispatch(RestoreProductRequest(
                  snackBarCompleter(context, localization.restoredProduct),
                  product.id));
              break;
            case EntityAction.clone:
              store.dispatch(UpdateProduct(product.clone));
              break;
          }
        });
  }

  final CompanyEntity company;
  final ProductEntity product;
  final ProductEntity origProduct;
  final Function(ProductEntity) onChanged;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext, EntityAction) onActionSelected;
  final Function onBackPressed;
  final bool isSaving;
  final bool isDirty;
}
