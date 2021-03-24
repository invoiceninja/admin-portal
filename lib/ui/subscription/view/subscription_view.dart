import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/subscription/view/subscription_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';

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

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: subscription,
      body: ScrollableListView(
        children: <Widget>[
        ],
      ),
    );
  }
}
