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

enum CreditReportFields {
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
  valid_until,
  partial,
  partial_due_date,
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
  tax_amount,
  net_amount,
  net_remaining,
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

var memoizedCreditReport = memo6((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> creditMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    creditReport(userCompany!, reportsUIState, creditMap, clientMap, userMap,
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
  final List<BaseEntity> entities = [];
  BuiltList<CreditReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final creditReportSettings = reportSettings.containsKey(kReportCredit)
      ? reportSettings[kReportCredit]!
      : ReportSettingsEntity();

  final defaultColumns = [
    CreditReportFields.number,
    CreditReportFields.amount,
    CreditReportFields.balance,
    CreditReportFields.date,
    CreditReportFields.valid_until,
    CreditReportFields.client
  ];

  if (creditReportSettings.columns.isNotEmpty) {
    columns = BuiltList(creditReportSettings.columns
        .map((e) => EnumUtils.fromString(CreditReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var creditId in creditMap.keys) {
    final credit = creditMap[creditId]!;
    final client = clientMap[credit.clientId] ?? ClientEntity();

    if (credit.invitations.isEmpty) {
      continue;
    }

    final contact = client.getContact(credit.invitations.first.clientContactId);

    if ((credit.isDeleted! && !userCompany.company.reportIncludeDeleted) ||
        client.isDeleted!) {
      continue;
    }

    if (!userCompany.company.reportIncludeDrafts && credit.isDraft) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case CreditReportFields.id:
          value = credit.id;
          break;
        case CreditReportFields.amount:
          value = credit.amount;
          break;
        case CreditReportFields.balance:
          value = credit.balance;
          break;
        case CreditReportFields.converted_amount:
          value = round(credit.amount * 1 / credit.exchangeRate, 2);
          break;
        case CreditReportFields.converted_balance:
          value = round(credit.balance * 1 / credit.exchangeRate, 2);
          break;
        case CreditReportFields.client:
          value = client.listDisplayName;
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
          value = kCreditStatuses[credit.calculatedStatusId] ?? '';
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
        case CreditReportFields.valid_until:
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
        case CreditReportFields.invoice1:
          value = presentCustomField(
            value: credit.customValue1,
            customFieldType: CustomFieldType.invoice1,
            company: userCompany.company,
          );
          break;
        case CreditReportFields.invoice2:
          value = presentCustomField(
            value: credit.customValue2,
            customFieldType: CustomFieldType.invoice2,
            company: userCompany.company,
          );
          break;
        case CreditReportFields.invoice3:
          value = presentCustomField(
            value: credit.customValue3,
            customFieldType: CustomFieldType.invoice3,
            company: userCompany.company,
          );
          break;
        case CreditReportFields.invoice4:
          value = presentCustomField(
            value: credit.customValue4,
            customFieldType: CustomFieldType.invoice4,
            company: userCompany.company,
          );
          break;
        case CreditReportFields.surcharge1:
          value = credit.customSurcharge1;
          break;
        case CreditReportFields.surcharge2:
          value = credit.customSurcharge2;
          break;
        case CreditReportFields.surcharge3:
          value = credit.customSurcharge3;
          break;
        case CreditReportFields.surcharge4:
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
        case CreditReportFields.exchange_rate:
          value = credit.exchangeRate;
          break;
        case CreditReportFields.client_postal_code:
          value = client.postalCode;
          break;
        case CreditReportFields.client_vat_number:
          value = client.vatNumber;
          break;
        case CreditReportFields.tax_name1:
          value = credit.taxName1;
          break;
        case CreditReportFields.tax_rate1:
          value = credit.taxRate1;
          break;
        case CreditReportFields.tax_name2:
          value = credit.taxName2;
          break;
        case CreditReportFields.tax_rate2:
          value = credit.taxRate2;
          break;
        case CreditReportFields.tax_name3:
          value = credit.taxName1;
          break;
        case CreditReportFields.tax_rate3:
          value = credit.taxRate1;
          break;
        case CreditReportFields.public_notes:
          value = credit.publicNotes;
          break;
        case CreditReportFields.private_notes:
          value = credit.privateNotes;
          break;
        case CreditReportFields.client_city:
          value = client.city;
          break;
        case CreditReportFields.currency:
          value =
              staticState.currencyMap[client.currencyId]?.listDisplayName ?? '';
          break;
        case CreditReportFields.is_viewed:
          value = credit.isViewed;
          break;
        case CreditReportFields.assigned_to:
          value = userMap[credit.assignedUserId]?.listDisplayName ?? '';
          break;
        case CreditReportFields.created_by:
          value = userMap[credit.createdUserId]?.listDisplayName ?? '';
          break;
        case CreditReportFields.client_phone:
          value = client.phone;
          break;
        case CreditReportFields.contact_email:
          value = contact.email;
          break;
        case CreditReportFields.contact_name:
          value = contact.fullName;
          break;
        case CreditReportFields.contact_phone:
          value = contact.phone;
          break;
        case CreditReportFields.client_website:
          value = client.website;
          break;
        case CreditReportFields.client_state:
          value = client.state;
          break;
        case CreditReportFields.client_shipping_city:
          value = client.shippingCity;
          break;
        case CreditReportFields.client_shipping_state:
          value = client.shippingState;
          break;
        case CreditReportFields.client_shipping_postal_code:
          value = client.shippingPostalCode;
          break;
        case CreditReportFields.client_shipping_country:
          value = staticState.countryMap[client.shippingCountryId]?.name ?? '';
          break;
        case CreditReportFields.client_number:
          value = client.number;
          break;
        case CreditReportFields.client_id_number:
          value = client.idNumber;
          break;
        case CreditReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(credit.entityState);
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
        row.add(credit.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        String? currencyId = client.currencyId;
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
      entities.add(credit);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) =>
      sortReportTableRows(rowA, rowB, creditReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns:
        CreditReportFields.values.map((e) => EnumUtils.parse(e)).toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
