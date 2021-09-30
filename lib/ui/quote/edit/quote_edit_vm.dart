import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_edit.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class QuoteEditScreen extends StatelessWidget {
  const QuoteEditScreen({Key key}) : super(key: key);

  static const String route = '/quote/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuoteEditVM>(
      converter: (Store<AppState> store) {
        return QuoteEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return QuoteEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.invoice.id),
        );
      },
    );
  }
}

class QuoteEditVM extends AbstractInvoiceEditVM {
  QuoteEditVM({
    AppState state,
    CompanyEntity company,
    InvoiceEntity invoice,
    int invoiceItemIndex,
    InvoiceEntity origInvoice,
    Function(BuildContext) onSavePressed,
    Function(List<InvoiceItemEntity>, String) onItemsAdded,
    bool isSaving,
    Function(BuildContext) onCancelPressed,
  }) : super(
          state: state,
          company: company,
          invoice: invoice,
          invoiceItemIndex: invoiceItemIndex,
          origInvoice: origInvoice,
          onSavePressed: onSavePressed,
          onItemsAdded: onItemsAdded,
          isSaving: isSaving,
          onCancelPressed: onCancelPressed,
        );

  factory QuoteEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing;

    return QuoteEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      invoice: quote,
      invoiceItemIndex: state.quoteUIState.editingItemIndex,
      origInvoice: store.state.quoteState.map[quote.id],
      onSavePressed: (BuildContext context, [EntityAction action]) {
        Debouncer.runOnComplete(() {
          final quote = store.state.quoteUIState.editing;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          if (quote.clientId.isEmpty) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext,
                builder: (BuildContext context) {
                  return ErrorDialog(localization.pleaseSelectAClient);
                });
            return null;
          }
          final Completer<InvoiceEntity> completer = Completer<InvoiceEntity>();
          store.dispatch(SaveQuoteRequest(completer: completer, quote: quote));
          return completer.future.then((savedQuote) {
            showToast(quote.isNew
                ? localization.createdQuote
                : localization.updatedQuote);

            if (state.prefState.isMobile) {
              store.dispatch(UpdateCurrentRoute(QuoteViewScreen.route));
              if (quote.isNew) {
                navigator.pushReplacementNamed(QuoteViewScreen.route);
              } else {
                navigator.pop(savedQuote);
              }
            } else {
              viewEntity(entity: savedQuote);

              if (state.prefState.isEditorFullScreen(EntityType.invoice)) {
                editEntity(
                    context: navigatorKey.currentContext, entity: savedQuote);
              }

              if ([
                EntityAction.emailQuote,
                EntityAction.viewPdf,
                EntityAction.convertToInvoice,
              ].contains(action)) {
                handleEntityAction(savedQuote, action);
              }
            }
          }).catchError((Object error) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext,
                builder: (BuildContext context) {
                  return ErrorDialog(error);
                });
          });
        });
      },
      onItemsAdded: (items, clientId) {
        if (items.length == 1) {
          store.dispatch(EditQuoteItem(quote.lineItems.length));
        }
        store.dispatch(AddQuoteItems(items));
      },
      onCancelPressed: (BuildContext context) {
        if (['pdf', 'email'].contains(state.uiState.previousSubRoute)) {
          viewEntitiesByType(entityType: EntityType.quote);
        } else {
          createEntity(context: context, entity: InvoiceEntity(), force: true);
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
    );
  }
}
