import 'package:built_collection/built_collection.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:memoize/memoize.dart';

enum CreditReportFields {
  amount,
  balance,
  converted_amount,
  converted_balance,
  client,
  client_balance,
  client_address1,
  client_address2,
  client_shipping_address1,
  client_shipping_address2,
  client_country,
  status,
  number,
  discount,
  po_number,
  date,
  due_date,
  partial,
  partial_due_date,
  auto_bill,
  custom_value1,
  custom_value2,
  custom_value3,
  custom_value4,
  custom_surcharge1,
  custom_surcharge2,
  custom_surcharge3,
  custom_surcharge4,
  updated_at,
  archived_at,
  is_deleted,
  tax_amount,
  net_amount,
  net_remaining,
}

var memoizedCreditReport = memo6((
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> creditMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    creditReport(userCompany, reportsUIState, creditMap, clientMap, userMap,
        staticState));

ReportResult creditReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> creditMap,
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
    CreditReportFields.number,
    CreditReportFields.amount,
    CreditReportFields.balance,
    CreditReportFields.date,
    CreditReportFields.due_date,
    CreditReportFields.client
  ];

  if (creditReportSettings.columns.isNotEmpty) {
    columns = BuiltList(creditReportSettings.columns
        .map((e) => EnumUtils.fromString(CreditReportFields.values, e))
        .where((element) => element != null)
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var creditId in creditMap.keys) {
    final credit = creditMap[creditId];
    final client = clientMap[credit.clientId];
    if (credit.isDeleted || client.isDeleted) {
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
        case CreditReportFields.converted_amount:
          value = credit.amount * 1 / credit.exchangeRate;
          break;
        case CreditReportFields.converted_balance:
          value = credit.balance * 1 / credit.exchangeRate;
          break;
        case CreditReportFields.client:
          value = client?.listDisplayName ?? '';
          break;
        case CreditReportFields.client_balance:
          value = client.balance;
          break;
        case CreditReportFields.client_address1:
          value = client.address1;
          break;
        case CreditReportFields.client_address2:
          value = client.address2;
          break;
        case CreditReportFields.client_shipping_address1:
          value = client.shippingAddress1;
          break;
        case CreditReportFields.client_shipping_address2:
          value = client.shippingAddress2;
          break;
        case CreditReportFields.status:
          value = kCreditStatuses[credit.statusId] ?? '';
          break;
        case CreditReportFields.number:
          value = credit.number;
          break;
        case CreditReportFields.discount:
          value = credit.discount;
          break;
        case CreditReportFields.po_number:
          value = credit.poNumber;
          break;
        case CreditReportFields.date:
          value = credit.date;
          break;
        case CreditReportFields.due_date:
          value = credit.dueDate;
          break;
        case CreditReportFields.partial:
          value = credit.partial;
          break;
        case CreditReportFields.partial_due_date:
          value = credit.partialDueDate;
          break;
        case CreditReportFields.auto_bill:
          value = credit.autoBill;
          break;
        case CreditReportFields.custom_value1:
          value = credit.customValue1;
          break;
        case CreditReportFields.custom_value2:
          value = credit.customValue2;
          break;
        case CreditReportFields.custom_value3:
          value = credit.customValue3;
          break;
        case CreditReportFields.custom_value4:
          value = credit.customValue4;
          break;
        case CreditReportFields.custom_surcharge1:
          value = credit.customSurcharge1;
          break;
        case CreditReportFields.custom_surcharge2:
          value = credit.customSurcharge2;
          break;
        case CreditReportFields.custom_surcharge3:
          value = credit.customSurcharge3;
          break;
        case CreditReportFields.custom_surcharge4:
          value = credit.customSurcharge4;
          break;
        case CreditReportFields.updated_at:
          value = convertTimestampToDateString(credit.createdAt);
          break;
        case CreditReportFields.archived_at:
          value = convertTimestampToDateString(credit.createdAt);
          break;
        case CreditReportFields.is_deleted:
          value = credit.isDeleted;
          break;
        case CreditReportFields.tax_amount:
          value = credit.taxAmount;
          break;
        case CreditReportFields.net_amount:
          value = credit.netAmount;
          break;
        case CreditReportFields.net_remaining:
          value = credit.netBalance;
          break;
        case CreditReportFields.client_country:
          value = staticState.countryMap[client.countryId]?.name ?? '';
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
        String currencyId = client.currencyId;
        if ([
          CreditReportFields.converted_amount,
          CreditReportFields.converted_balance
        ].contains(column)) {
          currencyId = userCompany.company.currencyId;
        }
        row.add(credit.getReportDouble(
          value: value,
          currencyId: currencyId,
          exchangeRate: credit.exchangeRate,
        ));
      } else {
        row.add(credit.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, creditReportSettings, selectedColumns));

  return ReportResult(
    allColumns:
        CreditReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
  );
}
