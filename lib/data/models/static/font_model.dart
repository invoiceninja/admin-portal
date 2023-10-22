// Package imports:
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'font_model.g.dart';

class FontFields {
  static const String name = 'name';
}

abstract class FontEntity extends Object
    with SelectableEntity
    implements Built<FontEntity, FontEntityBuilder> {
  factory FontEntity({String? id, String? name}) {
    return _$FontEntity._(
      id: id ?? '',
      name: name ?? '',
    );
  }
  FontEntity._();

  @override
  @memoized
  int get hashCode;

  String get name;

  @override
  bool matchesFilter(String? filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();

    if (name.toLowerCase().contains(filter)) {
      return true;
    }

    return false;
  }

  @override
  String? matchesFilterValue(String? filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    return null;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double? get listDisplayAmount => null;

  static Serializer<FontEntity> get serializer => _$fontEntitySerializer;
}
