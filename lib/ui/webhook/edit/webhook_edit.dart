import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
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

  final _urlController = TextEditingController();

  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_webhookEdit');
  final _debouncer = Debouncer();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _urlController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    //final webhook = widget.viewModel.webhook;
    //_urlController.text = webhook.

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
      final webhook = widget.viewModel.webhook.rebuild((b) => b
          // STARTER: set value - do not remove comment
          );
      if (webhook != widget.viewModel.webhook) {
        widget.viewModel.onChanged(webhook);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final localization = AppLocalization.of(context);
    //final webhook = viewModel.webhook;

    return EditScaffold(
      title: localization.editWebhook,
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
            return ListView(
              children: <Widget>[
                FormCard(
                  children: <Widget>[
                    DecoratedFormField(
                      controller: _urlController,
                      label: localization.url,
                    )
                  ],
                ),
              ],
            );
          })),
    );
  }
}
