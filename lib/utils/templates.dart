import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/.env.dart';
import 'dialogs.dart';

void loadEmailTemplate({
  @required BuildContext context,
  @required Function(String, String, String) onComplete,
  String template,
  String subject,
  String body,
  InvoiceEntity invoice,
}) {
  if (Config.DEMO_MODE) {
    onComplete(subject, body, '');
    return;
  }

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

  if (template != null) {
    template = 'email_template_$template';
  }

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
    onComplete(response['subject'], response['body'], response['wrapper']);
  }).catchError((dynamic error) {
    showErrorDialog(context: context, message: '$error');
    onComplete(subject, body, '');
  });
}
