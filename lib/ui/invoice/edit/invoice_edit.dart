import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_desktop.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_item_selector.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_flat_button.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class InvoiceEdit extends StatefulWidget {
  const InvoiceEdit({
    Key key,
    @required this.formKey,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditVM viewModel;
  final GlobalKey<FormState> formKey;

  @override
  _InvoiceEditState createState() => _InvoiceEditState();
}

class _InvoiceEditState extends State<InvoiceEdit>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  static const kDetailsScreen = 0;
  static const kContactScreen = 1;
  static const kItemScreen = 2;
  static const kNotesScreen = 3;

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

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: isMobile(context),
          title: Text(invoice.isNew
              ? localization.newInvoice
              : localization.editInvoice),
          actions: <Widget>[
            if (!isMobile(context))
              FlatButton(
                child: Text(
                  localization.cancel,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => viewModel.onCancelPressed(context),
              ),
            ActionFlatButton(
              tooltip: localization.save,
              isVisible: !invoice.isDeleted,
              isSaving: widget.viewModel.isSaving,
              isDirty: invoice.isNew || invoice != viewModel.origInvoice,
              onPressed: () {
                if (!widget.formKey.currentState.validate()) {
                  return;
                }

                widget.viewModel.onSavePressed(context);
              },
            )
          ],
          bottom: state.prefState.isDesktop
              ? null
              : TabBar(
                  controller: _controller,
                  //isScrollable: true,
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
        ),
        body: state.prefState.isDesktop
            ? InvoiceEditDetailsScreen()
            : Form(
                key: widget.formKey,
                child: TabBarView(
                  key: ValueKey('__invoice_${viewModel.invoice.id}__'),
                  controller: _controller,
                  children: <Widget>[
                    InvoiceEditDetailsScreen(),
                    InvoiceEditContactsScreen(),
                    InvoiceEditItemsScreen(),
                    InvoiceEditNotesScreen(),
                  ],
                ),
              ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              '${localization.total}: ${formatNumber(invoice.calculateTotal(viewModel.company.settings.enableInclusiveTaxes ?? false), context, clientId: viewModel.invoice.clientId)}',
              style: TextStyle(
                //color: Theme.of(context).selectedRowColor,
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          heroTag: 'invoice_edit_fab',
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
      ),
    );
  }
}
