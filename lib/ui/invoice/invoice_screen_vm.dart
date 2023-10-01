// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'invoice_screen.dart';

class InvoiceScreenBuilder extends StatelessWidget {
  const InvoiceScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceScreenVM>(
      converter: InvoiceScreenVM.fromStore,
      builder: (context, vm) {
        return InvoiceScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class InvoiceScreenVM {
  InvoiceScreenVM({
    required this.isInMultiselect,
    required this.invoiceList,
    required this.userCompany,
    required this.invoiceMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> invoiceList;
  final BuiltMap<String, InvoiceEntity> invoiceMap;

  static InvoiceScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return InvoiceScreenVM(
      invoiceMap: state.invoiceState.map,
      invoiceList: memoizedFilteredInvoiceList(
        state.getUISelection(EntityType.invoice),
        state.invoiceState.map,
        state.invoiceState.list,
        state.clientState.map,
        state.vendorState.map,
        state.paymentState.map,
        state.invoiceListState,
        state.userState.map,
        state.company.settings.recurringNumberPrefix,
      ),
      userCompany: state.userCompany,
      isInMultiselect: state.invoiceListState.isInMultiselect(),
    );
  }
}
