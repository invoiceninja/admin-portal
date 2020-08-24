import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'system_log_model.g.dart';

abstract class SystemLogEntity implements Built<SystemLogEntity, SystemLogEntityBuilder> {
  factory SystemLogEntity() {
    return _$SystemLogEntity._(
      id: '',
      clientId: '',
      createdAt: 0,
      companyId: '',
      categoryId: 0,
      eventId: 0,
      log: '',
      typeId: 0,
      userId: '',
    );
  }

  SystemLogEntity._();

  @override
  @memoized
  int get hashCode;

  String get id;

  @BuiltValueField(wireName: 'company_id')
  String get companyId;

  @BuiltValueField(wireName: 'user_id')
  String get userId;

  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  @BuiltValueField(wireName: 'event_id')
  int get eventId;

  @BuiltValueField(wireName: 'category_id')
  int get categoryId;

  @BuiltValueField(wireName: 'type_id')
  int get typeId;

  String get log;

  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  static Serializer<SystemLogEntity> get serializer => _$systemLogEntitySerializer;
}
