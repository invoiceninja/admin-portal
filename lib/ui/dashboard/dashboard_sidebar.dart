import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_sidebar_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
import 'package:invoiceninja_flutter/ui/payment/payment_list_item.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SidebarScaffold extends StatelessWidget {
  const SidebarScaffold({
    @required this.tabController,
    @required this.scrollController,
  });

  final TabController tabController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          isScrollable: true,
          controller: tabController,
          onTap: (int index) {
            scrollController
                .jumpTo((index.toDouble() * kDashboardPanelHeight) + 1);
          },
          tabs: [
            if (company.isModuleEnabled(EntityType.invoice))
              Tab(
                text: localization.invoices,
              ),
            if (company.isModuleEnabled(EntityType.payment))
              Tab(
                text: localization.payments,
              ),
            if (company.isModuleEnabled(EntityType.quote))
              Tab(
                text: localization.quotes,
              ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          if (company.isModuleEnabled(EntityType.invoice)) _InvoiceSidebar(),
          if (company.isModuleEnabled(EntityType.payment)) _PaymentSidebar(),
          if (company.isModuleEnabled(EntityType.quote)) _QuoteSidebar(),
        ],
      ),
    );
  }
}

class _InvoiceSidebar extends StatelessWidget {
  const _InvoiceSidebar();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final upcomingInvoices = memoizedUpcomingInvoices(state.invoiceState.map);
    final pastDueInvoices = memoizedPastDueInvoices(state.invoiceState.map);
    final selectedIds = state.uiState.selectedEntities[EntityType.invoice];

    return _DashboardSidebar(
      entityType: EntityType.invoice,
      label1: localization.upcomingInvoices +
          (upcomingInvoices.isNotEmpty ? ' (${upcomingInvoices.length})' : ''),
      list1: upcomingInvoices.isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: upcomingInvoices.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: upcomingInvoices[index],
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label2: localization.pastDueInvoices +
          (pastDueInvoices.isNotEmpty ? ' (${pastDueInvoices.length})' : ''),
      list2: pastDueInvoices.isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: pastDueInvoices.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: pastDueInvoices[index],
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : localization.selectedInvoices + ' (${selectedIds.length})',
      list3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: selectedIds?.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: state.invoiceState.get(selectedIds[index]),
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
    );
  }
}

class _PaymentSidebar extends StatelessWidget {
  const _PaymentSidebar();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final recentPayments = memoizedRecentPayments(state.paymentState.map);
    final selectedIds = state.uiState.selectedEntities[EntityType.payment];

    return _DashboardSidebar(
      entityType: EntityType.payment,
      label1: localization.recentPayments +
          (recentPayments.isNotEmpty ? ' (${recentPayments.length})' : ''),
      list1: recentPayments.isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: recentPayments.length,
              itemBuilder: (BuildContext context, int index) {
                return PaymentListItem(
                  payment: recentPayments[index],
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : localization.selectedPayments + ' (${selectedIds.length})',
      list3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: selectedIds?.length,
              itemBuilder: (BuildContext context, int index) {
                return PaymentListItem(
                  payment: state.paymentState.get(selectedIds[index]),
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
    );
  }
}

class _QuoteSidebar extends StatelessWidget {
  const _QuoteSidebar();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final upcomingInvoices = memoizedUpcomingInvoices(state.invoiceState.map);
    final pastDueInvoices = memoizedPastDueInvoices(state.invoiceState.map);
    final selectedIds = state.uiState.selectedEntities[EntityType.invoice];

    return _DashboardSidebar(
      entityType: EntityType.invoice,
      label1: localization.upcomingInvoices +
          (upcomingInvoices.isNotEmpty ? ' (${upcomingInvoices.length})' : ''),
      list1: upcomingInvoices.isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: upcomingInvoices.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: upcomingInvoices[index],
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label2: localization.pastDueInvoices +
          (pastDueInvoices.isNotEmpty ? ' (${pastDueInvoices.length})' : ''),
      list2: pastDueInvoices.isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: pastDueInvoices.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: pastDueInvoices[index],
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : localization.selectedInvoices + ' (${selectedIds.length})',
      list3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: selectedIds?.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: state.invoiceState.get(selectedIds[index]),
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
    );
  }
}

class _DashboardSidebar extends StatelessWidget {
  const _DashboardSidebar({
    @required this.entityType,
    @required this.label1,
    @required this.list1,
    this.label2,
    this.list2,
    this.label3,
    this.list3,
  });

  final EntityType entityType;
  final String label1;
  final String label2;
  final String label3;
  final ListView list1;
  final ListView list2;
  final ListView list3;

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
              child: Text(label1, style: textTheme.bodyText2),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
            ),
          ),
          Expanded(
            child: list1 == null
                ? HelpText(localization.noRecordsFound)
                : ClipRRect(child: list1),
          ),
          if (label2 != null) ...[
            Material(
              elevation: 4,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                child: Text(label2, style: textTheme.bodyText2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                width: double.infinity,
              ),
            ),
            Expanded(
              child: list2 == null
                  ? HelpText(localization.noRecordsFound)
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
                                style: textTheme.bodyText2)),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
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
