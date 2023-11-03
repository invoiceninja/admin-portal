// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'dialogs.dart';

void loadDesign({
  required BuildContext context,
  required DesignEntity design,
  required bool isDraftMode,
  required bool isPurchaseOrder,
  required Function(Response?) onComplete,
}) {
  if (Config.DEMO_MODE) {
    onComplete(null);
    return;
  }

  final webClient = WebClient();
  final state = StoreProvider.of<AppState>(context).state;
  final credentials = state.credentials;
  String url = '${credentials.url}/preview';

  if (isPurchaseOrder) {
    url += '/purchase_order';
  }

  if (isDraftMode) {
    url += '?html=true';
  }

  final request = DesignPreviewRequest(design: design);
  final data =
      serializers.serializeWith(DesignPreviewRequest.serializer, request);

  webClient
      .post(url, credentials.token, data: json.encode(data), rawResponse: true)
      .then((dynamic response) {
    onComplete(response);
  }).catchError((dynamic error) {
    showErrorDialog(message: '$error');
    onComplete(null);
  });
}
