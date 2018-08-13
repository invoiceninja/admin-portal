import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

String processTemplate(String template, InvoiceEntity invoice, BuildContext context) {
  if (template == null) {
    return '';
  }

  final state = StoreProvider.of<AppState>(context).state;
  final company = state.selectedCompany;
  final client = state.clientState.map[invoice.clientId];

  //template = template.replaceAll('$footer', company.)
  print('template was: $template');
  template = template.replaceAll('\$client', client.displayName);
  print('template is: $template');

  return template;
}