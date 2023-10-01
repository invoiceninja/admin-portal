// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_activity.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_contacts.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_documents.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_history.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_overview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_schedule.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
    required this.tabIndex,
  }) : super(key: key);

  final AbstractInvoiceViewVM viewModel;
  final bool isFilter;
  final int tabIndex;

  @override
  _InvoiceViewState createState() => new _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final invoice = widget.viewModel.invoice!;
    final state = widget.viewModel.state!;
    final company = state.company;

    int tabIndex = 0;

    if (invoice.isRecurring) {
      tabIndex = state.recurringInvoiceUIState.tabIndex;
    } else if (invoice.isQuote) {
      tabIndex = state.quoteUIState.tabIndex;
    } else if (invoice.isCredit) {
      tabIndex = state.creditUIState.tabIndex;
    } else if (invoice.isPurchaseOrder) {
      tabIndex = state.purchaseOrderUIState.tabIndex;
    } else {
      tabIndex = state.invoiceUIState.tabIndex;
    }

    _controller = TabController(
      vsync: this,
      length: company.isModuleEnabled(EntityType.document) ? 5 : 4,
      initialIndex: widget.isFilter ? 0 : tabIndex,
    );
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    final invoice = widget.viewModel.invoice!;

    if (invoice.isRecurring) {
      store.dispatch(UpdateRecurringInvoiceTab(tabIndex: _controller!.index));
    } else if (invoice.isQuote) {
      store.dispatch(UpdateQuoteTab(tabIndex: _controller!.index));
    } else if (invoice.isCredit) {
      store.dispatch(UpdateCreditTab(tabIndex: _controller!.index));
    } else if (invoice.isPurchaseOrder) {
      store.dispatch(UpdatePurchaseOrderTab(tabIndex: _controller!.index));
    } else {
      store.dispatch(UpdateInvoiceTab(tabIndex: _controller!.index));
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
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice!;
    final localization = AppLocalization.of(context)!;
    final state = viewModel.state!;
    final company = state.company;
    /*
    final documents = memoizedInvoiceDocumentsSelector(
        documentState.map, viewModel.state.expenseState.map, invoice);
    */
    final documents = invoice.documents;

    EntityAction secondAction;

    if (invoice.isRecurringInvoice) {
      secondAction = invoice.isRunning ? EntityAction.stop : EntityAction.start;
    } else if (invoice.isCredit) {
      secondAction = EntityAction.applyCredit;
    } else {
      secondAction = EntityAction.sendEmail;
    }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: invoice,
      appBarBottom: TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(text: localization.overview),
          Tab(text: localization.contacts),
          if (company.isModuleEnabled(EntityType.document))
            Tab(
                text: documents.isEmpty
                    ? localization.documents
                    : '${localization.documents} (${documents.length})'),
          if (invoice.isRecurring) Tab(text: localization.schedule),
          if (!invoice.isRecurring) Tab(text: localization.history),
          Tab(text: localization.activity),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return RefreshIndicator(
            onRefresh: () => viewModel.onRefreshed!(context),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      RefreshIndicator(
                        onRefresh: () => viewModel.onRefreshed!(context),
                        child: InvoiceOverview(
                          viewModel: viewModel,
                          isFilter: widget.isFilter,
                          key: ValueKey(
                              '${viewModel.invoice!.id}-${viewModel.invoice!.loadedAt}'),
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () => viewModel.onRefreshed!(context),
                        child: InvoiceViewContacts(
                          viewModel: viewModel,
                          key: ValueKey(
                              '${viewModel.invoice!.id}-${viewModel.invoice!.loadedAt}'),
                        ),
                      ),
                      if (company.isModuleEnabled(EntityType.document))
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed!(context),
                          child: InvoiceViewDocuments(
                              viewModel: viewModel,
                              invoice: viewModel.invoice,
                              key: ValueKey(
                                  '${viewModel.invoice!.id}-${viewModel.invoice!.loadedAt}')),
                        ),
                      if (invoice.isRecurring)
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed!(context),
                          child: InvoiceViewSchedule(
                            viewModel: viewModel,
                            key: ValueKey(
                                '${viewModel.invoice!.id}-${viewModel.invoice!.loadedAt}'),
                          ),
                        ),
                      if (!invoice.isRecurring)
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed!(context),
                          child: InvoiceViewHistory(
                              viewModel: viewModel,
                              key: ValueKey(
                                  '${viewModel.invoice!.id}-${viewModel.invoice!.loadedAt}')),
                        ),
                      RefreshIndicator(
                        onRefresh: () => viewModel.onRefreshed!(context),
                        child: InvoiceViewActivity(
                            viewModel: viewModel,
                            key: ValueKey(
                                '${viewModel.invoice!.id}-${viewModel.invoice!.loadedAt}')),
                      ),
                    ],
                  ),
                ),
                BottomButtons(
                  entity: invoice,
                  action1: invoice.isPaid || !invoice.isInvoice
                      ? EntityAction.viewPdf
                      : EntityAction.newPayment,
                  action2: secondAction,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
