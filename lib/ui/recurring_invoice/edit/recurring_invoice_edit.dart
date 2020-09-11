import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class RecurringInvoiceEdit extends StatefulWidget {
  const RecurringInvoiceEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EntityEditVM viewModel;

  @override
  _RecurringInvoiceEditState createState() => _RecurringInvoiceEditState();
}

class _RecurringInvoiceEditState extends State<RecurringInvoiceEdit>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_recurringInvoiceEdit');
  TabController _controller;
  final _debouncer = Debouncer();

  static const kDetailsScreen = 0;
  static const kItemScreen = 1;

  // STARTER: controllers - do not remove comment

  List<TextEditingController> _controllers = [];

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
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final recurringInvoice = viewModel.invoice;
    final state = viewModel.state;

    return EditScaffold(
      title: recurringInvoice.isNew
          ? localization.newRecurringInvoice
          : localization.editRecurringInvoice,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        /*
          setState(() {
            _autoValidate = !isValid;
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
          child: Builder(builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    // STARTER: widgets - do not remove comment
                  ],
                ),
              ],
            );
          })),
    );
  }
}
