import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja/redux/static/static_state.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/redux/company/company_state.dart';
import 'package:invoiceninja/redux/ui/ui_state.dart';
import 'package:meta/meta.dart';
import 'package:invoiceninja/data/models/serializers.dart';
import 'package:invoiceninja/data/file_storage.dart';

class PersistenceRepository {
  final FileStorage fileStorage;

  const PersistenceRepository({
    @required this.fileStorage,
  });


  Future<File> saveCompanyState(CompanyState state) async {
    var data = serializers.serializeWith(CompanyState.serializer, state);
    return await fileStorage.save(json.encode(data));
  }

  Future<CompanyState> loadCompanyState() async {
    String data = await fileStorage.load();
    return serializers.deserializeWith(CompanyState.serializer, json.decode(data));
    //return compute(_deserialize, data);
  }


  Future<File> saveAuthState(AuthState state) async {
    var data = serializers.serializeWith(AuthState.serializer, state);
    return await fileStorage.save(json.encode(data));
  }

  Future<AuthState> loadAuthState() async {
    String data = await fileStorage.load();
    return serializers.deserializeWith(AuthState.serializer, json.decode(data));
  }


  Future<File> saveStaticState(StaticState state) async {
    var data = serializers.serializeWith(StaticState.serializer, state);
    return await fileStorage.save(json.encode(data));
  }

  Future<StaticState> loadStaticState() async {
    String data = await fileStorage.load();
    return serializers.deserializeWith(StaticState.serializer, json.decode(data));
  }


  Future<File> saveUIState(UIState state) async {
    var data = serializers.serializeWith(UIState.serializer, state);
    return await fileStorage.save(json.encode(data));
  }

  Future<UIState> loadUIState() async {
    final String data = await fileStorage.load();
    return serializers.deserializeWith(UIState.serializer, json.decode(data));
  }


  Future<FileSystemEntity> delete() async {
    return await fileStorage.exists().then((exists) => exists ? fileStorage.delete() : null);
  }

  Future<bool> exists() async {
    return await fileStorage.exists();
  }
}

/*
AppState _deserialize(String data) {
  return serializers.deserializeWith(AppState.serializer, json.decode(data));
}
*/