import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
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
          : null;

  if (clientReportSettings != null) {
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
        case ClientFields.updatedAt:
          value = convertTimestampToDateString(client.updatedAt);
          break;
      }

      if (reportsUIState.filters.containsKey(column)) {
        final filter = reportsUIState.filters[column];
        if (filter.isNotEmpty &&
            !value.toLowerCase().contains(filter.toLowerCase())) {
          print('## Not matching $column filter: $filter');
          skip = true;
        }
      }

      row.add(client.getReportValue(value: value));
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
      ClientFields.idNumber,
      ClientFields.vatNumber,
      ClientFields.state,
      ClientFields.createdAt,
      ClientFields.updatedAt,
    ],
    columns: columns.toList(),
    data: data,
  );
}

