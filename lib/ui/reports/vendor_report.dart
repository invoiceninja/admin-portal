// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/data/models/group_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_selectors.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/money.dart';

enum VendorReportFields {
  id,
  name,
  website,
  currency,
  language,
  private_notes,
  public_notes,
  address1,
  address2,
  city,
  state,
  postal_code,
  phone,
  country,
  vendor1,
  vendor2,
  vendor3,
  vendor4,
  created_by,
  assigned_to,
  number,
  id_number,
  vat_number,
  contact_full_name,
  contact_first_name,
  contact_last_name,
  contact_email,
  contact_phone,
  contact1,
  contact2,
  contact3,
  contact4,
  is_active,
  created_at,
  updated_at,
  documents,
  last_login,
  classification,
  record_state,
  /*
  contact_last_login,
  shipping_address1,
  shipping_address2,
  shipping_city,
  shipping_state,
  shipping_postal_code,
  shipping_country,
  language,
  group,
  */
}

var memoizedVendorReport = memo6((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, GroupEntity> groupMap,
  StaticState staticState,
) =>
    vendorReport(userCompany!, reportsUIState, vendorMap, userMap, groupMap,
        staticState));

ReportResult vendorReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, GroupEntity> groupMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<VendorReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final vendorReportSettings = reportSettings.containsKey(kReportVendor)
      ? reportSettings[kReportVendor]!
      : ReportSettingsEntity();

  final defaultColumns = [
    VendorReportFields.name,
    VendorReportFields.contact_email,
    VendorReportFields.id_number,
    VendorReportFields.vat_number,
    VendorReportFields.currency,
    VendorReportFields.country,
    VendorReportFields.created_at,
  ];

  if (vendorReportSettings.columns.isNotEmpty) {
    columns = BuiltList(vendorReportSettings.columns
        .map((e) => EnumUtils.fromString(VendorReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var vendorId in vendorMap.keys) {
    final vendor = vendorMap[vendorId]!;
    final contact = vendor.primaryContact;
    if (vendor.isDeleted! && !userCompany.company.reportIncludeDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    final exchangeRate = getExchangeRate(staticState.currencyMap,
        fromCurrencyId: vendor.currencyId,
        toCurrencyId: userCompany.company.currencyId);

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case VendorReportFields.id:
          value = vendor.id;
          break;
        case VendorReportFields.name:
          value = vendor.name;
          break;
        /*
        case VendorReportFields.group:
          value = groupMap[vendor.groupId]?.name ?? '';
          break;
        */
        case VendorReportFields.website:
          value = vendor.website;
          break;
        case VendorReportFields.currency:
          value =
              staticState.currencyMap[vendor.currencyId]?.listDisplayName ?? '';
          break;
        case VendorReportFields.language:
          value =
              staticState.languageMap[vendor.languageId]?.listDisplayName ?? '';
          break;
        /*
        case VendorReportFields.language:
          value =
              staticState.languageMap[vendor.languageId]?.listDisplayName ?? '';
          break;
          */
        case VendorReportFields.private_notes:
          value = vendor.privateNotes;
          break;
        case VendorReportFields.public_notes:
          value = vendor.publicNotes;
          break;
        case VendorReportFields.vendor1:
          value = presentCustomField(
            value: vendor.customValue1,
            customFieldType: CustomFieldType.vendor1,
            company: userCompany.company,
          );
          break;
        case VendorReportFields.vendor2:
          value = presentCustomField(
            value: vendor.customValue2,
            customFieldType: CustomFieldType.vendor2,
            company: userCompany.company,
          );
          break;
        case VendorReportFields.vendor3:
          value = presentCustomField(
            value: vendor.customValue3,
            customFieldType: CustomFieldType.vendor3,
            company: userCompany.company,
          );
          break;
        case VendorReportFields.vendor4:
          value = presentCustomField(
            value: vendor.customValue4,
            customFieldType: CustomFieldType.vendor4,
            company: userCompany.company,
          );
          break;
        case VendorReportFields.address1:
          value = vendor.address1;
          break;
        case VendorReportFields.address2:
          value = vendor.address2;
          break;
        case VendorReportFields.city:
          value = vendor.city;
          break;
        case VendorReportFields.state:
          value = vendor.state;
          break;
        case VendorReportFields.postal_code:
          value = vendor.postalCode;
          break;
        case VendorReportFields.country:
          value =
              staticState.countryMap[vendor.countryId]?.listDisplayName ?? '';
          break;
        /*
        case VendorReportFields.shipping_address1:
          value = vendor.shippingAddress1;
          break;
        case VendorReportFields.shipping_address2:
          value = vendor.shippingAddress2;
          break;
        case VendorReportFields.shipping_city:
          value = vendor.shippingCity;
          break;
        case VendorReportFields.shipping_state:
          value = vendor.shippingState;
          break;
        case VendorReportFields.shipping_postal_code:
          value = vendor.shippingPostalCode;
          break;
        case VendorReportFields.shipping_country:
          value = staticState
                  .countryMap[vendor.shippingCountryId]?.listDisplayName ??
              '';
          break;
          */
        case VendorReportFields.phone:
          value = vendor.phone;
          break;
        case VendorReportFields.number:
          value = vendor.number;
          break;
        case VendorReportFields.id_number:
          value = vendor.idNumber;
          break;
        case VendorReportFields.vat_number:
          value = vendor.vatNumber;
          break;
        case VendorReportFields.assigned_to:
          value = userMap[vendor.assignedUserId]?.listDisplayName ?? '';
          break;
        case VendorReportFields.created_by:
          value = userMap[vendor.createdUserId]?.listDisplayName ?? '';
          break;
        case VendorReportFields.contact_full_name:
          value = contact.fullName;
          break;
        case VendorReportFields.contact_first_name:
          value = contact.firstName;
          break;
        case VendorReportFields.contact_last_name:
          value = contact.lastName;
          break;
        case VendorReportFields.contact_email:
          value = contact.email;
          break;
        case VendorReportFields.contact_phone:
          value = contact.phone;
          break;

        case VendorReportFields.contact1:
          value = presentCustomField(
            value: contact.customValue1,
            customFieldType: CustomFieldType.vendorContact1,
            company: userCompany.company,
          );
          break;
        case VendorReportFields.contact2:
          value = presentCustomField(
            value: contact.customValue2,
            customFieldType: CustomFieldType.vendorContact2,
            company: userCompany.company,
          );
          break;
        case VendorReportFields.contact3:
          value = presentCustomField(
            value: contact.customValue3,
            customFieldType: CustomFieldType.vendorContact3,
            company: userCompany.company,
          );
          break;
        case VendorReportFields.contact4:
          value = presentCustomField(
            value: contact.customValue4,
            customFieldType: CustomFieldType.vendorContact4,
            company: userCompany.company,
          );
          break;
        case VendorReportFields.last_login:
          value = convertTimestampToDateString(vendor.lastLogin);
          break;
        /*
        case VendorReportFields.contact_last_login:
          value = convertTimestampToDateString(contact.lastLogin);
          break;
          */
        case VendorReportFields.is_active:
          value = vendor.isActive;
          break;
        case VendorReportFields.updated_at:
          value = convertTimestampToDateString(vendor.updatedAt);
          break;
        case VendorReportFields.created_at:
          value = convertTimestampToDateString(vendor.createdAt);
          break;
        case VendorReportFields.documents:
          value = vendor.documents.length;
          break;
        case VendorReportFields.classification:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(vendor.classification);
          break;
        case VendorReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(vendor.entityState);
          break;
      }

      if (!ReportResult.matchField(
        value: value,
        userCompany: userCompany,
        reportsUIState: reportsUIState,
        column: EnumUtils.parse(column),
      )!) {
        skip = true;
      }

      if (value.runtimeType == bool) {
        row.add(vendor.getReportBool(value: value));
      } else if (column == VendorReportFields.documents) {
        row.add(vendor.getReportInt(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(vendor.getReportDouble(
          value: value,
          currencyId: vendor.currencyId,
          exchangeRate: exchangeRate,
        ));
      } else {
        row.add(vendor.getReportString(value: '$value'));
      }
    }

    if (!skip) {
      data.add(row);
      entities.add(vendor);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, vendorReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        VendorReportFields.values.map((item) => EnumUtils.parse(item)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
