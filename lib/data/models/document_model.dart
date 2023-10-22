// Package imports:
import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
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
  static const String createdAt = 'created_at';
  static const String archivedAt = 'archived_at';
  static const String isDeleted = 'is_deleted';
  static const String name = 'name';
  static const String url = 'url';
  static const String type = 'type';
  static const String size = 'size';
  static const String width = 'width';
  static const String height = 'height';
  static const String hash = 'hash';
  static const String linkedTo = 'linked_to';
  static const String isPublic = 'public';
  static const String isPrivate = 'private';
}

abstract class DocumentEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<DocumentEntity, DocumentEntityBuilder> {
  factory DocumentEntity({String? id}) {
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
      isPublic: true,
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
    'xml',
    'zip',
    'ods',
    'odt',
    'odp',
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

  @BuiltValueField(serialize: false)
  Uint8List? get data;

  @BuiltValueField(wireName: 'is_default')
  bool get isDefault;

  @BuiltValueField(wireName: 'is_public')
  bool get isPublic;

  @BuiltValueField(wireName: 'parent_id')
  String? get parentId;

  @BuiltValueField(wireName: 'parent_type')
  EntityType? get parentType;

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
  double? get listDisplayAmount => null;

  @override
  FormatNumberType get listDisplayAmountType => FormatNumberType.money;

  @override
  bool get isDeletable => false;

  String get prettySize => formatSize(size);

  String get downloadUrl => '/documents/$hash';

  bool get isImage {
    final fileName = name.toLowerCase();
    return fileName.endsWith('.png') ||
        fileName.endsWith('.jpg') ||
        fileName.endsWith('.jpeg') ||
        fileName.endsWith('.bmp') ||
        fileName.endsWith('.webp');
  }

  bool get isPdf {
    final fileName = name.toLowerCase();
    return fileName.endsWith('.pdf');
  }

  bool get isTxt {
    final fileName = name.toLowerCase();
    return fileName.endsWith('.txt');
  }

  int compareTo(DocumentEntity? document,
      [String? sortField, bool sortAscending = true]) {
    int response = 0;
    final DocumentEntity? documentA = sortAscending ? this : document;
    final DocumentEntity? documentB = sortAscending ? document : this;

    switch (sortField) {
      case DocumentFields.name:
        response = documentA!.name
            .toLowerCase()
            .compareTo(documentB!.name.toLowerCase());
        break;
      case DocumentFields.id:
        response = documentA!.id.compareTo(documentB!.id);
        break;
      case DocumentFields.createdAt:
        response = documentA!.createdAt.compareTo(documentB!.createdAt);
        break;
      case DocumentFields.type:
        response = documentA!.type.compareTo(documentB!.type);
        break;
      case DocumentFields.size:
        response = documentA!.size.compareTo(documentB!.size);
        break;
      case DocumentFields.width:
        response = documentA!.width.compareTo(documentB!.width);
        break;
      case DocumentFields.height:
        response = documentA!.height.compareTo(documentB!.height);
        break;
      case DocumentFields.hash:
        response = documentA!.hash.compareTo(documentB!.hash);
        break;
      case DocumentFields.linkedTo:
        if (documentA!.parentType == documentB!.parentType) {
          response = documentA.parentId!.compareTo(documentB.parentId!);
        } else {
          response =
              '${documentA.parentType}'.compareTo('${documentB.parentType}');
        }
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
  bool matchesStatuses(BuiltList<EntityStatus> statuses) {
    if (statuses.isEmpty) {
      return true;
    }

    for (final status in statuses) {
      if (status.id == kDocumentStatusPublic && isPublic) {
        return true;
      } else if (status.id == kDocumentStatusPrivate && !isPublic) {
        return true;
      }

      if (status.id == kDocumentStatusImage && isImage) {
        return true;
      } else if (status.id == kDocumentStatusPDF && isPdf) {
        return true;
      } else if (status.id == kDocumentStatusOther && !isImage && !isPdf) {
        return true;
      }
    }

    return false;
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        name,
        type,
        preview,
        '$prettySize',
        '$width',
        '$height',
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
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
  List<EntityAction?> getActions(
      {UserCompanyEntity? userCompany,
      ClientEntity? client,
      bool includeEdit = false,
      bool includePreview = false,
      bool multiselect = false}) {
    final actions = <EntityAction?>[];

    if (!isDeleted! && !multiselect) {
      if (includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }
    }

    if (!multiselect) {
      actions.add(EntityAction.viewDocument);
    }

    if (!isDeleted!) {
      if (multiselect) {
        actions.add(EntityAction.bulkDownload);
      } else {
        actions.add(EntityAction.download);
      }
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    if (userCompany!.canEditEntity(this) && !multiselect) {
      actions.add(EntityAction.delete);
    }

    //return actions..addAll(super.getActions(userCompany: userCompany));

    return actions;
  }

  // ignore: unused_element
  static void _initializeBuilder(DocumentEntityBuilder builder) =>
      builder..isPublic = true;

  static Serializer<DocumentEntity> get serializer =>
      _$documentEntitySerializer;
}
