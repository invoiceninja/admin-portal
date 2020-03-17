import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
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
  final url = formatApiUrl(credentials.url) + '/preview';

  final request = DesignPreviewRequest(design: design);
  final data =
      serializers.serializeWith(DesignPreviewRequest.serializer, request);

  webClient
      .post(url, credentials.token, data: json.encode(data), rawResponse: true)
      .then((dynamic response) {
    if ((response as Response).statusCode >= 400) {
      showErrorDialog(
          context: context,
          message:
              '${(response as Response).statusCode}: ${(response as Response).reasonPhrase}');
      onComplete(null);
    } else {
      onComplete(response);
    }
  }).catchError((dynamic error) {
    showErrorDialog(context: context, message: '$error');
    onComplete(null);
  });
}
