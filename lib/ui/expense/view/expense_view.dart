// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_documents.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_overview.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_schedule.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
    required this.tabIndex,
  }) : super(key: key);

  final AbstractExpenseViewVM viewModel;
  final bool isFilter;
  final int tabIndex;

  @override
  _ExpenseViewState createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;
    final state = viewModel.state!;
    final company = state.company;

    _controller = TabController(
        vsync: this,
        length: 1 +
            (viewModel.expense.isRecurring ? 1 : 0) +
            (company.isModuleEnabled(EntityType.document) ? 1 : 0),
        initialIndex: widget.isFilter ? 0 : state.expenseUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    final expense = widget.viewModel.expense;

    if (expense.isRecurring) {
      store.dispatch(UpdateRecurringExpenseTab(tabIndex: _controller!.index));
    } else {
      store.dispatch(UpdateExpenseTab(tabIndex: _controller!.index));
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex) {
      _controller!.index = widget.tabIndex;
    }
  }

  @override
  void dispose() {
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final expense = viewModel.expense;
    final company = viewModel.company!;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: expense,
      appBarBottom:
          (company.isModuleEnabled(EntityType.document) || expense.isRecurring)
              ? TabBar(
                  controller: _controller,
                  isScrollable: isMobile(context),
                  tabs: [
                    Tab(
                      text: localization!.overview,
                    ),
                    if (company.isModuleEnabled(EntityType.document))
                      Tab(
                        text: expense.documents.isEmpty
                            ? localization.documents
                            : '${localization.documents} (${expense.documents.length})',
                      ),
                    if (expense.isRecurring)
                      Tab(
                        text: localization.schedule,
                      )
                  ],
                )
              : null,
      body: Builder(builder: (context) {
        return Column(
          children: [
            Expanded(
              child: (company.isModuleEnabled(EntityType.document) ||
                      expense.isRecurring)
                  ? TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed!(context),
                          child: ExpenseOverview(
                            key: ValueKey(
                                '${viewModel.expense.id}-${viewModel.expense.loadedAt}'),
                            viewModel: viewModel,
                            isFilter: widget.isFilter,
                          ),
                        ),
                        if (company.isModuleEnabled(EntityType.document))
                          RefreshIndicator(
                            onRefresh: () => viewModel.onRefreshed!(context),
                            child: ExpenseViewDocuments(
                                key: ValueKey(
                                    '${viewModel.expense.id}-${viewModel.expense.loadedAt}'),
                                viewModel: viewModel,
                                expense: viewModel.expense),
                          ),
                        if (expense.isRecurring)
                          RefreshIndicator(
                            onRefresh: () => viewModel.onRefreshed!(context),
                            child: ExpenseViewSchedule(
                                key: ValueKey(
                                    '${viewModel.expense.id}-${viewModel.expense.loadedAt}'),
                                viewModel: viewModel),
                          ),
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: () => viewModel.onRefreshed!(context),
                      child: ExpenseOverview(
                        viewModel: viewModel,
                        isFilter: widget.isFilter,
                      ),
                    ),
            ),
            BottomButtons(
              entity: expense,
              action1: expense.isRecurring
                  ? (expense.canBeStopped
                      ? EntityAction.stop
                      : EntityAction.start)
                  : EntityAction.invoiceExpense,
              action1Enabled:
                  (!expense.isInvoiced && expense.shouldBeInvoiced) ||
                      (expense.isRecurring &&
                          (expense.canBeStarted || expense.canBeStopped)),
              action2: expense.isRecurring
                  ? EntityAction.cloneToRecurring
                  : EntityAction.cloneToExpense,
            )
          ],
        );
      }),
    );
  }
}
