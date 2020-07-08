import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/webhook/view/webhook_view_vm.dart';

class WebhookView extends StatefulWidget {
  const WebhookView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final WebhookViewVM viewModel;
  final bool isFilter;

  @override
  _WebhookViewState createState() => new _WebhookViewState();
}

class _WebhookViewState extends State<WebhookView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final webhook = viewModel.webhook;

    return ViewScaffold(
      isFilter: widget.isFilter,
      onBackPressed: () => viewModel.onBackPressed(),
      entity: webhook,
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
