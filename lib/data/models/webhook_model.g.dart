// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WebhookListResponse> _$webhookListResponseSerializer =
    new _$WebhookListResponseSerializer();
Serializer<WebhookItemResponse> _$webhookItemResponseSerializer =
    new _$WebhookItemResponseSerializer();
Serializer<WebhookEntity> _$webhookEntitySerializer =
    new _$WebhookEntitySerializer();

class _$WebhookListResponseSerializer
    implements StructuredSerializer<WebhookListResponse> {
  @override
  final Iterable<Type> types = const [
    WebhookListResponse,
    _$WebhookListResponse
  ];
  @override
  final String wireName = 'WebhookListResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WebhookListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(WebhookEntity)])),
    ];

    return result;
  }

  @override
  WebhookListResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebhookListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(WebhookEntity)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$WebhookItemResponseSerializer
    implements StructuredSerializer<WebhookItemResponse> {
  @override
  final Iterable<Type> types = const [
    WebhookItemResponse,
    _$WebhookItemResponse
  ];
  @override
  final String wireName = 'WebhookItemResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WebhookItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(WebhookEntity)),
    ];

    return result;
  }

  @override
  WebhookItemResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebhookItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(WebhookEntity))! as WebhookEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$WebhookEntitySerializer implements StructuredSerializer<WebhookEntity> {
  @override
  final Iterable<Type> types = const [WebhookEntity, _$WebhookEntity];
  @override
  final String wireName = 'WebhookEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, WebhookEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'event_id',
      serializers.serialize(object.eventId,
          specifiedType: const FullType(String)),
      'target_url',
      serializers.serialize(object.targetUrl,
          specifiedType: const FullType(String)),
      'format',
      serializers.serialize(object.format,
          specifiedType: const FullType(String)),
      'rest_method',
      serializers.serialize(object.restMethod,
          specifiedType: const FullType(String)),
      'headers',
      serializers.serialize(object.headers,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'archived_at',
      serializers.serialize(object.archivedAt,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.isChanged;
    if (value != null) {
      result
        ..add('isChanged')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isDeleted;
    if (value != null) {
      result
        ..add('is_deleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdUserId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.assignedUserId;
    if (value != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  WebhookEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebhookEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'event_id':
          result.eventId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'target_url':
          result.targetUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'format':
          result.format = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'rest_method':
          result.restMethod = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'headers':
          result.headers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WebhookListResponse extends WebhookListResponse {
  @override
  final BuiltList<WebhookEntity> data;

  factory _$WebhookListResponse(
          [void Function(WebhookListResponseBuilder)? updates]) =>
      (new WebhookListResponseBuilder()..update(updates))._build();

  _$WebhookListResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'WebhookListResponse', 'data');
  }

  @override
  WebhookListResponse rebuild(
          void Function(WebhookListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebhookListResponseBuilder toBuilder() =>
      new WebhookListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebhookListResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WebhookListResponse')
          ..add('data', data))
        .toString();
  }
}

class WebhookListResponseBuilder
    implements Builder<WebhookListResponse, WebhookListResponseBuilder> {
  _$WebhookListResponse? _$v;

  ListBuilder<WebhookEntity>? _data;
  ListBuilder<WebhookEntity> get data =>
      _$this._data ??= new ListBuilder<WebhookEntity>();
  set data(ListBuilder<WebhookEntity>? data) => _$this._data = data;

  WebhookListResponseBuilder();

  WebhookListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WebhookListResponse;
  }

  @override
  void update(void Function(WebhookListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WebhookListResponse build() => _build();

  _$WebhookListResponse _build() {
    _$WebhookListResponse _$result;
    try {
      _$result = _$v ?? new _$WebhookListResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WebhookListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$WebhookItemResponse extends WebhookItemResponse {
  @override
  final WebhookEntity data;

  factory _$WebhookItemResponse(
          [void Function(WebhookItemResponseBuilder)? updates]) =>
      (new WebhookItemResponseBuilder()..update(updates))._build();

  _$WebhookItemResponse._({required this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'WebhookItemResponse', 'data');
  }

  @override
  WebhookItemResponse rebuild(
          void Function(WebhookItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebhookItemResponseBuilder toBuilder() =>
      new WebhookItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebhookItemResponse && data == other.data;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WebhookItemResponse')
          ..add('data', data))
        .toString();
  }
}

class WebhookItemResponseBuilder
    implements Builder<WebhookItemResponse, WebhookItemResponseBuilder> {
  _$WebhookItemResponse? _$v;

  WebhookEntityBuilder? _data;
  WebhookEntityBuilder get data => _$this._data ??= new WebhookEntityBuilder();
  set data(WebhookEntityBuilder? data) => _$this._data = data;

  WebhookItemResponseBuilder();

  WebhookItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WebhookItemResponse;
  }

  @override
  void update(void Function(WebhookItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WebhookItemResponse build() => _build();

  _$WebhookItemResponse _build() {
    _$WebhookItemResponse _$result;
    try {
      _$result = _$v ?? new _$WebhookItemResponse._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WebhookItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$WebhookEntity extends WebhookEntity {
  @override
  final String eventId;
  @override
  final String targetUrl;
  @override
  final String format;
  @override
  final String restMethod;
  @override
  final BuiltMap<String, String> headers;
  @override
  final bool? isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool? isDeleted;
  @override
  final String? createdUserId;
  @override
  final String? assignedUserId;
  @override
  final String id;

  factory _$WebhookEntity([void Function(WebhookEntityBuilder)? updates]) =>
      (new WebhookEntityBuilder()..update(updates))._build();

  _$WebhookEntity._(
      {required this.eventId,
      required this.targetUrl,
      required this.format,
      required this.restMethod,
      required this.headers,
      this.isChanged,
      required this.createdAt,
      required this.updatedAt,
      required this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(eventId, r'WebhookEntity', 'eventId');
    BuiltValueNullFieldError.checkNotNull(
        targetUrl, r'WebhookEntity', 'targetUrl');
    BuiltValueNullFieldError.checkNotNull(format, r'WebhookEntity', 'format');
    BuiltValueNullFieldError.checkNotNull(
        restMethod, r'WebhookEntity', 'restMethod');
    BuiltValueNullFieldError.checkNotNull(headers, r'WebhookEntity', 'headers');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'WebhookEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'WebhookEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, r'WebhookEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, r'WebhookEntity', 'id');
  }

  @override
  WebhookEntity rebuild(void Function(WebhookEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebhookEntityBuilder toBuilder() => new WebhookEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebhookEntity &&
        eventId == other.eventId &&
        targetUrl == other.targetUrl &&
        format == other.format &&
        restMethod == other.restMethod &&
        headers == other.headers &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        id == other.id;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, targetUrl.hashCode);
    _$hash = $jc(_$hash, format.hashCode);
    _$hash = $jc(_$hash, restMethod.hashCode);
    _$hash = $jc(_$hash, headers.hashCode);
    _$hash = $jc(_$hash, isChanged.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdUserId.hashCode);
    _$hash = $jc(_$hash, assignedUserId.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WebhookEntity')
          ..add('eventId', eventId)
          ..add('targetUrl', targetUrl)
          ..add('format', format)
          ..add('restMethod', restMethod)
          ..add('headers', headers)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('id', id))
        .toString();
  }
}

class WebhookEntityBuilder
    implements Builder<WebhookEntity, WebhookEntityBuilder> {
  _$WebhookEntity? _$v;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(String? eventId) => _$this._eventId = eventId;

  String? _targetUrl;
  String? get targetUrl => _$this._targetUrl;
  set targetUrl(String? targetUrl) => _$this._targetUrl = targetUrl;

  String? _format;
  String? get format => _$this._format;
  set format(String? format) => _$this._format = format;

  String? _restMethod;
  String? get restMethod => _$this._restMethod;
  set restMethod(String? restMethod) => _$this._restMethod = restMethod;

  MapBuilder<String, String>? _headers;
  MapBuilder<String, String> get headers =>
      _$this._headers ??= new MapBuilder<String, String>();
  set headers(MapBuilder<String, String>? headers) => _$this._headers = headers;

  bool? _isChanged;
  bool? get isChanged => _$this._isChanged;
  set isChanged(bool? isChanged) => _$this._isChanged = isChanged;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  int? _updatedAt;
  int? get updatedAt => _$this._updatedAt;
  set updatedAt(int? updatedAt) => _$this._updatedAt = updatedAt;

  int? _archivedAt;
  int? get archivedAt => _$this._archivedAt;
  set archivedAt(int? archivedAt) => _$this._archivedAt = archivedAt;

  bool? _isDeleted;
  bool? get isDeleted => _$this._isDeleted;
  set isDeleted(bool? isDeleted) => _$this._isDeleted = isDeleted;

  String? _createdUserId;
  String? get createdUserId => _$this._createdUserId;
  set createdUserId(String? createdUserId) =>
      _$this._createdUserId = createdUserId;

  String? _assignedUserId;
  String? get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String? assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  WebhookEntityBuilder() {
    WebhookEntity._initializeBuilder(this);
  }

  WebhookEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _eventId = $v.eventId;
      _targetUrl = $v.targetUrl;
      _format = $v.format;
      _restMethod = $v.restMethod;
      _headers = $v.headers.toBuilder();
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WebhookEntity;
  }

  @override
  void update(void Function(WebhookEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WebhookEntity build() => _build();

  _$WebhookEntity _build() {
    _$WebhookEntity _$result;
    try {
      _$result = _$v ??
          new _$WebhookEntity._(
              eventId: BuiltValueNullFieldError.checkNotNull(
                  eventId, r'WebhookEntity', 'eventId'),
              targetUrl: BuiltValueNullFieldError.checkNotNull(
                  targetUrl, r'WebhookEntity', 'targetUrl'),
              format: BuiltValueNullFieldError.checkNotNull(
                  format, r'WebhookEntity', 'format'),
              restMethod: BuiltValueNullFieldError.checkNotNull(
                  restMethod, r'WebhookEntity', 'restMethod'),
              headers: headers.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, r'WebhookEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(
                  updatedAt, r'WebhookEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(
                  archivedAt, r'WebhookEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'WebhookEntity', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'headers';
        headers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WebhookEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
