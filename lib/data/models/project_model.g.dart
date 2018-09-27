// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

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
  Iterable serialize(Serializers serializers, ProjectListResponse object,
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
  ProjectListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProjectEntity)]))
              as BuiltList);
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
  Iterable serialize(Serializers serializers, ProjectItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ProjectEntity)),
    ];

    return result;
  }

  @override
  ProjectItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
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
  Iterable serialize(Serializers serializers, ProjectEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(int)),
      'task_rate',
      serializers.serialize(object.taskRate,
          specifiedType: const FullType(double)),
      'due_date',
      serializers.serialize(object.dueDate,
          specifiedType: const FullType(String)),
      'private_notes',
      serializers.serialize(object.privateNotes,
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
    ];
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(int)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }
    if (object.archivedAt != null) {
      result
        ..add('archived_at')
        ..add(serializers.serialize(object.archivedAt,
            specifiedType: const FullType(int)));
    }
    if (object.isDeleted != null) {
      result
        ..add('is_deleted')
        ..add(serializers.serialize(object.isDeleted,
            specifiedType: const FullType(bool)));
    }
    if (object.isOwner != null) {
      result
        ..add('is_owner')
        ..add(serializers.serialize(object.isOwner,
            specifiedType: const FullType(bool)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  ProjectEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
        case 'is_owner':
          result.isOwner = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectListResponse extends ProjectListResponse {
  @override
  final BuiltList<ProjectEntity> data;

  factory _$ProjectListResponse([void updates(ProjectListResponseBuilder b)]) =>
      (new ProjectListResponseBuilder()..update(updates)).build();

  _$ProjectListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ProjectListResponse', 'data');
    }
  }

  @override
  ProjectListResponse rebuild(void updates(ProjectListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectListResponseBuilder toBuilder() =>
      new ProjectListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProjectListResponse;
  }

  @override
  void update(void updates(ProjectListResponseBuilder b)) {
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

  factory _$ProjectItemResponse([void updates(ProjectItemResponseBuilder b)]) =>
      (new ProjectItemResponseBuilder()..update(updates)).build();

  _$ProjectItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ProjectItemResponse', 'data');
    }
  }

  @override
  ProjectItemResponse rebuild(void updates(ProjectItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectItemResponseBuilder toBuilder() =>
      new ProjectItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
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
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProjectItemResponse;
  }

  @override
  void update(void updates(ProjectItemResponseBuilder b)) {
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
  final int clientId;
  @override
  final double taskRate;
  @override
  final String dueDate;
  @override
  final String privateNotes;
  @override
  final double budgetedHours;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final int archivedAt;
  @override
  final bool isDeleted;
  @override
  final bool isOwner;
  @override
  final int id;

  factory _$ProjectEntity([void updates(ProjectEntityBuilder b)]) =>
      (new ProjectEntityBuilder()..update(updates)).build();

  _$ProjectEntity._(
      {this.name,
      this.clientId,
      this.taskRate,
      this.dueDate,
      this.privateNotes,
      this.budgetedHours,
      this.customValue1,
      this.customValue2,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('ProjectEntity', 'name');
    }
    if (clientId == null) {
      throw new BuiltValueNullFieldError('ProjectEntity', 'clientId');
    }
    if (taskRate == null) {
      throw new BuiltValueNullFieldError('ProjectEntity', 'taskRate');
    }
    if (dueDate == null) {
      throw new BuiltValueNullFieldError('ProjectEntity', 'dueDate');
    }
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('ProjectEntity', 'privateNotes');
    }
    if (budgetedHours == null) {
      throw new BuiltValueNullFieldError('ProjectEntity', 'budgetedHours');
    }
    if (customValue1 == null) {
      throw new BuiltValueNullFieldError('ProjectEntity', 'customValue1');
    }
    if (customValue2 == null) {
      throw new BuiltValueNullFieldError('ProjectEntity', 'customValue2');
    }
  }

  @override
  ProjectEntity rebuild(void updates(ProjectEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectEntityBuilder toBuilder() => new ProjectEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectEntity &&
        name == other.name &&
        clientId == other.clientId &&
        taskRate == other.taskRate &&
        dueDate == other.dueDate &&
        privateNotes == other.privateNotes &&
        budgetedHours == other.budgetedHours &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        archivedAt == other.archivedAt &&
        isDeleted == other.isDeleted &&
        isOwner == other.isOwner &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
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
                                                    $jc($jc(0, name.hashCode),
                                                        clientId.hashCode),
                                                    taskRate.hashCode),
                                                dueDate.hashCode),
                                            privateNotes.hashCode),
                                        budgetedHours.hashCode),
                                    customValue1.hashCode),
                                customValue2.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProjectEntity')
          ..add('name', name)
          ..add('clientId', clientId)
          ..add('taskRate', taskRate)
          ..add('dueDate', dueDate)
          ..add('privateNotes', privateNotes)
          ..add('budgetedHours', budgetedHours)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
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

  int _clientId;
  int get clientId => _$this._clientId;
  set clientId(int clientId) => _$this._clientId = clientId;

  double _taskRate;
  double get taskRate => _$this._taskRate;
  set taskRate(double taskRate) => _$this._taskRate = taskRate;

  String _dueDate;
  String get dueDate => _$this._dueDate;
  set dueDate(String dueDate) => _$this._dueDate = dueDate;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

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

  bool _isOwner;
  bool get isOwner => _$this._isOwner;
  set isOwner(bool isOwner) => _$this._isOwner = isOwner;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  ProjectEntityBuilder();

  ProjectEntityBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _clientId = _$v.clientId;
      _taskRate = _$v.taskRate;
      _dueDate = _$v.dueDate;
      _privateNotes = _$v.privateNotes;
      _budgetedHours = _$v.budgetedHours;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _archivedAt = _$v.archivedAt;
      _isDeleted = _$v.isDeleted;
      _isOwner = _$v.isOwner;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProjectEntity;
  }

  @override
  void update(void updates(ProjectEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ProjectEntity build() {
    final _$result = _$v ??
        new _$ProjectEntity._(
            name: name,
            clientId: clientId,
            taskRate: taskRate,
            dueDate: dueDate,
            privateNotes: privateNotes,
            budgetedHours: budgetedHours,
            customValue1: customValue1,
            customValue2: customValue2,
            createdAt: createdAt,
            updatedAt: updatedAt,
            archivedAt: archivedAt,
            isDeleted: isDeleted,
            isOwner: isOwner,
            id: id);
    replace(_$result);
    return _$result;
  }
}
