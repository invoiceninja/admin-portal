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
      ClientFields.name,
    ]);
  }

  for (var clientId in clientMap.keys) {
    final client = clientMap[clientId];
    if (client.isDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      String value = '';
      double amount;

      switch (column) {
        case ClientFields.name:
          value = client.name;
          break;
        case ClientFields.idNumber:
          value = client.idNumber;
          break;
        case ClientFields.vatNumber:
          value = client.vatNumber;
          break;
        case ClientFields.state:
          value = client.state;
          break;
        case ClientFields.createdAt:
          value = convertTimestampToDateString(client.createdAt);
          break;
        case ClientFields.assignedTo:
          value = userCompany
                  .company.userMap[client.assignedUserId]?.listDisplayName ??
              '';
          break;
        case ClientFields.assignedToId:
          value = client.assignedUserId;
          break;
        case ClientFields.createdBy:
          value = userCompany
                  .company.userMap[client.createdUserId]?.listDisplayName ??
              '';
          break;
        case ClientFields.createdById:
          value = client.createdUserId;
          break;
        case ClientFields.updatedAt:
          value = convertTimestampToDateString(client.updatedAt);
          break;
        case ClientFields.balance:
          amount = client.balance;
          break;
        case ClientFields.paidToDate:
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
      ClientFields.name,
      ClientFields.createdBy,
      ClientFields.assignedTo,
      ClientFields.balance,
      ClientFields.paidToDate,
      ClientFields.idNumber,
      ClientFields.vatNumber,
      ClientFields.state,
      ClientFields.createdAt,
      ClientFields.updatedAt,
      ClientFields.clientId,
      ClientFields.assignedToId,
      ClientFields.createdById,
    ],
    columns: columns.toList(),
    data: data,
  );
}
