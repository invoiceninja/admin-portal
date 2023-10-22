// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
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
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class InvoiceEditScreen extends StatelessWidget {
  const InvoiceEditScreen({Key? key}) : super(key: key);

  static const String route = '/invoice/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InvoiceEditVM>(
      converter: (Store<AppState> store) {
        return InvoiceEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return InvoiceEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.invoice!.updatedAt),
        );
      },
    );
  }
}

abstract class AbstractInvoiceEditVM {
  AbstractInvoiceEditVM({
    required this.state,
    required this.company,
    required this.invoice,
    required this.invoiceItemIndex,
    required this.origInvoice,
    required this.onSavePressed,
    required this.onItemsAdded,
    required this.isSaving,
    required this.onCancelPressed,
    required this.onUploadDocuments,
  });

  final AppState? state;
  final CompanyEntity? company;
  final InvoiceEntity? invoice;
  final int? invoiceItemIndex;
  final InvoiceEntity? origInvoice;
  final Function(BuildContext, [EntityAction?])? onSavePressed;
  final Function(List<InvoiceItemEntity>, String?, String?)? onItemsAdded;
  final bool? isSaving;
  final Function(BuildContext)? onCancelPressed;
  final Function(BuildContext, List<MultipartFile>, bool)? onUploadDocuments;
}

class InvoiceEditVM extends AbstractInvoiceEditVM {
  InvoiceEditVM({
    AppState? state,
    CompanyEntity? company,
    InvoiceEntity? invoice,
    int? invoiceItemIndex,
    InvoiceEntity? origInvoice,
    Function(BuildContext, [EntityAction?])? onSavePressed,
    Function(List<InvoiceItemEntity>, String?, String?)? onItemsAdded,
    bool? isSaving,
    Function(BuildContext)? onCancelPressed,
    Function(BuildContext, List<MultipartFile>, bool?)? onUploadDocuments,
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
          onUploadDocuments: onUploadDocuments,
        );

  factory InvoiceEditVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final invoice = state.invoiceUIState.editing!;

    return InvoiceEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      invoice: invoice,
      invoiceItemIndex: state.invoiceUIState.editingItemIndex,
      origInvoice: store.state.invoiceState.map[invoice.id],
      onSavePressed: (BuildContext context, [EntityAction? action]) {
        Debouncer.runOnComplete(() {
          final invoice = store.state.invoiceUIState.editing!;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          if (invoice.clientId.isEmpty) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(localization!.pleaseSelectAClient);
                });
            return null;
          }

          final state = store.state;
          final clientId = invoice.clientId;
          for (int i = 0; i < invoice.lineItems.length; i++) {
            final lineItem = invoice.lineItems[i];
            final task = state.taskState.get(lineItem.taskId ?? '');
            if (task.clientId.isNotEmpty && task.clientId != clientId) {
              showDialog<ErrorDialog>(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return ErrorDialog(localization!.errorCrossClientTasks);
                  });
              return null;
            }
            final expense = state.expenseState.get(lineItem.expenseId ?? '');
            if ((expense.clientId ?? '').isNotEmpty &&
                expense.clientId != clientId) {
              showDialog<ErrorDialog>(
                  context: navigatorKey.currentContext!,
                  builder: (BuildContext context) {
                    return ErrorDialog(localization!.errorCrossClientExpenses);
                  });
              return null;
            }
          }

          if (invoice.isOld &&
              invoice.isChanged != true &&
              action != null &&
              action.isClientSide) {
            handleEntityAction(invoice, action);
          } else {
            final Completer<InvoiceEntity> completer =
                Completer<InvoiceEntity>();
            store.dispatch(SaveInvoiceRequest(
              completer: completer,
              invoice: invoice,
              entityAction: action,
            ));
            return completer.future.then((savedInvoice) {
              showToast(invoice.isNew
                  ? localization!.createdInvoice
                  : localization!.updatedInvoice);

              if (state.prefState.isMobile) {
                store.dispatch(UpdateCurrentRoute(InvoiceViewScreen.route));
                if (invoice.isNew) {
                  navigator!.pushReplacementNamed(InvoiceViewScreen.route);
                } else {
                  navigator!.pop(savedInvoice);
                }
              } else {
                if (!state.prefState.isPreviewVisible) {
                  store.dispatch(TogglePreviewSidebar());
                }

                viewEntity(entity: savedInvoice);

                if (state.prefState.isEditorFullScreen(EntityType.invoice) &&
                    state.prefState.editAfterSaving) {
                  editEntity(entity: savedInvoice);
                }
              }

              if (action != null && action.isClientSide) {
                handleEntityAction(savedInvoice, action);
              } else if (action != null && action.requiresSecondRequest) {
                handleEntityAction(savedInvoice, action);
                viewEntity(entity: savedInvoice, force: true);
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
        if ((clientId ?? '').isNotEmpty || (projectId ?? '').isNotEmpty) {
          final client = state.clientState.get(clientId!);
          store.dispatch(UpdateInvoice(invoice.rebuild((b) => b
            ..clientId = clientId
            ..projectId = projectId
            ..invitations.replace(BuiltList<InvitationEntity>(client
                .emailContacts
                .map((contact) => InvitationEntity(clientContactId: contact.id))
                .toList())))));
        }
        store.dispatch(AddInvoiceItems(items));

        // if we're just adding one item automatically show the editor
        if (items.length == 1) {
          store.dispatch(EditInvoiceItem(invoice.lineItems.length));
        }
      },
      onCancelPressed: (BuildContext context) {
        if (['pdf', 'email'].contains(state.uiState.previousSubRoute)) {
          viewEntitiesByType(entityType: EntityType.invoice);
        } else {
          createEntity(entity: InvoiceEntity(), force: true);
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFiles, bool? isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SaveInvoiceDocumentRequest(
            isPrivate: isPrivate,
            multipartFiles: multipartFiles,
            invoice: invoice,
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
