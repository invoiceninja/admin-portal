// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/learn_more.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/webhook/edit/webhook_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class WebhookEdit extends StatefulWidget {
  const WebhookEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final WebhookEditVM viewModel;

  @override
  _WebhookEditState createState() => _WebhookEditState();
}

class _WebhookEditState extends State<WebhookEdit> {
  final _targetUrlController = TextEditingController();
  final _headerKeyController = TextEditingController();
  final _headerValueController = TextEditingController();

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_webhookEdit');
  final _debouncer = Debouncer();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _targetUrlController,
      _headerKeyController,
      _headerValueController,
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
    final webhook = widget.viewModel.webhook
        .rebuild((b) => b..targetUrl = _targetUrlController.text.trim());
    if (webhook != widget.viewModel.webhook) {
      _debouncer.run(() {
        widget.viewModel.onChanged(webhook);
      });
    }
  }

  void _onSavePressed(BuildContext context) {
    final bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.viewModel.onSavePressed(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    final webhook = viewModel.webhook;

    final key = _headerKeyController.text.trim();
    final value = _headerValueController.text.trim();

    return EditScaffold(
      entity: webhook,
      title:
          webhook.isNew ? localization!.newWebhook : localization!.editWebhook,
      onCancelPressed: (context) => viewModel.onCancelPressed(context),
      onSavePressed: _onSavePressed,
      body: Form(
          key: _formKey,
          child: Builder(builder: (BuildContext context) {
            return ScrollableListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    LearnMoreUrl(
                      url: kWebhookSiteURL,
                      label: localization.testUrl,
                      child: DecoratedFormField(
                        autofocus: true,
                        controller: _targetUrlController,
                        label: localization.targetUrl,
                        keyboardType: TextInputType.url,
                        validator: (value) =>
                            value.isEmpty || value.trim().isEmpty
                                ? localization.pleaseEnterAValue
                                : null,
                      ),
                    ),
                    AppDropdownButton<String>(
                      labelText: localization.eventType,
                      value: webhook.eventId,
                      onChanged: (dynamic value) => viewModel.onChanged(
                          webhook.rebuild((b) => b..eventId = value)),
                      items: WebhookEntity.EVENT_MAP.keys
                          .map((eventId) => DropdownMenuItem(
                                child: Text(localization
                                    .lookup(WebhookEntity.EVENT_MAP[eventId])),
                                value: eventId,
                              ))
                          .toList(),
                    ),
                    AppDropdownButton<String>(
                      showBlank: true,
                      labelText: localization.restMethod,
                      value: webhook.restMethod,
                      onChanged: (dynamic value) => viewModel.onChanged(
                          webhook.rebuild((b) => b..restMethod = value)),
                      items: [
                        DropdownMenuItem(
                          child: Text('POST'),
                          value: 'post',
                        ),
                        DropdownMenuItem(
                          child: Text('PUT'),
                          value: 'put',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DecoratedFormField(
                            label: localization.headerKey,
                            controller: _headerKeyController,
                            onSavePressed: _onSavePressed,
                            onChanged: (value) => setState(() {}),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          width: kTableColumnGap,
                        ),
                        Expanded(
                          child: DecoratedFormField(
                            label: localization.headerValue,
                            controller: _headerValueController,
                            onSavePressed: _onSavePressed,
                            onChanged: (value) => setState(() {}),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          width: kTableColumnGap,
                        ),
                        IconButton(
                            tooltip: localization.addHeader,
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: (key.isEmpty || value.isEmpty)
                                ? null
                                : () {
                                    _headerKeyController.text = '';
                                    _headerValueController.text = '';

                                    if (webhook.headers.containsKey(key)) {
                                      return;
                                    }

                                    viewModel.onChanged(webhook.rebuild(
                                        (b) => b..headers[key] = value));
                                  })
                      ],
                    ),
                    SizedBox(height: 8),
                    if (webhook.headers.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Center(
                          child: HelpText(localization.noHeaders),
                        ),
                      )
                    else
                      ...webhook.headers.keys.map(
                        (key) => ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(key),
                              ),
                              SizedBox(width: kTableColumnGap),
                              Expanded(
                                child: Text(webhook.headers[key]!),
                              )
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.clear),
                            tooltip: localization.removeHeader,
                            onPressed: () {
                              viewModel.onChanged(webhook
                                  .rebuild((b) => b..headers.remove(key)));
                            },
                          ),
                        ),
                      )
                  ],
                ),
              ],
            );
          })),
    );
  }
}
