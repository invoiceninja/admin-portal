// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_details_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_items_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_notes_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_pdf_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_contacts_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_footer.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_item_selector.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CreditEdit extends StatefulWidget {
  const CreditEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AbstractInvoiceEditVM viewModel;

  @override
  _CreditEditState createState() => _CreditEditState();
}

class _CreditEditState extends State<CreditEdit>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_creditEdit');

  static const kDetailsScreen = 0;
  static const kItemScreen = 2;

  //static const kNotesScreen = 2;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;

    final index =
        viewModel.invoiceItemIndex != null ? kItemScreen : kDetailsScreen;
    _controller = TabController(vsync: this, length: 5, initialIndex: index);
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.viewModel.invoiceItemIndex != null) {
      _controller!.animateTo(kItemScreen);
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _onSavePressed(BuildContext context, [EntityAction? action]) {
    final bool isValid = _formKey.currentState!.validate();

    /*
        setState(() {
          autoValidate = !isValid ?? false;
        });
         */

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed!(context, action);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice!;
    final state = viewModel.state!;
    final prefState = state.prefState;
    final isFullscreen = prefState.isEditorFullScreen(EntityType.invoice);
    final client = state.clientState.get(invoice.clientId);

    return EditScaffold(
      isFullscreen: isFullscreen,
      entity: invoice,
      title: invoice.isNew ? localization.newCredit : localization.editCredit,
      onCancelPressed: (context) => viewModel.onCancelPressed!(context),
      onSavePressed: (context) => _onSavePressed(context),
      actions: invoice.getActions(
        userCompany: state.userCompany,
        client: client,
      ),
      onActionPressed: (context, action) => _onSavePressed(context, action),
      appBarBottom: TabBar(
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
          Tab(
            text: localization.pdf,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: isFullscreen
            ? CreditEditDetailsScreen(
                viewModel: widget.viewModel,
              )
            : TabBarView(
                key: ValueKey('__invoice_${invoice.id}_${invoice.updatedAt}__'),
                controller: _controller,
                children: <Widget>[
                  CreditEditDetailsScreen(
                    viewModel: widget.viewModel,
                  ),
                  InvoiceEditContactsScreen(
                    entityType: invoice.entityType,
                  ),
                  CreditEditItemsScreen(
                    viewModel: widget.viewModel,
                  ),
                  CreditEditNotesScreen(),
                  CreditEditPDFScreen(),
                ],
              ),
      ),
      bottomNavigationBar: InvoiceEditFooter(invoice: invoice),
      floatingActionButton: FloatingActionButton(
        heroTag: 'credit_edit_fab',
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          showDialog<InvoiceItemSelector>(
              context: context,
              builder: (BuildContext context) {
                return InvoiceItemSelector(
                  invoice: invoice,
                  showTasksAndExpenses: false,
                  excluded: invoice.lineItems
                      .where((item) => item.isTask || item.isExpense)
                      .map((item) => item.isTask
                          ? viewModel.state!.taskState.map[item.taskId]
                          : viewModel.state!.expenseState.map[item.expenseId])
                      .whereType<BaseEntity>()
                      .toList(),
                  clientId: invoice.clientId,
                  onItemsSelected: (items, [clientId, projectId]) {
                    viewModel.onItemsAdded!(items, clientId, projectId);
                    if (!isFullscreen) {
                      _controller!.animateTo(kItemScreen);
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
