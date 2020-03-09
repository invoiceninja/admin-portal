import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

import 'dialogs.dart';

void loadDesign({
  @required BuildContext context,
  @required DesignEntity design,
  @required Function(Response) onComplete,
}) {
  final webClient = WebClient();
  final state = StoreProvider.of<AppState>(context).state;
  final credentials = state.credentials;
  final invoice = state.invoiceState.list.isEmpty
      ? InvoiceEntity(state: state)
      : state.invoiceState.map[state.invoiceState.list.first];
  final url = formatApiUrl(credentials.url) + '/preview';

  final request = DesignPreviewRequest(design: design);
  final data =
      serializers.serializeWith(DesignPreviewRequest.serializer, request);

  webClient
      .post(url, credentials.token, data: json.encode(data), rawResponse: true)
      .then((dynamic response) {
    onComplete(response);
  }).catchError((dynamic error) {
    showErrorDialog(context: context, message: '$error');
    onComplete(null);
  });
}
