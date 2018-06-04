import 'dart:async';
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

    var data = serializers.serializeWith(AppState.serializer, state).toString();

    fileStorage.saveData(data);
  }
}