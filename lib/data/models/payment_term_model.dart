// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'payment_term_model.g.dart';

abstract class PaymentTermListResponse
    implements Built<PaymentTermListResponse, PaymentTermListResponseBuilder> {
  factory PaymentTermListResponse(
          [void updates(PaymentTermListResponseBuilder b)]) =
      _$PaymentTermListResponse;

  PaymentTermListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<PaymentTermEntity> get data;

  static Serializer<PaymentTermListResponse> get serializer =>
      _$paymentTermListResponseSerializer;
}

abstract class PaymentTermItemResponse
    implements Built<PaymentTermItemResponse, PaymentTermItemResponseBuilder> {
  factory PaymentTermItemResponse(
          [void updates(PaymentTermItemResponseBuilder b)]) =
      _$PaymentTermItemResponse;

  PaymentTermItemResponse._();

  @override
  @memoized
  int get hashCode;

  PaymentTermEntity get data;

  static Serializer<PaymentTermItemResponse> get serializer =>
      _$paymentTermItemResponseSerializer;
}

class PaymentTermFields {
  static const String name = 'name';
  static const String numDays = 'num_days';
}

abstract class PaymentTermEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<PaymentTermEntity, PaymentTermEntityBuilder> {
  factory PaymentTermEntity({String? id, AppState? state}) {
    return _$PaymentTermEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      isDeleted: false,
      archivedAt: 0,
      numDays: 0,
      name: '',
      createdAt: 0,
      updatedAt: 0,
    );
  }

  PaymentTermEntity._();

  @override
  EntityType get entityType {
    return EntityType.paymentTerm;
  }

  @override
  @memoized
  int get hashCode;

  static Serializer<PaymentTermEntity> get serializer =>
      _$paymentTermEntitySerializer;

  String getPaymentTerm(String netLabel) {
    if (numDays == 0) {
      return '';
    } else if (numDays == -1) {
      return '$netLabel 0';
    } else {
      return '$netLabel $numDays';
    }
  }

  String get name;

  @BuiltValueField(wireName: 'num_days')
  int get numDays;

  int compareTo(PaymentTermEntity paymentTerm, String sortField,
          bool sortAscending) =>
      numDays.compareTo(paymentTerm.numDays);

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        '$numDays',
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [
        //
      ],
      needle: filter,
    );
  }

  @override
  String get listDisplayName => name;
}
