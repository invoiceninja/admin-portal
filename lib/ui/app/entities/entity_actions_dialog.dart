import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/group/group_actions.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_actions.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_actions.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/redux/project/project_actions.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_actions.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/tax_rate/tax_rate_actions.dart';
import 'package:invoiceninja_flutter/redux/user/user_actions.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

Future<void> showEntityActionsDialog(
    {@required BuildContext context,
    @required List<BaseEntity> entities,
    ClientEntity client,
    Completer completer,
    bool multiselect = false}) async {
  if (entities == null) {
    return;
  }
  final mainContext = context;
  showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        final state = StoreProvider.of<AppState>(context).state;
        final actions = <Widget>[];

        actions.addAll(entities[0]
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
          case EntityType.payment:
            handlePaymentAction(mainContext, entities, action);
            break;
          case EntityType.quote:
            handleQuoteAction(mainContext, entities, action);
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
          // TODO add to starter.sh
          default:
            throw 'Error: unhandled entity type ${first.entityType}';
        }
      },
    );
  }
}
