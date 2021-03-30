import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/subscription/view/subscription_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
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
    final localization = AppLocalization.of(context);

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: subscription,
      body: ScrollableListView(
        children: <Widget>[
          EntityHeader(
              entity: subscription,
              label: localization.price,
              value: formatNumber(subscription.price, context)),
          ListDivider(),
          ListTile(
            title: Text(localization.registrationUrl),
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
          ),
          ListDivider(),
        ],
      ),
    );
  }
}
