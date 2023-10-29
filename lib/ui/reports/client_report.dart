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

enum ClientReportFields {
  id,
  name,
  group,
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
  payment_balance,
  paid_to_date,
  total,
  converted_balance,
  converted_payment_balance,
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
  last_login,
  contact_last_login,
  is_active,
  created_at,
  updated_at,
  documents,
  routing_id,
  tax_exempt,
  classification,
  record_state,
}

var memoizedClientReport = memo6((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, GroupEntity> groupMap,
  StaticState staticState,
) =>
    clientReport(userCompany!, reportsUIState, clientMap, userMap, groupMap,
        staticState));

ReportResult clientReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, GroupEntity> groupMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<ClientReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final clientReportSettings = reportSettings.containsKey(kReportClient)
      ? reportSettings[kReportClient]!
      : ReportSettingsEntity();

  final defaultColumns = [
    ClientReportFields.name,
    ClientReportFields.contact_email,
    ClientReportFields.id_number,
    ClientReportFields.vat_number,
    ClientReportFields.currency,
    ClientReportFields.balance,
    ClientReportFields.paid_to_date,
    ClientReportFields.country,
    ClientReportFields.created_at,
  ];

  if (clientReportSettings.columns.isNotEmpty) {
    columns = BuiltList(clientReportSettings.columns
        .map((e) => EnumUtils.fromString(ClientReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var clientId in clientMap.keys) {
    final client = clientMap[clientId]!;
    final contact = client.primaryContact;
    if (client.isDeleted! && !userCompany.company.reportIncludeDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    final exchangeRate = getExchangeRate(staticState.currencyMap,
        fromCurrencyId: client.currencyId,
        toCurrencyId: userCompany.company.currencyId);

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case ClientReportFields.id:
          value = client.id;
          break;
        case ClientReportFields.name:
          value = client.displayName;
          break;
        case ClientReportFields.group:
          value = groupMap[client.groupId]?.name ?? '';
          break;
        case ClientReportFields.website:
          value = client.website;
          break;
        case ClientReportFields.currency:
          value =
              staticState.currencyMap[client.currencyId]?.listDisplayName ?? '';
          break;
        case ClientReportFields.language:
          value =
              staticState.languageMap[client.languageId]?.listDisplayName ?? '';
          break;
        case ClientReportFields.private_notes:
          value = client.privateNotes;
          break;
        case ClientReportFields.public_notes:
          value = client.publicNotes;
          break;
        case ClientReportFields.industry:
          value =
              staticState.industryMap[client.industryId]?.listDisplayName ?? '';
          break;
        case ClientReportFields.size:
          value = staticState.sizeMap[client.sizeId]?.listDisplayName ?? '';
          break;
        case ClientReportFields.client1:
          value = presentCustomField(
            value: client.customValue1,
            customFieldType: CustomFieldType.client1,
            company: userCompany.company,
          );
          break;
        case ClientReportFields.client2:
          value = presentCustomField(
            value: client.customValue2,
            customFieldType: CustomFieldType.client2,
            company: userCompany.company,
          );
          break;
        case ClientReportFields.client3:
          value = presentCustomField(
            value: client.customValue3,
            customFieldType: CustomFieldType.client3,
            company: userCompany.company,
          );
          break;
        case ClientReportFields.client4:
          value = presentCustomField(
            value: client.customValue4,
            customFieldType: CustomFieldType.client4,
            company: userCompany.company,
          );
          break;
        case ClientReportFields.address1:
          value = client.address1;
          break;
        case ClientReportFields.address2:
          value = client.address2;
          break;
        case ClientReportFields.city:
          value = client.city;
          break;
        case ClientReportFields.state:
          value = client.state;
          break;
        case ClientReportFields.postal_code:
          value = client.postalCode;
          break;
        case ClientReportFields.country:
          value =
              staticState.countryMap[client.countryId]?.listDisplayName ?? '';
          break;
        case ClientReportFields.shipping_address1:
          value = client.shippingAddress1;
          break;
        case ClientReportFields.shipping_address2:
          value = client.shippingAddress2;
          break;
        case ClientReportFields.shipping_city:
          value = client.shippingCity;
          break;
        case ClientReportFields.shipping_state:
          value = client.shippingState;
          break;
        case ClientReportFields.shipping_postal_code:
          value = client.shippingPostalCode;
          break;
        case ClientReportFields.shipping_country:
          value = staticState
                  .countryMap[client.shippingCountryId]?.listDisplayName ??
              '';
          break;
        case ClientReportFields.phone:
          value = client.phone;
          break;
        case ClientReportFields.number:
          value = client.number;
          break;
        case ClientReportFields.id_number:
          value = client.idNumber;
          break;
        case ClientReportFields.vat_number:
          value = client.vatNumber;
          break;
        case ClientReportFields.assigned_to:
          value = userMap[client.assignedUserId]?.listDisplayName ?? '';
          break;
        case ClientReportFields.created_by:
          value = userMap[client.createdUserId]?.listDisplayName ?? '';
          break;
        case ClientReportFields.contact_full_name:
          value = contact.fullName;
          break;
        case ClientReportFields.contact_first_name:
          value = contact.firstName;
          break;
        case ClientReportFields.contact_last_name:
          value = contact.lastName;
          break;
        case ClientReportFields.contact_email:
          value = contact.email;
          break;
        case ClientReportFields.contact_phone:
          value = contact.phone;
          break;
        case ClientReportFields.contact1:
          value = presentCustomField(
            value: contact.customValue1,
            customFieldType: CustomFieldType.contact1,
            company: userCompany.company,
          );
          break;
        case ClientReportFields.contact2:
          value = presentCustomField(
            value: contact.customValue2,
            customFieldType: CustomFieldType.contact2,
            company: userCompany.company,
          );
          break;
        case ClientReportFields.contact3:
          value = presentCustomField(
            value: contact.customValue3,
            customFieldType: CustomFieldType.contact3,
            company: userCompany.company,
          );
          break;
        case ClientReportFields.contact4:
          value = presentCustomField(
            value: contact.customValue4,
            customFieldType: CustomFieldType.contact4,
            company: userCompany.company,
          );
          break;
        case ClientReportFields.last_login:
          value = convertTimestampToDateString(client.lastLogin);
          break;
        case ClientReportFields.contact_last_login:
          value = convertTimestampToDateString(contact.lastLogin);
          break;
        case ClientReportFields.total:
          value = client.balance + client.paidToDate;
          break;
        case ClientReportFields.balance:
          value = client.balance;
          break;
        case ClientReportFields.credit_balance:
          value = client.creditBalance;
          break;
        case ClientReportFields.payment_balance:
          value = client.paymentBalance;
          break;
        case ClientReportFields.paid_to_date:
          value = client.paidToDate;
          break;
        case ClientReportFields.converted_total:
          value = round((client.balance + client.paidToDate) * exchangeRate, 2);
          break;
        case ClientReportFields.converted_balance:
          value = round(client.balance * exchangeRate, 2);
          break;
        case ClientReportFields.converted_credit_balance:
          value = round(client.creditBalance * exchangeRate, 2);
          break;
        case ClientReportFields.converted_payment_balance:
          value = round(client.paymentBalance * exchangeRate, 2);
          break;
        case ClientReportFields.converted_paid_to_date:
          value = round(client.paidToDate * exchangeRate, 2);
          break;
        case ClientReportFields.is_active:
          value = client.isActive;
          break;
        case ClientReportFields.updated_at:
          value = convertTimestampToDateString(client.updatedAt);
          break;
        case ClientReportFields.created_at:
          value = convertTimestampToDateString(client.createdAt);
          break;
        case ClientReportFields.documents:
          value = client.documents.length;
          break;
        case ClientReportFields.routing_id:
          value = client.routingId;
          break;
        case ClientReportFields.tax_exempt:
          value = client.isTaxExempt;
          break;
        case ClientReportFields.classification:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(client.classification);
          break;
        case ClientReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(client.entityState);
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
      } else if (column == ClientReportFields.documents) {
        row.add(client.getReportInt(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        String? currencyId = client.currencyId;
        if ([
          ClientReportFields.converted_balance,
          ClientReportFields.converted_credit_balance,
          ClientReportFields.converted_paid_to_date,
          ClientReportFields.converted_total,
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
      entities.add(client);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, clientReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        ClientReportFields.values.map((item) => EnumUtils.parse(item)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
