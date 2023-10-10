// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';

class CreditEditDetailsScreen extends StatelessWidget {
  const CreditEditDetailsScreen({Key? key, required this.viewModel})
      : super(key: key);

  final AbstractInvoiceEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditEditDetailsVM>(
      converter: (Store<AppState> store) {
        return CreditEditDetailsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        if (viewModel.state!.prefState.isEditorFullScreen(EntityType.invoice)) {
          return InvoiceEditDesktop(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
            key: ValueKey('__credit_${viewModel.invoice!.id}__'),
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
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    Function(InvoiceEntity)? onChanged,
    Function(BuildContext, InvoiceEntity, ClientEntity?)? onClientChanged,
    Function(BuildContext, InvoiceEntity, VendorEntity?)? onVendorChanged,
    BuiltMap<String, ClientEntity>? clientMap,
    BuiltList<String>? clientList,
    Function(BuildContext context, Completer<SelectableEntity> completer)?
        onAddClientPressed,
    Function(BuildContext context, Completer<SelectableEntity> completer)?
        onAddVendorPressed,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          onChanged: onChanged,
          onClientChanged: onClientChanged,
          onVendorChanged: onVendorChanged,
          clientMap: clientMap,
          clientList: clientList,
          onAddClientPressed: onAddClientPressed,
          onAddVendorPressed: onAddVendorPressed,
        );

  factory CreditEditDetailsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final credit = state.creditUIState.editing;
    final company = state.company;

    return CreditEditDetailsVM(
      state: state,
      company: company,
      invoice: credit,
      onChanged: (InvoiceEntity credit) => store.dispatch(UpdateCredit(credit)),
      clientMap: state.clientState.map,
      clientList: state.clientState.list,
      onClientChanged: (context, credit, client) {
        if (client != null) {
          store.dispatch(UpdateCredit(credit.applyClient(state, client)));
        }
        store.dispatch(UpdateCreditClient(client: client));
      },
      onAddClientPressed: (context, completer) {
        createEntity(
            entity: ClientEntity(),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then<Null>((_) {
                store.dispatch(UpdateCurrentRoute(CreditEditScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(CreditEditScreen.route));
        });
      },
    );
  }
}
