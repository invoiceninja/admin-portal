// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_model.dart';

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

Serializer<CreditListResponse> _$creditListResponseSerializer =
    new _$CreditListResponseSerializer();
Serializer<CreditItemResponse> _$creditItemResponseSerializer =
    new _$CreditItemResponseSerializer();
Serializer<CreditEntity> _$creditEntitySerializer =
    new _$CreditEntitySerializer();

class _$CreditListResponseSerializer
    implements StructuredSerializer<CreditListResponse> {
  @override
  final Iterable<Type> types = const [CreditListResponse, _$CreditListResponse];
  @override
  final String wireName = 'CreditListResponse';

  @override
  Iterable serialize(Serializers serializers, CreditListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CreditEntity)])),
    ];

    return result;
  }

  @override
  CreditListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreditListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CreditEntity)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$CreditItemResponseSerializer
    implements StructuredSerializer<CreditItemResponse> {
  @override
  final Iterable<Type> types = const [CreditItemResponse, _$CreditItemResponse];
  @override
  final String wireName = 'CreditItemResponse';

  @override
  Iterable serialize(Serializers serializers, CreditItemResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(CreditEntity)),
    ];

    return result;
  }

  @override
  CreditItemResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreditItemResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(CreditEntity)) as CreditEntity);
          break;
      }
    }

    return result.build();
  }
}

class _$CreditEntitySerializer implements StructuredSerializer<CreditEntity> {
  @override
  final Iterable<Type> types = const [CreditEntity, _$CreditEntity];
  @override
  final String wireName = 'CreditEntity';

  @override
  Iterable serialize(Serializers serializers, CreditEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'balance',
      serializers.serialize(object.balance,
          specifiedType: const FullType(double)),
      'credit_date',
      serializers.serialize(object.creditDate,
          specifiedType: const FullType(String)),
      'credit_number',
      serializers.serialize(object.creditNumber,
          specifiedType: const FullType(String)),
      'private_notes',
      serializers.serialize(object.privateNotes,
          specifiedType: const FullType(String)),
      'public_notes',
      serializers.serialize(object.publicNotes,
          specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(int)),
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
  CreditEntity deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CreditEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'credit_date':
          result.creditDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_number':
          result.creditNumber = serializers.deserialize(value,
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
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$CreditListResponse extends CreditListResponse {
  @override
  final BuiltList<CreditEntity> data;

  factory _$CreditListResponse([void updates(CreditListResponseBuilder b)]) =>
      (new CreditListResponseBuilder()..update(updates)).build();

  _$CreditListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('CreditListResponse', 'data');
    }
  }

  @override
  CreditListResponse rebuild(void updates(CreditListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CreditListResponseBuilder toBuilder() =>
      new CreditListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreditListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreditListResponse')
          ..add('data', data))
        .toString();
  }
}

class CreditListResponseBuilder
    implements Builder<CreditListResponse, CreditListResponseBuilder> {
  _$CreditListResponse _$v;

  ListBuilder<CreditEntity> _data;
  ListBuilder<CreditEntity> get data =>
      _$this._data ??= new ListBuilder<CreditEntity>();
  set data(ListBuilder<CreditEntity> data) => _$this._data = data;

  CreditListResponseBuilder();

  CreditListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreditListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CreditListResponse;
  }

  @override
  void update(void updates(CreditListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CreditListResponse build() {
    _$CreditListResponse _$result;
    try {
      _$result = _$v ?? new _$CreditListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CreditListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CreditItemResponse extends CreditItemResponse {
  @override
  final CreditEntity data;

  factory _$CreditItemResponse([void updates(CreditItemResponseBuilder b)]) =>
      (new CreditItemResponseBuilder()..update(updates)).build();

  _$CreditItemResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('CreditItemResponse', 'data');
    }
  }

  @override
  CreditItemResponse rebuild(void updates(CreditItemResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CreditItemResponseBuilder toBuilder() =>
      new CreditItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreditItemResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreditItemResponse')
          ..add('data', data))
        .toString();
  }
}

class CreditItemResponseBuilder
    implements Builder<CreditItemResponse, CreditItemResponseBuilder> {
  _$CreditItemResponse _$v;

  CreditEntityBuilder _data;
  CreditEntityBuilder get data => _$this._data ??= new CreditEntityBuilder();
  set data(CreditEntityBuilder data) => _$this._data = data;

  CreditItemResponseBuilder();

  CreditItemResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreditItemResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CreditItemResponse;
  }

  @override
  void update(void updates(CreditItemResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CreditItemResponse build() {
    _$CreditItemResponse _$result;
    try {
      _$result = _$v ?? new _$CreditItemResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CreditItemResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CreditEntity extends CreditEntity {
  @override
  final double amount;
  @override
  final double balance;
  @override
  final String creditDate;
  @override
  final String creditNumber;
  @override
  final String privateNotes;
  @override
  final String publicNotes;
  @override
  final int clientId;
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

  factory _$CreditEntity([void updates(CreditEntityBuilder b)]) =>
      (new CreditEntityBuilder()..update(updates)).build();

  _$CreditEntity._(
      {this.amount,
      this.balance,
      this.creditDate,
      this.creditNumber,
      this.privateNotes,
      this.publicNotes,
      this.clientId,
      this.createdAt,
      this.updatedAt,
      this.archivedAt,
      this.isDeleted,
      this.isOwner,
      this.id})
      : super._() {
    if (amount == null) {
      throw new BuiltValueNullFieldError('CreditEntity', 'amount');
    }
    if (balance == null) {
      throw new BuiltValueNullFieldError('CreditEntity', 'balance');
    }
    if (creditDate == null) {
      throw new BuiltValueNullFieldError('CreditEntity', 'creditDate');
    }
    if (creditNumber == null) {
      throw new BuiltValueNullFieldError('CreditEntity', 'creditNumber');
    }
    if (privateNotes == null) {
      throw new BuiltValueNullFieldError('CreditEntity', 'privateNotes');
    }
    if (publicNotes == null) {
      throw new BuiltValueNullFieldError('CreditEntity', 'publicNotes');
    }
    if (clientId == null) {
      throw new BuiltValueNullFieldError('CreditEntity', 'clientId');
    }
  }

  @override
  CreditEntity rebuild(void updates(CreditEntityBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CreditEntityBuilder toBuilder() => new CreditEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreditEntity &&
        amount == other.amount &&
        balance == other.balance &&
        creditDate == other.creditDate &&
        creditNumber == other.creditNumber &&
        privateNotes == other.privateNotes &&
        publicNotes == other.publicNotes &&
        clientId == other.clientId &&
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
                                                $jc($jc(0, amount.hashCode),
                                                    balance.hashCode),
                                                creditDate.hashCode),
                                            creditNumber.hashCode),
                                        privateNotes.hashCode),
                                    publicNotes.hashCode),
                                clientId.hashCode),
                            createdAt.hashCode),
                        updatedAt.hashCode),
                    archivedAt.hashCode),
                isDeleted.hashCode),
            isOwner.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CreditEntity')
          ..add('amount', amount)
          ..add('balance', balance)
          ..add('creditDate', creditDate)
          ..add('creditNumber', creditNumber)
          ..add('privateNotes', privateNotes)
          ..add('publicNotes', publicNotes)
          ..add('clientId', clientId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('archivedAt', archivedAt)
          ..add('isDeleted', isDeleted)
          ..add('isOwner', isOwner)
          ..add('id', id))
        .toString();
  }
}

class CreditEntityBuilder
    implements Builder<CreditEntity, CreditEntityBuilder> {
  _$CreditEntity _$v;

  double _amount;
  double get amount => _$this._amount;
  set amount(double amount) => _$this._amount = amount;

  double _balance;
  double get balance => _$this._balance;
  set balance(double balance) => _$this._balance = balance;

  String _creditDate;
  String get creditDate => _$this._creditDate;
  set creditDate(String creditDate) => _$this._creditDate = creditDate;

  String _creditNumber;
  String get creditNumber => _$this._creditNumber;
  set creditNumber(String creditNumber) => _$this._creditNumber = creditNumber;

  String _privateNotes;
  String get privateNotes => _$this._privateNotes;
  set privateNotes(String privateNotes) => _$this._privateNotes = privateNotes;

  String _publicNotes;
  String get publicNotes => _$this._publicNotes;
  set publicNotes(String publicNotes) => _$this._publicNotes = publicNotes;

  int _clientId;
  int get clientId => _$this._clientId;
  set clientId(int clientId) => _$this._clientId = clientId;

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

  CreditEntityBuilder();

  CreditEntityBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _balance = _$v.balance;
      _creditDate = _$v.creditDate;
      _creditNumber = _$v.creditNumber;
      _privateNotes = _$v.privateNotes;
      _publicNotes = _$v.publicNotes;
      _clientId = _$v.clientId;
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
  void replace(CreditEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CreditEntity;
  }

  @override
  void update(void updates(CreditEntityBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CreditEntity build() {
    final _$result = _$v ??
        new _$CreditEntity._(
            amount: amount,
            balance: balance,
            creditDate: creditDate,
            creditNumber: creditNumber,
            privateNotes: privateNotes,
            publicNotes: publicNotes,
            clientId: clientId,
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
