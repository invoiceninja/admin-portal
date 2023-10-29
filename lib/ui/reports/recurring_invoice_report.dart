// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/main_app.dart';
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

enum RecurringInvoiceReportFields {
  id,
  amount,
  converted_amount,
  client,
  client_number,
  client_id_number,
  client_balance,
  client_address1,
  client_address2,
  client_vat_number,
  client_city,
  client_postal_code,
  client_country,
  client_shipping_address1,
  client_shipping_address2,
  client_state,
  client_shipping_city,
  client_shipping_state,
  client_shipping_postal_code,
  client_shipping_country,
  status,
  number,
  discount,
  po_number,
  auto_bill,
  invoice1,
  invoice2,
  invoice3,
  invoice4,
  has_expenses,
  has_tasks,
  surcharge1,
  surcharge2,
  surcharge3,
  surcharge4,
  updated_at,
  archived_at,
  is_deleted,
  tax_amount,
  net_amount,
  net_balance,
  reminder1_sent,
  reminder2_sent,
  reminder3_sent,
  reminder_last_sent,
  exchange_rate,
  public_notes,
  private_notes,
  client_website,
  tax_rate1,
  tax_rate2,
  tax_rate3,
  tax_name1,
  tax_name2,
  tax_name3,
  currency,
  assigned_to,
  created_by,
  project,
  vendor,
  is_paid,
  client_phone,
  contact_email,
  contact_phone,
  contact_name,
  frequency,
  start_date,
  remaining_cycles,
  due_on,
  next_send_date,
  last_sent_date,
  record_state,
}

var memoizedRecurringInvoiceReport = memo8((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, ProjectEntity> projectMap,
  StaticState staticState,
) =>
    recurringInvoiceReport(
      userCompany!,
      reportsUIState,
      invoiceMap,
      clientMap,
      userMap,
      vendorMap,
      projectMap,
      staticState,
    ));

ReportResult recurringInvoiceReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, ProjectEntity> projectMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<RecurringInvoiceReportFields> columns;

  final localization = AppLocalization.of(navigatorKey.currentContext!);
  final reportSettings = userCompany.settings.reportSettings;
  final invoiceReportSettings =
      reportSettings.containsKey(kReportRecurringInvoice)
          ? reportSettings[kReportRecurringInvoice]!
          : ReportSettingsEntity();

  final defaultColumns = [
    RecurringInvoiceReportFields.number,
    RecurringInvoiceReportFields.client,
    RecurringInvoiceReportFields.amount,
    RecurringInvoiceReportFields.frequency,
    RecurringInvoiceReportFields.start_date,
    RecurringInvoiceReportFields.remaining_cycles,
  ];

  if (invoiceReportSettings.columns.isNotEmpty) {
    columns = BuiltList(invoiceReportSettings.columns
        .map(
            (e) => EnumUtils.fromString(RecurringInvoiceReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var invoiceId in invoiceMap.keys) {
    final invoice = invoiceMap[invoiceId]!;
    final client = clientMap[invoice.clientId] ?? ClientEntity();

    if (invoice.invitations.isEmpty) {
      continue;
    }

    final contact =
        client.getContact(invoice.invitations.first.clientContactId);

    if ((invoice.isDeleted! && !userCompany.company.reportIncludeDeleted) ||
        client.isDeleted!) {
      continue;
    }

    if (!userCompany.company.reportIncludeDrafts && invoice.isDraft) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case RecurringInvoiceReportFields.id:
          value = invoice.id;
          break;
        case RecurringInvoiceReportFields.amount:
          value = invoice.amount;
          break;
        case RecurringInvoiceReportFields.converted_amount:
          value = round(invoice.amount * 1 / invoice.exchangeRate, 2);
          break;
        case RecurringInvoiceReportFields.client:
          value = client.displayName;
          break;
        case RecurringInvoiceReportFields.client_balance:
          value = client.balance;
          break;
        case RecurringInvoiceReportFields.client_address1:
          value = client.address1;
          break;
        case RecurringInvoiceReportFields.client_address2:
          value = client.address2;
          break;
        case RecurringInvoiceReportFields.client_shipping_address1:
          value = client.shippingAddress1;
          break;
        case RecurringInvoiceReportFields.client_shipping_address2:
          value = client.shippingAddress2;
          break;
        case RecurringInvoiceReportFields.status:
          value = kRecurringInvoiceStatuses[invoice.calculatedStatusId] ?? '';
          break;
        case RecurringInvoiceReportFields.number:
          value = invoice.number;
          break;
        case RecurringInvoiceReportFields.discount:
          value = invoice.discount;
          break;
        case RecurringInvoiceReportFields.po_number:
          value = invoice.poNumber;
          break;
        case RecurringInvoiceReportFields.reminder1_sent:
          value = invoice.reminder1Sent;
          break;
        case RecurringInvoiceReportFields.reminder2_sent:
          value = invoice.reminder2Sent;
          break;
        case RecurringInvoiceReportFields.reminder3_sent:
          value = invoice.reminder3Sent;
          break;
        case RecurringInvoiceReportFields.reminder_last_sent:
          value = invoice.reminderLastSent;
          break;
        case RecurringInvoiceReportFields.auto_bill:
          value = invoice.autoBill;
          break;
        case RecurringInvoiceReportFields.invoice1:
          value = invoice.customValue1;
          break;
        case RecurringInvoiceReportFields.invoice2:
          value = invoice.customValue2;
          break;
        case RecurringInvoiceReportFields.invoice3:
          value = invoice.customValue3;
          break;
        case RecurringInvoiceReportFields.invoice4:
          value = invoice.customValue4;
          break;
        case RecurringInvoiceReportFields.has_expenses:
          value = invoice.hasExpenses;
          break;
        case RecurringInvoiceReportFields.has_tasks:
          value = invoice.hasTasks;
          break;
        case RecurringInvoiceReportFields.surcharge1:
          value = invoice.customSurcharge1;
          break;
        case RecurringInvoiceReportFields.surcharge2:
          value = invoice.customSurcharge2;
          break;
        case RecurringInvoiceReportFields.surcharge3:
          value = invoice.customSurcharge3;
          break;
        case RecurringInvoiceReportFields.surcharge4:
          value = invoice.customSurcharge4;
          break;
        case RecurringInvoiceReportFields.updated_at:
          value = convertTimestampToDateString(invoice.createdAt);
          break;
        case RecurringInvoiceReportFields.archived_at:
          value = convertTimestampToDateString(invoice.createdAt);
          break;
        case RecurringInvoiceReportFields.is_deleted:
          value = invoice.isDeleted;
          break;
        case RecurringInvoiceReportFields.tax_amount:
          value = invoice.taxAmount;
          break;
        case RecurringInvoiceReportFields.net_amount:
          value = invoice.netAmount;
          break;
        case RecurringInvoiceReportFields.net_balance:
          value = invoice.netBalanceOrAmount;
          break;
        case RecurringInvoiceReportFields.exchange_rate:
          value = invoice.exchangeRate;
          break;
        case RecurringInvoiceReportFields.client_country:
          value = staticState.countryMap[client.countryId]?.name ?? '';
          break;
        case RecurringInvoiceReportFields.client_postal_code:
          value = client.postalCode;
          break;
        case RecurringInvoiceReportFields.client_vat_number:
          value = client.vatNumber;
          break;
        case RecurringInvoiceReportFields.tax_name1:
          value = invoice.taxName1;
          break;
        case RecurringInvoiceReportFields.tax_rate1:
          value = invoice.taxRate1;
          break;
        case RecurringInvoiceReportFields.tax_name2:
          value = invoice.taxName2;
          break;
        case RecurringInvoiceReportFields.tax_rate2:
          value = invoice.taxRate2;
          break;
        case RecurringInvoiceReportFields.tax_name3:
          value = invoice.taxName1;
          break;
        case RecurringInvoiceReportFields.tax_rate3:
          value = invoice.taxRate1;
          break;
        case RecurringInvoiceReportFields.public_notes:
          value = invoice.publicNotes;
          break;
        case RecurringInvoiceReportFields.private_notes:
          value = invoice.privateNotes;
          break;
        case RecurringInvoiceReportFields.client_city:
          value = client.city;
          break;
        case RecurringInvoiceReportFields.currency:
          value =
              staticState.currencyMap[client.currencyId]?.listDisplayName ?? '';
          break;
        case RecurringInvoiceReportFields.assigned_to:
          value = userMap[invoice.assignedUserId]?.listDisplayName ?? '';
          break;
        case RecurringInvoiceReportFields.created_by:
          value = userMap[invoice.createdUserId]?.listDisplayName ?? '';
          break;
        case RecurringInvoiceReportFields.project:
          value = (projectMap[invoice.projectId] ?? ProjectEntity()).name;
          break;
        case RecurringInvoiceReportFields.vendor:
          value = (vendorMap[invoice.vendorId] ?? VendorEntity()).name;
          break;
        case RecurringInvoiceReportFields.is_paid:
          value = invoice.isPaid;
          break;
        case RecurringInvoiceReportFields.client_phone:
          value = client.phone;
          break;
        case RecurringInvoiceReportFields.contact_email:
          value = contact.email;
          break;
        case RecurringInvoiceReportFields.contact_name:
          value = contact.fullName;
          break;
        case RecurringInvoiceReportFields.contact_phone:
          value = contact.phone;
          break;
        case RecurringInvoiceReportFields.client_website:
          value = client.website;
          break;
        case RecurringInvoiceReportFields.client_state:
          value = client.state;
          break;
        case RecurringInvoiceReportFields.client_shipping_city:
          value = client.shippingCity;
          break;
        case RecurringInvoiceReportFields.client_shipping_state:
          value = client.shippingState;
          break;
        case RecurringInvoiceReportFields.client_shipping_postal_code:
          value = client.shippingPostalCode;
          break;
        case RecurringInvoiceReportFields.client_shipping_country:
          value = staticState.countryMap[client.shippingCountryId]?.name ?? '';
          break;
        case RecurringInvoiceReportFields.frequency:
          value = localization!.lookup(kFrequencies[invoice.frequencyId]);
          break;
        case RecurringInvoiceReportFields.start_date:
        case RecurringInvoiceReportFields.next_send_date:
          value = invoice.nextSendDate;
          break;
        case RecurringInvoiceReportFields.last_sent_date:
          value = invoice.lastSentDate;
          break;
        case RecurringInvoiceReportFields.remaining_cycles:
          value = invoice.remainingCycles == -1
              ? localization!.endless
              : '${invoice.remainingCycles}';
          break;
        case RecurringInvoiceReportFields.client_number:
          value = client.number;
          break;
        case RecurringInvoiceReportFields.client_id_number:
          value = client.idNumber;
          break;
        case RecurringInvoiceReportFields.due_on:
          if (invoice.dueDateDays == 'terms') {
            value = localization!.usePaymentTerms;
          } else if (invoice.dueDateDays == 'on_receipt') {
            value = localization!.dueOnReceipt;
          } else if (invoice.dueDateDays == '1') {
            value = localization!.firstDayOfTheMonth;
          } else if (invoice.dueDateDays == '31') {
            value = localization!.lastDayOfTheMonth;
          } else {
            value = localization!.dayCount
                .replaceFirst(':count', '${invoice.dueDateDays}');
          }
          break;
        case RecurringInvoiceReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(invoice.entityState);
          break;
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
        row.add(invoice.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        String? currencyId = client.currencyId;
        if ([
          RecurringInvoiceReportFields.converted_amount,
        ].contains(column)) {
          currencyId = userCompany.company.currencyId;
        }
        row.add(invoice.getReportDouble(
          value: value,
          currencyId: currencyId,
          exchangeRate: invoice.exchangeRate,
        ));
      } else {
        row.add(invoice.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
      entities.add(invoice);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, invoiceReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns: RecurringInvoiceReportFields.values
        .map((e) => EnumUtils.parse(e))
        .toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
