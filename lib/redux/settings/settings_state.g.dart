// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SettingsUIState> _$settingsUIStateSerializer =
    new _$SettingsUIStateSerializer();

class _$SettingsUIStateSerializer
    implements StructuredSerializer<SettingsUIState> {
  @override
  final Iterable<Type> types = const [SettingsUIState, _$SettingsUIState];
  @override
  final String wireName = 'SettingsUIState';

  @override
  Iterable<Object?> serialize(Serializers serializers, SettingsUIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'company',
      serializers.serialize(object.company,
          specifiedType: const FullType(CompanyEntity)),
      'origCompany',
      serializers.serialize(object.origCompany,
          specifiedType: const FullType(CompanyEntity)),
      'client',
      serializers.serialize(object.client,
          specifiedType: const FullType(ClientEntity)),
      'origClient',
      serializers.serialize(object.origClient,
          specifiedType: const FullType(ClientEntity)),
      'group',
      serializers.serialize(object.group,
          specifiedType: const FullType(GroupEntity)),
      'origGroup',
      serializers.serialize(object.origGroup,
          specifiedType: const FullType(GroupEntity)),
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(UserEntity)),
      'origUser',
      serializers.serialize(object.origUser,
          specifiedType: const FullType(UserEntity)),
      'entityType',
      serializers.serialize(object.entityType,
          specifiedType: const FullType(EntityType)),
      'isChanged',
      serializers.serialize(object.isChanged,
          specifiedType: const FullType(bool)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'section',
      serializers.serialize(object.section,
          specifiedType: const FullType(String)),
      'tabIndex',
      serializers.serialize(object.tabIndex,
          specifiedType: const FullType(int)),
      'selectedTemplate',
      serializers.serialize(object.selectedTemplate,
          specifiedType: const FullType(EmailTemplate)),
      'filterClearedAt',
      serializers.serialize(object.filterClearedAt,
          specifiedType: const FullType(int)),
      'showNewSettings',
      serializers.serialize(object.showNewSettings,
          specifiedType: const FullType(bool)),
      'showPdfPreview',
      serializers.serialize(object.showPdfPreview,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.filter;
    if (value != null) {
      result
        ..add('filter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SettingsUIState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingsUIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'company':
          result.company.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyEntity))! as CompanyEntity);
          break;
        case 'origCompany':
          result.origCompany.replace(serializers.deserialize(value,
              specifiedType: const FullType(CompanyEntity))! as CompanyEntity);
          break;
        case 'client':
          result.client.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientEntity))! as ClientEntity);
          break;
        case 'origClient':
          result.origClient.replace(serializers.deserialize(value,
              specifiedType: const FullType(ClientEntity))! as ClientEntity);
          break;
        case 'group':
          result.group.replace(serializers.deserialize(value,
              specifiedType: const FullType(GroupEntity))! as GroupEntity);
          break;
        case 'origGroup':
          result.origGroup.replace(serializers.deserialize(value,
              specifiedType: const FullType(GroupEntity))! as GroupEntity);
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserEntity))! as UserEntity);
          break;
        case 'origUser':
          result.origUser.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserEntity))! as UserEntity);
          break;
        case 'entityType':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(EntityType))! as EntityType;
          break;
        case 'isChanged':
          result.isChanged = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'section':
          result.section = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'tabIndex':
          result.tabIndex = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'selectedTemplate':
          result.selectedTemplate = serializers.deserialize(value,
              specifiedType: const FullType(EmailTemplate))! as EmailTemplate;
          break;
        case 'filter':
          result.filter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'filterClearedAt':
          result.filterClearedAt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'showNewSettings':
          result.showNewSettings = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'showPdfPreview':
          result.showPdfPreview = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$SettingsUIState extends SettingsUIState {
  @override
  final CompanyEntity company;
  @override
  final CompanyEntity origCompany;
  @override
  final ClientEntity client;
  @override
  final ClientEntity origClient;
  @override
  final GroupEntity group;
  @override
  final GroupEntity origGroup;
  @override
  final UserEntity user;
  @override
  final UserEntity origUser;
  @override
  final EntityType entityType;
  @override
  final bool isChanged;
  @override
  final int updatedAt;
  @override
  final String section;
  @override
  final int tabIndex;
  @override
  final EmailTemplate selectedTemplate;
  @override
  final String? filter;
  @override
  final int filterClearedAt;
  @override
  final bool showNewSettings;
  @override
  final bool showPdfPreview;

  factory _$SettingsUIState([void Function(SettingsUIStateBuilder)? updates]) =>
      (new SettingsUIStateBuilder()..update(updates))._build();

  _$SettingsUIState._(
      {required this.company,
      required this.origCompany,
      required this.client,
      required this.origClient,
      required this.group,
      required this.origGroup,
      required this.user,
      required this.origUser,
      required this.entityType,
      required this.isChanged,
      required this.updatedAt,
      required this.section,
      required this.tabIndex,
      required this.selectedTemplate,
      this.filter,
      required this.filterClearedAt,
      required this.showNewSettings,
      required this.showPdfPreview})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        company, r'SettingsUIState', 'company');
    BuiltValueNullFieldError.checkNotNull(
        origCompany, r'SettingsUIState', 'origCompany');
    BuiltValueNullFieldError.checkNotNull(client, r'SettingsUIState', 'client');
    BuiltValueNullFieldError.checkNotNull(
        origClient, r'SettingsUIState', 'origClient');
    BuiltValueNullFieldError.checkNotNull(group, r'SettingsUIState', 'group');
    BuiltValueNullFieldError.checkNotNull(
        origGroup, r'SettingsUIState', 'origGroup');
    BuiltValueNullFieldError.checkNotNull(user, r'SettingsUIState', 'user');
    BuiltValueNullFieldError.checkNotNull(
        origUser, r'SettingsUIState', 'origUser');
    BuiltValueNullFieldError.checkNotNull(
        entityType, r'SettingsUIState', 'entityType');
    BuiltValueNullFieldError.checkNotNull(
        isChanged, r'SettingsUIState', 'isChanged');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'SettingsUIState', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        section, r'SettingsUIState', 'section');
    BuiltValueNullFieldError.checkNotNull(
        tabIndex, r'SettingsUIState', 'tabIndex');
    BuiltValueNullFieldError.checkNotNull(
        selectedTemplate, r'SettingsUIState', 'selectedTemplate');
    BuiltValueNullFieldError.checkNotNull(
        filterClearedAt, r'SettingsUIState', 'filterClearedAt');
    BuiltValueNullFieldError.checkNotNull(
        showNewSettings, r'SettingsUIState', 'showNewSettings');
    BuiltValueNullFieldError.checkNotNull(
        showPdfPreview, r'SettingsUIState', 'showPdfPreview');
  }

  @override
  SettingsUIState rebuild(void Function(SettingsUIStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsUIStateBuilder toBuilder() =>
      new SettingsUIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsUIState &&
        company == other.company &&
        origCompany == other.origCompany &&
        client == other.client &&
        origClient == other.origClient &&
        group == other.group &&
        origGroup == other.origGroup &&
        user == other.user &&
        origUser == other.origUser &&
        entityType == other.entityType &&
        isChanged == other.isChanged &&
        updatedAt == other.updatedAt &&
        section == other.section &&
        tabIndex == other.tabIndex &&
        selectedTemplate == other.selectedTemplate &&
        filter == other.filter &&
        filterClearedAt == other.filterClearedAt &&
        showNewSettings == other.showNewSettings &&
        showPdfPreview == other.showPdfPreview;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, company.hashCode);
    _$hash = $jc(_$hash, origCompany.hashCode);
    _$hash = $jc(_$hash, client.hashCode);
    _$hash = $jc(_$hash, origClient.hashCode);
    _$hash = $jc(_$hash, group.hashCode);
    _$hash = $jc(_$hash, origGroup.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, origUser.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, isChanged.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, section.hashCode);
    _$hash = $jc(_$hash, tabIndex.hashCode);
    _$hash = $jc(_$hash, selectedTemplate.hashCode);
    _$hash = $jc(_$hash, filter.hashCode);
    _$hash = $jc(_$hash, filterClearedAt.hashCode);
    _$hash = $jc(_$hash, showNewSettings.hashCode);
    _$hash = $jc(_$hash, showPdfPreview.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SettingsUIState')
          ..add('company', company)
          ..add('origCompany', origCompany)
          ..add('client', client)
          ..add('origClient', origClient)
          ..add('group', group)
          ..add('origGroup', origGroup)
          ..add('user', user)
          ..add('origUser', origUser)
          ..add('entityType', entityType)
          ..add('isChanged', isChanged)
          ..add('updatedAt', updatedAt)
          ..add('section', section)
          ..add('tabIndex', tabIndex)
          ..add('selectedTemplate', selectedTemplate)
          ..add('filter', filter)
          ..add('filterClearedAt', filterClearedAt)
          ..add('showNewSettings', showNewSettings)
          ..add('showPdfPreview', showPdfPreview))
        .toString();
  }
}

class SettingsUIStateBuilder
    implements Builder<SettingsUIState, SettingsUIStateBuilder> {
  _$SettingsUIState? _$v;

  CompanyEntityBuilder? _company;
  CompanyEntityBuilder get company =>
      _$this._company ??= new CompanyEntityBuilder();
  set company(CompanyEntityBuilder? company) => _$this._company = company;

  CompanyEntityBuilder? _origCompany;
  CompanyEntityBuilder get origCompany =>
      _$this._origCompany ??= new CompanyEntityBuilder();
  set origCompany(CompanyEntityBuilder? origCompany) =>
      _$this._origCompany = origCompany;

  ClientEntityBuilder? _client;
  ClientEntityBuilder get client =>
      _$this._client ??= new ClientEntityBuilder();
  set client(ClientEntityBuilder? client) => _$this._client = client;

  ClientEntityBuilder? _origClient;
  ClientEntityBuilder get origClient =>
      _$this._origClient ??= new ClientEntityBuilder();
  set origClient(ClientEntityBuilder? origClient) =>
      _$this._origClient = origClient;

  GroupEntityBuilder? _group;
  GroupEntityBuilder get group => _$this._group ??= new GroupEntityBuilder();
  set group(GroupEntityBuilder? group) => _$this._group = group;

  GroupEntityBuilder? _origGroup;
  GroupEntityBuilder get origGroup =>
      _$this._origGroup ??= new GroupEntityBuilder();
  set origGroup(GroupEntityBuilder? origGroup) => _$this._origGroup = origGroup;

  UserEntityBuilder? _user;
  UserEntityBuilder get user => _$this._user ??= new UserEntityBuilder();
  set user(UserEntityBuilder? user) => _$this._user = user;

  UserEntityBuilder? _origUser;
  UserEntityBuilder get origUser =>
      _$this._origUser ??= new UserEntityBuilder();
  set origUser(UserEntityBuilder? origUser) => _$this._origUser = origUser;

  EntityType? _entityType;
  EntityType? get entityType => _$this._entityType;
  set entityType(EntityType? entityType) => _$this._entityType = entityType;

  bool? _isChanged;
  bool? get isChanged => _$this._isChanged;
  set isChanged(bool? isChanged) => _$this._isChanged = isChanged;

  int? _updatedAt;
  int? get updatedAt => _$this._updatedAt;
  set updatedAt(int? updatedAt) => _$this._updatedAt = updatedAt;

  String? _section;
  String? get section => _$this._section;
  set section(String? section) => _$this._section = section;

  int? _tabIndex;
  int? get tabIndex => _$this._tabIndex;
  set tabIndex(int? tabIndex) => _$this._tabIndex = tabIndex;

  EmailTemplate? _selectedTemplate;
  EmailTemplate? get selectedTemplate => _$this._selectedTemplate;
  set selectedTemplate(EmailTemplate? selectedTemplate) =>
      _$this._selectedTemplate = selectedTemplate;

  String? _filter;
  String? get filter => _$this._filter;
  set filter(String? filter) => _$this._filter = filter;

  int? _filterClearedAt;
  int? get filterClearedAt => _$this._filterClearedAt;
  set filterClearedAt(int? filterClearedAt) =>
      _$this._filterClearedAt = filterClearedAt;

  bool? _showNewSettings;
  bool? get showNewSettings => _$this._showNewSettings;
  set showNewSettings(bool? showNewSettings) =>
      _$this._showNewSettings = showNewSettings;

  bool? _showPdfPreview;
  bool? get showPdfPreview => _$this._showPdfPreview;
  set showPdfPreview(bool? showPdfPreview) =>
      _$this._showPdfPreview = showPdfPreview;

  SettingsUIStateBuilder() {
    SettingsUIState._initializeBuilder(this);
  }

  SettingsUIStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _company = $v.company.toBuilder();
      _origCompany = $v.origCompany.toBuilder();
      _client = $v.client.toBuilder();
      _origClient = $v.origClient.toBuilder();
      _group = $v.group.toBuilder();
      _origGroup = $v.origGroup.toBuilder();
      _user = $v.user.toBuilder();
      _origUser = $v.origUser.toBuilder();
      _entityType = $v.entityType;
      _isChanged = $v.isChanged;
      _updatedAt = $v.updatedAt;
      _section = $v.section;
      _tabIndex = $v.tabIndex;
      _selectedTemplate = $v.selectedTemplate;
      _filter = $v.filter;
      _filterClearedAt = $v.filterClearedAt;
      _showNewSettings = $v.showNewSettings;
      _showPdfPreview = $v.showPdfPreview;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsUIState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SettingsUIState;
  }

  @override
  void update(void Function(SettingsUIStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SettingsUIState build() => _build();

  _$SettingsUIState _build() {
    _$SettingsUIState _$result;
    try {
      _$result = _$v ??
          new _$SettingsUIState._(
              company: company.build(),
              origCompany: origCompany.build(),
              client: client.build(),
              origClient: origClient.build(),
              group: group.build(),
              origGroup: origGroup.build(),
              user: user.build(),
              origUser: origUser.build(),
              entityType: BuiltValueNullFieldError.checkNotNull(
                  entityType, r'SettingsUIState', 'entityType'),
              isChanged: BuiltValueNullFieldError.checkNotNull(
                  isChanged, r'SettingsUIState', 'isChanged'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(
                  updatedAt, r'SettingsUIState', 'updatedAt'),
              section: BuiltValueNullFieldError.checkNotNull(
                  section, r'SettingsUIState', 'section'),
              tabIndex: BuiltValueNullFieldError.checkNotNull(
                  tabIndex, r'SettingsUIState', 'tabIndex'),
              selectedTemplate: BuiltValueNullFieldError.checkNotNull(
                  selectedTemplate, r'SettingsUIState', 'selectedTemplate'),
              filter: filter,
              filterClearedAt: BuiltValueNullFieldError.checkNotNull(
                  filterClearedAt, r'SettingsUIState', 'filterClearedAt'),
              showNewSettings: BuiltValueNullFieldError.checkNotNull(
                  showNewSettings, r'SettingsUIState', 'showNewSettings'),
              showPdfPreview:
                  BuiltValueNullFieldError.checkNotNull(showPdfPreview, r'SettingsUIState', 'showPdfPreview'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'company';
        company.build();
        _$failedField = 'origCompany';
        origCompany.build();
        _$failedField = 'client';
        client.build();
        _$failedField = 'origClient';
        origClient.build();
        _$failedField = 'group';
        group.build();
        _$failedField = 'origGroup';
        origGroup.build();
        _$failedField = 'user';
        user.build();
        _$failedField = 'origUser';
        origUser.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SettingsUIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
