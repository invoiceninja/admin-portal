import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/ui/app/actions_menu_button.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_vm.dart';
import 'package:invoiceninja/utils/localization.dart';

import '../../app/save_icon_button.dart';

class InvoiceEdit extends StatefulWidget {
  final InvoiceEditVM viewModel;

  InvoiceEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _InvoiceEditState createState() => _InvoiceEditState();
}

class _InvoiceEditState extends State<InvoiceEdit> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _invoiceKey;
  String _notes;
  double _cost;

  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.invoice.isNew()
            ? AppLocalization.of(context).newInvoice
            : viewModel.invoice.invoiceNumber),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return SaveIconButton(
              isLoading: viewModel.isLoading,
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }

                _formKey.currentState.save();
                /*
                viewModel.onSaveClicked(
                    context,
                    viewModel.invoice.rebuild((b) => b
                      ..invoiceNumber= _invoiceKey
                      ..notes = _notes
                      ..cost = _cost));
                      */
              },
            );
          }),
          viewModel.invoice.isNew()
              ? Container()
              : ActionMenuButton(
                  entity: viewModel.invoice,
                  onSelected: viewModel.onActionSelected,
                )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            FormCard(
              children: <Widget>[
                /*
                TextFormField(
                  autocorrect: false,
                  onSaved: (value) {
                    _invoiceKey = value;
                  },
                  initialValue: viewModel.invoice.invoiceKey,
                  decoration: InputDecoration(
                    //border: InputBorder.none,
                    labelText: AppLocalization.of(context).invoice,
                  ),
                  validator: (val) => val.isEmpty || val.trim().length == 0
                      ? AppLocalization.of(context).pleaseEnterAInvoiceKey
                      : null,
                ),
                TextFormField(
                  initialValue: viewModel.invoice.notes,
                  onSaved: (value) {
                    _notes = value;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: AppLocalization.of(context).notes,
                  ),
                ),
                TextFormField(
                  initialValue: viewModel.invoice.cost == null ||
                          viewModel.invoice.cost == 0.0
                      ? null
                      : viewModel.invoice.cost.toStringAsFixed(2),
                  onSaved: (value) {
                    _cost = double.tryParse(value) ?? 0.0;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    //border: InputBorder.none,
                    labelText: AppLocalization.of(context).cost,
                  ),
                ),
                */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
