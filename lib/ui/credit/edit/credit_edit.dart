import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_item_selector.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_notes_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CreditEdit extends StatefulWidget {
  const CreditEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditVM viewModel;

  @override
  _CreditEditState createState() => _CreditEditState();
}

class _CreditEditState extends State<CreditEdit>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_creditEdit');

  static const kDetailsScreen = 0;
  static const kItemScreen = 1;

  //static const kNotesScreen = 2;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    final index =
        viewModel.invoiceItemIndex != null ? kItemScreen : kDetailsScreen;
    _controller = TabController(vsync: this, length: 3, initialIndex: index);
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.viewModel.invoiceItemIndex != null) {
      _controller.animateTo(kItemScreen);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;
    final state = viewModel.state;

    return EditScaffold(
      entity: invoice,
      title: invoice.isNew ? localization.newCredit : localization.editCredit,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        if (!_formKey.currentState.validate()) {
          return;
        }

        widget.viewModel.onSavePressed(context);
      },
      appBarBottom: state.prefState.isDesktop
          ? null
          : TabBar(
              controller: _controller,
              //isScrollable: true,
              tabs: [
                Tab(
                  text: localization.details,
                ),
                Tab(
                  text: localization.items,
                ),
                Tab(
                  text: localization.notes,
                ),
              ],
            ),
      body: Form(
        key: _formKey,
        child: state.prefState.isDesktop
            ? CreditEditDetailsScreen(
          viewModel: widget.viewModel,
        )
            : TabBarView(
                key: ValueKey('__credit_${viewModel.invoice.id}__'),
                controller: _controller,
                children: <Widget>[
                  CreditEditDetailsScreen(
                    viewModel: widget.viewModel,
                  ),
                  CreditEditItemsScreen(
                    viewModel: widget.viewModel,
                  ),
                  CreditEditNotesScreen(),
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).cardColor,
        shape: CircularNotchedRectangle(),
        child: SizedBox(
          height: kTopBottomBarHeight,
          child: AppBorder(
            isTop: true,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${localization.total}: ${formatNumber(invoice.calculateTotal, context, clientId: viewModel.invoice.clientId)}',
                style: TextStyle(
                  //color: Theme.of(context).selectedRowColor,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'credit_edit_fab',
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          showDialog<InvoiceItemSelector>(
              context: context,
              builder: (BuildContext context) {
                return InvoiceItemSelector(
                  excluded: invoice.lineItems
                      .where((item) => item.isTask || item.isExpense)
                      .map((item) => item.isTask
                          ? viewModel.state.taskState.map[item.taskId]
                          : viewModel.state.expenseState.map[item.expenseId])
                      .toList(),
                  clientId: invoice.clientId,
                  onItemsSelected: (items, [clientId]) {
                    viewModel.onItemsAdded(items, clientId);
                    _controller.animateTo(kItemScreen);
                  },
                );
              });
        },
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: localization.addItem,
      ),
    );
  }
}
