// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_log_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SystemLogEntity> _$systemLogEntitySerializer =
    new _$SystemLogEntitySerializer();
Serializer<EmailHistoryEntity> _$emailHistoryEntitySerializer =
    new _$EmailHistoryEntitySerializer();
Serializer<EmailHistoryEventEntity> _$emailHistoryEventEntitySerializer =
    new _$EmailHistoryEventEntitySerializer();

class _$SystemLogEntitySerializer
    implements StructuredSerializer<SystemLogEntity> {
  @override
  final Iterable<Type> types = const [SystemLogEntity, _$SystemLogEntity];
  @override
  final String wireName = 'SystemLogEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, SystemLogEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'company_id',
      serializers.serialize(object.companyId,
          specifiedType: const FullType(String)),
      'user_id',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
      'event_id',
      serializers.serialize(object.eventId, specifiedType: const FullType(int)),
      'category_id',
      serializers.serialize(object.categoryId,
          specifiedType: const FullType(int)),
      'type_id',
      serializers.serialize(object.typeId, specifiedType: const FullType(int)),
      'log',
      serializers.serialize(object.log, specifiedType: const FullType(String)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  SystemLogEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SystemLogEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'company_id':
          result.companyId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'event_id':
          result.eventId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'category_id':
          result.categoryId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'type_id':
          result.typeId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'log':
          result.log = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$EmailHistoryEntitySerializer
    implements StructuredSerializer<EmailHistoryEntity> {
  @override
  final Iterable<Type> types = const [EmailHistoryEntity, _$EmailHistoryEntity];
  @override
  final String wireName = 'EmailHistoryEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, EmailHistoryEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'recipients',
      serializers.serialize(object.recipients,
          specifiedType: const FullType(String)),
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(String)),
      'entity',
      serializers.serialize(object.entity,
          specifiedType: const FullType(String)),
      'entity_id',
      serializers.serialize(object.entityId,
          specifiedType: const FullType(String)),
      'events',
      serializers.serialize(object.events,
          specifiedType: const FullType(
              BuiltList, const [const FullType(EmailHistoryEventEntity)])),
    ];

    return result;
  }

  @override
  EmailHistoryEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EmailHistoryEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'recipients':
          result.recipients = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'subject':
          result.subject = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'entity':
          result.entity = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'entity_id':
          result.entityId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'events':
          result.events.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(EmailHistoryEventEntity)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$EmailHistoryEventEntitySerializer
    implements StructuredSerializer<EmailHistoryEventEntity> {
  @override
  final Iterable<Type> types = const [
    EmailHistoryEventEntity,
    _$EmailHistoryEventEntity
  ];
  @override
  final String wireName = 'EmailHistoryEventEntity';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, EmailHistoryEventEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'recipient',
      serializers.serialize(object.recipient,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
      'delivery_message',
      serializers.serialize(object.deliveryMessage,
          specifiedType: const FullType(String)),
      'server',
      serializers.serialize(object.server,
          specifiedType: const FullType(String)),
      'server_ip',
      serializers.serialize(object.serverIp,
          specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  EmailHistoryEventEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EmailHistoryEventEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'recipient':
          result.recipient = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'delivery_message':
          result.deliveryMessage = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'server':
          result.server = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'server_ip':
          result.serverIp = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SystemLogEntity extends SystemLogEntity {
  @override
  final String id;
  @override
  final String companyId;
  @override
  final String userId;
  @override
  final String clientId;
  @override
  final int eventId;
  @override
  final int categoryId;
  @override
  final int typeId;
  @override
  final String log;
  @override
  final int createdAt;

  factory _$SystemLogEntity([void Function(SystemLogEntityBuilder)? updates]) =>
      (new SystemLogEntityBuilder()..update(updates))._build();

  _$SystemLogEntity._(
      {required this.id,
      required this.companyId,
      required this.userId,
      required this.clientId,
      required this.eventId,
      required this.categoryId,
      required this.typeId,
      required this.log,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'SystemLogEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(
        companyId, r'SystemLogEntity', 'companyId');
    BuiltValueNullFieldError.checkNotNull(userId, r'SystemLogEntity', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        clientId, r'SystemLogEntity', 'clientId');
    BuiltValueNullFieldError.checkNotNull(
        eventId, r'SystemLogEntity', 'eventId');
    BuiltValueNullFieldError.checkNotNull(
        categoryId, r'SystemLogEntity', 'categoryId');
    BuiltValueNullFieldError.checkNotNull(typeId, r'SystemLogEntity', 'typeId');
    BuiltValueNullFieldError.checkNotNull(log, r'SystemLogEntity', 'log');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'SystemLogEntity', 'createdAt');
  }

  @override
  SystemLogEntity rebuild(void Function(SystemLogEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemLogEntityBuilder toBuilder() =>
      new SystemLogEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemLogEntity &&
        id == other.id &&
        companyId == other.companyId &&
        userId == other.userId &&
        clientId == other.clientId &&
        eventId == other.eventId &&
        categoryId == other.categoryId &&
        typeId == other.typeId &&
        log == other.log &&
        createdAt == other.createdAt;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, companyId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, typeId.hashCode);
    _$hash = $jc(_$hash, log.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SystemLogEntity')
          ..add('id', id)
          ..add('companyId', companyId)
          ..add('userId', userId)
          ..add('clientId', clientId)
          ..add('eventId', eventId)
          ..add('categoryId', categoryId)
          ..add('typeId', typeId)
          ..add('log', log)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class SystemLogEntityBuilder
    implements Builder<SystemLogEntity, SystemLogEntityBuilder> {
  _$SystemLogEntity? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _companyId;
  String? get companyId => _$this._companyId;
  set companyId(String? companyId) => _$this._companyId = companyId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  int? _eventId;
  int? get eventId => _$this._eventId;
  set eventId(int? eventId) => _$this._eventId = eventId;

  int? _categoryId;
  int? get categoryId => _$this._categoryId;
  set categoryId(int? categoryId) => _$this._categoryId = categoryId;

  int? _typeId;
  int? get typeId => _$this._typeId;
  set typeId(int? typeId) => _$this._typeId = typeId;

  String? _log;
  String? get log => _$this._log;
  set log(String? log) => _$this._log = log;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  SystemLogEntityBuilder();

  SystemLogEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _companyId = $v.companyId;
      _userId = $v.userId;
      _clientId = $v.clientId;
      _eventId = $v.eventId;
      _categoryId = $v.categoryId;
      _typeId = $v.typeId;
      _log = $v.log;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SystemLogEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SystemLogEntity;
  }

  @override
  void update(void Function(SystemLogEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SystemLogEntity build() => _build();

  _$SystemLogEntity _build() {
    final _$result = _$v ??
        new _$SystemLogEntity._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'SystemLogEntity', 'id'),
            companyId: BuiltValueNullFieldError.checkNotNull(
                companyId, r'SystemLogEntity', 'companyId'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'SystemLogEntity', 'userId'),
            clientId: BuiltValueNullFieldError.checkNotNull(
                clientId, r'SystemLogEntity', 'clientId'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'SystemLogEntity', 'eventId'),
            categoryId: BuiltValueNullFieldError.checkNotNull(
                categoryId, r'SystemLogEntity', 'categoryId'),
            typeId: BuiltValueNullFieldError.checkNotNull(
                typeId, r'SystemLogEntity', 'typeId'),
            log: BuiltValueNullFieldError.checkNotNull(
                log, r'SystemLogEntity', 'log'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'SystemLogEntity', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

class _$EmailHistoryEntity extends EmailHistoryEntity {
  @override
  final String recipients;
  @override
  final String subject;
  @override
  final String entity;
  @override
  final String entityId;
  @override
  final BuiltList<EmailHistoryEventEntity> events;

  factory _$EmailHistoryEntity(
          [void Function(EmailHistoryEntityBuilder)? updates]) =>
      (new EmailHistoryEntityBuilder()..update(updates))._build();

  _$EmailHistoryEntity._(
      {required this.recipients,
      required this.subject,
      required this.entity,
      required this.entityId,
      required this.events})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        recipients, r'EmailHistoryEntity', 'recipients');
    BuiltValueNullFieldError.checkNotNull(
        subject, r'EmailHistoryEntity', 'subject');
    BuiltValueNullFieldError.checkNotNull(
        entity, r'EmailHistoryEntity', 'entity');
    BuiltValueNullFieldError.checkNotNull(
        entityId, r'EmailHistoryEntity', 'entityId');
    BuiltValueNullFieldError.checkNotNull(
        events, r'EmailHistoryEntity', 'events');
  }

  @override
  EmailHistoryEntity rebuild(
          void Function(EmailHistoryEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmailHistoryEntityBuilder toBuilder() =>
      new EmailHistoryEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmailHistoryEntity &&
        recipients == other.recipients &&
        subject == other.subject &&
        entity == other.entity &&
        entityId == other.entityId &&
        events == other.events;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, recipients.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, entity.hashCode);
    _$hash = $jc(_$hash, entityId.hashCode);
    _$hash = $jc(_$hash, events.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EmailHistoryEntity')
          ..add('recipients', recipients)
          ..add('subject', subject)
          ..add('entity', entity)
          ..add('entityId', entityId)
          ..add('events', events))
        .toString();
  }
}

class EmailHistoryEntityBuilder
    implements Builder<EmailHistoryEntity, EmailHistoryEntityBuilder> {
  _$EmailHistoryEntity? _$v;

  String? _recipients;
  String? get recipients => _$this._recipients;
  set recipients(String? recipients) => _$this._recipients = recipients;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _entity;
  String? get entity => _$this._entity;
  set entity(String? entity) => _$this._entity = entity;

  String? _entityId;
  String? get entityId => _$this._entityId;
  set entityId(String? entityId) => _$this._entityId = entityId;

  ListBuilder<EmailHistoryEventEntity>? _events;
  ListBuilder<EmailHistoryEventEntity> get events =>
      _$this._events ??= new ListBuilder<EmailHistoryEventEntity>();
  set events(ListBuilder<EmailHistoryEventEntity>? events) =>
      _$this._events = events;

  EmailHistoryEntityBuilder() {
    EmailHistoryEntity._initializeBuilder(this);
  }

  EmailHistoryEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recipients = $v.recipients;
      _subject = $v.subject;
      _entity = $v.entity;
      _entityId = $v.entityId;
      _events = $v.events.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmailHistoryEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EmailHistoryEntity;
  }

  @override
  void update(void Function(EmailHistoryEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmailHistoryEntity build() => _build();

  _$EmailHistoryEntity _build() {
    _$EmailHistoryEntity _$result;
    try {
      _$result = _$v ??
          new _$EmailHistoryEntity._(
              recipients: BuiltValueNullFieldError.checkNotNull(
                  recipients, r'EmailHistoryEntity', 'recipients'),
              subject: BuiltValueNullFieldError.checkNotNull(
                  subject, r'EmailHistoryEntity', 'subject'),
              entity: BuiltValueNullFieldError.checkNotNull(
                  entity, r'EmailHistoryEntity', 'entity'),
              entityId: BuiltValueNullFieldError.checkNotNull(
                  entityId, r'EmailHistoryEntity', 'entityId'),
              events: events.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'events';
        events.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'EmailHistoryEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EmailHistoryEventEntity extends EmailHistoryEventEntity {
  @override
  final String recipient;
  @override
  final String status;
  @override
  final String deliveryMessage;
  @override
  final String server;
  @override
  final String serverIp;
  @override
  final String date;

  factory _$EmailHistoryEventEntity(
          [void Function(EmailHistoryEventEntityBuilder)? updates]) =>
      (new EmailHistoryEventEntityBuilder()..update(updates))._build();

  _$EmailHistoryEventEntity._(
      {required this.recipient,
      required this.status,
      required this.deliveryMessage,
      required this.server,
      required this.serverIp,
      required this.date})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        recipient, r'EmailHistoryEventEntity', 'recipient');
    BuiltValueNullFieldError.checkNotNull(
        status, r'EmailHistoryEventEntity', 'status');
    BuiltValueNullFieldError.checkNotNull(
        deliveryMessage, r'EmailHistoryEventEntity', 'deliveryMessage');
    BuiltValueNullFieldError.checkNotNull(
        server, r'EmailHistoryEventEntity', 'server');
    BuiltValueNullFieldError.checkNotNull(
        serverIp, r'EmailHistoryEventEntity', 'serverIp');
    BuiltValueNullFieldError.checkNotNull(
        date, r'EmailHistoryEventEntity', 'date');
  }

  @override
  EmailHistoryEventEntity rebuild(
          void Function(EmailHistoryEventEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmailHistoryEventEntityBuilder toBuilder() =>
      new EmailHistoryEventEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmailHistoryEventEntity &&
        recipient == other.recipient &&
        status == other.status &&
        deliveryMessage == other.deliveryMessage &&
        server == other.server &&
        serverIp == other.serverIp &&
        date == other.date;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, recipient.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, deliveryMessage.hashCode);
    _$hash = $jc(_$hash, server.hashCode);
    _$hash = $jc(_$hash, serverIp.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EmailHistoryEventEntity')
          ..add('recipient', recipient)
          ..add('status', status)
          ..add('deliveryMessage', deliveryMessage)
          ..add('server', server)
          ..add('serverIp', serverIp)
          ..add('date', date))
        .toString();
  }
}

class EmailHistoryEventEntityBuilder
    implements
        Builder<EmailHistoryEventEntity, EmailHistoryEventEntityBuilder> {
  _$EmailHistoryEventEntity? _$v;

  String? _recipient;
  String? get recipient => _$this._recipient;
  set recipient(String? recipient) => _$this._recipient = recipient;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _deliveryMessage;
  String? get deliveryMessage => _$this._deliveryMessage;
  set deliveryMessage(String? deliveryMessage) =>
      _$this._deliveryMessage = deliveryMessage;

  String? _server;
  String? get server => _$this._server;
  set server(String? server) => _$this._server = server;

  String? _serverIp;
  String? get serverIp => _$this._serverIp;
  set serverIp(String? serverIp) => _$this._serverIp = serverIp;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  EmailHistoryEventEntityBuilder() {
    EmailHistoryEventEntity._initializeBuilder(this);
  }

  EmailHistoryEventEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recipient = $v.recipient;
      _status = $v.status;
      _deliveryMessage = $v.deliveryMessage;
      _server = $v.server;
      _serverIp = $v.serverIp;
      _date = $v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmailHistoryEventEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EmailHistoryEventEntity;
  }

  @override
  void update(void Function(EmailHistoryEventEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmailHistoryEventEntity build() => _build();

  _$EmailHistoryEventEntity _build() {
    final _$result = _$v ??
        new _$EmailHistoryEventEntity._(
            recipient: BuiltValueNullFieldError.checkNotNull(
                recipient, r'EmailHistoryEventEntity', 'recipient'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'EmailHistoryEventEntity', 'status'),
            deliveryMessage: BuiltValueNullFieldError.checkNotNull(
                deliveryMessage, r'EmailHistoryEventEntity', 'deliveryMessage'),
            server: BuiltValueNullFieldError.checkNotNull(
                server, r'EmailHistoryEventEntity', 'server'),
            serverIp: BuiltValueNullFieldError.checkNotNull(
                serverIp, r'EmailHistoryEventEntity', 'serverIp'),
            date: BuiltValueNullFieldError.checkNotNull(
                date, r'EmailHistoryEventEntity', 'date'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
