import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';
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
  static const String id = 'id';
  static const String updatedAt = 'updated_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
  static const String name = 'name';
}

abstract class DocumentEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<DocumentEntity, DocumentEntityBuilder> {
  factory DocumentEntity({String id}) {
    return _$DocumentEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      name: '',
      path: '',
      type: '',
      isDefault: false,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      preview: '',
      width: 0,
      height: 0,
      size: 0,
      customValue1: '',
      customValue2: '',
      customValue3: '',
      customValue4: '',
      createdUserId: '',
      assignedUserId: '',
      createdAt: 0,
      vendorId: '',
      projectId: '',
      invoiceId: '',
      expenseId: '',
    );
  }

  DocumentEntity._();

  String get name;

  String get type;

  String get path;

  int get width;

  int get height;

  int get size;

  String get preview;

  @nullable
  @BuiltValueField(wireName: 'invoice_id')
  String get invoiceId;

  @nullable
  @BuiltValueField(wireName: 'expense_id')
  String get expenseId;

  @BuiltValueField(wireName: 'is_default')
  bool get isDefault;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @nullable
  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @nullable
  @BuiltValueField(wireName: 'project_id')
  String get projectId;

  @nullable
  @BuiltValueField(wireName: 'vendor_id')
  String get vendorId;

  DocumentEntity get clone => rebuild((b) => b
    ..id = BaseEntity.nextId
    ..isChanged = false
    ..isDeleted = false);

  @override
  EntityType get entityType {
    return EntityType.document;
  }

  @override
  String get listDisplayName {
    return name;
  }

  @override
  double get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  bool get isInvoiceDocument => invoiceId != null && invoiceId.isNotEmpty;

  bool get isExpenseDocument => expenseId != null && expenseId.isNotEmpty;

  String get prettySize => size > 1000000
      ? '${round(size / 1000000, 1).toInt()} MB'
      : '${round(size / 1000, 0).toInt()} KB';

  String previewUrl(String baseUrl) =>
      formatApiUrl(
          baseUrl != null && baseUrl.startsWith('http') ? baseUrl : Constants.hostedApiUrl) +
      '/documents/$id';

  int compareTo(DocumentEntity document,
      [String sortField, bool sortAscending = true]) {
    int response = 0;
    final DocumentEntity documentA = sortAscending ? this : document;
    final DocumentEntity documentB = sortAscending ? document : this;

    switch (sortField) {
      case DocumentFields.name:
        response = documentA.name
            .toLowerCase()
            .compareTo(documentB.name.toLowerCase());
        break;
      case DocumentFields.updatedAt:
        response = documentA.updatedAt.compareTo(documentB.updatedAt);
        break;
      default:
        print('## ERROR: sort by documents.$sortField is not implemented');
        break;
    }

    /*
    if (response == 0) {
      return documentA.createdAt.compareTo(documentB.createdAt);
    } else {
      return response;
    }
    */

    return response;
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
    return true;
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
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted) {
      if (includeEdit && userCompany.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }

      if (userCompany.canCreate(EntityType.invoice)) {
        actions.add(EntityAction.newInvoice);
      }
    }

    if (userCompany.canCreate(EntityType.document)) {
      actions.add(EntityAction.clone);
    }

    if (actions.isNotEmpty) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  static Serializer<DocumentEntity> get serializer =>
      _$documentEntitySerializer;
}
