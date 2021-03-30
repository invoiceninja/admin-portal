import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_actions.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/expense_category/expense_category_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/payment_term/payment_term_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/subscription/subscription_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

Future<void> showEntityActionsDialog(
    {@required BuildContext context,
    @required List<BaseEntity> entities,
    Completer completer,
    bool multiselect = false}) async {
  if (entities == null) {
    return;
  }
  final mainContext = context;
  final state = StoreProvider.of<AppState>(context).state;
  final actions = <Widget>[];
  final first = entities[0];
  final ClientEntity client = first is BelongsToClient
      ? state.clientState.get((first as BelongsToClient).clientId)
      : null;

  actions.addAll(first
      .getActions(
    userCompany: state.userCompany,
    includeEdit: true,
    client: client,
    multiselect: multiselect,
  )
      .map((entityAction) {
    if (entityAction == null) {
      return Divider();
    } else {
      return EntityActionListTile(
        entities: entities,
        action: entityAction,
        mainContext: mainContext,
        completer: completer,
      );
    }
  }).toList());

  if (actions.isEmpty) {
    return;
  }

  showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(children: actions);
      });
}

class EntityActionListTile extends StatelessWidget {
  const EntityActionListTile({
    this.entities,
    this.action,
    this.onEntityAction,
    this.mainContext,
    this.completer,
  });

  final List<BaseEntity> entities;
  final EntityAction action;
  final BuildContext mainContext;
  final Completer completer;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListTile(
      leading: Icon(getEntityActionIcon(action)),
      title: Text(localization.lookup(action.toString())),
      onTap: () {
        if (completer != null) {
          completer.complete(null);
        }
        Navigator.of(context).pop();
        final first = entities.first;
        switch (first.entityType) {
          case EntityType.client:
            handleClientAction(mainContext, entities, action);
            break;
          case EntityType.product:
            handleProductAction(mainContext, entities, action);
            break;
          case EntityType.invoice:
            handleInvoiceAction(mainContext, entities, action);
            break;
          case EntityType.recurringInvoice:
            handleRecurringInvoiceAction(mainContext, entities, action);
            break;
          case EntityType.payment:
            handlePaymentAction(mainContext, entities, action);
            break;
          case EntityType.quote:
            handleQuoteAction(mainContext, entities, action);
            break;
          case EntityType.credit:
            handleCreditAction(mainContext, entities, action);
            break;
          case EntityType.task:
            handleTaskAction(mainContext, entities, action);
            break;
          case EntityType.project:
            handleProjectAction(mainContext, entities, action);
            break;
          case EntityType.vendor:
            handleVendorAction(mainContext, entities, action);
            break;
          case EntityType.expense:
            handleExpenseAction(mainContext, entities, action);
            break;
          case EntityType.companyGateway:
            handleCompanyGatewayAction(mainContext, entities, action);
            break;
          case EntityType.group:
            handleGroupAction(mainContext, entities, action);
            break;
          case EntityType.taxRate:
            handleTaxRateAction(mainContext, entities, action);
            break;
          case EntityType.user:
            handleUserAction(mainContext, entities, action);
            break;
          case EntityType.design:
            handleDesignAction(mainContext, entities, action);
            break;
          case EntityType.paymentTerm:
            handlePaymentTermAction(mainContext, entities, action);
            break;
          case EntityType.token:
            handleTokenAction(mainContext, entities, action);
            break;
          case EntityType.webhook:
            handleWebhookAction(mainContext, entities, action);
            break;
          case EntityType.expenseCategory:
            handleExpenseCategoryAction(mainContext, entities, action);
            break;
          case EntityType.taskStatus:
            handleTaskStatusAction(mainContext, entities, action);
            break;
          case EntityType.subscription:
            handleSubscriptionAction(mainContext, entities, action);
            break;
          // TODO add to starter.sh
          default:
            throw 'Error: unhandled entity type ${first.entityType}';
        }
      },
    );
  }
}
