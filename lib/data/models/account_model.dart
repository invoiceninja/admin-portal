import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

part 'account_model.g.dart';

abstract class AccountEntity
    implements Built<AccountEntity, AccountEntityBuilder> {
  factory AccountEntity({String id, AppState state}) {
    return _$AccountEntity._(
      id: '',
      defaultUrl: '',
      plan: '',
      latestVersion: '',
      currentVersion: '',
    );
  }

  AccountEntity._();

  String get id;

  @BuiltValueField(wireName: 'default_url')
  String get defaultUrl;

  String get plan;

  @BuiltValueField(wireName: 'latest_version')
  String get latestVersion;

  @nullable
  @BuiltValueField(wireName: 'current_version')
  String get currentVersion;

  static Serializer<AccountEntity> get serializer => _$accountEntitySerializer;
}
