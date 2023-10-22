// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/recurring_invoice/recurring_invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/subscription/view/subscription_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final SubscriptionViewVM viewModel;
  final bool isFilter;

  @override
  _SubscriptionViewState createState() => new _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final subscription = viewModel.subscription;
    final localization = AppLocalization.of(context)!;
    final state = viewModel.state;
    final company = state.company;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: subscription,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ScrollableListView(
        children: <Widget>[
          EntityHeader(
              entity: subscription,
              label: localization.price,
              value: formatNumber(subscription.price, context)),
          ListDivider(),
          ListTile(
            title: Text(localization.paymentLink),
            subtitle: Text(
              subscription.purchasePage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.content_copy),
            onTap: () {
              Clipboard.setData(ClipboardData(text: subscription.purchasePage));
              showToast(localization.copiedToClipboard
                  .replaceFirst(':value', subscription.purchasePage));
            },
            onLongPress: () => launchUrl(Uri.parse(subscription.purchasePage)),
          ),
          ListDivider(),
          /*
          if (subscription.groupId.isNotEmpty)
            EntityListTile(
              isFilter: widget.isFilter,
              entity: state.groupState.get(subscription.groupId),
            ),
          if (subscription.assignedUserId.isNotEmpty)
            EntityListTile(
              isFilter: widget.isFilter,
              entity: state.userState.get(subscription.assignedUserId),
            ),
            */
          if (company.isModuleEnabled(EntityType.invoice))
            EntitiesListTile(
              entity: subscription,
              isFilter: widget.isFilter,
              entityType: EntityType.invoice,
              title: localization.invoices,
              subtitle: memoizedInvoiceStatsForSubscription(
                      subscription.id, state.invoiceState.map)
                  .present(localization.active, localization.archived),
              hideNew: true,
            ),
          if (company.isModuleEnabled(EntityType.recurringInvoice))
            EntitiesListTile(
              entity: subscription,
              isFilter: widget.isFilter,
              entityType: EntityType.recurringInvoice,
              title: localization.recurringInvoices,
              subtitle: memoizedRecurringInvoiceStatsForSubscription(
                      subscription.id, state.recurringInvoiceState.map)
                  .present(localization.active, localization.archived),
              hideNew: true,
            ),
        ],
      ),
    );
  }
}
