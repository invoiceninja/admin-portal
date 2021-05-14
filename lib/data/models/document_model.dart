import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'document_model.g.dart';

abstract class DocumentListResponse
    implements Built<DocumentListResponse, DocumentListResponseBuilder> {
  factory DocumentListResponse([void updates(DocumentListResponseBuilder b)]) =
      _$DocumentListResponse;

  DocumentListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<DocumentEntity> get data;

  static Serializer<DocumentListResponse> get serializer =>
      _$documentListResponseSerializer;
}

abstract class DocumentItemResponse
    implements Built<DocumentItemResponse, DocumentItemResponseBuilder> {
  factory DocumentItemResponse([void updates(DocumentItemResponseBuilder b)]) =
      _$DocumentItemResponse;

  DocumentItemResponse._();

  @override
  @memoized
  int get hashCode;

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
      url: '',
      type: '',
      isDefault: false,
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      preview: '',
      width: 0,
      height: 0,
      size: 0,
      hash: '',
      createdUserId: '',
      assignedUserId: '',
      createdAt: 0,
    );
  }

  DocumentEntity._();

  static const ALLOWED_EXTENSIONS = [
    'png',
    'svg',
    'jpeg',
    'gif',
    'jpg',
    'bmp',
    'txt',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'pdf',
  ];

  @override
  @memoized
  int get hashCode;

  String get name;

  String get hash;

  String get type;

  String get url;

  int get width;

  int get height;

  int get size;

  String get preview;

  @BuiltValueField(wireName: 'is_default')
  bool get isDefault;

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

  String get prettySize => formatSize(size);

  String get downloadUrl => '/documents/$hash';

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
    return matchesStrings(
      haystacks: [
        name,
        type,
        preview,
      ],
      needle: filter,
    );
  }

  @override
  String matchesFilterValue(String filter) {
    return matchesStringsValue(
      haystacks: [
        name,
        type,
        preview,
      ],
      needle: filter,
    );
  }

  @override
  List<EntityAction> getActions(
      {UserCompanyEntity userCompany,
      ClientEntity client,
      bool includeEdit = false,
      bool multiselect = false}) {
    final actions = <EntityAction>[];

    if (!isDeleted && !multiselect) {
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

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  static Serializer<DocumentEntity> get serializer =>
      _$documentEntitySerializer;
}
