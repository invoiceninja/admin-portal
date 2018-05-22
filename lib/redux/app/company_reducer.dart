import 'package:redux/redux.dart';
import 'package:invoiceninja/redux/product/product_actions.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/product/product_selectors.dart';
import 'package:invoiceninja/redux/app/company_state.dart';
import 'package:invoiceninja/redux/product/product_reducer.dart';
import 'package:invoiceninja/redux/dashboard/dashboard_reducer.dart';

CompanyState companyReducer(CompanyState state, action) {

  return CompanyState (
    dashboard: dashboardReducer(state.dashboard, action),
    product: productsReducer(state.product, action),
  );
}

