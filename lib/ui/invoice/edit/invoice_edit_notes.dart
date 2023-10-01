// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/client/client_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/invoice/edit/invoice_edit_notes_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class InvoiceEditNotes extends StatefulWidget {
  const InvoiceEditNotes({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EntityEditNotesVM viewModel;

  @override
  InvoiceEditNotesState createState() => InvoiceEditNotesState();
}

class InvoiceEditNotesState extends State<InvoiceEditNotes> {
  final _publicNotesController = TextEditingController();
  final _privateNotesController = TextEditingController();
  final _termsController = TextEditingController();
  final _footerController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _publicNotesController,
      _privateNotesController,
      _termsController,
      _footerController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final invoice = widget.viewModel.invoice!;
    _publicNotesController.text = invoice.publicNotes;
    _privateNotesController.text = invoice.privateNotes;
    _termsController.text = invoice.terms;
    _footerController.text = invoice.footer;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final invoice = widget.viewModel.invoice!.rebuild((b) => b
      ..publicNotes = _publicNotesController.text.trim()
      ..privateNotes = _privateNotesController.text.trim()
      ..terms = _termsController.text.trim()
      ..footer = _footerController.text.trim());
    if (invoice != widget.viewModel.invoice) {
      _debouncer.run(() {
        widget.viewModel.onChanged!(invoice);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state!;
    final invoice = viewModel.invoice!;
    final client = state.clientState.get(invoice.clientId);
    final settings = getClientSettings(state, client);

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          isLast: true,
          children: <Widget>[
            DecoratedFormField(
              maxLines: 4,
              controller: _termsController,
              keyboardType: TextInputType.multiline,
              label: invoice.entityType == EntityType.credit
                  ? localization.creditTerms
                  : invoice.entityType == EntityType.quote
                      ? localization.quoteTerms
                      : localization.invoiceTerms,
              hint: invoice.isOld
                  ? ''
                  : settings.getDefaultTerms(invoice.entityType),
            ),
            DecoratedFormField(
              maxLines: 4,
              controller: _footerController,
              keyboardType: TextInputType.multiline,
              label: invoice.entityType == EntityType.credit
                  ? localization.creditFooter
                  : invoice.entityType == EntityType.quote
                      ? localization.quoteFooter
                      : localization.invoiceFooter,
              hint: invoice.isOld
                  ? ''
                  : settings.getDefaultFooter(invoice.entityType),
            ),
            DecoratedFormField(
              maxLines: 4,
              controller: _publicNotesController,
              keyboardType: TextInputType.multiline,
              label: localization.publicNotes,
              hint: client.publicNotes,
            ),
            DecoratedFormField(
              maxLines: 4,
              controller: _privateNotesController,
              keyboardType: TextInputType.multiline,
              label: localization.privateNotes,
            ),
          ],
        ),
      ],
    );
  }
}
