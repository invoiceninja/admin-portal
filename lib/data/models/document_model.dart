import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

part 'document_model.g.dart';

abstract class DocumentListResponse
    implements Built<DocumentListResponse, DocumentListResponseBuilder> {
  factory DocumentListResponse([void updates(DocumentListResponseBuilder b)]) =
      _$DocumentListResponse;

  DocumentListResponse._();

  BuiltList<DocumentEntity> get data;

  static Serializer<DocumentListResponse> get serializer =>
      _$documentListResponseSerializer;
}

abstract class DocumentItemResponse
    implements Built<DocumentItemResponse, DocumentItemResponseBuilder> {
  factory DocumentItemResponse([void updates(DocumentItemResponseBuilder b)]) =
      _$DocumentItemResponse;

  DocumentItemResponse._();

  DocumentEntity get data;

  static Serializer<DocumentItemResponse> get serializer =>
      _$documentItemResponseSerializer;
}

class DocumentFields {
  static const String updatedAt = 'updatedAt';
  static const String archivedAt = 'archivedAt';
  static const String isDeleted = 'isDeleted';
  static const String name = 'name';
}

abstract class DocumentEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<DocumentEntity, DocumentEntityBuilder> {
  factory DocumentEntity({int id}) {
    return _$DocumentEntity._(
      id: id ?? --DocumentEntity.counter,
      name: '',
      path: '',
      type: '',
      isDefault: false,
      invoiceId: 0,
      expenseId: 0,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
    );
  }

  DocumentEntity._();

  static int counter = 0;

  String get name;

  String get type;

  String get path;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  int get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'expense_id')
  int get expenseId;

  @BuiltValueField(wireName: 'is_default')
  bool get isDefault;

  DocumentEntity get clone => rebuild((b) => b
    ..id = --DocumentEntity.counter
    ..isDeleted = false);

  @override
  EntityType get entityType {
    return EntityType.document;
  }

  @override
  String get listDisplayName {
    return null;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  int compareTo(DocumentEntity document,
      [String sortField, bool sortAscending = true]) {
    int response = 0;
    final DocumentEntity documentA = sortAscending ? this : document;
    final DocumentEntity documentB = sortAscending ? document : this;

    return null;

    /*
    switch (sortField) {
      case DocumentFields.cost:
        response = documentA.cost.compareTo(documentB.cost);
        break;
      case DocumentFields.updatedAt:
        response = documentA.updatedAt.compareTo(documentB.updatedAt);
        break;
    }

    if (response == 0) {
      return documentA.documentKey
          .toLowerCase()
          .compareTo(documentB.documentKey.toLowerCase());
    } else {
      return response;
    }
    */
  }

  @override
  bool matchesFilter(String filter) {
    if (filter == null || filter.isEmpty) {
      return true;
    }

    filter = filter.toLowerCase();
    /*
    if (documentKey.toLowerCase().contains(filter)) {
      return true;
    } else if (notes.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return true;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return true;
    }
    */
    return false;
  }

  @override
  String matchesFilterValue(String filter) {
    if (filter == null || filter.isEmpty) {
      return null;
    }

    filter = filter.toLowerCase();

    /*
    if (notes.toLowerCase().contains(filter)) {
      return notes;
    } else if (customValue1.isNotEmpty &&
        customValue1.toLowerCase().contains(filter)) {
      return customValue1;
    } else if (customValue2.isNotEmpty &&
        customValue2.toLowerCase().contains(filter)) {
      return customValue2;
    }
    */

    return null;
  }

  @override
  List<EntityAction> getActions(
      {UserEntity user, ClientEntity client, bool includeEdit = false}) {
    final actions = <EntityAction>[];

    if (includeEdit && user.canEditEntity(this) && !isDeleted) {
      actions.add(EntityAction.edit);
    }

    if (user.canCreate(EntityType.document)) {
      actions.add(EntityAction.clone);
    }

    if (user.canCreate(EntityType.invoice)) {
      actions.add(EntityAction.newInvoice);
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(user: user));
  }

  static Serializer<DocumentEntity> get serializer =>
      _$documentEntitySerializer;
}
