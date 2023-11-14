// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/redux/reports/reports_selectors.dart';
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

enum InvoiceReportFields {
  id,
  amount,
  balance,
  converted_amount,
  converted_balance,
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
  date,
  due_date,
  age,
  partial,
  partial_due_date,
  paid_date,
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
  is_viewed,
  assigned_to,
  created_by,
  project,
  vendor,
  is_paid,
  client_phone,
  contact_email,
  contact_phone,
  contact_name,
  age_group_0,
  age_group_30,
  age_group_60,
  age_group_90,
  age_group_120,
  record_state,
}

var memoizedInvoiceReport = memo9((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  StaticState staticState,
) =>
    invoiceReport(
      userCompany!,
      reportsUIState,
      invoiceMap,
      clientMap,
      userMap,
      vendorMap,
      projectMap,
      paymentMap,
      staticState,
    ));

ReportResult invoiceReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> invoiceMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, ProjectEntity> projectMap,
  BuiltMap<String, PaymentEntity> paymentMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<InvoiceReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final invoiceReportSettings = reportSettings.containsKey(kReportInvoice)
      ? reportSettings[kReportInvoice]!
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
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  // Get the last payment for each invoice
  final lastPaymentMap = <String?, PaymentEntity?>{};
  if (columns.contains(InvoiceReportFields.paid_date)) {
    // Loop through each payment and add to the map if it is the last payment for the invoice
    paymentMap.forEach((paymentId, payment) {
      if (payment.paymentables.isNotEmpty) {
        // Loop through each invoice on the payment
        payment.paymentables.forEach((paymentable) {
          final invoiceId = paymentable.invoiceId;
          // If the invoice is in the invoice map and the payment is the last payment for the invoice
          if (lastPaymentMap.containsKey(invoiceId)) {
            if (payment.date.compareTo(lastPaymentMap[invoiceId]!.date) == 1) {
              lastPaymentMap[invoiceId] = payment;
            }
          } else {
            lastPaymentMap[invoiceId] = payment;
          }
        });
      }
    });
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
        case InvoiceReportFields.id:
          value = invoice.id;
          break;
        case InvoiceReportFields.amount:
          value = invoice.amount;
          break;
        case InvoiceReportFields.balance:
          value = invoice.isCancelled ? 0.0 : invoice.balanceOrAmount;
          break;
        case InvoiceReportFields.converted_amount:
          value = round(invoice.amount * 1 / invoice.exchangeRate, 2);
          break;
        case InvoiceReportFields.converted_balance:
          value = invoice.isCancelled
              ? 0.0
              : round(invoice.balanceOrAmount * 1 / invoice.exchangeRate, 2);
          break;
        case InvoiceReportFields.client:
          value = client.displayName;
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
          value = kInvoiceStatuses[invoice.calculatedStatusId] ?? '';
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
        case InvoiceReportFields.reminder1_sent:
          value = invoice.reminder1Sent;
          break;
        case InvoiceReportFields.reminder2_sent:
          value = invoice.reminder2Sent;
          break;
        case InvoiceReportFields.reminder3_sent:
          value = invoice.reminder3Sent;
          break;
        case InvoiceReportFields.reminder_last_sent:
          value = invoice.reminderLastSent;
          break;
        case InvoiceReportFields.age:
          value = invoice.isPaid ? -1 : invoice.age;
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
        case InvoiceReportFields.paid_date:
          value = invoice.isPaid ? lastPaymentMap[invoice.id]?.date : null;
          break;
        case InvoiceReportFields.auto_bill:
          value = invoice.autoBill;
          break;
        case InvoiceReportFields.invoice1:
          value = presentCustomField(
            value: invoice.customValue1,
            customFieldType: CustomFieldType.invoice1,
            company: userCompany.company,
          );
          break;
        case InvoiceReportFields.invoice2:
          value = presentCustomField(
            value: invoice.customValue2,
            customFieldType: CustomFieldType.invoice2,
            company: userCompany.company,
          );
          break;
        case InvoiceReportFields.invoice3:
          value = presentCustomField(
            value: invoice.customValue3,
            customFieldType: CustomFieldType.invoice3,
            company: userCompany.company,
          );
          break;
        case InvoiceReportFields.invoice4:
          value = presentCustomField(
            value: invoice.customValue4,
            customFieldType: CustomFieldType.invoice4,
            company: userCompany.company,
          );
          break;
        case InvoiceReportFields.has_expenses:
          value = invoice.hasExpenses;
          break;
        case InvoiceReportFields.has_tasks:
          value = invoice.hasTasks;
          break;
        case InvoiceReportFields.surcharge1:
          value = invoice.customSurcharge1;
          break;
        case InvoiceReportFields.surcharge2:
          value = invoice.customSurcharge2;
          break;
        case InvoiceReportFields.surcharge3:
          value = invoice.customSurcharge3;
          break;
        case InvoiceReportFields.surcharge4:
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
          value = invoice.isCancelled ? 0.0 : invoice.taxAmount;
          break;
        case InvoiceReportFields.net_amount:
          value = invoice.isCancelled ? 0.0 : invoice.netAmount;
          break;
        case InvoiceReportFields.net_balance:
          value = invoice.isCancelled ? 0.0 : invoice.netBalanceOrAmount;
          break;
        case InvoiceReportFields.exchange_rate:
          value = invoice.exchangeRate;
          break;
        case InvoiceReportFields.client_country:
          value = staticState.countryMap[client.countryId]?.name ?? '';
          break;
        case InvoiceReportFields.client_postal_code:
          value = client.postalCode;
          break;
        case InvoiceReportFields.client_vat_number:
          value = client.vatNumber;
          break;
        case InvoiceReportFields.tax_name1:
          value = invoice.taxName1;
          break;
        case InvoiceReportFields.tax_rate1:
          value = invoice.taxRate1;
          break;
        case InvoiceReportFields.tax_name2:
          value = invoice.taxName2;
          break;
        case InvoiceReportFields.tax_rate2:
          value = invoice.taxRate2;
          break;
        case InvoiceReportFields.tax_name3:
          value = invoice.taxName1;
          break;
        case InvoiceReportFields.tax_rate3:
          value = invoice.taxRate1;
          break;
        case InvoiceReportFields.public_notes:
          value = invoice.publicNotes;
          break;
        case InvoiceReportFields.private_notes:
          value = invoice.privateNotes;
          break;
        case InvoiceReportFields.client_city:
          value = client.city;
          break;
        case InvoiceReportFields.currency:
          value =
              staticState.currencyMap[client.currencyId]?.listDisplayName ?? '';
          break;
        case InvoiceReportFields.is_viewed:
          value = invoice.isViewed;
          break;
        case InvoiceReportFields.assigned_to:
          value = userMap[invoice.assignedUserId]?.listDisplayName ?? '';
          break;
        case InvoiceReportFields.created_by:
          value = userMap[invoice.createdUserId]?.listDisplayName ?? '';
          break;
        case InvoiceReportFields.project:
          value = (projectMap[invoice.projectId] ?? ProjectEntity()).name;
          break;
        case InvoiceReportFields.vendor:
          value = (vendorMap[invoice.vendorId] ?? VendorEntity()).name;
          break;
        case InvoiceReportFields.is_paid:
          value = invoice.isPaid;
          break;
        case InvoiceReportFields.client_phone:
          value = client.phone;
          break;
        case InvoiceReportFields.contact_email:
          value = contact.email;
          break;
        case InvoiceReportFields.contact_name:
          value = contact.fullName;
          break;
        case InvoiceReportFields.contact_phone:
          value = contact.phone;
          break;
        case InvoiceReportFields.client_website:
          value = client.website;
          break;
        case InvoiceReportFields.client_state:
          value = client.state;
          break;
        case InvoiceReportFields.client_shipping_city:
          value = client.shippingCity;
          break;
        case InvoiceReportFields.client_shipping_state:
          value = client.shippingState;
          break;
        case InvoiceReportFields.client_shipping_postal_code:
          value = client.shippingPostalCode;
          break;
        case InvoiceReportFields.client_shipping_country:
          value = staticState.countryMap[client.shippingCountryId]?.name ?? '';
          break;
        case InvoiceReportFields.client_number:
          value = client.number;
          break;
        case InvoiceReportFields.client_id_number:
          value = client.idNumber;
          break;
        case InvoiceReportFields.age_group_0:
          value = invoice.isPaid || invoice.age >= 30 ? 0.0 : invoice.balance;
          break;
        case InvoiceReportFields.age_group_30:
          value = invoice.isPaid || invoice.age < 30 || invoice.age >= 60
              ? 0.0
              : invoice.balance;
          break;
        case InvoiceReportFields.age_group_60:
          value = invoice.isPaid || invoice.age < 60 || invoice.age >= 90
              ? 0.0
              : invoice.balance;
          break;
        case InvoiceReportFields.age_group_90:
          value = invoice.isPaid || invoice.age < 90 || invoice.age >= 120
              ? 0.0
              : invoice.balance;
          break;
        case InvoiceReportFields.age_group_120:
          value = invoice.isPaid || invoice.age < 120 ? 0.0 : invoice.balance;
          break;
        case InvoiceReportFields.record_state:
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
      } else if (column == InvoiceReportFields.age) {
        row.add(
            invoice.getReportAge(value: value, currencyId: client.currencyId));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        String? currencyId = client.currencyId;
        if ([
          InvoiceReportFields.converted_amount,
          InvoiceReportFields.converted_balance
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
    allColumns:
        InvoiceReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
