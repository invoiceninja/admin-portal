import 'dart:convert';
import 'dart:core';
import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';

class ScheduleRepository {
  const ScheduleRepository({
    this.webClient = const WebClient(),
  });

  final WebClient webClient;

  Future<ScheduleEntity> loadItem(
      Credentials credentials, String? entityId) async {
    final dynamic response = await webClient.get(
        '${credentials.url}/task_schedulers/$entityId', credentials.token);

    final ScheduleItemResponse scheduleResponse =
        serializers.deserializeWith(ScheduleItemResponse.serializer, response)!;

    return scheduleResponse.data;
  }

  Future<BuiltList<ScheduleEntity>> loadList(Credentials credentials) async {
    final String url = credentials.url+ '/task_schedulers?';
    final dynamic response = await webClient.get(url, credentials.token);

    final ScheduleListResponse scheduleResponse =
        serializers.deserializeWith(ScheduleListResponse.serializer, response)!;

    return scheduleResponse.data;
  }

  Future<List<ScheduleEntity>> bulkAction(
      Credentials credentials, List<String> ids, EntityAction action) async {
    if (ids.length > kMaxEntitiesPerBulkAction && action.applyMaxLimit) {
      ids = ids.sublist(0, kMaxEntitiesPerBulkAction);
    }

    final url = credentials.url+
        '/task_schedulers/bulk?per_page=$kMaxEntitiesPerBulkAction';
    final dynamic response = await webClient.post(url, credentials.token,
        data: json.encode({'ids': ids, 'action': action.toApiParam()}));

    final ScheduleListResponse scheduleResponse =
        serializers.deserializeWith(ScheduleListResponse.serializer, response)!;

    return scheduleResponse.data.toList();
  }

  Future<ScheduleEntity> saveData(
      Credentials credentials, ScheduleEntity schedule) async {
    final data = serializers.serializeWith(ScheduleEntity.serializer, schedule);
    dynamic response;

    if (schedule.isNew) {
      response = await webClient.post(
          credentials.url+ '/task_schedulers', credentials.token,
          data: json.encode(data));
    } else {
      final url = '${credentials.url}/task_schedulers/${schedule.id}';
      response =
          await webClient.put(url, credentials.token, data: json.encode(data));
    }

    final ScheduleItemResponse scheduleResponse =
        serializers.deserializeWith(ScheduleItemResponse.serializer, response)!;

    return scheduleResponse.data;
  }
}
