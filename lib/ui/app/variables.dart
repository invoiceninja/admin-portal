import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VariablesHelp extends StatefulWidget {
  @override
  _VariablesHelpState createState() => _VariablesHelpState();
}

class _VariablesHelpState extends State<VariablesHelp>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return FormCard(
      children: [
        TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(child: Text(localization.email)),
            Tab(child: Text(localization.invoice)),
            Tab(child: Text(localization.client)),
            Tab(child: Text(localization.contact)),
            Tab(child: Text(localization.user)),
          ],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _controller,
            children: [
              SizedBox(),
              _VariableGrid(
                fields: [
                  InvoiceFields.total,
                  InvoiceFields.discount,
                  InvoiceFields.balance,
                  InvoiceFields.date,
                  InvoiceFields.dueDate,
                  InvoiceFields.poNumber,
                  InvoiceFields.publicNotes,
                ],
              ),
              _VariableGrid(
                fields: [
                  ClientFields.name,
                  ClientFields.publicNotes,
                  ClientFields.vatNumber,
                  ClientFields.state,
                ].map((field) => 'client.$field').toList(),
              ),
              _VariableGrid(
                fields: [
                  ContactFields.firstName,
                ],
              ),
              _VariableGrid(
                fields: [
                  UserFields.firstName,
                  UserFields.lastName,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VariableGrid extends StatelessWidget {
  const _VariableGrid({this.fields});

  final List<String> fields;

  @override
  Widget build(BuildContext context) {
    fields.sort((a, b) => a.compareTo(b));

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(6),
          shrinkWrap: true,
          primary: true,
          crossAxisCount: 3,
          childAspectRatio: 3 / 1,
          children: fields.map((field) => SelectableText('\$$field')).toList()),
    );
  }
}
