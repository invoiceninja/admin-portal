import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

import 'dialogs.dart';

void loadDesign({
  @required BuildContext context,
  @required Map<String, String> design,
  @required Function(String) onStart,
  @required Function(String) onComplete,
}) {
  final webClient = WebClient();
  final state = StoreProvider.of<AppState>(context).state;
  final credentials = state.credentials;
  final invoice = state.invoiceState.list.isEmpty
      ? InvoiceEntity(state: state)
      : state.invoiceState.map[state.invoiceState.list.first];
  final url = formatApiUrl(credentials.url) + '/preview';

  webClient
      .post(url, credentials.token,
          data: json.encode({
            'entity': 'invoice',
            'entity_id': '${invoice.id}',
            'body': design,
          }))
      .then((dynamic response) {
    print('## response: $response');
    //subject = response['subject'] ?? '';
    //body = base64Encode(encoder.convert(response['body'] ?? ''));
    //onComplete(subject, body);
  }).catchError((dynamic error) {
    showErrorDialog(context: context, message: '$error');
    //onComplete(subject, hase64Body);
  });
}
