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
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class CreditEditScreen extends StatelessWidget {
  const CreditEditScreen({Key? key}) : super(key: key);

  static const String route = '/credit/edit';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreditEditVM>(
      converter: (Store<AppState> store) {
        return CreditEditVM.fromStore(store);
      },
      builder: (context, viewModel) {
        return CreditEdit(
          viewModel: viewModel,
          key: ValueKey(viewModel.invoice!.updatedAt),
        );
      },
    );
  }
}

class CreditEditVM extends AbstractInvoiceEditVM {
  CreditEditVM({
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

  factory CreditEditVM.fromStore(Store<AppState> store) {
    final AppState state = store.state;
    final credit = state.creditUIState.editing!;

    return CreditEditVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      invoice: credit,
      invoiceItemIndex: state.creditUIState.editingItemIndex,
      origInvoice: store.state.creditState.map[credit.id],
      onSavePressed: (BuildContext context, [EntityAction? action]) {
        Debouncer.runOnComplete(() {
          final credit = store.state.creditUIState.editing!;
          final localization = navigatorKey.localization;
          final navigator = navigatorKey.currentState;
          if (credit.clientId.isEmpty) {
            showDialog<ErrorDialog>(
                context: navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return ErrorDialog(localization!.pleaseSelectAClient);
                });
            return null;
          }

          if (credit.isOld &&
              credit.isChanged != true &&
              action != null &&
              action.isClientSide) {
            handleEntityAction(credit, action);
          } else {
            final Completer<InvoiceEntity> completer =
                Completer<InvoiceEntity>();
            store.dispatch(SaveCreditRequest(
              completer: completer,
              credit: credit,
              action: action,
            ));
            return completer.future.then((savedCredit) {
              showToast(credit.isNew
                  ? localization!.createdCredit
                  : localization!.updatedCredit);

              if (state.prefState.isMobile) {
                store.dispatch(UpdateCurrentRoute(CreditViewScreen.route));
                if (credit.isNew) {
                  navigator!.pushReplacementNamed(CreditViewScreen.route);
                } else {
                  navigator!.pop(savedCredit);
                }
              } else {
                if (!state.prefState.isPreviewVisible) {
                  store.dispatch(TogglePreviewSidebar());
                }

                viewEntity(entity: savedCredit);

                if (state.prefState.isEditorFullScreen(EntityType.credit) &&
                    state.prefState.editAfterSaving) {
                  editEntity(entity: savedCredit);
                }
              }

              if (action != null && action.isClientSide) {
                handleEntityAction(savedCredit, action);
              } else if (action != null && action.requiresSecondRequest) {
                handleEntityAction(savedCredit, action);
                viewEntity(entity: savedCredit, force: true);
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
          store.dispatch(EditCreditItem(credit.lineItems.length));
        }
        store.dispatch(AddCreditItems(items));
      },
      onCancelPressed: (BuildContext context) {
        if (['pdf', 'email'].contains(state.uiState.previousSubRoute)) {
          viewEntitiesByType(entityType: EntityType.credit);
        } else {
          createEntity(entity: InvoiceEntity(), force: true);
          store.dispatch(UpdateCurrentRoute(state.uiState.previousRoute));
        }
      },
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFile, bool? isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SaveCreditDocumentRequest(
            isPrivate: isPrivate,
            multipartFiles: multipartFile,
            credit: credit,
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
