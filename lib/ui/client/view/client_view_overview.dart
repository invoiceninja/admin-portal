// Flutter imports:
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/portal_links.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/company_gateway_model.dart';
import 'package:invoiceninja_flutter/data/models/gateway_token_model.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/gateways/token_meta.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/extensions.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ClientOverview extends StatelessWidget {
  const ClientOverview({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final ClientViewVM viewModel;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    final localization = context.localization!;
    final client = viewModel.client;
    final company = viewModel.company!;
    final state = context.state;
    final statics = state.staticState;
    final fields = <String?, String?>{};
    final group = client.hasGroup ? state.groupState.map[client.groupId] : null;
    final contact = client.primaryContact;
    final user =
        client.hasUser ? state.userState.get(client.assignedUserId!) : null;

    // Group gateway tokens by the customerReference
    final tokenMap = <String, List<GatewayTokenEntity>>{};
    final gatewayMap = <String, CompanyGatewayEntity>{};
    final linkMap = <String, String>{};

    client.gatewayTokens.forEach((gatewayToken) {
      final companyGateway =
          state.companyGatewayState.get(gatewayToken.companyGatewayId);
      if (companyGateway.isOld && !companyGateway.isDeleted!) {
        final customerReference = gatewayToken.customerReference;
        gatewayMap[customerReference] = companyGateway;
        final clientUrl = GatewayEntity.getClientUrl(
          gatewayId: companyGateway.gatewayId,
          customerReference: customerReference,
        );
        if (clientUrl != null) {
          linkMap[customerReference] = clientUrl;
        }
        if (tokenMap.containsKey(customerReference)) {
          tokenMap[customerReference]!.add(gatewayToken);
        } else {
          tokenMap[customerReference] = [gatewayToken];
        }
      }
    });

    if (client.isTaxExempt) {
      fields[localization.isTaxExempt] = localization.yes;
    }

    if (client.hasLanguage &&
        client.languageId != company.settings.languageId) {
      fields[ClientFields.language] =
          statics.languageMap[client.languageId]?.name;
    }

    if (client.hasCurrency && client.currencyId != company.currencyId) {
      fields[ClientFields.currency] =
          statics.currencyMap[client.currencyId]?.name;
    }

    if (company.hasCustomField(CustomFieldType.client1) &&
        client.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.client1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.client1,
          value: client.customValue1);
    }
    if (company.hasCustomField(CustomFieldType.client2) &&
        client.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.client2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.client2,
          value: client.customValue2);
    }
    if (company.hasCustomField(CustomFieldType.client3) &&
        client.customValue3.isNotEmpty) {
      final label3 = company.getCustomFieldLabel(CustomFieldType.client3);
      fields[label3] = formatCustomValue(
          context: context,
          field: CustomFieldType.client3,
          value: client.customValue3);
    }
    if (company.hasCustomField(CustomFieldType.client4) &&
        client.customValue4.isNotEmpty) {
      final label4 = company.getCustomFieldLabel(CustomFieldType.client4);
      fields[label4] = formatCustomValue(
          context: context,
          field: CustomFieldType.client4,
          value: client.customValue4);
    }

    return ScrollableListView(
      children: <Widget>[
        EntityHeader(
          entity: client,
          label: localization.paidToDate,
          value: formatNumber(client.paidToDate, context, clientId: client.id),
          secondLabel: localization.balanceDue,
          secondValue:
              formatNumber(client.balance, context, clientId: client.id),
        ),
        ListDivider(),
        if (client.creditBalance != 0 || client.paymentBalance != 0) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (client.paymentBalance != 0)
                Text(localization.payments +
                    ': ' +
                    formatNumber(client.paymentBalance, context,
                        clientId: client.id)!),
              if (client.creditBalance != 0)
                Text(localization.credit +
                    ': ' +
                    formatNumber(client.creditBalance, context,
                        clientId: client.id)!),
            ]),
          ),
          ListDivider(),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: PortalLinks(
            viewLink: contact.silentLink,
            copyLink: contact.link,
            client: client,
          ),
        ),
        ListDivider(),
        if (client.privateNotes.isNotEmpty) ...[
          IconMessage(client.privateNotes, iconData: Icons.lock),
          ListDivider()
        ],
        if (client.hasGroup && group != null)
          EntityListTile(
            entity: group,
            isFilter: isFilter,
          ),
        for (var customerReference in tokenMap.keys) ...[
          ListTile(
            title: Text(
                '${localization.gateway}  ›  ${gatewayMap[customerReference]!.label}'),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              children: tokenMap[customerReference]!
                  .map((token) => TokenMeta(
                        meta: token.meta,
                      ))
                  .toList(),
            ),
            onTap: linkMap.containsKey(customerReference)
                ? () => launchUrl(Uri.parse(linkMap[customerReference]!))
                : null,
            leading: IgnorePointer(
              child: IconButton(
                icon: Icon(Icons.payment),
                onPressed: () => null,
              ),
            ),
            trailing: linkMap.containsKey(customerReference)
                ? IgnorePointer(
                    child: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () => null,
                    ),
                  )
                : null,
          ),
          ListDivider(),
        ],
        if (client.hasUser)
          EntityListTile(
            entity: user!,
            isFilter: isFilter,
          ),
        FieldGrid(fields),
        if (company.isModuleEnabled(EntityType.invoice))
          EntitiesListTile(
            entity: client,
            isFilter: isFilter,
            entityType: EntityType.invoice,
            title: localization.invoices,
            subtitle:
                memoizedInvoiceStatsForClient(client.id, state.invoiceState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.task))
          EntitiesListTile(
            entity: client,
            isFilter: isFilter,
            entityType: EntityType.task,
            title: localization.tasks,
            subtitle: memoizedTaskStatsForClient(client.id, state.taskState.map)
                .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.expense))
          EntitiesListTile(
            entity: client,
            isFilter: isFilter,
            entityType: EntityType.expense,
            title: localization.expenses,
            subtitle:
                memoizedExpenseStatsForClient(client.id, state.expenseState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.payment))
          EntitiesListTile(
            entity: client,
            isFilter: isFilter,
            entityType: EntityType.payment,
            title: localization.payments,
            subtitle: memoizedPaymentStatsForClient(
                    client.id, state.paymentState.map, state.invoiceState.map)
                .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.quote))
          EntitiesListTile(
            entity: client,
            isFilter: isFilter,
            entityType: EntityType.quote,
            title: localization.quotes,
            subtitle:
                memoizedQuoteStatsForClient(client.id, state.quoteState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.credit))
          EntitiesListTile(
            entity: client,
            isFilter: isFilter,
            entityType: EntityType.credit,
            title: localization.credits,
            subtitle:
                memoizedCreditStatsForClient(client.id, state.creditState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.project))
          EntitiesListTile(
            entity: client,
            isFilter: isFilter,
            entityType: EntityType.project,
            title: localization.projects,
            subtitle:
                memoizedProjectStatsForClient(client.id, state.projectState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.recurringInvoice))
          EntitiesListTile(
            entity: client,
            isFilter: isFilter,
            entityType: EntityType.recurringInvoice,
            title: localization.recurringInvoices,
            subtitle: memoizedRecurringInvoiceStatsForClient(
                    client.id, state.recurringInvoiceState.map)
                .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.recurringExpense))
          EntitiesListTile(
            entity: client,
            isFilter: isFilter,
            entityType: EntityType.recurringExpense,
            title: localization.recurringExpenses,
            subtitle: memoizedRecurringExpenseStatsForClient(
                    client.id, state.recurringExpenseState.map)
                .present(localization.active, localization.archived),
          ),
        if (client.publicNotes.isNotEmpty) ...[
          IconMessage(client.publicNotes, copyToClipboard: true),
          ListDivider()
        ],
      ],
    );
  }
}
