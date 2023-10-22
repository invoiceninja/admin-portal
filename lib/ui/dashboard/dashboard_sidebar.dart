// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_sidebar_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense/expense_list_item.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_list_item.dart';
import 'package:invoiceninja_flutter/ui/task/task_list_item.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SidebarScaffold extends StatelessWidget {
  const SidebarScaffold({
    required this.tabController,
  });

  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: TabBar(
                isScrollable: true,
                controller: tabController,
                tabs: [
                  if (company.isModuleEnabled(EntityType.invoice))
                    Tab(
                      text: localization!.invoices,
                    ),
                  if (company.isModuleEnabled(EntityType.payment))
                    Tab(
                      text: localization!.payments,
                    ),
                  if (company.isModuleEnabled(EntityType.quote))
                    Tab(
                      text: localization!.quotes,
                    ),
                  if (company.isModuleEnabled(EntityType.task))
                    Tab(
                      text: localization!.tasks,
                    ),
                  if (company.isModuleEnabled(EntityType.expense))
                    Tab(
                      text: localization!.expenses,
                    ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => store.dispatch(
                UpdateDashboardSidebar(showSidebar: false),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          if (company.isModuleEnabled(EntityType.invoice)) InvoiceSidebar(),
          if (company.isModuleEnabled(EntityType.payment)) PaymentSidebar(),
          if (company.isModuleEnabled(EntityType.quote)) QuoteSidebar(),
          if (company.isModuleEnabled(EntityType.task)) TaskSidebar(),
          if (company.isModuleEnabled(EntityType.expense)) ExpenseSidbar(),
        ],
      ),
    );
  }
}

class InvoiceSidebar extends StatelessWidget {
  const InvoiceSidebar();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final upcomingInvoices = memoizedUpcomingInvoices(
      state.invoiceState.map,
      state.clientState.map,
    );
    final pastDueInvoices = memoizedPastDueInvoices(
      state.invoiceState.map,
      state.clientState.map,
    );
    final selectedIds =
        state.dashboardUIState.selectedEntities[EntityType.invoice];

    return _DashboardSidebar(
      entityType: EntityType.invoice,
      label1: localization.upcomingInvoices +
          (upcomingInvoices.isNotEmpty ? ' (${upcomingInvoices.length})' : ''),
      list1: upcomingInvoices.isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: upcomingInvoices.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: upcomingInvoices[index]!,
                  showSelected: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label2: localization.pastDueInvoices +
          (pastDueInvoices.isNotEmpty ? ' (${pastDueInvoices.length})' : ''),
      list2: pastDueInvoices.isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: pastDueInvoices.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: pastDueInvoices[index]!,
                  showSelected: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : localization.selectedInvoices + ' (${selectedIds!.length})',
      list3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: selectedIds?.length,
              itemBuilder: (BuildContext context, int index) {
                final invoice = state.invoiceState.map[selectedIds![index]];
                return invoice == null
                    ? SizedBox()
                    : InvoiceListItem(
                        invoice: invoice,
                        showSelected: false,
                      );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
    );
  }
}

class PaymentSidebar extends StatelessWidget {
  const PaymentSidebar();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final recentPayments = memoizedRecentPayments(
      state.paymentState.map,
      state.clientState.map,
    );
    final selectedIds =
        state.dashboardUIState.selectedEntities[EntityType.payment];

    return _DashboardSidebar(
      entityType: EntityType.payment,
      label1: localization.recentPayments +
          (recentPayments.isNotEmpty ? ' (${recentPayments.length})' : ''),
      list1: recentPayments.isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: recentPayments.length,
              itemBuilder: (BuildContext context, int index) {
                return PaymentListItem(
                  payment: recentPayments[index]!,
                  showSelected: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : localization.selectedPayments + ' (${selectedIds!.length})',
      list3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: selectedIds?.length,
              itemBuilder: (BuildContext context, int index) {
                final payment = state.paymentState.map[selectedIds![index]];
                return payment == null
                    ? SizedBox()
                    : PaymentListItem(
                        payment: payment,
                        showSelected: false,
                      );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
    );
  }
}

class QuoteSidebar extends StatelessWidget {
  const QuoteSidebar();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final upcomingQuotes = memoizedUpcomingQuotes(
      state.quoteState.map,
      state.clientState.map,
    );
    final expriedQuotes = memoizedExpiredQuotes(
      state.quoteState.map,
      state.clientState.map,
    );
    final selectedIds =
        state.dashboardUIState.selectedEntities[EntityType.quote];

    return _DashboardSidebar(
      entityType: EntityType.quote,
      label1: localization.upcomingQuotes +
          (upcomingQuotes.isNotEmpty ? ' (${upcomingQuotes.length})' : ''),
      list1: upcomingQuotes.isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: upcomingQuotes.length,
              itemBuilder: (BuildContext context, int index) {
                return QuoteListItem(
                  quote: upcomingQuotes[index]!,
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label2: localization.expiredQuotes +
          (expriedQuotes.isNotEmpty ? ' (${expriedQuotes.length})' : ''),
      list2: expriedQuotes.isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: expriedQuotes.length,
              itemBuilder: (BuildContext context, int index) {
                return QuoteListItem(
                  quote: expriedQuotes[index]!,
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : localization.selectedQuotes + ' (${selectedIds!.length})',
      list3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: selectedIds?.length,
              itemBuilder: (BuildContext context, int index) {
                final quote = state.quoteState.map[selectedIds![index]];
                return quote == null
                    ? SizedBox()
                    : QuoteListItem(
                        quote: quote,
                        showCheckbox: false,
                      );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
    );
  }
}

class TaskSidebar extends StatelessWidget {
  const TaskSidebar();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final runningTasks = memoizedRunningTasks(
      state.taskState.map,
      state.clientState.map,
    );
    final recentTasks = memoizedRecentTasks(
      state.taskState.map,
      state.clientState.map,
    );
    final selectedIds =
        state.dashboardUIState.selectedEntities[EntityType.task];

    return _DashboardSidebar(
      entityType: EntityType.quote,
      label1: localization.runningTasks +
          (runningTasks.isNotEmpty ? ' (${runningTasks.length})' : ''),
      list1: runningTasks.isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: runningTasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskListItem(
                  task: runningTasks[index]!,
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label2: localization.recentTasks +
          (recentTasks.isNotEmpty ? ' (${recentTasks.length})' : ''),
      list2: recentTasks.isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: recentTasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskListItem(
                  task: recentTasks[index],
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : localization.selectedTasks + ' (${selectedIds!.length})',
      list3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: selectedIds?.length,
              itemBuilder: (BuildContext context, int index) {
                final task = state.taskState.map[selectedIds![index]];
                return task == null
                    ? SizedBox()
                    : TaskListItem(
                        task: task,
                        showCheckbox: false,
                      );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
    );
  }
}

class ExpenseSidbar extends StatelessWidget {
  const ExpenseSidbar();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final recentExpenses = memoizedRecentExpenses(
      state.expenseState.map,
      state.clientState.map,
    );
    /*
    final upcomingExpenses = memoizedUpcomingExpenses(
      state.expenseState.map,
      state.clientState.map,
    );
    */
    final selectedIds =
        state.dashboardUIState.selectedEntities[EntityType.expense];

    return _DashboardSidebar(
      entityType: EntityType.expense,
      /*
      label1: localization.upcomingExpenses +
          (upcomingExpenses.isNotEmpty ? ' (${upcomingExpenses.length})' : ''),
      list1: upcomingExpenses.isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: upcomingExpenses.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpenseListItem(
                  expense: upcomingExpenses[index],
                  showCheckbox: false,
                  showSelected: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
            */
      label1: localization.recentExpenses +
          (recentExpenses.isNotEmpty ? ' (${recentExpenses.length})' : ''),
      list1: recentExpenses.isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: recentExpenses.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpenseListItem(
                  expense: recentExpenses[index]!,
                  showCheckbox: false,
                  showSelected: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : localization.selectedExpenses + ' (${selectedIds!.length})',
      list3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : ScrollableListViewBuilder(
              itemCount: selectedIds?.length,
              itemBuilder: (BuildContext context, int index) {
                final expense = state.expenseState.map[selectedIds![index]];
                return expense == null
                    ? SizedBox()
                    : ExpenseListItem(
                        expense: expense,
                        showCheckbox: false,
                        showSelected: false,
                      );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
    );
  }
}

class _DashboardSidebar extends StatelessWidget {
  const _DashboardSidebar({
    required this.entityType,
    required this.label1,
    required this.list1,
    this.label2,
    this.list2,
    this.label3,
    this.list3,
  });

  final EntityType entityType;
  final String label1;
  final String? label2;
  final String? label3;
  final ScrollableListViewBuilder? list1;
  final ScrollableListViewBuilder? list2;
  final ScrollableListViewBuilder? list3;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final textTheme = Theme.of(context).textTheme;
    final store = StoreProvider.of<AppState>(context);

    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(
              child: Text(label1, style: textTheme.bodyMedium),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
            ),
          ),
          Expanded(
            child: list1 == null
                ? HelpText(localization!.noRecordsFound)
                : ClipRRect(child: list1),
          ),
          if (label2 != null) ...[
            Material(
              elevation: 4,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                child: Text(label2!, style: textTheme.bodyMedium),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                width: double.infinity,
              ),
            ),
            Expanded(
              child: list2 == null
                  ? HelpText(localization!.noRecordsFound)
                  : ClipRRect(child: list2),
            ),
          ],
          AnimatedContainer(
            height: label3 == null
                ? 0
                : (MediaQuery.of(context).size.height - 100) / 2,
            duration: Duration(milliseconds: kDefaultAnimationDuration),
            curve: Curves.easeInOutCubic,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 4,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(label3 ?? '',
                                style: textTheme.bodyMedium)),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            store.dispatch(UpdateDashboardSelection(
                              entityIds: null,
                              entityType: entityType,
                            ));
                          },
                        )
                      ],
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  child: ClipRRect(child: list3 ?? SizedBox()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
