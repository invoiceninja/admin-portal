// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class RecurringExpenseViewScreen extends StatelessWidget {
  const RecurringExpenseViewScreen({
    Key? key,
    this.isFilter = false,
  }) : super(key: key);
  static const String route = '/recurring_expense/view';
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecurringExpenseViewVM>(
      converter: (Store<AppState> store) {
        return RecurringExpenseViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return ExpenseView(
          viewModel: vm,
          isFilter: isFilter,
          tabIndex: vm.state!.recurringExpenseUIState.tabIndex,
        );
      },
    );
  }
}

class RecurringExpenseViewVM extends AbstractExpenseViewVM {
  RecurringExpenseViewVM({
    required ExpenseEntity expense,
    AppState? state,
    CompanyEntity? company,
    Function(BuildContext, EntityAction)? onEntityAction,
    Function(BuildContext)? onRefreshed,
    Function(BuildContext, List<MultipartFile>, bool)? onUploadDocuments,
    bool? isSaving,
    bool? isLoading,
    bool? isDirty,
  }) : super(
          state: state,
          expense: expense,
          company: company,
          onEntityAction: onEntityAction,
          onRefreshed: onRefreshed,
          onUploadDocuments: onUploadDocuments,
          isSaving: isSaving,
          isLoading: isLoading,
          isDirty: isDirty,
        );

  factory RecurringExpenseViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final recurringExpense = state.recurringExpenseState
            .map[state.recurringExpenseUIState.selectedId] ??
        ExpenseEntity(id: state.recurringExpenseUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer =
          snackBarCompleter<Null>(AppLocalization.of(context)!.refreshComplete);
      store.dispatch(LoadRecurringExpense(
          completer: completer, recurringExpenseId: recurringExpense.id));
      return completer.future;
    }

    return RecurringExpenseViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: recurringExpense.isNew,
      expense: recurringExpense,
      onRefreshed: (context) => _handleRefresh(context),
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleEntitiesActions([recurringExpense], action, autoPop: true),
      onUploadDocuments: (BuildContext context,
          List<MultipartFile> multipartFiles, bool isPrivate) {
        final completer = Completer<List<DocumentEntity>>();
        store.dispatch(SaveRecurringExpenseDocumentRequest(
            isPrivate: isPrivate,
            multipartFile: multipartFiles,
            expense: recurringExpense,
            completer: completer));
        completer.future.then((client) {
          showToast(AppLocalization.of(context)!.uploadedDocument);
        }).catchError((Object error) {
          showDialog<ErrorDialog>(
              context: navigatorKey.currentContext!,
              builder: (BuildContext context) {
                return ErrorDialog(error);
              });
        });
      },
    );
  }
}
