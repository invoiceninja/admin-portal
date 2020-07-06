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
  Iterable<Object> serialize(
      Serializers serializers, WebhookListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(WebhookEntity)])),
    ];

    return result;
  }

  @override
  WebhookListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebhookListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(WebhookEntity)]))
              as BuiltList<Object>);
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
  Iterable<Object> serialize(
      Serializers serializers, WebhookItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(WebhookEntity)),
    ];

    return result;
  }

  @override
  WebhookItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebhookItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(WebhookEntity)) as WebhookEntity);
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
  Iterable<Object> serialize(Serializers serializers, WebhookEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'webhook',
      serializers.serialize(object.webhook,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'archived_at',
      serializers.serialize(object.archivedAt,
          specifiedType: const FullType(int)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.isChanged != null) {
      result
        ..add('isChanged')
        ..add(serializers.serialize(object.isChanged,
            specifiedType: const FullType(bool)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.createdUserId != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(object.createdUserId,
            specifiedType: const FullType(String)));
    }
    if (object.assignedUserId != null) {
      result
        ..add('assigned_user_id')
        ..add(serializers.serialize(object.assignedUserId,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  WebhookEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebhookEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'webhook':
          result.webhook = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'archived_at':
          result.archivedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'is_deleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'user_id':
          result.createdUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'assigned_user_id':
          result.assignedUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
          [void Function(WebhookListResponseBuilder) updates]) =>
      (new WebhookListResponseBuilder()..update(updates)).build();

  _$WebhookListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('WebhookListResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WebhookListResponse')
          ..add('data', data))
        .toString();
  }
}

class WebhookListResponseBuilder
    implements Builder<WebhookListResponse, WebhookListResponseBuilder> {
  _$WebhookListResponse _$v;

  ListBuilder<WebhookEntity> _data;
  ListBuilder<WebhookEntity> get data =>
      _$this._data ??= new ListBuilder<WebhookEntity>();
  set data(ListBuilder<WebhookEntity> data) => _$this._data = data;

  WebhookListResponseBuilder();

  WebhookListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WebhookListResponse;
  }

  @override
  void update(void Function(WebhookListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WebhookListResponse build() {
    _$WebhookListResponse _$result;
    try {
      _$result = _$v ?? new _$WebhookListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WebhookListResponse', _$failedField, e.toString());
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
          [void Function(WebhookItemResponseBuilder) updates]) =>
      (new WebhookItemResponseBuilder()..update(updates)).build();

  _$WebhookItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('WebhookItemResponse', 'data');
    }
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

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WebhookItemResponse')
          ..add('data', data))
        .toString();
  }
}

class WebhookItemResponseBuilder
    implements Builder<WebhookItemResponse, WebhookItemResponseBuilder> {
  _$WebhookItemResponse _$v;

  WebhookEntityBuilder _data;
  WebhookEntityBuilder get data => _$this._data ??= new WebhookEntityBuilder();
  set data(WebhookEntityBuilder data) => _$this._data = data;

  WebhookItemResponseBuilder();

  WebhookItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WebhookItemResponse;
  }

  @override
  void update(void Function(WebhookItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WebhookItemResponse build() {
    _$WebhookItemResponse _$result;
    try {
      _$result = _$v ?? new _$WebhookItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WebhookItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$WebhookEntity extends WebhookEntity {
  @override
  final String id;
  @override
  final String webhook;
  @override
  final String name;
  @override
  final String url;
  @override
  final bool isChanged;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final String createdUserId;
  @override
  final String assignedUserId;

  factory _$WebhookEntity([void Function(WebhookEntityBuilder) updates]) =>
      (new WebhookEntityBuilder()..update(updates)).build();

  _$WebhookEntity._(
      {this.id,
      this.webhook,
      this.name,
      this.url,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId})
      : super._() {
    if (webhook == null) {
      throw new BuiltValueNullFieldError('WebhookEntity', 'webhook');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('WebhookEntity', 'name');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('WebhookEntity', 'url');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('WebhookEntity', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('WebhookEntity', 'updatedAt');
    }
    if (archivedAt == null) {
      throw new BuiltValueNullFieldError('WebhookEntity', 'archivedAt');
    }
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
        id == other.id &&
        webhook == other.webhook &&
        name == other.name &&
        url == other.url &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, id.hashCode),
                                            webhook.hashCode),
                                        name.hashCode),
                                    url.hashCode),
                                isChanged.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            createdUserId.hashCode),
        assignedUserId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WebhookEntity')
          ..add('id', id)
          ..add('webhook', webhook)
          ..add('name', name)
          ..add('url', url)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId))
        .toString();
  }
}

class WebhookEntityBuilder
    implements Builder<WebhookEntity, WebhookEntityBuilder> {
  _$WebhookEntity _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _webhook;
  String get webhook => _$this._webhook;
  set webhook(String webhook) => _$this._webhook = webhook;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  bool _isChanged;
  bool get isChanged => _$this._isChanged;
  set isChanged(bool isChanged) => _$this._isChanged = isChanged;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  int _archivedAt;
  int get archivedAt => _$this._archivedAt;
  set archivedAt(int archivedAt) => _$this._archivedAt = archivedAt;

  bool _isDeleted;
  bool get isDeleted => _$this._isDeleted;
  set isDeleted(bool isDeleted) => _$this._isDeleted = isDeleted;

  String _createdUserId;
  String get createdUserId => _$this._createdUserId;
  set createdUserId(String createdUserId) =>
      _$this._createdUserId = createdUserId;

  String _assignedUserId;
  String get assignedUserId => _$this._assignedUserId;
  set assignedUserId(String assignedUserId) =>
      _$this._assignedUserId = assignedUserId;

  WebhookEntityBuilder();

  WebhookEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _webhook = _$v.webhook;
      _name = _$v.name;
      _url = _$v.url;
      _isChanged = _$v.isChanged;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _createdUserId = _$v.createdUserId;
      _assignedUserId = _$v.assignedUserId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WebhookEntity;
  }

  @override
  void update(void Function(WebhookEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WebhookEntity build() {
    final _$result = _$v ??
        new _$WebhookEntity._(
            id: id,
            webhook: webhook,
            name: name,
            url: url,
            isChanged: isChanged,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            createdUserId: createdUserId,
            assignedUserId: assignedUserId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
