import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/learn_more.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/settings/integrations_vm.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class IntegrationSettings extends StatefulWidget {
  const IntegrationSettings({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final IntegrationSettingsVM viewModel;

  @override
  _IntegrationSettingsState createState() => _IntegrationSettingsState();
}

class _IntegrationSettingsState extends State<IntegrationSettings> {
  //static final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: '_notifications');

  bool autoValidate = false;

  final _googleAnalyticsController = TextEditingController();
  final _slackWebhookController = TextEditingController();

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _googleAnalyticsController,
      _slackWebhookController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final company = widget.viewModel.state.company;
    _googleAnalyticsController.text = company.googleAnalyticsKey;
    _slackWebhookController.text = company.slackWebhookUrl;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    _debouncer.run(() {
      final state = widget.viewModel.state;
      final company = state.company.rebuild((b) => b
        ..slackWebhookUrl = _slackWebhookController.text.trim()
        ..googleAnalyticsKey = _googleAnalyticsController.text.trim());
      if (state.company != company) {
        widget.viewModel.onCompanyChanged(company);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    //final viewModel = widget.viewModel;

    return EditScaffold(
      title: localization.integrations,
      onSavePressed: widget.viewModel.onSavePressed,
      body: ScrollableListView(
        children: <Widget>[
          FormCard(
            children: <Widget>[
              LearnMoreUrl(
                url: 'https://my.slack.com/services/new/incoming-webhook/',
                child: DecoratedFormField(
                  label: 'Slack',
                  keyboardType: TextInputType.url,
                  hint: localization.slackWebhookUrl,
                  controller: _slackWebhookController,
                ),
              ),
              LearnMoreUrl(
                url: 'https://support.google.com/analytics/answer/1037249',
                child: DecoratedFormField(
                  label: 'Google Analytics',
                  hint: localization.trackingId,
                  controller: _googleAnalyticsController,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
