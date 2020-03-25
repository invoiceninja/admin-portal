import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'dialogs.dart';

void loadTemplate({
  @required BuildContext context,
  @required Function(String, String) onStart,
  @required Function(String, String) onComplete,
  String subject,
  String body,
  InvoiceEntity invoice,
  String template,
}) {
  final webClient = WebClient();
  final state = StoreProvider.of<AppState>(context).state;
  final credentials = state.credentials;
  final url = formatApiUrl(credentials.url) + '/templates';

  /*
  final invoice = state.invoiceState.list.isEmpty
      ? InvoiceEntity(state: state)
      : state.invoiceState.map[state.invoiceState.list.first];
   */

  subject ??= '';
  body ??= '';

  onStart(subject, body);

  webClient
      .post(url, credentials.token,
          data: json.encode({
            'entity': '${invoice?.entityType ?? ''}',
            'entity_id': '${invoice?.id ?? ''}',
            'template': (subject.isEmpty && body.isEmpty && template != null)
                ? template
                : '',
            'subject': subject,
            'body': body,
          }))
      .then((dynamic response) {
    onComplete(response['subject'], response['body']);
  }).catchError((dynamic error) {
    showErrorDialog(context: context, message: '$error');
    onComplete(subject, body);
  });
}
