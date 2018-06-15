import 'package:invoiceninja/redux/client/client_actions.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja/redux/auth/auth_actions.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, UserLoginRequest>(_setLoading),
  TypedReducer<bool, UserLoginSuccess>(_setLoaded),
  TypedReducer<bool, UserLoginFailure>(_setLoaded),

  TypedReducer<bool, LoadDashboardRequest>(_setLoading),
  TypedReducer<bool, LoadDashboardSuccess>(_setLoaded),
  TypedReducer<bool, LoadDashboardFailure>(_setLoaded),

  // Products
  TypedReducer<bool, LoadProductsRequest>(_setLoading),
  TypedReducer<bool, LoadProductsSuccess>(_setLoaded),
  TypedReducer<bool, LoadProductsFailure>(_setLoaded),

  TypedReducer<bool, SaveProductRequest>(_setLoading),
  TypedReducer<bool, SaveProductFailure>(_setLoaded),
  TypedReducer<bool, SaveProductSuccess>(_setLoaded),
  TypedReducer<bool, AddProductSuccess>(_setLoaded),

  TypedReducer<bool, ArchiveProductRequest>(_setLoading),
  TypedReducer<bool, ArchiveProductSuccess>(_setLoaded),
  TypedReducer<bool, ArchiveProductFailure>(_setLoaded),

  TypedReducer<bool, DeleteProductRequest>(_setLoading),
  TypedReducer<bool, DeleteProductSuccess>(_setLoaded),
  TypedReducer<bool, DeleteProductFailure>(_setLoaded),

  TypedReducer<bool, RestoreProductRequest>(_setLoading),
  TypedReducer<bool, RestoreProductSuccess>(_setLoaded),
  TypedReducer<bool, RestoreProductFailure>(_setLoaded),

  // Clients
  TypedReducer<bool, LoadClientsRequest>(_setLoading),
  TypedReducer<bool, LoadClientsSuccess>(_setLoaded),
  TypedReducer<bool, LoadClientsFailure>(_setLoaded),

  TypedReducer<bool, SaveClientRequest>(_setLoading),
  TypedReducer<bool, SaveClientFailure>(_setLoaded),
  TypedReducer<bool, SaveClientSuccess>(_setLoaded),
  TypedReducer<bool, AddClientSuccess>(_setLoaded),

  TypedReducer<bool, ArchiveClientRequest>(_setLoading),
  TypedReducer<bool, ArchiveClientSuccess>(_setLoaded),
  TypedReducer<bool, ArchiveClientFailure>(_setLoaded),

  TypedReducer<bool, DeleteClientRequest>(_setLoading),
  TypedReducer<bool, DeleteClientSuccess>(_setLoaded),
  TypedReducer<bool, DeleteClientFailure>(_setLoaded),

  TypedReducer<bool, RestoreClientRequest>(_setLoading),
  TypedReducer<bool, RestoreClientSuccess>(_setLoaded),
  TypedReducer<bool, RestoreClientFailure>(_setLoaded),

  // Invoices
  TypedReducer<bool, LoadInvoicesRequest>(_setLoading),
  TypedReducer<bool, LoadInvoicesSuccess>(_setLoaded),
  TypedReducer<bool, LoadInvoicesFailure>(_setLoaded),

  TypedReducer<bool, SaveInvoiceRequest>(_setLoading),
  TypedReducer<bool, SaveInvoiceFailure>(_setLoaded),
  TypedReducer<bool, SaveInvoiceSuccess>(_setLoaded),
  TypedReducer<bool, AddInvoiceSuccess>(_setLoaded),

  TypedReducer<bool, ArchiveInvoiceRequest>(_setLoading),
  TypedReducer<bool, ArchiveInvoiceSuccess>(_setLoaded),
  TypedReducer<bool, ArchiveInvoiceFailure>(_setLoaded),

  TypedReducer<bool, DeleteInvoiceRequest>(_setLoading),
  TypedReducer<bool, DeleteInvoiceSuccess>(_setLoaded),
  TypedReducer<bool, DeleteInvoiceFailure>(_setLoaded),

  TypedReducer<bool, RestoreInvoiceRequest>(_setLoading),
  TypedReducer<bool, RestoreInvoiceSuccess>(_setLoaded),
  TypedReducer<bool, RestoreInvoiceFailure>(_setLoaded),

]);

bool _setLoading(bool state, action) {
  return true;
}

bool _setLoaded(bool state, action) {
  return false;
}


