import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/invoice_model.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:memoize/memoize.dart';

enum InvoiceReportFields {
  amount,
  balance,
  client,
  client_balance,
  client_address1,
  client_address2,
  client_shipping_address1,
  client_shipping_address2,
  status,
  number,
  discount,
  po_number,
  date,
  due_date,
  age,
  partial,
  partial_due_date,
  auto_bill,
  custom_value1,
  custom_value2,
  custom_value3,
  custom_value4,
  has_expenses,
  custom_surcharge1,
  custom_surcharge2,
  custom_surcharge3,
  custom_surcharge4,
  updated_at,
  archived_at,
  is_deleted,
  tax_amount,
}

var memoizedInvoiceReport = memo6((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    invoiceReport(userCompany, reportsUIState, invoiceMap, clientMap, userMap,
        staticState));

ReportResult invoiceReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  BuiltList<InvoiceReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final invoiceReportSettings =
      reportSettings != null && reportSettings.containsKey(kReportInvoice)
          ? reportSettings[kReportInvoice]
          : ReportSettingsEntity();

  final defaultColumns = [
    InvoiceReportFields.number,
    InvoiceReportFields.client,
    InvoiceReportFields.amount,
    InvoiceReportFields.balance,
    InvoiceReportFields.date,
    InvoiceReportFields.due_date,
    InvoiceReportFields.age,
  ];

  if (invoiceReportSettings.columns.isNotEmpty) {
    columns = BuiltList(invoiceReportSettings.columns
        .map((e) => EnumUtils.fromString(InvoiceReportFields.values, e))
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var invoiceId in invoiceMap.keys) {
    final invoice = invoiceMap[invoiceId];
    final client = clientMap[invoice.clientId];
    if (invoice.isDeleted) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case InvoiceReportFields.amount:
          value = invoice.amount;
          break;
        case InvoiceReportFields.balance:
          value = invoice.balance;
          break;
        case InvoiceReportFields.client:
          value = client?.listDisplayName ?? '';
          break;
        case InvoiceReportFields.client_balance:
          value = client.balance;
          break;
        case InvoiceReportFields.client_address1:
          value = client.address1;
          break;
        case InvoiceReportFields.client_address2:
          value = client.address2;
          break;
        case InvoiceReportFields.client_shipping_address1:
          value = client.shippingAddress1;
          break;
        case InvoiceReportFields.client_shipping_address2:
          value = client.shippingAddress2;
          break;
        case InvoiceReportFields.status:
          value = staticState.invoiceStatusMap[invoice.statusId]?.name ?? '';
          break;
        case InvoiceReportFields.number:
          value = invoice.number;
          break;
        case InvoiceReportFields.discount:
          value = invoice.discount;
          break;
        case InvoiceReportFields.po_number:
          value = invoice.poNumber;
          break;
        case InvoiceReportFields.date:
          value = invoice.date;
          break;
        case InvoiceReportFields.age:
          value = invoice.age;
          break;
        case InvoiceReportFields.due_date:
          value = invoice.dueDate;
          break;
        case InvoiceReportFields.partial:
          value = invoice.partial;
          break;
        case InvoiceReportFields.partial_due_date:
          value = invoice.partialDueDate;
          break;
        case InvoiceReportFields.auto_bill:
          value = invoice.autoBill;
          break;
        case InvoiceReportFields.custom_value1:
          value = invoice.customValue1;
          break;
        case InvoiceReportFields.custom_value2:
          value = invoice.customValue2;
          break;
        case InvoiceReportFields.custom_value3:
          value = invoice.customValue3;
          break;
        case InvoiceReportFields.custom_value4:
          value = invoice.customValue4;
          break;
        case InvoiceReportFields.has_expenses:
          value = invoice.hasExpenses;
          break;
        case InvoiceReportFields.custom_surcharge1:
          value = invoice.customSurcharge1;
          break;
        case InvoiceReportFields.custom_surcharge2:
          value = invoice.customSurcharge2;
          break;
        case InvoiceReportFields.custom_surcharge3:
          value = invoice.customSurcharge3;
          break;
        case InvoiceReportFields.custom_surcharge4:
          value = invoice.customSurcharge4;
          break;
        case InvoiceReportFields.updated_at:
          value = convertTimestampToDateString(invoice.createdAt);
          break;
        case InvoiceReportFields.archived_at:
          value = convertTimestampToDateString(invoice.createdAt);
          break;
        case InvoiceReportFields.is_deleted:
          value = invoice.isDeleted;
          break;
        case InvoiceReportFields.tax_amount:
          value = invoice.taxAmount;
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
      } else if (column == InvoiceReportFields.age) {
        row.add(invoice.getReportAge(
            value: value, currencyId: client.settings.currencyId));
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
      sortReportTableRows(rowA, rowB, invoiceReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        InvoiceReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
