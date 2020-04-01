import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CreditEditDetailsScreen extends StatelessWidget {
  const CreditEditDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditEditDetailsVM>(
      converter: (Store<AppState> store) {
        return CreditEditDetailsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        if (viewModel.state.prefState.isDesktop) {
          return InvoiceEditDesktop(
            viewModel: viewModel,
            key: ValueKey('__credit_${viewModel.invoice.id}__'),
            entityType: EntityType.credit,
          );
        } else {
          return InvoiceEditDetails(
            viewModel: viewModel,
            entityType: EntityType.credit,
          );
        }
      },
    );
  }
}

class CreditEditDetailsVM extends EntityEditDetailsVM {
  CreditEditDetailsVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    Function(InvoiceEntity) onChanged,
    Function(InvoiceEntity, ClientEntity) onClientChanged,
    BuiltMap<String, ClientEntity> clientMap,
    BuiltList<String> clientList,
    Function(BuildContext context, Completer<SelectableEntity> completer)
        onAddClientPressed,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          onChanged: onChanged,
          onClientChanged: onClientChanged,
          clientMap: clientMap,
          clientList: clientList,
          onAddClientPressed: onAddClientPressed,
        );

  factory CreditEditDetailsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final credit = state.creditUIState.editing;

    return CreditEditDetailsVM(
      state: state,
      company: state.company,
      invoice: credit,
      onChanged: (InvoiceEntity credit) => store.dispatch(UpdateCredit(credit)),
      clientMap: state.clientState.map,
      clientList: state.clientState.list,
      onClientChanged: (invoice, client) {
        store.dispatch(UpdateCreditClient(client: client));
      },
      onAddClientPressed: (context, completer) {
        createEntity(
            context: context,
            entity: ClientEntity(),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then((_) {
                store.dispatch(UpdateCurrentRoute(CreditEditScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(CreditEditScreen.route));
        });
      },
    );
  }
}
