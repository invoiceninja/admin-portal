import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:meta/meta.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/file_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceRepository {
  const PersistenceRepository({
    @required this.fileStorage,
  });

  final FileStorage fileStorage;

  Future<File> saveCompanyState(CompanyState state) async {
    final stateWithoutToken = state.rebuild(
        (b) => b..company.replace(state.company.rebuild((b) => b..token = '')));
    final data =
        serializers.serializeWith(CompanyState.serializer, stateWithoutToken);
    return await fileStorage.save(json.encode(data));
  }

  Future<CompanyState> loadCompanyState(int index) async {
    final String data = await fileStorage.load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(getKeychainTokenKey(index - 1)) ?? '';
    final companyState =
        serializers.deserializeWith(CompanyState.serializer, json.decode(data));
    return companyState.rebuild((b) => b
      ..company.replace(companyState.company.rebuild((b) => b..token = token)));
    //return compute(_deserialize, data);
  }

  Future<File> saveAuthState(AuthState state) async {
    final data = serializers.serializeWith(AuthState.serializer, state);
    return await fileStorage.save(json.encode(data));
  }

  Future<AuthState> loadAuthState() async {
    final String data = await fileStorage.load();
    return serializers.deserializeWith(AuthState.serializer, json.decode(data));
  }

  Future<File> saveStaticState(StaticState state) async {
    final data = serializers.serializeWith(StaticState.serializer, state);
    return await fileStorage.save(json.encode(data));
  }

  Future<StaticState> loadStaticState() async {
    final String data = await fileStorage.load();
    return serializers.deserializeWith(
        StaticState.serializer, json.decode(data));
  }

  Future<File> saveUIState(UIState state) async {
    final data = serializers.serializeWith(UIState.serializer, state);
    return await fileStorage.save(json.encode(data));
  }

  Future<UIState> loadUIState() async {
    final String data = await fileStorage.load();
    return serializers.deserializeWith(UIState.serializer, json.decode(data));
  }

  Future<FileSystemEntity> delete() async {
    return await fileStorage
        .exists()
        .then((exists) => exists ? fileStorage.delete() : null);
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
