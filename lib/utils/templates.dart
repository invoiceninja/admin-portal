import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

import 'dialogs.dart';

void loadTemplate({
  @required BuildContext context,
  @required String subject,
  @required String body,
  @required Function(String, String) onStart,
  @required Function(String, String) onComplete,
}) {
  final webClient = WebClient();
  final state = StoreProvider.of<AppState>(context).state;
  final credentials = state.credentials;
  final invoice =
      state.invoiceState.map[state.invoiceState.list.first] ?? InvoiceEntity();
  final url = credentials.url + '/templates/invoice/${invoice.id}';
  const encoder = const Utf8Encoder();

  final hase64Body =
      'data:text/html;base64,' + base64Encode(encoder.convert(body));
  onStart(subject, hase64Body);

  webClient
      .post(url, credentials.token,
          data: json.encode({'subject': subject, 'body': body}))
      .then((dynamic response) {
    print('### response');
    print(response);
    final String contentBase64 =
        base64Encode(encoder.convert(response));
    onComplete(subject, contentBase64);
  }).catchError((dynamic error) {
    showErrorDialog(context: context, message: '$error');
    onComplete(subject, hase64Body);
  });
}
