import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_documents.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_overview.dart';
import 'package:invoiceninja_flutter/ui/invoice/view/invoice_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityViewVM viewModel;

  @override
  _InvoiceViewState createState() => new _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
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
    final documentState = viewModel.state.documentState;
    final documents = memoizedInvoiceDocumentsSelector(
        documentState.map, viewModel.state.expenseState.map, invoice);

    EntityAction secondAction;
    if (invoice.isCredit) {
      secondAction = EntityAction.cloneToCredit;
    } else if (invoice.isQuote) {
      if (invoice.hasInvoice) {
        secondAction = EntityAction.cloneToQuote;
      } else {
        secondAction = EntityAction.convert;
      }
    } else {
      if (invoice.isPaid) {
        secondAction = EntityAction.cloneToInvoice;
      } else {
        secondAction = EntityAction.newPayment;
      }
    }

    return ViewScaffold(
      entity: invoice,
      title: '${invoice.number ?? '• ${localization.pending}'}',
      appBarBottom: TabBar(
        controller: _controller,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: documents.isEmpty
                ? localization.documents
                : '${localization.documents} (${documents.length})',
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
                        child: InvoiceOverview(viewModel: viewModel),
                      ),
                      RefreshIndicator(
                        onRefresh: () => viewModel.onRefreshed(context),
                        child: InvoiceViewDocuments(
                            viewModel: viewModel, invoice: viewModel.invoice),
                      ),
                    ],
                  ),
                ),
                BottomButtons(
                  entity: invoice,
                  action1: EntityAction.pdf,
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
