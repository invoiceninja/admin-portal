// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

part 'token_model.g.dart';

abstract class TokenListResponse
    implements Built<TokenListResponse, TokenListResponseBuilder> {
  factory TokenListResponse([void updates(TokenListResponseBuilder b)]) =
      _$TokenListResponse;

  TokenListResponse._();

  @override
  @memoized
  int get hashCode;

  BuiltList<TokenEntity> get data;

  static Serializer<TokenListResponse> get serializer =>
      _$tokenListResponseSerializer;
}

abstract class TokenItemResponse
    implements Built<TokenItemResponse, TokenItemResponseBuilder> {
  factory TokenItemResponse([void updates(TokenItemResponseBuilder b)]) =
      _$TokenItemResponse;

  TokenItemResponse._();

  @override
  @memoized
  int get hashCode;

  TokenEntity get data;

  static Serializer<TokenItemResponse> get serializer =>
      _$tokenItemResponseSerializer;
}

class TokenFields {
  static const String name = 'name';
  static const String custom1 = 'custom1';
  static const String custom2 = 'custom2';
}

abstract class TokenEntity extends Object
    with BaseEntity, SelectableEntity
    implements Built<TokenEntity, TokenEntityBuilder> {
  factory TokenEntity({String? id, AppState? state}) {
    return _$TokenEntity._(
      id: id ?? BaseEntity.nextId,
      isChanged: false,
      name: '',
      token: '',
      updatedAt: 0,
      archivedAt: 0,
      isDeleted: false,
      createdAt: 0,
      assignedUserId: '',
      createdUserId: '',
      isSystem: false,
    );
  }

  TokenEntity._();

  @override
  @memoized
  int get hashCode;

  @override
  EntityType get entityType {
    return EntityType.token;
  }

  @BuiltValueField(wireName: 'is_system')
  bool get isSystem;

  String get token;

  String get name;

  String get obscuredToken => TokenEntity.obscureToken(token);

  bool get isMasked => token.substring(10) == 'xxxxxxxxxxx';

  static String obscureToken(String value) => base64Encode(utf8.encode(value));

  static String? unobscureToken(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return utf8.decode(base64Decode(value));
  }

  @override
  String get listDisplayName {
    return name;
  }

  int compareTo(TokenEntity? token, String sortField, bool sortAscending) {
    int response = 0;
    final TokenEntity? tokenA = sortAscending ? this : token;
    final TokenEntity? tokenB = sortAscending ? token : this;

    switch (sortField) {
      case TokenFields.name:
        response =
            tokenA!.name.toLowerCase().compareTo(tokenB!.name.toLowerCase());
        break;
      default:
        print('## ERROR: sort by token.$sortField is not implemented');
        break;
    }

    return response;
  }

  @override
  bool matchesFilter(String? filter) {
    return matchesStrings(
      haystacks: [
        name,
      ],
      needle: filter,
    );
  }

  @override
  String? matchesFilterValue(String? filter) {
    return matchesStringsValue(
      haystacks: [],
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

    if (!isMasked && !multiselect) {
      actions.add(EntityAction.copy);
    }

    if (!isDeleted! && !multiselect) {
      if (includeEdit && userCompany!.canEditEntity(this)) {
        actions.add(EntityAction.edit);
      }
    }

    if (actions.isNotEmpty && actions.last != null) {
      actions.add(null);
    }

    return actions..addAll(super.getActions(userCompany: userCompany));
  }

  @override
  double? get listDisplayAmount => null;

  @override
  FormatNumberType? get listDisplayAmountType => null;

  static Serializer<TokenEntity> get serializer => _$tokenEntitySerializer;
}
