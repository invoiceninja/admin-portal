import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/webhook/view/webhook_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';

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
    final userCompany = viewModel.state.userCompany;
    final webhook = viewModel.webhook;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: webhook,
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
