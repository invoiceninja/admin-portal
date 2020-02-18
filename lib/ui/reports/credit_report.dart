import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/credit_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:memoize/memoize.dart';

enum CreditReportFields {
  amount,
  balance,
  credit_date,
  credit_number,
  client,
}

var memoizedCreditReport = memo6((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, CreditEntity> creditMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    creditReport(userCompany, reportsUIState, creditMap, clientMap, userMap,
        staticState));

ReportResult creditReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, CreditEntity> creditMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<CreditReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final creditReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportCredit)
          ? reportSettings[kReportCredit]
          : ReportSettingsEntity();

  final defaultColumns = [
    CreditReportFields.amount,
    CreditReportFields.balance,
    CreditReportFields.credit_date,
    CreditReportFields.credit_number,
    CreditReportFields.client,
  ];

  if (creditReportSettings.columns.isNotEmpty) {
    columns = BuiltList(creditReportSettings.columns
        .map((e) => EnumUtils.fromString(CreditReportFields.values, e))
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var creditId in creditMap.keys) {
    final credit = creditMap[creditId];
    final client = clientMap[credit.clientId];
    if (credit.isDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case CreditReportFields.amount:
          value = credit.amount;
          break;
        case CreditReportFields.balance:
          value = credit.balance;
          break;
        case CreditReportFields.credit_date:
          value = credit.creditDate;
          break;
        case CreditReportFields.credit_number:
          value = credit.creditNumber;
          break;
        case CreditReportFields.client:
          value = clientMap[credit.clientId].displayName;
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
        row.add(credit.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(credit.getReportNumber(
            value: value, currencyId: client.settings.currencyId));
      } else {
        row.add(credit.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
    }
  }

  data.sort((rowA, rowB) => sortReportTableRows(rowA, rowB, creditReportSettings));

  return ReportResult(
    allColumns:
        CreditReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: columns.map((item) => EnumUtils.parse(item)).toList(),
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
