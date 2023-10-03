// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/webhook/webhook_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/webhook/view/webhook_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class WebhookView extends StatefulWidget {
  const WebhookView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final WebhookViewVM viewModel;
  final bool isFilter;

  @override
  _WebhookViewState createState() => new _WebhookViewState();
}

class _WebhookViewState extends State<WebhookView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final webhook = viewModel.webhook;

    return ViewScaffold(
      isFilter: widget.isFilter,
      onBackPressed: () => viewModel.onBackPressed(),
      entity: webhook,
      body: ScrollableListView(
        children: <Widget>[
          EntityHeader(
            entity: webhook,
            label: localization.eventType,
            value: localization.lookup(webhook.eventType),
            secondLabel: localization.createdOn,
            secondValue: formatDate(
                convertTimestampToDateString(webhook.createdAt), context),
          ),
          ListDivider(),
          TargetListTile(
            webhook: webhook,
          ),
          ListDivider(),
        ],
      ),
    );
  }
}

class TargetListTile extends StatelessWidget {
  const TargetListTile({
    required this.webhook,
  });

  final WebhookEntity webhook;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(22),
      title: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Text(webhook.targetUrl),
      ),
      trailing: Icon(Icons.content_copy),
      onTap: () {
        handleWebhookAction(context, [webhook], EntityAction.copy);
      },
    );
  }
}
