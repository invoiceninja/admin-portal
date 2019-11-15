import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_actions.dart';
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
                multiselect: multiselect)
            .map((entityAction) {
          if (entityAction == null) {
            return Divider();
          } else {
            return EntityActionListTile(
              entities: entities,
              action: entityAction,
              mainContext: mainContext,
            );
          }
        }).toList());

        return SimpleDialog(children: actions);
      });
}

class EntityActionListTile extends StatelessWidget {
  const EntityActionListTile(
      {this.entities, this.action, this.onEntityAction, this.mainContext});

  final List<BaseEntity> entities;
  final EntityAction action;
  final BuildContext mainContext;
  final Function(BuildContext, List<BaseEntity>, EntityAction) onEntityAction;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListTile(
      leading: Icon(getEntityActionIcon(action)),
      title: Text(localization.lookup(action.toString())),
      onTap: () {
        Navigator.of(context).pop();
        final first = entities.first;
        switch (first.entityType) {
          case EntityType.client:
            handleClientAction(context, entities, action);
            break;
          case EntityType.product:
            handleProductAction(context, entities, action);
            break;
          case EntityType.invoice:
            handleInvoiceAction(context, entities, action);
            break;
          case EntityType.payment:
            handlePaymentAction(context, entities, action);
            break;
          case EntityType.quote:
            handleQuoteAction(context, entities, action);
            break;
          case EntityType.task:
            handleTaskAction(context, entities, action);
            break;
          case EntityType.project:
            handleProjectAction(context, entities, action);
            break;
          case EntityType.vendor:
            handleVendorAction(context, entities, action);
            break;
          case EntityType.expense:
            handleExpenseAction(context, entities, action);
            break;
          case EntityType.companyGateway:
            handleCompanyGatewayAction(context, entities, action);
            break;
          case EntityType.group:
            handleGroupAction(context, entities, action);
            break;
          case EntityType.taxRate:
            handleTaxRateAction(context, entities, action);
            break;
          case EntityType.user:
            handleUserAction(context, entities, action);
            break;
        }
      },
    );
  }
}
