// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProjectListResponse> _$projectListResponseSerializer =
    new _$ProjectListResponseSerializer();
Serializer<ProjectItemResponse> _$projectItemResponseSerializer =
    new _$ProjectItemResponseSerializer();
Serializer<ProjectEntity> _$projectEntitySerializer =
    new _$ProjectEntitySerializer();

class _$ProjectListResponseSerializer
    implements StructuredSerializer<ProjectListResponse> {
  @override
  final Iterable<Type> types = const [
    ProjectListResponse,
    _$ProjectListResponse
  ];
  @override
  final String wireName = 'ProjectListResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ProjectListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ProjectEntity)])),
    ];

    return result;
  }

  @override
  ProjectListResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProjectEntity)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectItemResponseSerializer
    implements StructuredSerializer<ProjectItemResponse> {
  @override
  final Iterable<Type> types = const [
    ProjectItemResponse,
    _$ProjectItemResponse
  ];
  @override
  final String wireName = 'ProjectItemResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ProjectItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ProjectEntity)),
    ];

    return result;
  }

  @override
  ProjectItemResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProjectEntity)) as ProjectEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectEntitySerializer implements StructuredSerializer<ProjectEntity> {
  @override
  final Iterable<Type> types = const [ProjectEntity, _$ProjectEntity];
  @override
  final String wireName = 'ProjectEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, ProjectEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'color',
      serializers.serialize(object.color,
          specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
      'task_rate',
      serializers.serialize(object.taskRate,
          specifiedType: const FullType(double)),
      'due_date',
      serializers.serialize(object.dueDate,
          specifiedType: const FullType(String)),
      'private_notes',
      serializers.serialize(object.privateNotes,
          specifiedType: const FullType(String)),
      'public_notes',
      serializers.serialize(object.publicNotes,
          specifiedType: const FullType(String)),
      'budgeted_hours',
      serializers.serialize(object.budgetedHours,
          specifiedType: const FullType(double)),
      'custom_value1',
      serializers.serialize(object.customValue1,
          specifiedType: const FullType(String)),
      'custom_value2',
      serializers.serialize(object.customValue2,
          specifiedType: const FullType(String)),
      'custom_value3',
      serializers.serialize(object.customValue3,
          specifiedType: const FullType(String)),
      'custom_value4',
      serializers.serialize(object.customValue4,
          specifiedType: const FullType(String)),
      'number',
      serializers.serialize(object.number,
          specifiedType: const FullType(String)),
      'documents',
      serializers.serialize(object.documents,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocumentEntity)])),
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
    Object value;
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
    value = object.idempotencyKey;
    if (value != null) {
      result
        ..add('idempotency_key')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ProjectEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'task_rate':
          result.taskRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'due_date':
          result.dueDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'private_notes':
          result.privateNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'public_notes':
          result.publicNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'budgeted_hours':
          result.budgetedHours = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'number':
          result.number = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'documents':
          result.documents.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentEntity)]))
              as BuiltList<Object>);
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
        case 'idempotency_key':
          result.idempotencyKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectListResponse extends ProjectListResponse {
  @override
  final BuiltList<ProjectEntity> data;

  factory _$ProjectListResponse(
          [void Function(ProjectListResponseBuilder) updates]) =>
      (new ProjectListResponseBuilder()..update(updates)).build();

  _$ProjectListResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'ProjectListResponse', 'data');
  }

  @override
  ProjectListResponse rebuild(
          void Function(ProjectListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectListResponseBuilder toBuilder() =>
      new ProjectListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectListResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectListResponse')
          ..add('data', data))
        .toString();
  }
}

class ProjectListResponseBuilder
    implements Builder<ProjectListResponse, ProjectListResponseBuilder> {
  _$ProjectListResponse _$v;

  ListBuilder<ProjectEntity> _data;
  ListBuilder<ProjectEntity> get data =>
      _$this._data ??= new ListBuilder<ProjectEntity>();
  set data(ListBuilder<ProjectEntity> data) => _$this._data = data;

  ProjectListResponseBuilder();

  ProjectListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectListResponse;
  }

  @override
  void update(void Function(ProjectListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectListResponse build() {
    _$ProjectListResponse _$result;
    try {
      _$result = _$v ?? new _$ProjectListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProjectListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProjectItemResponse extends ProjectItemResponse {
  @override
  final ProjectEntity data;

  factory _$ProjectItemResponse(
          [void Function(ProjectItemResponseBuilder) updates]) =>
      (new ProjectItemResponseBuilder()..update(updates)).build();

  _$ProjectItemResponse._({this.data}) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, 'ProjectItemResponse', 'data');
  }

  @override
  ProjectItemResponse rebuild(
          void Function(ProjectItemResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectItemResponseBuilder toBuilder() =>
      new ProjectItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectItemResponse && data == other.data;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectItemResponse')
          ..add('data', data))
        .toString();
  }
}

class ProjectItemResponseBuilder
    implements Builder<ProjectItemResponse, ProjectItemResponseBuilder> {
  _$ProjectItemResponse _$v;

  ProjectEntityBuilder _data;
  ProjectEntityBuilder get data => _$this._data ??= new ProjectEntityBuilder();
  set data(ProjectEntityBuilder data) => _$this._data = data;

  ProjectItemResponseBuilder();

  ProjectItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectItemResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectItemResponse;
  }

  @override
  void update(void Function(ProjectItemResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectItemResponse build() {
    _$ProjectItemResponse _$result;
    try {
      _$result = _$v ?? new _$ProjectItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProjectItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProjectEntity extends ProjectEntity {
  @override
  final String name;
  @override
  final String color;
  @override
  final String clientId;
  @override
  final double taskRate;
  @override
  final String dueDate;
  @override
  final String privateNotes;
  @override
  final String publicNotes;
  @override
  final double budgetedHours;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final String number;
  @override
  final BuiltList<DocumentEntity> documents;
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
  @override
  final String idempotencyKey;
  @override
  final String id;

  factory _$ProjectEntity([void Function(ProjectEntityBuilder) updates]) =>
      (new ProjectEntityBuilder()..update(updates)).build();

  _$ProjectEntity._(
      {this.name,
      this.color,
      this.clientId,
      this.taskRate,
      this.dueDate,
      this.privateNotes,
      this.publicNotes,
      this.budgetedHours,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.number,
      this.documents,
      this.isChanged,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.createdUserId,
      this.assignedUserId,
      this.idempotencyKey,
      this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'ProjectEntity', 'name');
    BuiltValueNullFieldError.checkNotNull(color, 'ProjectEntity', 'color');
    BuiltValueNullFieldError.checkNotNull(
        clientId, 'ProjectEntity', 'clientId');
    BuiltValueNullFieldError.checkNotNull(
        taskRate, 'ProjectEntity', 'taskRate');
    BuiltValueNullFieldError.checkNotNull(dueDate, 'ProjectEntity', 'dueDate');
    BuiltValueNullFieldError.checkNotNull(
        privateNotes, 'ProjectEntity', 'privateNotes');
    BuiltValueNullFieldError.checkNotNull(
        publicNotes, 'ProjectEntity', 'publicNotes');
    BuiltValueNullFieldError.checkNotNull(
        budgetedHours, 'ProjectEntity', 'budgetedHours');
    BuiltValueNullFieldError.checkNotNull(
        customValue1, 'ProjectEntity', 'customValue1');
    BuiltValueNullFieldError.checkNotNull(
        customValue2, 'ProjectEntity', 'customValue2');
    BuiltValueNullFieldError.checkNotNull(
        customValue3, 'ProjectEntity', 'customValue3');
    BuiltValueNullFieldError.checkNotNull(
        customValue4, 'ProjectEntity', 'customValue4');
    BuiltValueNullFieldError.checkNotNull(number, 'ProjectEntity', 'number');
    BuiltValueNullFieldError.checkNotNull(
        documents, 'ProjectEntity', 'documents');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'ProjectEntity', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'ProjectEntity', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        archivedAt, 'ProjectEntity', 'archivedAt');
    BuiltValueNullFieldError.checkNotNull(id, 'ProjectEntity', 'id');
  }

  @override
  ProjectEntity rebuild(void Function(ProjectEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectEntityBuilder toBuilder() => new ProjectEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectEntity &&
        name == other.name &&
        color == other.color &&
        clientId == other.clientId &&
        taskRate == other.taskRate &&
        dueDate == other.dueDate &&
        privateNotes == other.privateNotes &&
        publicNotes == other.publicNotes &&
        budgetedHours == other.budgetedHours &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        number == other.number &&
        documents == other.documents &&
        isChanged == other.isChanged &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        createdUserId == other.createdUserId &&
        assignedUserId == other.assignedUserId &&
        idempotencyKey == other.idempotencyKey &&
        id == other.id;
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
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc(0, name.hashCode), color.hashCode), clientId.hashCode), taskRate.hashCode),
                                                                                dueDate.hashCode),
                                                                            privateNotes.hashCode),
                                                                        publicNotes.hashCode),
                                                                    budgetedHours.hashCode),
                                                                customValue1.hashCode),
                                                            customValue2.hashCode),
                                                        customValue3.hashCode),
                                                    customValue4.hashCode),
                                                number.hashCode),
                                            documents.hashCode),
                                        isChanged.hashCode),
                                    createdAt.hashCode),
                                updatedAt.hashCode),
                            archivedAt.hashCode),
                        isDeleted.hashCode),
                    createdUserId.hashCode),
                assignedUserId.hashCode),
            idempotencyKey.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectEntity')
          ..add('name', name)
          ..add('color', color)
          ..add('clientId', clientId)
          ..add('taskRate', taskRate)
          ..add('dueDate', dueDate)
          ..add('privateNotes', privateNotes)
          ..add('publicNotes', publicNotes)
          ..add('budgetedHours', budgetedHours)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('number', number)
          ..add('documents', documents)
          ..add('isChanged', isChanged)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('createdUserId', createdUserId)
          ..add('assignedUserId', assignedUserId)
          ..add('idempotencyKey', idempotencyKey)
          ..add('id', id))
        .toString();
  }
}

class ProjectEntityBuilder
    implements Builder<ProjectEntity, ProjectEntityBuilder> {
  _$ProjectEntity _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _color;
  String get color => _$this._color;
  set color(String color) => _$this._color = color;

  String _clientId;
  String get clientId => _$this._clientId;
  set clientId(String clientId) => _$this._clientId = clientId;

  double _taskRate;
  double get taskRate => _$this._taskRate;
  set taskRate(double taskRate) => _$this._taskRate = taskRate;

  String _dueDate;
  String get dueDate => _$this._dueDate;
  set dueDate(String dueDate) => _$this._dueDate = dueDate;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

  String _publicNotes;
  String get publicNotes => _$this._publicNotes;
  set publicNotes(String publicNotes) => _$this._publicNotes = publicNotes;

  double _budgetedHours;
  double get budgetedHours => _$this._budgetedHours;
  set budgetedHours(double budgetedHours) =>
      _$this._budgetedHours = budgetedHours;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  String _customValue3;
  String get customValue3 => _$this._customValue3;
  set customValue3(String customValue3) => _$this._customValue3 = customValue3;

  String _customValue4;
  String get customValue4 => _$this._customValue4;
  set customValue4(String customValue4) => _$this._customValue4 = customValue4;

  String _number;
  String get number => _$this._number;
  set number(String number) => _$this._number = number;

  ListBuilder<DocumentEntity> _documents;
  ListBuilder<DocumentEntity> get documents =>
      _$this._documents ??= new ListBuilder<DocumentEntity>();
  set documents(ListBuilder<DocumentEntity> documents) =>
      _$this._documents = documents;

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

  String _idempotencyKey;
  String get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  ProjectEntityBuilder() {
    ProjectEntity._initializeBuilder(this);
  }

  ProjectEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _color = $v.color;
      _clientId = $v.clientId;
      _taskRate = $v.taskRate;
      _dueDate = $v.dueDate;
      _privateNotes = $v.privateNotes;
      _publicNotes = $v.publicNotes;
      _budgetedHours = $v.budgetedHours;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _number = $v.number;
      _documents = $v.documents.toBuilder();
      _isChanged = $v.isChanged;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _archivedAt = $v.archivedAt;
      _isDeleted = $v.isDeleted;
      _createdUserId = $v.createdUserId;
      _assignedUserId = $v.assignedUserId;
      _idempotencyKey = $v.idempotencyKey;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectEntity;
  }

  @override
  void update(void Function(ProjectEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectEntity build() {
    _$ProjectEntity _$result;
    try {
      _$result = _$v ??
          new _$ProjectEntity._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'ProjectEntity', 'name'),
              color: BuiltValueNullFieldError.checkNotNull(
                  color, 'ProjectEntity', 'color'),
              clientId: BuiltValueNullFieldError.checkNotNull(
                  clientId, 'ProjectEntity', 'clientId'),
              taskRate: BuiltValueNullFieldError.checkNotNull(
                  taskRate, 'ProjectEntity', 'taskRate'),
              dueDate: BuiltValueNullFieldError.checkNotNull(
                  dueDate, 'ProjectEntity', 'dueDate'),
              privateNotes: BuiltValueNullFieldError.checkNotNull(
                  privateNotes, 'ProjectEntity', 'privateNotes'),
              publicNotes: BuiltValueNullFieldError.checkNotNull(
                  publicNotes, 'ProjectEntity', 'publicNotes'),
              budgetedHours: BuiltValueNullFieldError.checkNotNull(
                  budgetedHours, 'ProjectEntity', 'budgetedHours'),
              customValue1: BuiltValueNullFieldError.checkNotNull(
                  customValue1, 'ProjectEntity', 'customValue1'),
              customValue2: BuiltValueNullFieldError.checkNotNull(customValue2, 'ProjectEntity', 'customValue2'),
              customValue3: BuiltValueNullFieldError.checkNotNull(customValue3, 'ProjectEntity', 'customValue3'),
              customValue4: BuiltValueNullFieldError.checkNotNull(customValue4, 'ProjectEntity', 'customValue4'),
              number: BuiltValueNullFieldError.checkNotNull(number, 'ProjectEntity', 'number'),
              documents: documents.build(),
              isChanged: isChanged,
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt, 'ProjectEntity', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt, 'ProjectEntity', 'updatedAt'),
              archivedAt: BuiltValueNullFieldError.checkNotNull(archivedAt, 'ProjectEntity', 'archivedAt'),
              isDeleted: isDeleted,
              createdUserId: createdUserId,
              assignedUserId: assignedUserId,
              idempotencyKey: idempotencyKey,
              id: BuiltValueNullFieldError.checkNotNull(id, 'ProjectEntity', 'id'));
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'documents';
        documents.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProjectEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
