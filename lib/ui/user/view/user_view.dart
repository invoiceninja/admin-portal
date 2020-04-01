import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view_vm.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class UserView extends StatelessWidget {
  const UserView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final UserViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final user = viewModel.user;
    final state = StoreProvider.of<AppState>(context).state;
    final company = state.company;

    return ViewScaffold(
      entity: user,
      isSettings: true,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ListView(
        children: <Widget>[
          EntityHeader(
            value: user.email,
            label: localization.email,
          ),
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
                memoizedInvoiceStatsForUser(user.id, state.invoiceState.map)
                    .present(localization.active, localization.archived),
          ),
          EntityListTile(
            bottomPadding: 1,
            icon: getEntityIcon(EntityType.payment),
            title: localization.payments,
            onTap: () => viewModel.onEntityPressed(context, EntityType.payment),
            onLongPress: () =>
                viewModel.onEntityPressed(context, EntityType.payment, true),
            subtitle: memoizedPaymentStatsForUser(
                    user.id, state.paymentState.map, state.invoiceState.map)
                .present(localization.active, localization.archived),
          ),
          company.isModuleEnabled(EntityType.quote)
              ? EntityListTile(
                  bottomPadding: 1,
                  icon: getEntityIcon(EntityType.quote),
                  title: localization.quotes,
                  onTap: () =>
                      viewModel.onEntityPressed(context, EntityType.quote),
                  onLongPress: () => viewModel.onEntityPressed(
                      context, EntityType.quote, true),
                  subtitle: memoizedQuoteStatsForUser(
                    user.id,
                    state.quoteState.map,
                  ).present(localization.active, localization.archived),
                )
              : Container(),
          /*
        company.isModuleEnabled(EntityType.project)
            ? EntityListTile(
          bottomPadding: 1,
          icon: getEntityIcon(EntityType.project),
          title: localization.projects,
          onTap: () =>
              viewModel.onEntityPressed(context, EntityType.project),
          onLongPress: () => viewModel.onEntityPressed(
              context, EntityType.project, true),
          subtitle: memoizedProjectStatsForUser(
              user.id,
              state.projectState.map,
              localization.active,
              localization.archived),
        )
            : Container(),
        company.isModuleEnabled(EntityType.task)
            ? EntityListTile(
          bottomPadding: 1,
          icon: getEntityIcon(EntityType.task),
          title: localization.tasks,
          onTap: () =>
              viewModel.onEntityPressed(context, EntityType.task),
          onLongPress: () =>
              viewModel.onEntityPressed(context, EntityType.task, true),
          subtitle: memoizedTaskStatsForUser(
              user.id,
              state.taskState.map,
              localization.active,
              localization.archived),
        )
            : Container(),
        company.isModuleEnabled(EntityType.expense)
            ? EntityListTile(
          bottomPadding: 1,
          icon: getEntityIcon(EntityType.expense),
          title: localization.expenses,
          onTap: () =>
              viewModel.onEntityPressed(context, EntityType.expense),
          onLongPress: () => viewModel.onEntityPressed(
              context, EntityType.expense, true),
          subtitle: memoizedExpenseStatsForUser(
              user.id,
              state.expenseState.map,
              localization.active,
              localization.archived),
        )
            : Container(),
         */
        ],
      ),
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
