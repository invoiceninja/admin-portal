// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_documents.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_overview.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/payment/view/payment_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
    required this.tabIndex,
  }) : super(key: key);

  final PaymentViewVM viewModel;
  final bool isFilter;
  final int tabIndex;

  @override
  _PaymentViewState createState() => new _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    _controller = TabController(
        vsync: this,
        length: 2,
        initialIndex: widget.isFilter ? 0 : state.paymentUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdatePaymentTab(tabIndex: _controller!.index));
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
    final payment = viewModel.payment;
    final state = StoreProvider.of<AppState>(context).state;
    final company = state.company;
    final documents = payment.documents;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: payment,
      appBarBottom: company.isModuleEnabled(EntityType.document)
          ? TabBar(
              controller: _controller,
              isScrollable: false,
              tabs: [
                Tab(
                  text: localization!.overview,
                ),
                Tab(
                  text: documents.isEmpty
                      ? localization.documents
                      : '${localization.documents} (${documents.length})',
                ),
              ],
            )
          : null,
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: company.isModuleEnabled(EntityType.document)
                    ? TabBarView(
                        controller: _controller,
                        children: <Widget>[
                          RefreshIndicator(
                            onRefresh: () => viewModel.onRefreshed(context),
                            child: PaymentOverview(
                              viewModel: viewModel,
                              key: ValueKey(viewModel.payment.id),
                              isFilter: widget.isFilter,
                            ),
                          ),
                          RefreshIndicator(
                            onRefresh: () => viewModel.onRefreshed(context),
                            child: PaymentViewDocuments(
                              viewModel: viewModel,
                              key: ValueKey(viewModel.payment.id),
                            ),
                          ),
                        ],
                      )
                    : RefreshIndicator(
                        onRefresh: () => viewModel.onRefreshed(context),
                        child: PaymentOverview(
                          viewModel: viewModel,
                          key: ValueKey(viewModel.payment.id),
                          isFilter: widget.isFilter,
                        ),
                      ),
              ),
              BottomButtons(
                entity: payment,
                action1: state.company.enableApplyingPayments
                    ? EntityAction.applyPayment
                    : EntityAction.sendEmail,
                action1Enabled: state.company.enableApplyingPayments
                    ? payment.applied < payment.amount &&
                        memoizedHasActiveUnpaidInvoices(
                          payment.clientId,
                          state.invoiceState.map,
                        )
                    : true,
                action2: EntityAction.refundPayment,
                action2Enabled: payment.refunded < payment.amount,
              ),
            ],
          );
        },
      ),
    );
  }
}
