import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/credit/credit_selectors.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/user/view/user_view_vm.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class UserView extends StatelessWidget {
  const UserView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final UserViewVM viewModel;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final user = viewModel.user;
    final state = StoreProvider.of<AppState>(context).state;
    final userCompany = state.userCompany;

    return ViewScaffold(
      isFilter: isFilter,
      entity: user,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          EntityHeader(
            entity: user,
            value: user.email,
            label: localization.email,
            secondLabel: localization.phone,
          ),
          ListDivider(),
          if (userCompany.canViewOrCreate(EntityType.invoice))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              title: localization.invoices,
              entityType: EntityType.invoice,
              subtitle:
                  memoizedInvoiceStatsForUser(user.id, state.invoiceState.map)
                      .present(localization.active, localization.archived),
            ),
          if (userCompany.canViewOrCreate(EntityType.recurringInvoice))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              title: localization.recurringInvoices,
              entityType: EntityType.recurringInvoice,
              subtitle: memoizedRecurringInvoiceStatsForUser(
                      user.id, state.recurringInvoiceState.map)
                  .present(localization.active, localization.archived),
            ),
          if (userCompany.canViewOrCreate(EntityType.quote))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              entityType: EntityType.quote,
              title: localization.quotes,
              subtitle: memoizedQuoteStatsForUser(
                user.id,
                state.quoteState.map,
              ).present(localization.active, localization.archived),
            ),
          if (userCompany.canViewOrCreate(EntityType.credit))
            EntitiesListTile(
              entity: user,
              isFilter: isFilter,
              entityType: EntityType.credit,
              title: localization.credits,
              subtitle: memoizedCreditStatsForUser(
                user.id,
                state.creditState.map,
              ).present(localization.active, localization.archived),
            ),

          /*
        userCompany.canViewOrCreate(EntityType.project)
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
        userCompany.canViewOrCreate(EntityType.task)
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
        userCompany.canViewOrCreate(EntityType.expense)
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
