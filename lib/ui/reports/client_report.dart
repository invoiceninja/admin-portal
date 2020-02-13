import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/dates.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:memoize/memoize.dart';

class ClientReportFields {
  static const String name = 'name';
  static const String website = 'website';
  static const String privateNotes = 'private_notes';
  static const String publicNotes = 'public_notes';
  static const String industry = 'industry';
  static const String size = 'size';
  static const String address1 = 'address1';
  static const String address2 = 'address2';
  static const String city = 'city';
  static const String state = 'state';
  static const String postCode = 'postal_code';
  static const String phone = 'phone';
  static const String country = 'country';
  static const String shippingAddress1 = 'shipping_address1';
  static const String shippingAddress2 = 'shipping_address2';
  static const String shippingCity = 'shipping_city';
  static const String shippingState = 'shipping_state';
  static const String shippingPostalCode = 'shipping_postal_code';
  static const String shippingCountry = 'shipping_country';
  static const String customValue1 = 'custom_value1';
  static const String customValue2 = 'custom_value2';
  static const String customValue3 = 'custom_value3';
  static const String customValue4 = 'custom_value4';
  static const String createdBy = 'created_by';
  static const String assignedTo = 'assigned_to';
  static const String balance = 'balance';
  static const String creditBalance = 'credit_balance';
  static const String paidToDate = 'paid_to_date';
  static const String idNumber = 'id_number';
  static const String vatNumber = 'vat_number';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String contactFirstName = 'contact_first_name';
  static const String contactLastName = 'contact_last_name';
  static const String contactEmail = 'contact_email';
  static const String contactPhone = 'contact_phone';
  static const String contactCustomValue1 = 'contact_custom_value1';
  static const String contactCustomValue2 = 'contact_custom_value2';
  static const String contactCustomValue3 = 'contact_custom_value3';
  static const String contactCustomValue4 = 'contact_custom_value4';
  static const String contactLastLogin = 'contact_last_login';
}

var memoizedClientReport = memo3((UserCompanyEntity userCompany,
        ReportsUIState reportsUIState,
        BuiltMap<String, ClientEntity> clientMap) =>
    clientReport(userCompany, reportsUIState, clientMap));

ReportResult clientReport(UserCompanyEntity userCompany,
    ReportsUIState reportsUIState, BuiltMap<String, ClientEntity> clientMap) {
  final List<List<ReportElement>> data = [];
  BuiltList<String> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final clientReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportClient)
          ? reportSettings[kReportClient]
          : ReportSettingsEntity();

  if (clientReportSettings.columns.isNotEmpty) {
    columns = clientReportSettings.columns;
  } else {
    columns = BuiltList(<String>[
      ClientReportFields.name,
      ClientReportFields.idNumber,
    ]);
  }

  for (var clientId in clientMap.keys) {
    final client = clientMap[clientId];
    final contact = client.primaryContact;
    if (client.isDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      String value = '';
      double amount;

      switch (column) {
        case ClientReportFields.name:
          value = client.name;
          break;
        case ClientReportFields.website:
          value = client.website;
          break;
        case ClientReportFields.privateNotes:
          value = client.privateNotes;
          break;
        case ClientReportFields.publicNotes:
          value = client.publicNotes;
          break;
        case ClientReportFields.idNumber:
          value = client.idNumber;
          break;
        case ClientReportFields.vatNumber:
          value = client.vatNumber;
          break;
        case ClientReportFields.state:
          value = client.state;
          break;
        case ClientReportFields.createdAt:
          value = convertTimestampToDateString(client.createdAt);
          break;
        case ClientReportFields.assignedTo:
          value = userCompany
                  .company.userMap[client.assignedUserId]?.listDisplayName ??
              '';
          break;
        case ClientReportFields.createdBy:
          value = userCompany
                  .company.userMap[client.createdUserId]?.listDisplayName ??
              '';
          break;
        case ClientReportFields.updatedAt:
          value = convertTimestampToDateString(client.updatedAt);
          break;
        case ClientReportFields.contactLastLogin:
          value = convertTimestampToDateString(contact.lastLogin);
          break;
        case ClientReportFields.balance:
          amount = client.balance;
          break;
        case ClientReportFields.paidToDate:
          amount = client.paidToDate;
          break;
      }

      if (reportsUIState.filters.containsKey(column)) {
        final filter = reportsUIState.filters[column];
        if (filter.isNotEmpty) {
          if (getReportColumnType(column) == ReportColumnType.number) {
            final String range = filter.replaceAll(',', '-') + '-';
            final List<String> parts = range.split('-');
            final min = parseDouble(parts[0]);
            final max = parseDouble(parts[1]);
            if (amount < min || (max > 0 && amount > max)) {
              skip = true;
            }
          } else if (getReportColumnType(column) == ReportColumnType.dateTime) {
            final startDate = calculateStartDate(
              dateRange: DateRange.valueOf(filter),
              company: userCompany.company,
              customStartDate: reportsUIState.customStartDate,
              customEndDate: reportsUIState.customEndDate,
            );
            final endDate = calculateEndDate(
              dateRange: DateRange.valueOf(filter),
              company: userCompany.company,
              customStartDate: reportsUIState.customStartDate,
              customEndDate: reportsUIState.customEndDate,
            );
            if (reportsUIState.customStartDate.isNotEmpty &&
                reportsUIState.customEndDate.isNotEmpty) {
              if (!(startDate.compareTo(value) <= 0 &&
                  endDate.compareTo(value) >= 0)) {
                skip = true;
              }
            } else if (reportsUIState.customStartDate.isNotEmpty) {
              if (!(startDate.compareTo(value) <= 0)) {
                skip = true;
              }
            } else if (reportsUIState.customEndDate.isNotEmpty) {
              if (!(endDate.compareTo(value) >= 0)) {
                skip = true;
              }
            }
          } else if (!value.toLowerCase().contains(filter.toLowerCase())) {
            skip = true;
          }
        }
      }

      if (amount != null) {
        row.add(client.getReportAmount(value: amount));
      } else {
        row.add(client.getReportValue(value: value));
      }
    }

    if (!skip) {
      data.add(row);
    }
  }

  data.sort((rowA, rowB) {
    if (rowA.length <= clientReportSettings.sortIndex ||
        rowB.length <= clientReportSettings.sortIndex) {
      return 0;
    }
    final valueA = rowA[clientReportSettings.sortIndex].sortString();
    final valueB = rowB[clientReportSettings.sortIndex].sortString();

    if (clientReportSettings.sortAscending) {
      return valueA.compareTo(valueB);
    } else {
      return valueB.compareTo(valueA);
    }
  });

  return ReportResult(
    allColumns: [
      ClientReportFields.name,
      ClientReportFields.website,
      ClientReportFields.privateNotes,
      ClientReportFields.publicNotes,
      ClientReportFields.industry,
      ClientReportFields.size,
      ClientReportFields.address1,
      ClientReportFields.address2,
      ClientReportFields.city,
      ClientReportFields.state,
      ClientReportFields.postCode,
      ClientReportFields.phone,
      ClientReportFields.country,
      ClientReportFields.shippingAddress1,
      ClientReportFields.shippingAddress2,
      ClientReportFields.shippingCity,
      ClientReportFields.shippingState,
      ClientReportFields.shippingPostalCode,
      ClientReportFields.shippingCountry,
      ClientReportFields.customValue1,
      ClientReportFields.customValue2,
      ClientReportFields.customValue3,
      ClientReportFields.customValue4,
      ClientReportFields.createdBy,
      ClientReportFields.assignedTo,
      ClientReportFields.balance,
      ClientReportFields.creditBalance,
      ClientReportFields.paidToDate,
      ClientReportFields.idNumber,
      ClientReportFields.vatNumber,
      ClientReportFields.createdAt,
      ClientReportFields.updatedAt,
      ClientReportFields.contactFirstName,
      ClientReportFields.contactLastName,
      ClientReportFields.contactEmail,
      ClientReportFields.contactPhone,
      ClientReportFields.contactCustomValue1,
      ClientReportFields.contactCustomValue2,
      ClientReportFields.contactCustomValue3,
      ClientReportFields.contactCustomValue4,
      ClientReportFields.contactLastLogin,
    ],
    columns: columns.toList(),
    data: data,
  );
}
