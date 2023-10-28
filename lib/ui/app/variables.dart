// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/quote_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_tab_bar.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VariablesHelp extends StatefulWidget {
  const VariablesHelp({
    this.showInvoiceAsQuote = false,
    this.showInvoiceAsInvoices = false,
  });

  final bool showInvoiceAsQuote;
  final bool showInvoiceAsInvoices;

  @override
  _VariablesHelpState createState() => _VariablesHelpState();
}

class _VariablesHelpState extends State<VariablesHelp>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final company = state.company;

    return FormCard(
      children: [
        AppTabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(
                child: Text(widget.showInvoiceAsQuote
                    ? localization.quote
                    : widget.showInvoiceAsInvoices
                        ? localization.invoices
                        : localization.invoice)),
            Tab(child: Text(localization.client)),
            Tab(child: Text(localization.contact)),
            Tab(child: Text(localization.company)),
          ],
        ),
        SizedBox(
          height: 540,
          child: TabBarView(
            controller: _controller,
            children: [
              _VariableGrid(
                fields: [
                  'view_button',
                  'view_url',
                  'payment_button',
                  'payment_url',
                  'created_by_user',
                  'assigned_to_user',
                  'invoice',
                  'invoices',
                  if (widget.showInvoiceAsInvoices) ...[
                    'invoice_references',
                    'payment.status',
                    'invoices.po_number',
                    'invoices.amount',
                    'invoices.balance',
                    'invoices.due_date',
                  ] else if (widget.showInvoiceAsQuote) ...[
                    QuoteFields.amount,
                    QuoteFields.discount,
                    QuoteFields.date,
                    QuoteFields.validUntil,
                    QuoteFields.poNumber,
                    QuoteFields.publicNotes,
                    QuoteFields.exchangeRate,
                    QuoteFields.number,
                    QuoteFields.terms,
                    QuoteFields.footer,
                  ] else ...[
                    InvoiceFields.amount,
                    InvoiceFields.discount,
                    InvoiceFields.balance,
                    InvoiceFields.date,
                    InvoiceFields.dueDate,
                    InvoiceFields.poNumber,
                    InvoiceFields.publicNotes,
                    InvoiceFields.exchangeRate,
                    InvoiceFields.number,
                    InvoiceFields.terms,
                    InvoiceFields.footer,
                    'payments',
                  ],
                  if (company.hasCustomField(CustomFieldType.invoice1))
                    InvoiceFields.customValue1,
                  if (company.hasCustomField(CustomFieldType.invoice2))
                    InvoiceFields.customValue2,
                  if (company.hasCustomField(CustomFieldType.invoice3))
                    InvoiceFields.customValue3,
                  if (company.hasCustomField(CustomFieldType.invoice4))
                    InvoiceFields.customValue4,
                  if (company.hasCustomField(CustomFieldType.surcharge1))
                    InvoiceFields.customSurcharge1,
                  if (company.hasCustomField(CustomFieldType.surcharge2))
                    InvoiceFields.customSurcharge2,
                  if (company.hasCustomField(CustomFieldType.surcharge3))
                    InvoiceFields.customSurcharge3,
                  if (company.hasCustomField(CustomFieldType.surcharge4))
                    InvoiceFields.customSurcharge4,
                ],
              ),
              _VariableGrid(
                fields: [
                  ClientFields.name,
                  ClientFields.publicNotes,
                  ClientFields.vatNumber,
                  ClientFields.address1,
                  ClientFields.address2,
                  ClientFields.city,
                  ClientFields.state,
                  ClientFields.postalCode,
                  ClientFields.country,
                  ClientFields.shippingAddress1,
                  ClientFields.shippingAddress2,
                  ClientFields.shippingCity,
                  ClientFields.shippingState,
                  ClientFields.shippingPostalCode,
                  ClientFields.shippingCountry,
                  ClientFields.phone,
                  ClientFields.creditBalance,
                  ClientFields.idNumber,
                  if (company.hasCustomField(CustomFieldType.client1))
                    ClientFields.custom1,
                  if (company.hasCustomField(CustomFieldType.client2))
                    ClientFields.custom2,
                  if (company.hasCustomField(CustomFieldType.client3))
                    ClientFields.custom3,
                  if (company.hasCustomField(CustomFieldType.client4))
                    ClientFields.custom4,
                ].map((field) => 'client.$field').toList(),
              ),
              _VariableGrid(
                fields: [
                  ContactFields.firstName,
                  ContactFields.lastName,
                  ContactFields.email,
                  ContactFields.phone,
                  if (company.hasCustomField(CustomFieldType.contact1))
                    ContactFields.custom1,
                  if (company.hasCustomField(CustomFieldType.contact2))
                    ContactFields.custom2,
                  if (company.hasCustomField(CustomFieldType.contact3))
                    ContactFields.custom3,
                  if (company.hasCustomField(CustomFieldType.contact4))
                    ContactFields.custom4,
                ].map((field) => 'contact.$field').toList(),
              ),
              _VariableGrid(
                fields: [
                  CompanyFields.name,
                  CompanyFields.country,
                  CompanyFields.address1,
                  CompanyFields.address2,
                  CompanyFields.city,
                  CompanyFields.postalCode,
                  CompanyFields.idNumber,
                  CompanyFields.email,
                  CompanyFields.phone,
                  CompanyFields.state,
                  CompanyFields.vatNumber,
                  CompanyFields.website,
                  if (company.hasCustomField(CustomFieldType.company1))
                    CompanyFields.custom1,
                  if (company.hasCustomField(CustomFieldType.company2))
                    CompanyFields.custom2,
                  if (company.hasCustomField(CustomFieldType.company3))
                    CompanyFields.custom3,
                  if (company.hasCustomField(CustomFieldType.company4))
                    CompanyFields.custom4,
                ].map((field) => 'company.$field').toList(),
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

  final List<String>? fields;

  @override
  Widget build(BuildContext context) {
    fields!.sort((a, b) => a.compareTo(b));

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: LayoutBuilder(builder: (context, constraints) {
        return GridView.count(
          //physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(6),
          shrinkWrap: true,
          primary: true,
          crossAxisCount: 2,
          childAspectRatio: ((constraints.maxWidth / 2) - 8) / 50,
          children: fields!
              .map(
                (field) => TextButton(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\$$field',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: '\$$field'));
                    showToast(AppLocalization.of(context)!
                        .copiedToClipboard
                        .replaceFirst(':value', '\$$field'));
                  },
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
