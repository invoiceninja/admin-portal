import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
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

    final List<ReportElement> row = [];
    data.add(row);

    for (var column in columns) {
      switch (column) {
        case ClientFields.name:
          row.add(ReportValue(value: client.name));
          break;
        case ClientFields.idNumber:
          row.add(ReportValue(value: client.idNumber));
          break;
        case ClientFields.vatNumber:
          row.add(ReportValue(value: client.vatNumber));
          break;
        case ClientFields.state:
          row.add(ReportValue(value: client.state));
          break;
      }
    }
  }

  data.sort((rowA, rowB) {
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
    ],
    columns: columns.toList(),
    data: data,
  );
}
