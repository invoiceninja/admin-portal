// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class UserView extends StatelessWidget {
  const UserView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final UserViewVM viewModel;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final user = viewModel.user;
    final state = StoreProvider.of<AppState>(context).state;
    final userCompany = state.userCompany;

    return ViewScaffold(
      isFilter: isFilter,
      entity: user,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ScrollableListView(
        children: <Widget>[
          if (user.emailVerifiedAt == null)
            IconMessage(localization.emailSentToConfirmEmail,
                color: Colors.orange),
          EntityHeader(
            entity: user,
            value: user.email,
            label: localization.email,
            secondLabel: localization.phone,
          ),
          ListDivider(),
          if (userCompany.canViewCreateOrEdit(EntityType.client))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              title: localization.clients,
              entityType: EntityType.client,
              subtitle:
                  memoizedClientStatsForUser(user.id, state.clientState.map)
                      .present(localization.active, localization.archived),
            ),
          if (userCompany.canViewCreateOrEdit(EntityType.invoice))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              title: localization.invoices,
              entityType: EntityType.invoice,
              subtitle:
                  memoizedInvoiceStatsForUser(user.id, state.invoiceState.map)
                      .present(localization.active, localization.archived),
            ),
          if (userCompany.canViewCreateOrEdit(EntityType.quote))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              entityType: EntityType.quote,
              title: localization.quotes,
              subtitle: memoizedQuoteStatsForUser(
                user.id,
                state.quoteState.map,
              ).present(localization.active, localization.archived),
            ),
          if (userCompany.canViewCreateOrEdit(EntityType.credit))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              entityType: EntityType.credit,
              title: localization.credits,
              subtitle: memoizedCreditStatsForUser(
                user.id,
                state.creditState.map,
              ).present(localization.active, localization.archived),
            ),
          if (userCompany.canViewCreateOrEdit(EntityType.task))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              entityType: EntityType.task,
              title: localization.tasks,
              subtitle: memoizedTaskStatsForUser(
                user.id,
                state.taskState.map,
              ).present(localization.active, localization.archived),
            ),
          if (userCompany.canViewCreateOrEdit(EntityType.project))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              entityType: EntityType.project,
              title: localization.projects,
              subtitle: memoizedProjectStatsForUser(
                user.id,
                state.projectState.map,
              ).present(localization.active, localization.archived),
            ),
          if (userCompany.canViewCreateOrEdit(EntityType.expense))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              entityType: EntityType.expense,
              title: localization.expenses,
              subtitle: memoizedExpenseStatsForUser(
                user.id,
                state.expenseState.map,
              ).present(localization.active, localization.archived),
            ),
          if (userCompany.canViewCreateOrEdit(EntityType.vendor))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              entityType: EntityType.vendor,
              title: localization.vendors,
              subtitle: memoizedVendorStatsForUser(
                user.id,
                state.vendorState.map,
              ).present(localization.active, localization.archived),
            ),
          if (userCompany.canViewCreateOrEdit(EntityType.recurringInvoice))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              title: localization.recurringInvoices,
              entityType: EntityType.recurringInvoice,
              subtitle: memoizedRecurringInvoiceStatsForUser(
                      user.id, state.recurringInvoiceState.map)
                  .present(localization.active, localization.archived),
            ),
          if (userCompany.canViewCreateOrEdit(EntityType.recurringExpense))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              entityType: EntityType.recurringExpense,
              title: localization.recurringExpenses,
              subtitle: memoizedRecurringExpenseStatsForUser(
                user.id,
                state.recurringExpenseState.map,
              ).present(localization.active, localization.archived),
            ),
        ],
      ),
    );
  }
}
