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
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/recurring_invoice/edit/recurring_invoice_edit_vm.dart';

class RecurringInvoiceEditDetailsScreen extends StatelessWidget {
  const RecurringInvoiceEditDetailsScreen({Key? key, required this.viewModel})
      : super(key: key);

  final AbstractInvoiceEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringInvoiceEditDetailsVM>(
      converter: (Store<AppState> store) {
        return RecurringInvoiceEditDetailsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        if (viewModel.state!.prefState.isEditorFullScreen(EntityType.invoice)) {
          return InvoiceEditDesktop(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
            key: ValueKey('__recurring_invoice_${viewModel.invoice!.id}__'),
          );
        } else {
          return InvoiceEditDetails(
            viewModel: viewModel,
            entityType: EntityType.recurringInvoice,
          );
        }
      },
    );
  }
}

class RecurringInvoiceEditDetailsVM extends EntityEditDetailsVM {
  RecurringInvoiceEditDetailsVM({
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

  factory RecurringInvoiceEditDetailsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final invoice = state.recurringInvoiceUIState.editing;
    final company = state.company;

    return RecurringInvoiceEditDetailsVM(
      state: state,
      company: company,
      invoice: invoice,
      onChanged: (InvoiceEntity invoice) =>
          store.dispatch(UpdateRecurringInvoice(invoice)),
      clientMap: state.clientState.map,
      clientList: state.clientState.list,
      onClientChanged: (context, invoice, client) {
        if (client != null) {
          store.dispatch(
              UpdateRecurringInvoice(invoice.applyClient(state, client)));
        }
        store.dispatch(UpdateRecurringInvoiceClient(client: client));
      },
      onAddClientPressed: (context, completer) {
        createEntity(
            entity: ClientEntity(),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then<Null>((_) {
                store.dispatch(
                    UpdateCurrentRoute(RecurringInvoiceEditScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(RecurringInvoiceEditScreen.route));
        });
      },
    );
  }
}
