import 'dart:async';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_actions.dart';
import 'package:invoiceninja_flutter/ui/user/user_screen.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/data/models/user_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class UserViewScreen extends StatelessWidget {
  const UserViewScreen({Key key}) : super(key: key);
  static const String route = '/$kSettings/$kSettingsUserManagementView';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserViewVM>(
      converter: (Store<AppState> store) {
        return UserViewVM.fromStore(store);
      },
      builder: (context, vm) {
        return UserView(
          viewModel: vm,
        );
      },
    );
  }
}

class UserViewVM {
  UserViewVM({
    @required this.state,
    @required this.user,
    @required this.company,
    @required this.onEntityAction,
    @required this.onEditPressed,
    @required this.onBackPressed,
    @required this.onRefreshed,
    @required this.isSaving,
    @required this.isLoading,
    @required this.isDirty,
    @required this.onEntityPressed,
  });

  factory UserViewVM.fromStore(Store<AppState> store) {
    final state = store.state;
    final user = state.userState.map[state.userUIState.selectedId] ??
        UserEntity(id: state.userUIState.selectedId);

    Future<Null> _handleRefresh(BuildContext context) {
      final completer = snackBarCompleter<Null>(
          context, AppLocalization.of(context).refreshComplete);
      store.dispatch(LoadUser(completer: completer, userId: user.id));
      return completer.future;
    }

    return UserViewVM(
      state: state,
      company: state.company,
      isSaving: state.isSaving,
      isLoading: state.isLoading,
      isDirty: user.isNew,
      user: user,
      onEditPressed: (BuildContext context) {
        final Completer<UserEntity> completer = Completer<UserEntity>();
        store.dispatch(
            EditUser(user: user, context: context, completer: completer));
        completer.future.then((user) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: SnackBarRow(
            message: AppLocalization.of(context).updatedUser,
          )));
        });
      },
      onRefreshed: (context) => _handleRefresh(context),
      onBackPressed: () {
        store.dispatch(UpdateCurrentRoute(UserScreen.route));
      },
      onEntityAction: (BuildContext context, EntityAction action) =>
          handleUserAction(context, [user], action),
      onEntityPressed: (BuildContext context, EntityType entityType,
          [longPress = false]) {
        switch (entityType) {
          case EntityType.invoice:
            if (longPress && user.isActive) {
              store.dispatch(EditInvoice(
                  context: context,
                  invoice: InvoiceEntity(company: state.company)));
            } else {
              store.dispatch(FilterInvoicesByEntity(
                  entityId: user.id, entityType: EntityType.user));
              store.dispatch(ViewInvoiceList(context: context));
            }
            break;
          case EntityType.quote:
            if (longPress && user.isActive) {
              store.dispatch(EditQuote(
                  context: context,
                  quote: InvoiceEntity(company: state.company, isQuote: true)));
            } else {
              store.dispatch(FilterQuotesByEntity(
                  entityId: user.id, entityType: EntityType.user));
              store.dispatch(ViewQuoteList(context: context));
            }
            break;
          case EntityType.payment:
            if (longPress && user.isActive) {
              store.dispatch(EditPayment(
                  context: context,
                  payment: PaymentEntity(company: state.company)));
            } else {
              store.dispatch(FilterPaymentsByEntity(
                  entityId: user.id, entityType: EntityType.user));
              store.dispatch(ViewPaymentList(context: context));
            }
            break;
          case EntityType.project:
            if (longPress && user.isActive) {
              store.dispatch(
                  EditProject(context: context, project: ProjectEntity()));
            } else {
              store.dispatch(FilterProjectsByEntity(
                  entityId: user.id, entityType: EntityType.user));
              store.dispatch(ViewProjectList(context: context));
            }
            break;
          case EntityType.task:
            if (longPress && user.isActive) {
              store.dispatch(EditTask(
                  context: context,
                  task: TaskEntity(isRunning: state.prefState.autoStartTasks)));
            } else {
              store.dispatch(FilterTasksByEntity(
                  entityId: user.id, entityType: EntityType.user));
              store.dispatch(ViewTaskList(context: context));
            }
            break;
          case EntityType.expense:
            if (longPress && user.isActive) {
              store.dispatch(EditExpense(
                  context: context,
                  expense: ExpenseEntity(
                      company: state.company, prefState: state.prefState)));
            } else {
              store.dispatch(FilterExpensesByEntity(
                  entityId: user.id, entityType: EntityType.user));
              store.dispatch(ViewExpenseList(context: context));
            }
            break;
        }
      },
    );
  }

  final AppState state;
  final UserEntity user;
  final CompanyEntity company;
  final Function(BuildContext, EntityAction) onEntityAction;
  final Function(BuildContext, EntityType, [bool]) onEntityPressed;
  final Function(BuildContext) onEditPressed;
  final Function onBackPressed;
  final Function(BuildContext) onRefreshed;
  final bool isSaving;
  final bool isLoading;
  final bool isDirty;
}
