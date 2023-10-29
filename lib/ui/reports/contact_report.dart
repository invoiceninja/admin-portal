// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
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

enum ContactReportFields {
  id,
  name,
  website,
  currency,
  language,
  private_notes,
  public_notes,
  industry,
  size,
  address1,
  address2,
  city,
  state,
  postal_code,
  phone,
  country,
  shipping_address1,
  shipping_address2,
  shipping_city,
  shipping_state,
  shipping_postal_code,
  shipping_country,
  client1,
  client2,
  client3,
  client4,
  created_by,
  assigned_to,
  balance,
  credit_balance,
  paid_to_date,
  total,
  converted_balance,
  converted_credit_balance,
  converted_paid_to_date,
  converted_total,
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
  contact_last_login,
  is_active,
  created_at,
  updated_at,
  record_state,
}

var memoizedContactReport = memo5((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    contactReport(
        userCompany!, reportsUIState, clientMap, userMap, staticState));

ReportResult contactReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<ContactReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final clientReportSettings = reportSettings.containsKey(kReportClientContact)
      ? reportSettings[kReportClientContact]!
      : ReportSettingsEntity();

  final defaultColumns = [
    ContactReportFields.name,
    ContactReportFields.contact_email,
    ContactReportFields.id_number,
    ContactReportFields.vat_number,
    ContactReportFields.currency,
    ContactReportFields.balance,
    ContactReportFields.paid_to_date,
    ContactReportFields.country,
    ContactReportFields.created_at,
  ];

  if (clientReportSettings.columns.isNotEmpty) {
    columns = BuiltList(clientReportSettings.columns
        .map((e) => EnumUtils.fromString(ContactReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var clientId in clientMap.keys) {
    final client = clientMap[clientId]!;
    if (client.isDeleted! && !userCompany.company.reportIncludeDeleted) {
      continue;
    }

    for (var contact in client.contacts) {
      bool skip = false;
      final List<ReportElement> row = [];

      final exchangeRate = getExchangeRate(staticState.currencyMap,
          fromCurrencyId: client.currencyId,
          toCurrencyId: userCompany.company.currencyId);

      for (var column in columns) {
        dynamic value = '';

        switch (column) {
          case ContactReportFields.id:
            value = contact.id;
            break;
          case ContactReportFields.name:
            value = client.displayName;
            break;
          case ContactReportFields.website:
            value = client.website;
            break;
          case ContactReportFields.currency:
            value =
                staticState.currencyMap[client.currencyId]?.listDisplayName ??
                    '';
            break;
          case ContactReportFields.language:
            value =
                staticState.languageMap[client.languageId]?.listDisplayName ??
                    '';
            break;
          case ContactReportFields.private_notes:
            value = client.privateNotes;
            break;
          case ContactReportFields.public_notes:
            value = client.publicNotes;
            break;
          case ContactReportFields.industry:
            value =
                staticState.industryMap[client.industryId]?.listDisplayName ??
                    '';
            break;
          case ContactReportFields.size:
            value = staticState.sizeMap[client.sizeId]?.listDisplayName ?? '';
            break;
          case ContactReportFields.client1:
            value = presentCustomField(
              value: client.customValue1,
              customFieldType: CustomFieldType.client1,
              company: userCompany.company,
            );
            break;
          case ContactReportFields.client2:
            value = presentCustomField(
              value: client.customValue2,
              customFieldType: CustomFieldType.client2,
              company: userCompany.company,
            );
            break;
          case ContactReportFields.client3:
            value = presentCustomField(
              value: client.customValue3,
              customFieldType: CustomFieldType.client3,
              company: userCompany.company,
            );
            break;
          case ContactReportFields.client4:
            value = presentCustomField(
              value: client.customValue4,
              customFieldType: CustomFieldType.client4,
              company: userCompany.company,
            );
            break;
          case ContactReportFields.address1:
            value = client.address1;
            break;
          case ContactReportFields.address2:
            value = client.address2;
            break;
          case ContactReportFields.city:
            value = client.city;
            break;
          case ContactReportFields.state:
            value = client.state;
            break;
          case ContactReportFields.postal_code:
            value = client.postalCode;
            break;
          case ContactReportFields.country:
            value =
                staticState.countryMap[client.countryId]?.listDisplayName ?? '';
            break;
          case ContactReportFields.shipping_address1:
            value = client.shippingAddress1;
            break;
          case ContactReportFields.shipping_address2:
            value = client.shippingAddress2;
            break;
          case ContactReportFields.shipping_city:
            value = client.shippingCity;
            break;
          case ContactReportFields.shipping_state:
            value = client.shippingState;
            break;
          case ContactReportFields.shipping_postal_code:
            value = client.shippingPostalCode;
            break;
          case ContactReportFields.shipping_country:
            value = staticState
                    .countryMap[client.shippingCountryId]?.listDisplayName ??
                '';
            break;
          case ContactReportFields.phone:
            value = client.phone;
            break;
          case ContactReportFields.number:
            value = client.number;
            break;
          case ContactReportFields.id_number:
            value = client.idNumber;
            break;
          case ContactReportFields.vat_number:
            value = client.vatNumber;
            break;
          case ContactReportFields.assigned_to:
            value = userMap[client.assignedUserId]?.listDisplayName ?? '';
            break;
          case ContactReportFields.created_by:
            value = userMap[client.createdUserId]?.listDisplayName ?? '';
            break;
          case ContactReportFields.contact_full_name:
            value = contact.fullName;
            break;
          case ContactReportFields.contact_first_name:
            value = contact.firstName;
            break;
          case ContactReportFields.contact_last_name:
            value = contact.lastName;
            break;
          case ContactReportFields.contact_email:
            value = contact.email;
            break;
          case ContactReportFields.contact_phone:
            value = contact.phone;
            break;
          case ContactReportFields.contact1:
            value = presentCustomField(
              value: contact.customValue1,
              customFieldType: CustomFieldType.contact1,
              company: userCompany.company,
            );
            break;
          case ContactReportFields.contact2:
            value = presentCustomField(
              value: contact.customValue2,
              customFieldType: CustomFieldType.contact2,
              company: userCompany.company,
            );
            break;
          case ContactReportFields.contact3:
            value = presentCustomField(
              value: contact.customValue3,
              customFieldType: CustomFieldType.contact3,
              company: userCompany.company,
            );
            break;
          case ContactReportFields.contact4:
            value = presentCustomField(
              value: contact.customValue4,
              customFieldType: CustomFieldType.contact4,
              company: userCompany.company,
            );
            break;
          case ContactReportFields.contact_last_login:
            value = convertTimestampToDateString(contact.lastLogin);
            break;
          case ContactReportFields.total:
            value =
                contact.isPrimary ? (client.balance + client.paidToDate) : 0.0;
            break;
          case ContactReportFields.balance:
            value = contact.isPrimary ? client.balance : 0.0;
            break;
          case ContactReportFields.credit_balance:
            value = contact.isPrimary ? client.creditBalance : 0.0;
            break;
          case ContactReportFields.paid_to_date:
            value = contact.isPrimary ? client.paidToDate : 0.0;
            break;
          case ContactReportFields.converted_total:
            value = contact.isPrimary
                ? round((client.balance + client.paidToDate) * exchangeRate, 2)
                : 0.0;
            break;
          case ContactReportFields.converted_balance:
            value = contact.isPrimary
                ? round(client.balance * exchangeRate, 2)
                : 0.0;
            break;
          case ContactReportFields.converted_credit_balance:
            value = contact.isPrimary
                ? round(client.creditBalance * exchangeRate, 2)
                : 0.0;
            break;
          case ContactReportFields.converted_paid_to_date:
            value = contact.isPrimary
                ? round(client.paidToDate * exchangeRate, 2)
                : 0.0;
            break;
          case ContactReportFields.is_active:
            value = client.isActive;
            break;
          case ContactReportFields.updated_at:
            value = convertTimestampToDateString(client.updatedAt);
            break;
          case ContactReportFields.created_at:
            value = convertTimestampToDateString(client.createdAt);
            break;
          case ContactReportFields.record_state:
            value = AppLocalization.of(navigatorKey.currentContext!)!
                .lookup(client.entityState);
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
          row.add(client.getReportBool(value: value));
        } else if (value.runtimeType == double || value.runtimeType == int) {
          String? currencyId = client.currencyId;
          if ([
            ContactReportFields.converted_balance,
            ContactReportFields.converted_credit_balance,
            ContactReportFields.converted_paid_to_date,
            ContactReportFields.converted_total,
          ].contains(column)) {
            currencyId = userCompany.company.currencyId;
          }
          row.add(client.getReportDouble(
            value: value,
            currencyId: currencyId,
            exchangeRate: exchangeRate,
          ));
        } else {
          row.add(client.getReportString(value: '$value'));
        }
      }

      if (!skip) {
        data.add(row);
      }
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, clientReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns: ContactReportFields.values
        .map((item) => EnumUtils.parse(item))
        .toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
