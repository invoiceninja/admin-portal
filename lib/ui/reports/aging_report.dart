import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/tax_rate_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:memoize/memoize.dart';

enum AgingReportFields {
  age,
  client,
  invoice,
  invoice_amount,
  invoice_balance,
  date,
  due_date,
  currency
}

var memoizedAgingReport = memo7((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    agingReport(userCompany, reportsUIState, invoiceMap, clientMap, paymentMap,
        userMap, staticState));

ReportResult agingReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<AgingReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final agingReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportAging)
          ? reportSettings[kReportAging]
          : ReportSettingsEntity();

  final defaultColumns = [
    AgingReportFields.invoice,
    AgingReportFields.age,
    AgingReportFields.invoice_amount,
    AgingReportFields.due_date,
    AgingReportFields.client,
  ];

  if (agingReportSettings.columns.isNotEmpty) {
    columns = BuiltList(agingReportSettings.columns
        .map((e) => EnumUtils.fromString(AgingReportFields.values, e))
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var invoiceId in invoiceMap.keys) {
    final invoice = invoiceMap[invoiceId];
    final client = clientMap[invoice.clientId];

    int ageInDays = 0;
    if (invoice.isPastDue && invoice.balance > 0) {
      final now = DateTime.now();
      final dueDate = DateTime.tryParse(
          invoice.partialDueDate == null || invoice.partialDueDate.isEmpty
              ? invoice.dueDate
              : invoice.partialDueDate);

      if (dueDate != null) {
        ageInDays = now.difference(dueDate).inDays;
      }
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case AgingReportFields.client:
          value = client.displayName;
          break;
        case AgingReportFields.invoice:
          value = invoice.listDisplayName;
          break;
        case AgingReportFields.invoice_amount:
          value = invoice.amount;
          break;
        case AgingReportFields.currency:
          value = staticState.currencyMap[client.currencyId]?.name ??
              staticState.currencyMap[client.settings.currencyId]?.name;
          break;
        case AgingReportFields.age:
          value = ageInDays.toDouble();
          break;
        case AgingReportFields.invoice_balance:
          value = invoice.balance;
          break;
        case AgingReportFields.date:
          value = invoice.date;
          break;
        case AgingReportFields.due_date:
          value = invoice.dueDate;
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
        row.add(invoice.getReportBool(value: value));
      } else if (column == AgingReportFields.age) {
        row.add(invoice.getReportNumber(
            value: value,
            currencyId: client.settings.currencyId,
            formatNumberType: FormatNumberType.int));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        row.add(invoice.getReportNumber(
            value: value, currencyId: client.settings.currencyId));
      } else {
        row.add(invoice.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, agingReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        AgingReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: columns.map((item) => EnumUtils.parse(item)).toList(),
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
