// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/quote/edit/quote_edit.dart';
import 'package:invoiceninja_flutter/ui/quote/view/quote_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class QuoteEditScreen extends StatelessWidget {
  const QuoteEditScreen({Key? key}) : super(key: key);

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
          key: ValueKey(viewModel.invoice!.updatedAt),
        );
      },
    );
  }
}

class QuoteEditVM extends AbstractInvoiceEditVM {
  QuoteEditVM({
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    int? invoiceItemIndex,
    InvoiceEntity? origInvoice,
    Function(BuildContext, [EntityAction?])? onSavePressed,
    Function(List<InvoiceItemEntity>, String?, String?)? onItemsAdded,
    bool? isSaving,
    Function(BuildContext)? onCancelPressed,
    Function(BuildContext, List<MultipartFile>, bool?)? onUploadDocument,
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
          onUploadDocuments: onUploadDocument,
        );

  factory QuoteEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final quote = state.quoteUIState.editing!;

    return QuoteEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      invoice: quote,
      invoiceItemIndex: state.quoteUIState.editingItemIndex,
      origInvoice: store.state.quoteState.map[quote.id],
      onSavePressed: (BuildContext context, [EntityAction? action]) {
        Debouncer.runOnComplete(() {
          final quote = store.state.quoteUIState.editing!;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          if (quote.clientId.isEmpty) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(localization!.pleaseSelectAClient);
                });
            return null;
          }
          if (quote.isOld &&
              quote.isChanged != true &&
              action != null &&
              action.isClientSide) {
            handleEntityAction(quote, action);
          } else {
            final Completer<InvoiceEntity> completer =
                Completer<InvoiceEntity>();
            store.dispatch(SaveQuoteRequest(
              completer: completer,
              quote: quote,
              action: action,
            ));
            return completer.future.then((savedQuote) {
              showToast(quote.isNew
                  ? localization!.createdQuote
                  : localization!.updatedQuote);

              if (state.prefState.isMobile) {
                store.dispatch(UpdateCurrentRoute(QuoteViewScreen.route));
                if (quote.isNew) {
                  navigator!.pushReplacementNamed(QuoteViewScreen.route);
                } else {
                  navigator!.pop(savedQuote);
                }
              } else {
                if (!state.prefState.isPreviewVisible) {
                  store.dispatch(TogglePreviewSidebar());
                }

                viewEntity(entity: savedQuote);

                if (state.prefState.isEditorFullScreen(EntityType.invoice) &&
                    state.prefState.editAfterSaving) {
                  editEntity(entity: savedQuote);
                }
              }

              if (action != null && action.isClientSide) {
                handleEntityAction(savedQuote, action);
              } else if (action != null && action.requiresSecondRequest) {
                handleEntityAction(savedQuote, action);
                viewEntity(entity: savedQuote, force: true);
              }
            }).catchError((Object error) {
              showDialog<ErrorDialog>(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return ErrorDialog(error);
                  });
            });
          }
        });
      },
      onItemsAdded: (items, clientId, projectId) {
        if (items.length == 1) {
          store.dispatch(EditQuoteItem(quote.lineItems.length));
        }
        store.dispatch(AddQuoteItems(items));
      },
      onCancelPressed: (BuildContext context) {
        if (['pdf', 'email'].contains(state.uiState.previousSubRoute)) {
          viewEntitiesByType(entityType: EntityType.quote);
        } else {
          createEntity(entity: InvoiceEntity(), force: true);
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onUploadDocument: (BuildContext context,
          List<MultipartFile> multipartFile, bool? isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SaveQuoteDocumentRequest(
            isPrivate: isPrivate,
            multipartFile: multipartFile,
            quote: quote,
            completer: completer));
        completer.future.then((client) {
          showToast(AppLocalization.of(context)!.uploadedDocument);
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }
}
