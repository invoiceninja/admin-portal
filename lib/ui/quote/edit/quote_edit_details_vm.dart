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
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';

class QuoteEditDetailsScreen extends StatelessWidget {
  const QuoteEditDetailsScreen({Key? key, required this.viewModel})
      : super(key: key);

  final AbstractInvoiceEditVM viewModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditDetailsVM>(
      converter: (Store<AppState> store) {
        return QuoteEditDetailsVM.fromStore(store);
      },
      builder: (context, viewModel) {
        if (viewModel.state!.prefState.isEditorFullScreen(EntityType.invoice)) {
          return InvoiceEditDesktop(
            viewModel: viewModel,
            entityViewModel: this.viewModel,
            key: ValueKey('__quote_${viewModel.invoice!.id}__'),
          );
        } else {
          return InvoiceEditDetails(
            viewModel: viewModel,
            entityType: EntityType.quote,
          );
        }
      },
    );
  }
}

class QuoteEditDetailsVM extends EntityEditDetailsVM {
  QuoteEditDetailsVM({
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

  factory QuoteEditDetailsVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing;
    final company = state.company;

    return QuoteEditDetailsVM(
      state: state,
      company: company,
      invoice: quote,
      onChanged: (InvoiceEntity quote) => store.dispatch(UpdateQuote(quote)),
      clientMap: state.clientState.map,
      clientList: state.clientState.list,
      onClientChanged: (context, quote, client) {
        if (client != null) {
          store.dispatch(UpdateQuote(quote.applyClient(state, client)));
        }
        store.dispatch(UpdateQuoteClient(client: client));
      },
      onAddClientPressed: (context, completer) {
        createEntity(
            entity: ClientEntity(),
            force: true,
            completer: completer,
            cancelCompleter: Completer<Null>()
              ..future.then<Null>((_) {
                store.dispatch(UpdateCurrentRoute(QuoteEditScreen.route));
              }));
        completer.future.then((SelectableEntity client) {
          store.dispatch(UpdateCurrentRoute(QuoteEditScreen.route));
        });
      },
    );
  }
}
