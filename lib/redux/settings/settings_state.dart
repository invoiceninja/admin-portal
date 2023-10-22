// Package imports:
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'settings_state.g.dart';

abstract class SettingsUIState extends Object
    implements Built<SettingsUIState, SettingsUIStateBuilder> {
  factory SettingsUIState(
      {CompanyEntity? company,
      ClientEntity? client,
      GroupEntity? group,
      UserEntity? user,
      CompanyEntity? origCompany,
      ClientEntity? origClient,
      GroupEntity? origGroup,
      UserEntity? origUser,
      String? section}) {
    return _$SettingsUIState._(
      company: company ?? CompanyEntity(),
      client: client ?? ClientEntity(),
      group: group ?? GroupEntity(),
      user: user ?? UserEntity(),
      entityType: client != null
          ? EntityType.client
          : group != null
              ? EntityType.group
              : EntityType.company,
      origClient: origClient ?? ClientEntity(),
      origGroup: origGroup ?? GroupEntity(),
      origCompany: origCompany ?? CompanyEntity(),
      origUser: origUser ?? UserEntity(),
      isChanged: false,
      showNewSettings: false,
      showPdfPreview: false,
      updatedAt: 0,
      filterClearedAt: 0,
      tabIndex: 0,
      selectedTemplate: EmailTemplate.invoice,
      section: section ?? kSettingsCompanyDetails,
    );
  }

  SettingsUIState._();

  @override
  @memoized
  int get hashCode;

  CompanyEntity get company;

  CompanyEntity get origCompany;

  ClientEntity get client;

  ClientEntity get origClient;

  GroupEntity get group;

  GroupEntity get origGroup;

  UserEntity get user;

  UserEntity get origUser;

  EntityType get entityType;

  bool get isChanged;

  int get updatedAt;

  String get section;

  int get tabIndex;

  EmailTemplate get selectedTemplate;

  String? get filter;

  int get filterClearedAt;

  bool get showNewSettings;

  bool get showPdfPreview;

  bool get isFiltered => entityType != EntityType.company;

  SettingsEntity get settings {
    if (entityType == EntityType.client) {
      return client.settings;
    } else if (entityType == EntityType.group) {
      return group.settings;
    } else {
      return company.settings;
    }
  }

  // ignore: unused_element
  static void _initializeBuilder(SettingsUIStateBuilder builder) => builder
    ..selectedTemplate = EmailTemplate.invoice
    ..showNewSettings = false
    ..showPdfPreview = false;

  static Serializer<SettingsUIState> get serializer =>
      _$settingsUIStateSerializer;
}
