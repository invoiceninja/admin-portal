// Package imports:
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';

part 'document_status_model.g.dart';

class DocumentStatusFields {
  static const String name = 'name';
}

abstract class DocumentStatusEntity extends Object
    with EntityStatus, SelectableEntity
    implements Built<DocumentStatusEntity, DocumentStatusEntityBuilder> {
  factory DocumentStatusEntity() {
    return _$DocumentStatusEntity._(
      id: '',
      name: '',
    );
  }

  DocumentStatusEntity._();

  @override
  @memoized
  int get hashCode;

  static Serializer<DocumentStatusEntity> get serializer =>
      _$documentStatusEntitySerializer;
}
