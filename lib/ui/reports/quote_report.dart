// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:invoiceninja_flutter/redux/reports/reports_selectors.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:memoize/memoize.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/utils/enums.dart';

enum QuoteReportFields {
  id,
  amount,
  converted_amount,
  client,
  client_number,
  client_id_number,
  client_balance,
  client_address1,
  client_address2,
  client_state,
  client_country,
  client_shipping_address1,
  client_shipping_address2,
  client_shipping_city,
  client_shipping_state,
  client_shipping_postal_code,
  client_shipping_country,
  status,
  number,
  discount,
  po_number,
  date,
  partial_due_date,
  valid_until,
  partial,
  auto_bill,
  invoice1,
  invoice2,
  invoice3,
  invoice4,
  surcharge1,
  surcharge2,
  surcharge3,
  surcharge4,
  updated_at,
  archived_at,
  is_deleted,
  is_approved,
  tax_amount,
  net_amount,
  exchange_rate,
  public_notes,
  private_notes,
  client_vat_number,
  client_city,
  client_postal_code,
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
  client_phone,
  contact_email,
  contact_phone,
  contact_name,
  record_state,
}

var memoizedQuoteReport = memo7((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    quoteReport(userCompany!, reportsUIState, quoteMap, clientMap, vendorMap,
        userMap, staticState));

ReportResult quoteReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> quoteMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<QuoteReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final quoteReportSettings = reportSettings.containsKey(kReportQuote)
      ? reportSettings[kReportQuote]!
      : ReportSettingsEntity();

  final defaultColumns = [
    QuoteReportFields.number,
    QuoteReportFields.client,
    QuoteReportFields.amount,
    QuoteReportFields.date,
    QuoteReportFields.valid_until,
  ];

  if (quoteReportSettings.columns.isNotEmpty) {
    columns = BuiltList(quoteReportSettings.columns
        .map((e) => EnumUtils.fromString(QuoteReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var quoteId in quoteMap.keys) {
    final quote = quoteMap[quoteId]!;
    final client = clientMap[quote.clientId] ?? ClientEntity();

    if (quote.invitations.isEmpty) {
      continue;
    }

    final contact = client.getContact(quote.invitations.first.clientContactId);
    //final vendor = vendorMap[quote.vendorId];

    if ((quote.isDeleted! && !userCompany.company.reportIncludeDeleted) ||
        client.isDeleted!) {
      continue;
    }

    if (!userCompany.company.reportIncludeDrafts && quote.isDraft) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case QuoteReportFields.id:
          value = quote.amount;
          break;
        case QuoteReportFields.amount:
          value = quote.amount;
          break;
        case QuoteReportFields.converted_amount:
          value = round(quote.amount * 1 / quote.exchangeRate, 2);
          break;
        case QuoteReportFields.number:
          value = quote.number;
          break;
        case QuoteReportFields.client:
          value = client.displayName;
          break;
        case QuoteReportFields.client_balance:
          value = client.balance;
          break;
        case QuoteReportFields.client_address1:
          value = client.address1;
          break;
        case QuoteReportFields.client_address2:
          value = client.address2;
          break;
        case QuoteReportFields.client_shipping_address1:
          value = client.shippingAddress1;
          break;
        case QuoteReportFields.client_shipping_address2:
          value = client.shippingAddress2;
          break;
        case QuoteReportFields.status:
          value = kQuoteStatuses[quote.calculatedStatusId] ?? '';
          break;
        case QuoteReportFields.discount:
          value = quote.discount;
          break;
        case QuoteReportFields.po_number:
          value = quote.poNumber;
          break;
        case QuoteReportFields.partial_due_date:
          value = quote.partialDueDate;
          break;
        case QuoteReportFields.date:
          value = quote.date;
          break;
        case QuoteReportFields.valid_until:
          value = quote.dueDate;
          break;
        case QuoteReportFields.partial:
          value = quote.partial;
          break;
        case QuoteReportFields.auto_bill:
          value = quote.autoBill;
          break;
        case QuoteReportFields.invoice1:
          value = presentCustomField(
            value: quote.customValue1,
            customFieldType: CustomFieldType.invoice1,
            company: userCompany.company,
          );
          break;
        case QuoteReportFields.invoice2:
          value = presentCustomField(
            value: quote.customValue2,
            customFieldType: CustomFieldType.invoice2,
            company: userCompany.company,
          );
          break;
        case QuoteReportFields.invoice3:
          value = presentCustomField(
            value: quote.customValue3,
            customFieldType: CustomFieldType.invoice3,
            company: userCompany.company,
          );
          break;
        case QuoteReportFields.invoice4:
          value = presentCustomField(
            value: quote.customValue4,
            customFieldType: CustomFieldType.invoice4,
            company: userCompany.company,
          );
          break;
        case QuoteReportFields.surcharge1:
          value = quote.customSurcharge1;
          break;
        case QuoteReportFields.surcharge2:
          value = quote.customSurcharge2;
          break;
        case QuoteReportFields.surcharge3:
          value = quote.customSurcharge3;
          break;
        case QuoteReportFields.surcharge4:
          value = quote.customSurcharge4;
          break;
        case QuoteReportFields.updated_at:
          value = quote.updatedAt;
          break;
        case QuoteReportFields.archived_at:
          value = quote.archivedAt;
          break;
        case QuoteReportFields.is_deleted:
          value = quote.isDeleted;
          break;
        case QuoteReportFields.is_approved:
          value = quote.isApproved;
          break;
        case QuoteReportFields.tax_amount:
          value = quote.taxAmount;
          break;
        case QuoteReportFields.net_amount:
          value = quote.netAmount;
          break;
        case QuoteReportFields.exchange_rate:
          value = quote.exchangeRate;
          break;
        case QuoteReportFields.client_country:
          value = staticState.countryMap[client.countryId]?.name ?? '';
          break;
        case QuoteReportFields.client_postal_code:
          value = client.postalCode;
          break;
        case QuoteReportFields.client_vat_number:
          value = client.vatNumber;
          break;
        case QuoteReportFields.tax_name1:
          value = quote.taxName1;
          break;
        case QuoteReportFields.tax_rate1:
          value = quote.taxRate1;
          break;
        case QuoteReportFields.tax_name2:
          value = quote.taxName2;
          break;
        case QuoteReportFields.tax_rate2:
          value = quote.taxRate2;
          break;
        case QuoteReportFields.tax_name3:
          value = quote.taxName1;
          break;
        case QuoteReportFields.tax_rate3:
          value = quote.taxRate1;
          break;
        case QuoteReportFields.public_notes:
          value = quote.publicNotes;
          break;
        case QuoteReportFields.private_notes:
          value = quote.privateNotes;
          break;
        case QuoteReportFields.client_city:
          value = client.city;
          break;
        case QuoteReportFields.currency:
          value =
              staticState.currencyMap[client.currencyId]?.listDisplayName ?? '';
          break;
        case QuoteReportFields.is_viewed:
          value = quote.isViewed;
          break;
        case QuoteReportFields.assigned_to:
          value = userMap[quote.assignedUserId]?.listDisplayName ?? '';
          break;
        case QuoteReportFields.created_by:
          value = userMap[quote.createdUserId]?.listDisplayName ?? '';
          break;
        case QuoteReportFields.client_phone:
          value = client.phone;
          break;
        case QuoteReportFields.contact_email:
          value = contact.email;
          break;
        case QuoteReportFields.contact_name:
          value = contact.fullName;
          break;
        case QuoteReportFields.contact_phone:
          value = contact.phone;
          break;
        case QuoteReportFields.client_website:
          value = client.website;
          break;
        case QuoteReportFields.client_state:
          value = client.state;
          break;
        case QuoteReportFields.client_shipping_city:
          value = client.shippingCity;
          break;
        case QuoteReportFields.client_shipping_state:
          value = client.shippingState;
          break;
        case QuoteReportFields.client_shipping_postal_code:
          value = client.shippingPostalCode;
          break;
        case QuoteReportFields.client_shipping_country:
          value = staticState.countryMap[client.shippingCountryId]?.name ?? '';
          break;
        case QuoteReportFields.client_number:
          value = client.number;
          break;
        case QuoteReportFields.client_id_number:
          value = client.idNumber;
          break;
        case QuoteReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(quote.entityState);
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
        row.add(quote.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        String? currencyId = client.currencyId;
        if ([
          QuoteReportFields.converted_amount,
        ].contains(column)) {
          currencyId = userCompany.company.currencyId;
        }
        row.add(quote.getReportDouble(
          value: value,
          currencyId: currencyId,
          exchangeRate: quote.exchangeRate,
        ));
      } else {
        row.add(quote.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
      entities.add(quote);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, quoteReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        QuoteReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
