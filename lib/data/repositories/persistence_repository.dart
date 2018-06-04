import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:invoiceninja/data/file_storage.dart';

class PersistenceRepository {
  final FileStorage fileStorage;

  const PersistenceRepository({
    @required this.fileStorage,
  });

  Future<File> saveData(AppState state) async {
    var data = serializers.serializeWith(AppState.serializer, state);

    return await fileStorage.saveData(json.encode(data));
  }

  Future<AppState> loadData() async {
    var data = await fileStorage.loadData();

    return serializers.deserializeWith(AppState.serializer, json.decode(data));
  }
}