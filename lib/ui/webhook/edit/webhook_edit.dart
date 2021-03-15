import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/webhook/edit/webhook_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';

class WebhookEdit extends StatefulWidget {
  const WebhookEdit({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final WebhookEditVM viewModel;

  @override
  _WebhookEditState createState() => _WebhookEditState();
}

class _WebhookEditState extends State<WebhookEdit> {
  final _targetUrlController = TextEditingController();

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_webhookEdit');
  final _debouncer = Debouncer();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _targetUrlController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    final webhook = widget.viewModel.webhook;
    _targetUrlController.text = webhook.targetUrl;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    _debouncer.run(() {
      final webhook = widget.viewModel.webhook
          .rebuild((b) => b..targetUrl = _targetUrlController.text.trim());
      if (webhook != widget.viewModel.webhook) {
        widget.viewModel.onChanged(webhook);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final webhook = viewModel.webhook;

    return EditScaffold(
      title: webhook.isNew ? localization.newWebhook : localization.editWebhook,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: (context) {
        final bool isValid = _formKey.currentState.validate();

        /*
          setState(() {
            _autoValidate = !isValid;
          });
            */

        if (!isValid) {
          return;
        }

        viewModel.onSavePressed(context);
      },
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      autofocus: true,
                      controller: _targetUrlController,
                      label: localization.targetUrl,
                      keyboardType: TextInputType.url,
                      validator: (value) =>
                          value.isEmpty || value.trim().isEmpty
                              ? localization.pleaseEnterAValue
                              : null,
                    ),
                    AppDropdownButton<String>(
                      labelText: localization.eventType,
                      value: webhook.eventId,
                      onChanged: (dynamic value) => viewModel.onChanged(
                          webhook.rebuild((b) => b..eventId = value)),
                      items: WebhookEntity.EVENTS
                          .map((eventId) => DropdownMenuItem(
                                child: Text(localization
                                    .lookup(WebhookEntity.EVENT_MAP[eventId])),
                                value: eventId,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
