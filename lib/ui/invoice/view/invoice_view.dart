import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_contacts.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_documents.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_history.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_overview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_schedule.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final EntityViewVM viewModel;
  final bool isFilter;

  @override
  _InvoiceViewState createState() => new _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();

    final invoice = widget.viewModel.invoice;
    _controller =
        TabController(vsync: this, length: invoice.isRecurring ? 5 : 4);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final localization = AppLocalization.of(context);
    /*
    final documents = memoizedInvoiceDocumentsSelector(
        documentState.map, viewModel.state.expenseState.map, invoice);
    */
    final documents = invoice.documents;

    EntityAction secondAction;
    if (invoice.isCredit) {
      secondAction = EntityAction.cloneToCredit;
    } else if (invoice.isQuote) {
      if (invoice.hasInvoice) {
        secondAction = EntityAction.cloneToQuote;
      } else {
        secondAction = EntityAction.convertToInvoice;
      }
    } else if (invoice.isRecurringInvoice) {
      secondAction = invoice.isRunning ? EntityAction.stop : EntityAction.start;
    } else {
      if (invoice.isPaid) {
        secondAction = EntityAction.cloneToInvoice;
      } else {
        secondAction = EntityAction.newPayment;
      }
    }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: invoice,
      appBarBottom: TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          if (invoice.isRecurring)
            Tab(
              text: localization.schedule,
            ),
          Tab(
            text: localization.contacts,
          ),
          Tab(
            text: documents.isEmpty
                ? localization.documents
                : '${localization.documents} (${documents.length})',
          ),
          Tab(
            text: localization.history,
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return RefreshIndicator(
            onRefresh: () => viewModel.onRefreshed(context),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      RefreshIndicator(
                        onRefresh: () => viewModel.onRefreshed(context),
                        child: InvoiceOverview(
                          viewModel: viewModel,
                          isFilter: widget.isFilter,
                          key: ValueKey(viewModel.invoice.id),
                        ),
                      ),
                      if (invoice.isRecurring)
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed(context),
                          child: InvoiceViewSchedule(
                            viewModel: viewModel,
                            key: ValueKey(viewModel.invoice.id),
                          ),
                        ),
                      RefreshIndicator(
                        onRefresh: () => viewModel.onRefreshed(context),
                        child: InvoiceViewContacts(
                          viewModel: viewModel,
                          key: ValueKey(viewModel.invoice.id),
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () => viewModel.onRefreshed(context),
                        child: InvoiceViewDocuments(
                            viewModel: viewModel,
                            invoice: viewModel.invoice,
                            key: ValueKey(viewModel.invoice.id)),
                      ),
                      RefreshIndicator(
                        onRefresh: () => viewModel.onRefreshed(context),
                        child: InvoiceViewHistory(
                            viewModel: viewModel,
                            key: ValueKey(viewModel.invoice.id)),
                      ),
                    ],
                  ),
                ),
                BottomButtons(
                  entity: invoice,
                  action1: EntityAction.viewPdf,
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
