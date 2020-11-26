import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_item_selector.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class InvoiceEdit extends StatefulWidget {
  const InvoiceEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditVM viewModel;

  @override
  _InvoiceEditState createState() => _InvoiceEditState();
}

class _InvoiceEditState extends State<InvoiceEdit>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_invoiceEdit');

  static const kDetailsScreen = 0;

  //static const kContactScreen = 1;
  static const kItemScreen = 2;

  //static const kNotesScreen = 3;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    final index =
        viewModel.invoiceItemIndex != null ? kItemScreen : kDetailsScreen;
    _controller = TabController(vsync: this, length: 4, initialIndex: index);
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
      isFullscreen: state.prefState.isDesktop,
      entity: invoice,
      title: invoice.isNew ? localization.newInvoice : localization.editInvoice,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        /*
        setState(() {
          autoValidate = !isValid ?? false;
        });
         */

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      appBarBottom: state.prefState.isDesktop
          ? null
          : TabBar(
              controller: _controller,
              isScrollable: true,
              tabs: [
                Tab(
                  text: localization.details,
                ),
                Tab(
                  text: localization.contacts,
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
            ? InvoiceEditDetailsScreen(
                viewModel: widget.viewModel,
              )
            : TabBarView(
                key: ValueKey('__invoice_${viewModel.invoice.id}__'),
                controller: _controller,
                children: <Widget>[
                  InvoiceEditDetailsScreen(
                    viewModel: widget.viewModel,
                  ),
                  InvoiceEditContactsScreen(
                    entityType: invoice.entityType,
                  ),
                  InvoiceEditItemsScreen(
                    viewModel: widget.viewModel,
                  ),
                  InvoiceEditNotesScreen(),
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
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${localization.lookup('${invoice.entityType}_total')}: ${formatNumber(invoice.calculateTotal(precision: precisionForInvoice(state, invoice)), context, clientId: viewModel.invoice.clientId)}',
                  style: TextStyle(
                    //color: Theme.of(context).selectedRowColor,
                    color: state.prefState.enableDarkMode
                        ? Colors.white
                        : Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'invoice_edit_fab',
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          showDialog<InvoiceItemSelector>(
              context: context,
              builder: (BuildContext context) {
                return InvoiceItemSelector(
                  showTasksAndExpenses: true,
                  excluded: invoice.lineItems
                      .where((item) => item.isTask || item.isExpense)
                      .map((item) => item.isTask
                          ? viewModel.state.taskState.map[item.taskId]
                          : viewModel.state.expenseState.map[item.expenseId])
                      .toList(),
                  clientId: invoice.clientId,
                  onItemsSelected: (items, [clientId]) {
                    viewModel.onItemsAdded(items, clientId);
                    if (isNotDesktop(context)) {
                      _controller.animateTo(kItemScreen);
                    }
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
