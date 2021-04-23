import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/money.dart';
import 'package:memoize/memoize.dart';

enum ClientReportFields {
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
}

var memoizedClientReport = memo5((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    clientReport(userCompany, reportsUIState, clientMap, userMap, staticState));

ReportResult clientReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<ClientReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final clientReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportClient)
          ? reportSettings[kReportClient]
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
  ];

  if (clientReportSettings.columns.isNotEmpty) {
    columns = BuiltList(clientReportSettings.columns
        .map((e) => EnumUtils.fromString(ClientReportFields.values, e))
        .where((element) => element != null)
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var clientId in clientMap.keys) {
    final client = clientMap[clientId];
    final contact = client.primaryContact;
    if (client.isDeleted) {
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
        case ClientReportFields.name:
          value = client.displayName;
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
          value = client.customValue1;
          break;
        case ClientReportFields.client2:
          value = client.customValue2;
          break;
        case ClientReportFields.client3:
          value = client.customValue3;
          break;
        case ClientReportFields.client4:
          value = client.customValue4;
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
          value = contact.customValue1;
          break;
        case ClientReportFields.contact2:
          value = contact.customValue2;
          break;
        case ClientReportFields.contact3:
          value = contact.customValue3;
          break;
        case ClientReportFields.contact4:
          value = contact.customValue4;
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
        case ClientReportFields.paid_to_date:
          value = client.paidToDate;
          break;
        case ClientReportFields.converted_total:
          value = (client.balance + client.paidToDate) * exchangeRate;
          break;
        case ClientReportFields.converted_balance:
          value = client.balance * exchangeRate;
          break;
        case ClientReportFields.converted_credit_balance:
          value = client.creditBalance * exchangeRate;
          break;
        case ClientReportFields.converted_paid_to_date:
          value = client.paidToDate * exchangeRate;
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
      }

      if (!ReportResult.matchField(
        value: value,
        userCompany: userCompany,
        reportsUIState: reportsUIState,
        column: EnumUtils.parse(column),
      )) {
        skip = true;
      }

      if (value.runtimeType == bool) {
        row.add(client.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        String currencyId = client.currencyId;
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
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, clientReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        ClientReportFields.values.map((item) => EnumUtils.parse(item)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
