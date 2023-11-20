// Dart imports:
import 'dart:async';
import 'dart:core';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/models/static/static_data_model.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class StaticRepository {
  const StaticRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<StaticDataEntity> loadList(Credentials credentials) async {
    final dynamic response =
        await webClient.get(credentials.url+ '/static', credentials.token);

    final StaticDataItemResponse staticDataResponse = serializers
        .deserializeWith(StaticDataItemResponse.serializer, response)!;

    return staticDataResponse.data;
  }
}
