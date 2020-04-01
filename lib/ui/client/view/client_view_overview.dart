import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/project/project_selectors.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/task/task_selectors.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientOverview extends StatelessWidget {
  const ClientOverview({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final client = viewModel.client;
    final company = viewModel.company;
    final state = StoreProvider.of<AppState>(context).state;
    final statics = state.staticState;
    final fields = <String, String>{};
    final group = client.hasGroup ? state.groupState.map[client.groupId] : null;

    if (client.hasLanguage &&
        client.languageId != company.settings.languageId) {
      fields[ClientFields.language] =
          statics.languageMap[client.languageId]?.name;
    }

    if (client.hasCurrency && client.currencyId != company.currencyId) {
      fields[ClientFields.currency] =
          statics.currencyMap[client.currencyId]?.name;
    }

    if (client.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.client1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.client1,
          value: client.customValue1);
    }
    if (client.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.client2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.client2,
          value: client.customValue2);
    }
    if (client.customValue3.isNotEmpty) {
      final label3 = company.getCustomFieldLabel(CustomFieldType.client3);
      fields[label3] = formatCustomValue(
          context: context,
          field: CustomFieldType.client3,
          value: client.customValue3);
    }
    if (client.customValue4.isNotEmpty) {
      final label4 = company.getCustomFieldLabel(CustomFieldType.client4);
      fields[label4] = formatCustomValue(
          context: context,
          field: CustomFieldType.client4,
          value: client.customValue4);
    }

    return ListView(
      children: <Widget>[
        EntityHeader(
          label: localization.paidToDate,
          value: formatNumber(client.paidToDate, context, clientId: client.id),
          secondLabel: localization.balanceDue,
          secondValue:
              formatNumber(client.balance, context, clientId: client.id),
        ),
        client.privateNotes != null && client.privateNotes.isNotEmpty
            ? IconMessage(client.privateNotes)
            : Container(),
        if (client.hasGroup) ...[
          Material(
            color: Theme.of(context).canvasColor,
            child: ListTile(
              title: EntityStateTitle(entity: group),
              leading: Icon(getEntityIcon(EntityType.group), size: 18.0),
              trailing: Icon(Icons.navigate_next),
              onTap: () => viewModel.onGroupPressed(context),
            ),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        ],
        FieldGrid(fields),
        Divider(
          height: 1.0,
        ),
        EntityListTile(
          bottomPadding: 1,
          icon: getEntityIcon(EntityType.invoice),
          title: localization.invoices,
          onTap: () => viewModel.onEntityPressed(context, EntityType.invoice),
          onLongPress: () =>
              viewModel.onEntityPressed(context, EntityType.invoice, true),
          subtitle:
              memoizedInvoiceStatsForClient(client.id, state.invoiceState.map)
                  .present(localization.active, localization.archived),
        ),
        EntityListTile(
          bottomPadding: 1,
          icon: getEntityIcon(EntityType.payment),
          title: localization.payments,
          onTap: () => viewModel.onEntityPressed(context, EntityType.payment),
          onLongPress: () =>
              viewModel.onEntityPressed(context, EntityType.payment, true),
          subtitle: memoizedPaymentStatsForClient(
                  client.id, state.paymentState.map, state.invoiceState.map)
              .present(localization.active, localization.archived),
        ),
        if (company.isModuleEnabled(EntityType.quote))
          EntityListTile(
            bottomPadding: 1,
            icon: getEntityIcon(EntityType.quote),
            title: localization.quotes,
            onTap: () => viewModel.onEntityPressed(context, EntityType.quote),
            onLongPress: () =>
                viewModel.onEntityPressed(context, EntityType.quote, true),
            subtitle:
                memoizedQuoteStatsForClient(client.id, state.quoteState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.credit))
          EntityListTile(
            bottomPadding: 1,
            icon: getEntityIcon(EntityType.credit),
            title: localization.credits,
            onTap: () => viewModel.onEntityPressed(context, EntityType.credit),
            onLongPress: () =>
                viewModel.onEntityPressed(context, EntityType.credit, true),
            subtitle:
                memoizedCreditStatsForClient(client.id, state.creditState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.project))
          EntityListTile(
            bottomPadding: 1,
            icon: getEntityIcon(EntityType.project),
            title: localization.projects,
            onTap: () => viewModel.onEntityPressed(context, EntityType.project),
            onLongPress: () =>
                viewModel.onEntityPressed(context, EntityType.project, true),
            subtitle:
                memoizedProjectStatsForClient(client.id, state.projectState.map)
                    .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.task))
          EntityListTile(
            bottomPadding: 1,
            icon: getEntityIcon(EntityType.task),
            title: localization.tasks,
            onTap: () => viewModel.onEntityPressed(context, EntityType.task),
            onLongPress: () =>
                viewModel.onEntityPressed(context, EntityType.task, true),
            subtitle: memoizedTaskStatsForClient(client.id, state.taskState.map)
                .present(localization.active, localization.archived),
          ),
        if (company.isModuleEnabled(EntityType.expense))
          EntityListTile(
            bottomPadding: 1,
            icon: getEntityIcon(EntityType.expense),
            title: localization.expenses,
            onTap: () => viewModel.onEntityPressed(context, EntityType.expense),
            onLongPress: () =>
                viewModel.onEntityPressed(context, EntityType.expense, true),
            subtitle:
                memoizedExpenseStatsForClient(client.id, state.expenseState.map)
                    .present(localization.active, localization.archived),
          ),
      ],
    );
  }
}

class EntityListTile extends StatelessWidget {
  const EntityListTile(
      {this.icon,
      this.onTap,
      this.onLongPress,
      this.title,
      this.subtitle,
      this.bottomPadding = 12});

  final Function onTap;
  final Function onLongPress;
  final IconData icon;
  final String title;
  final String subtitle;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Theme.of(context).canvasColor,
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            leading: Icon(icon, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        ),
        ListDivider(),
      ],
    );
  }
}
