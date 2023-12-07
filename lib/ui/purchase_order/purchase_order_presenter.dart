// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/purchase_order_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/purchase_order/purchase_order_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/copy_to_clipboard.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';
import 'package:invoiceninja_flutter/ui/app/link_text.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseOrderPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity? userCompany) {
    return [
      PurchaseOrderFields.status,
      PurchaseOrderFields.number,
      PurchaseOrderFields.vendor,
      PurchaseOrderFields.expense,
      PurchaseOrderFields.amount,
      PurchaseOrderFields.date,
      PurchaseOrderFields.dueDate,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity? userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      PurchaseOrderFields.discount,
      PurchaseOrderFields.poNumber,
      PurchaseOrderFields.publicNotes,
      PurchaseOrderFields.privateNotes,
      PurchaseOrderFields.documents,
      PurchaseOrderFields.customValue1,
      PurchaseOrderFields.customValue2,
      PurchaseOrderFields.customValue3,
      PurchaseOrderFields.customValue4,
      PurchaseOrderFields.taxAmount,
      PurchaseOrderFields.exchangeRate,
      PurchaseOrderFields.isViewed,
      PurchaseOrderFields.lastSentDate,
      PurchaseOrderFields.project,
      PurchaseOrderFields.client,
      PurchaseOrderFields.contactName,
      PurchaseOrderFields.contactEmail,
      PurchaseOrderFields.vendorState,
      PurchaseOrderFields.vendorCity,
      PurchaseOrderFields.vendorPostalCode,
      PurchaseOrderFields.vendorCountry,
      PurchaseOrderFields.partial,
      PurchaseOrderFields.partialDueDate,
    ];
  }

  @override
  Widget getField({String? field, required BuildContext context}) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;
    final purchaseOrder = entity as InvoiceEntity;
    final client = state.clientState.get(purchaseOrder.clientId);
    final vendor = state.vendorState.get(purchaseOrder.vendorId);
    final expense = state.expenseState.get(purchaseOrder.expenseId);

    switch (field) {
      case PurchaseOrderFields.status:
        return EntityStatusChip(entity: purchaseOrder, showState: true);
      case PurchaseOrderFields.number:
        return Text(purchaseOrder.number.isEmpty
            ? localization!.pending
            : purchaseOrder.number);
      case PurchaseOrderFields.client:
        return LinkTextRelatedEntity(entity: client, relation: purchaseOrder);
      case PurchaseOrderFields.date:
        return Text(formatDate(purchaseOrder.date, context));
      case PurchaseOrderFields.lastSentDate:
        return Text(formatDate(purchaseOrder.lastSentDate, context));
      case PurchaseOrderFields.amount:
        return Align(
          alignment: Alignment.centerRight,
          child: Text(formatNumber(purchaseOrder.amount, context,
              vendorId: purchaseOrder.vendorId)!),
        );
      case PurchaseOrderFields.dueDate:
        return Text(formatDate(purchaseOrder.dueDate, context));
      case PurchaseOrderFields.customValue1:
        return Text(presentCustomField(context, purchaseOrder.customValue1)!);
      case PurchaseOrderFields.customValue2:
        return Text(presentCustomField(context, purchaseOrder.customValue2)!);
      case PurchaseOrderFields.customValue3:
        return Text(presentCustomField(context, purchaseOrder.customValue3)!);
      case PurchaseOrderFields.customValue4:
        return Text(presentCustomField(context, purchaseOrder.customValue4)!);
      case PurchaseOrderFields.publicNotes:
        return TableTooltip(message: purchaseOrder.publicNotes);
      case PurchaseOrderFields.privateNotes:
        return TableTooltip(message: purchaseOrder.privateNotes);
      case PurchaseOrderFields.discount:
        return Text(purchaseOrder.isAmountDiscount
            ? formatNumber(purchaseOrder.discount, context,
                formatNumberType: FormatNumberType.money,
                vendorId: purchaseOrder.vendorId)!
            : formatNumber(purchaseOrder.discount, context,
                formatNumberType: FormatNumberType.percent)!);
      case PurchaseOrderFields.poNumber:
        return Text(purchaseOrder.poNumber);
      case PurchaseOrderFields.documents:
        return Text('${purchaseOrder.documents.length}');
      case PurchaseOrderFields.taxAmount:
        return Text(formatNumber(purchaseOrder.taxAmount, context,
            vendorId: purchaseOrder.vendorId)!);
      case PurchaseOrderFields.exchangeRate:
        return Text(formatNumber(purchaseOrder.exchangeRate, context,
            formatNumberType: FormatNumberType.double)!);
      case PurchaseOrderFields.isViewed:
        return Text(
            purchaseOrder.isViewed ? localization!.yes : localization!.no);
      case PurchaseOrderFields.project:
        final project = state.projectState.get(purchaseOrder.projectId);
        return LinkTextRelatedEntity(entity: project, relation: purchaseOrder);
      case PurchaseOrderFields.vendor:
        final vendor = state.vendorState.get(purchaseOrder.vendorId);
        return LinkTextRelatedEntity(entity: vendor, relation: purchaseOrder);
      case PurchaseOrderFields.vendorState:
        return Text(vendor.state);
      case PurchaseOrderFields.vendorCity:
        return Text(vendor.city);
      case PurchaseOrderFields.vendorPostalCode:
        return Text(vendor.postalCode);
      case PurchaseOrderFields.vendorCountry:
        return Text(state.staticState.countryMap[client.countryId]?.name ?? '');
      case PurchaseOrderFields.contactName:
      case PurchaseOrderFields.contactEmail:
        final contact = purchaseOrderContactSelector(
            purchaseOrder, state.vendorState.get(purchaseOrder.vendorId));
        if (contact == null) {
          return SizedBox();
        }
        if (field == PurchaseOrderFields.contactName) {
          return Text(contact.fullName);
        }
        return CopyToClipboard(
          value: contact.email,
          showBorder: true,
          onLongPress: () => launchUrl(Uri.parse('mailto:${contact.email}')),
        );
      case PurchaseOrderFields.partial:
        return Text(formatNumber(purchaseOrder.partial, context,
            vendorId: purchaseOrder.vendorId)!);
      case PurchaseOrderFields.partialDueDate:
        return Text(formatDate(purchaseOrder.partialDueDate, context));
      case PurchaseOrderFields.expense:
        return LinkTextRelatedEntity(entity: expense, relation: purchaseOrder);
    }

    return super.getField(field: field, context: context);
  }
}
