import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/entity_dropdown.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_details_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

class InvoiceEditDetails extends StatefulWidget {
  InvoiceEditDetails({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final InvoiceEditDetailsVM viewModel;

  @override
  InvoiceEditDetailsState createState() => new InvoiceEditDetailsState();
}

class InvoiceEditDetailsState extends State<InvoiceEditDetails> {

  final _invoiceNumberController = TextEditingController();
  final _poNumberController = TextEditingController();
  final _discountController = TextEditingController();
  final _partialController = TextEditingController();

  var _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      _invoiceNumberController,
      _poNumberController,
      _discountController,
      _partialController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    var invoice = widget.viewModel.invoice;
    _invoiceNumberController.text = invoice.invoiceNumber;
    _poNumberController.text = invoice.poNumber;
    _discountController.text = invoice.discount?.toStringAsFixed(2) ?? '';
    _partialController.text = invoice.partial?.toStringAsFixed(2) ?? '';

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  _onChanged() {
    var invoice = widget.viewModel.invoice.rebuild((b) => b
      ..poNumber = _poNumberController.text.trim()
      ..discount = double.tryParse(_discountController.text) ?? 0.0
      ..partial = double.tryParse(_partialController.text) ?? 0.0
    );
    if (invoice != widget.viewModel.invoice) {
      widget.viewModel.onChanged(invoice);
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var viewModel = widget.viewModel;
    var invoice = viewModel.invoice;

    return ListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            invoice.isNew()
                ? EntityDropdown(
                    labelText: localization.client,
                    entityList: viewModel.clientList,
                    entityMap: viewModel.clientMap,
                    onFilterChanged: viewModel.onEntityFilterChanged,
                ) : TextFormField(
                    autocorrect: false,
                    controller: _invoiceNumberController,
                    decoration: InputDecoration(
                      labelText: localization.invoiceNumber,
                    ),
                  ),
            TextFormField(
              autocorrect: false,
              controller: _poNumberController,
              decoration: InputDecoration(
                labelText: localization.poNumber,
              ),
            ),
            TextFormField(
              autocorrect: false,
              controller: _discountController,
              decoration: InputDecoration(
                labelText: localization.discount,
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              autocorrect: false,
              controller: _partialController,
              decoration: InputDecoration(
                labelText: localization.partial,
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }
}
