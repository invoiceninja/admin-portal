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

enum PurchaseOrderReportFields {
  id,
  amount,
  converted_amount,
  vendor,
  vendor_number,
  //vendor_balance,
  vendor_address1,
  vendor_address2,
  vendor_state,
  vendor_country,
  /*
  vendor_shipping_address1,
  vendor_shipping_address2,
  vendor_shipping_city,
  vendor_shipping_state,
  vendor_shipping_postal_code,
  vendor_shipping_country,
  */
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
  vendor_vat_number,
  vendor_city,
  vendor_postal_code,
  vendor_website,
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
  vendor_phone,
  contact_email,
  contact_phone,
  contact_name,
  record_state,
}

var memoizedPurchaseOrderReport = memo7((
  UserCompanyEntity? userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> purchaseOrderMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) =>
    purchaseOrderReport(userCompany!, reportsUIState, purchaseOrderMap,
        clientMap, vendorMap, userMap, staticState));

ReportResult purchaseOrderReport(
  UserCompanyEntity userCompany,
  ReportsUIState reportsUIState,
  BuiltMap<String, InvoiceEntity> purchaseOrderMap,
  BuiltMap<String, ClientEntity> clientMap,
  BuiltMap<String, VendorEntity> vendorMap,
  BuiltMap<String, UserEntity> userMap,
  StaticState staticState,
) {
  final List<List<ReportElement>> data = [];
  final List<BaseEntity> entities = [];
  BuiltList<PurchaseOrderReportFields> columns;

  final reportSettings = userCompany.settings.reportSettings;
  final purchaseOrderReportSettings =
      reportSettings.containsKey(kReportPurchaseOrder)
          ? reportSettings[kReportPurchaseOrder]!
          : ReportSettingsEntity();

  final defaultColumns = [
    PurchaseOrderReportFields.number,
    PurchaseOrderReportFields.vendor,
    PurchaseOrderReportFields.amount,
    PurchaseOrderReportFields.date,
    PurchaseOrderReportFields.valid_until,
  ];

  if (purchaseOrderReportSettings.columns.isNotEmpty) {
    columns = BuiltList(purchaseOrderReportSettings.columns
        .map((e) => EnumUtils.fromString(PurchaseOrderReportFields.values, e))
        .whereNotNull()
        .toList());
  } else {
    columns = BuiltList(defaultColumns);
  }

  for (var purchaseOrderId in purchaseOrderMap.keys) {
    final purchaseOrder = purchaseOrderMap[purchaseOrderId]!;
    final vendor = vendorMap[purchaseOrder.vendorId] ?? VendorEntity();

    if (purchaseOrder.invitations.isEmpty) {
      continue;
    }

    final contact =
        vendor.getContact(purchaseOrder.invitations.first.vendorContactId);
    //final vendor = vendorMap[purchaseOrder.vendorId];

    if ((purchaseOrder.isDeleted! &&
            !userCompany.company.reportIncludeDeleted) ||
        vendor.isDeleted!) {
      continue;
    }

    if (!userCompany.company.reportIncludeDrafts && purchaseOrder.isDraft) {
      continue;
    }

    bool skip = false;
    final List<ReportElement> row = [];

    for (var column in columns) {
      dynamic value = '';

      switch (column) {
        case PurchaseOrderReportFields.id:
          value = purchaseOrder.amount;
          break;
        case PurchaseOrderReportFields.amount:
          value = purchaseOrder.amount;
          break;
        case PurchaseOrderReportFields.converted_amount:
          value =
              round(purchaseOrder.amount * 1 / purchaseOrder.exchangeRate, 2);
          break;
        case PurchaseOrderReportFields.number:
          value = purchaseOrder.number;
          break;
        case PurchaseOrderReportFields.vendor:
          value = vendor.name;
          break;
        //case PurchaseOrderReportFields.vendor_balance:
        //  value = vendor.balance;
        //  break;
        case PurchaseOrderReportFields.vendor_address1:
          value = vendor.address1;
          break;
        case PurchaseOrderReportFields.vendor_address2:
          value = vendor.address2;
          break;
        case PurchaseOrderReportFields.status:
          value =
              kPurchaseOrderStatuses[purchaseOrder.calculatedStatusId] ?? '';
          break;
        case PurchaseOrderReportFields.discount:
          value = purchaseOrder.discount;
          break;
        case PurchaseOrderReportFields.po_number:
          value = purchaseOrder.poNumber;
          break;
        case PurchaseOrderReportFields.partial_due_date:
          value = purchaseOrder.partialDueDate;
          break;
        case PurchaseOrderReportFields.date:
          value = purchaseOrder.date;
          break;
        case PurchaseOrderReportFields.valid_until:
          value = purchaseOrder.dueDate;
          break;
        case PurchaseOrderReportFields.partial:
          value = purchaseOrder.partial;
          break;
        case PurchaseOrderReportFields.auto_bill:
          value = purchaseOrder.autoBill;
          break;
        case PurchaseOrderReportFields.invoice1:
          value = presentCustomField(
            value: purchaseOrder.customValue1,
            customFieldType: CustomFieldType.invoice1,
            company: userCompany.company,
          );
          break;
        case PurchaseOrderReportFields.invoice2:
          value = presentCustomField(
            value: purchaseOrder.customValue2,
            customFieldType: CustomFieldType.invoice2,
            company: userCompany.company,
          );
          break;
        case PurchaseOrderReportFields.invoice3:
          value = presentCustomField(
            value: purchaseOrder.customValue3,
            customFieldType: CustomFieldType.invoice3,
            company: userCompany.company,
          );
          break;
        case PurchaseOrderReportFields.invoice4:
          value = presentCustomField(
            value: purchaseOrder.customValue4,
            customFieldType: CustomFieldType.invoice4,
            company: userCompany.company,
          );
          break;
        case PurchaseOrderReportFields.surcharge1:
          value = purchaseOrder.customSurcharge1;
          break;
        case PurchaseOrderReportFields.surcharge2:
          value = purchaseOrder.customSurcharge2;
          break;
        case PurchaseOrderReportFields.surcharge3:
          value = purchaseOrder.customSurcharge3;
          break;
        case PurchaseOrderReportFields.surcharge4:
          value = purchaseOrder.customSurcharge4;
          break;
        case PurchaseOrderReportFields.updated_at:
          value = purchaseOrder.updatedAt;
          break;
        case PurchaseOrderReportFields.archived_at:
          value = purchaseOrder.archivedAt;
          break;
        case PurchaseOrderReportFields.is_deleted:
          value = purchaseOrder.isDeleted;
          break;
        case PurchaseOrderReportFields.is_approved:
          value = purchaseOrder.isApproved;
          break;
        case PurchaseOrderReportFields.tax_amount:
          value = purchaseOrder.taxAmount;
          break;
        case PurchaseOrderReportFields.net_amount:
          value = purchaseOrder.netAmount;
          break;
        case PurchaseOrderReportFields.exchange_rate:
          value = purchaseOrder.exchangeRate;
          break;
        case PurchaseOrderReportFields.vendor_country:
          value = staticState.countryMap[vendor.countryId]?.name ?? '';
          break;
        case PurchaseOrderReportFields.vendor_postal_code:
          value = vendor.postalCode;
          break;
        case PurchaseOrderReportFields.vendor_vat_number:
          value = vendor.vatNumber;
          break;
        case PurchaseOrderReportFields.tax_name1:
          value = purchaseOrder.taxName1;
          break;
        case PurchaseOrderReportFields.tax_rate1:
          value = purchaseOrder.taxRate1;
          break;
        case PurchaseOrderReportFields.tax_name2:
          value = purchaseOrder.taxName2;
          break;
        case PurchaseOrderReportFields.tax_rate2:
          value = purchaseOrder.taxRate2;
          break;
        case PurchaseOrderReportFields.tax_name3:
          value = purchaseOrder.taxName1;
          break;
        case PurchaseOrderReportFields.tax_rate3:
          value = purchaseOrder.taxRate1;
          break;
        case PurchaseOrderReportFields.public_notes:
          value = purchaseOrder.publicNotes;
          break;
        case PurchaseOrderReportFields.private_notes:
          value = purchaseOrder.privateNotes;
          break;
        case PurchaseOrderReportFields.vendor_city:
          value = vendor.city;
          break;
        case PurchaseOrderReportFields.currency:
          value = staticState.currencyMap[userCompany.company.currencyId]
                  ?.listDisplayName ??
              '';
          break;
        case PurchaseOrderReportFields.is_viewed:
          value = purchaseOrder.isViewed;
          break;
        case PurchaseOrderReportFields.assigned_to:
          value = userMap[purchaseOrder.assignedUserId]?.listDisplayName ?? '';
          break;
        case PurchaseOrderReportFields.created_by:
          value = userMap[purchaseOrder.createdUserId]?.listDisplayName ?? '';
          break;
        case PurchaseOrderReportFields.vendor_phone:
          value = vendor.phone;
          break;
        case PurchaseOrderReportFields.contact_email:
          value = contact.email;
          break;
        case PurchaseOrderReportFields.contact_name:
          value = contact.fullName;
          break;
        case PurchaseOrderReportFields.contact_phone:
          value = contact.phone;
          break;
        case PurchaseOrderReportFields.vendor_website:
          value = vendor.website;
          break;
        case PurchaseOrderReportFields.vendor_state:
          value = vendor.state;
          break;
        /*
        case PurchaseOrderReportFields.vendor_shipping_address1:
          value = vendor.shippingAddress1;
          break;
        case PurchaseOrderReportFields.vendor_shipping_address2:
          value = vendor.shippingAddress2;
          break;
        case PurchaseOrderReportFields.vendor_shipping_city:
          value = vendor.shippingCity;
          break;
        case PurchaseOrderReportFields.vendor_shipping_state:
          value = vendor.shippingState;
          break;
        case PurchaseOrderReportFields.vendor_shipping_postal_code:
          value = vendor.shippingPostalCode;
          break;
        case PurchaseOrderReportFields.vendor_shipping_country:
          value = staticState.countryMap[vendor.shippingCountryId]?.name ?? '';
          break;
          */
        case PurchaseOrderReportFields.vendor_number:
          value = vendor.number;
          break;
        case PurchaseOrderReportFields.record_state:
          value = AppLocalization.of(navigatorKey.currentContext!)!
              .lookup(purchaseOrder.entityState);
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
        row.add(purchaseOrder.getReportBool(value: value));
      } else if (value.runtimeType == double || value.runtimeType == int) {
        String currencyId = vendor.currencyId;
        if ([
          PurchaseOrderReportFields.converted_amount,
        ].contains(column)) {
          currencyId = userCompany.company.currencyId;
        }
        row.add(purchaseOrder.getReportDouble(
          value: value,
          currencyId: currencyId,
          exchangeRate: purchaseOrder.exchangeRate,
        ));
      } else {
        row.add(purchaseOrder.getReportString(value: value));
      }
    }

    if (!skip) {
      data.add(row);
      entities.add(purchaseOrder);
    }
  }

  final selectedColumns = columns.map((item) => EnumUtils.parse(item)).toList();
  data.sort((rowA, rowB) => sortReportTableRows(
      rowA, rowB, purchaseOrderReportSettings, selectedColumns)!);

  return ReportResult(
    allColumns: PurchaseOrderReportFields.values
        .map((e) => EnumUtils.parse(e))
        .toList(),
    columns: selectedColumns,
    defaultColumns:
        defaultColumns.map((item) => EnumUtils.parse(item)).toList(),
    data: data,
    entities: entities,
  );
}
