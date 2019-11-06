import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TemplatesAndReminders extends StatefulWidget {
  const TemplatesAndReminders({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TemplatesAndRemindersVM viewModel;

  @override
  _TemplatesAndRemindersState createState() => _TemplatesAndRemindersState();
}

class _TemplatesAndRemindersState extends State<TemplatesAndReminders>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _debouncer = Debouncer();

  String _template = kEmailTemplateInvoice;
  FocusScopeNode _focusNode;
  TabController _controller;

  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
    _controller = TabController(vsync: this, length: 2);
    _controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.removeListener(_handleTabSelection);
    _controller.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _subjectController,
      _bodyController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    //_loadTemplate(kEmailTemplateInvoice);

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _loadTemplate(String type) {
    final settings = widget.viewModel.settings;
    String body = '';
    String subject = '';

    if (type == kEmailTemplateInvoice) {
      subject = settings.emailSubjectInvoice;
      body = settings.emailBodyInvoice;
    } else if (type == kEmailTemplateQuote) {
      subject = settings.emailSubjectQuote;
      body = settings.emailBodyQuote;
    } else if (type == kEmailTemplatePayment) {
      subject = settings.emailSubjectPayment;
      body = settings.emailBodyPayment;
    } else if (type == kEmailTemplateReminder1) {
      subject = settings.emailSubjectReminder1;
      body = settings.emailBodyReminder1;
    } else if (type == kEmailTemplateReminder2) {
      subject = settings.emailSubjectReminder2;
      body = settings.emailBodyReminder2;
    } else if (type == kEmailTemplateReminder3) {
      subject = settings.emailSubjectReminder3;
      body = settings.emailBodyReminder3;
    } else if (type == kEmailTemplateReminder4) {
      subject = settings.emailSubjectReminder4;
      body = settings.emailBodyReminder4;
    }

    _bodyController.text = body;
    _subjectController.text = subject;
  }

  void _onChanged() {
    _debouncer.run(() {
      final String body = _bodyController.text.trim();
      final String subject = _subjectController.text.trim();
      SettingsEntity settings = widget.viewModel.settings;

      if (_template == kEmailTemplateInvoice) {
        settings = settings.rebuild((b) => b
          ..emailBodyInvoice = body
          ..emailSubjectInvoice = subject);
      } else if (_template == kEmailTemplateQuote) {
        settings = settings.rebuild((b) => b
          ..emailBodyQuote = body
          ..emailSubjectQuote = subject);
      } else if (_template == kEmailTemplatePayment) {
        settings = settings.rebuild((b) => b
          ..emailBodyPayment = body
          ..emailSubjectPayment = subject);
      } else if (_template == kEmailTemplateReminder1) {
        settings = settings.rebuild((b) => b
          ..emailBodyReminder1 = body
          ..emailSubjectReminder1 = subject);
      } else if (_template == kEmailTemplateReminder2) {
        settings = settings.rebuild((b) => b
          ..emailBodyReminder2 = body
          ..emailSubjectReminder2 = subject);
      } else if (_template == kEmailTemplateReminder3) {
        settings = settings.rebuild((b) => b
          ..emailBodyReminder3 = body
          ..emailSubjectReminder3 = subject);
      } else if (_template == kEmailTemplateReminder4) {
        settings = settings.rebuild((b) => b
          ..emailBodyReminder4 = body
          ..emailSubjectReminder4 = subject);
      }

      if (settings != widget.viewModel.settings) {
        widget.viewModel.onSettingsChanged(settings);

        /*
      final str =
          '<b>${_subjectController.text.trim()}</b><br/><br/>${_bodyController.text.trim()}';
      final String contentBase64 =
          base64Encode(const Utf8Encoder().convert(str));
      final url = 'data:text/html;base64,$contentBase64';
      _webViewController.loadUrl(url);
       */
      }
    });
  }

  void _handleTabSelection() {
    print('### TAB CHANGED ##');
    //_webViewController.loadUrl(_getUrl(_template));
  }

  String _getUrl(String template) {
    final str =
        '<b>${_subjectController.text.trim()}</b><br/><br/>${_bodyController.text.trim()}';
    final String contentBase64 = base64Encode(const Utf8Encoder().convert(str));
    return 'data:text/html;base64,$contentBase64';
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;

    return SettingsScaffold(
      title: localization.templatesAndReminders,
      onSavePressed: viewModel.onSavePressed,
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: false,
        tabs: [
          Tab(
            text: localization.edit,
          ),
          Tab(
            text: localization.preview,
          ),
        ],
      ),
      body: AppTabForm(
        tabController: _controller,
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          ListView(
            children: <Widget>[
              FormCard(children: <Widget>[
                AppDropdownButton(
                  labelText: localization.template,
                  value: _template,
                  showBlank: false,
                  onChanged: (value) => setState(() {
                    _template = value;
                    _loadTemplate(_template);
                  }),
                  items: kEmailTemplateTypes
                      .map((item) => DropdownMenuItem<String>(
                            child: Text(localization.lookup(item)),
                            value: item,
                          ))
                      .toList(),
                ),
                DecoratedFormField(
                  label: localization.subject,
                  controller: _subjectController,
                ),
                DecoratedFormField(
                  label: localization.body,
                  controller: _bodyController,
                  maxLines: 8,
                ),
              ]),
              if (_template == kEmailTemplateReminder1)
                ReminderSettings(
                  key: ValueKey('__reminder1_${_template}__'),
                  viewModel: viewModel,
                  enabled: settings.enableReminder1,
                  numDays: settings.numDaysReminder1,
                  schedule: settings.scheduleReminder1,
                  feeAmount: settings.lateFeeAmount1,
                  feePercent: settings.lateFeePercent1,
                  onChanged: (enabled, days, schedule, feeAmount, feePercent) =>
                      viewModel.onSettingsChanged(settings.rebuild((b) => b
                        ..enableReminder1 = enabled
                        ..numDaysReminder1 = days
                        ..scheduleReminder1 = schedule
                        ..lateFeeAmount1 = feeAmount
                        ..lateFeePercent1 = feePercent)),
                ),
              if (_template == kEmailTemplateReminder2)
                ReminderSettings(
                  key: ValueKey('__reminder2_${_template}__'),
                  viewModel: viewModel,
                  enabled: settings.enableReminder2,
                  numDays: settings.numDaysReminder2,
                  schedule: settings.scheduleReminder2,
                  feeAmount: settings.lateFeeAmount2,
                  feePercent: settings.lateFeePercent2,
                  onChanged: (enabled, days, schedule, feeAmount, feePercent) =>
                      viewModel.onSettingsChanged(settings.rebuild((b) => b
                        ..enableReminder2 = enabled
                        ..numDaysReminder2 = days
                        ..scheduleReminder2 = schedule
                        ..lateFeeAmount2 = feeAmount
                        ..lateFeePercent2 = feePercent)),
                ),
              if (_template == kEmailTemplateReminder3)
                ReminderSettings(
                  key: ValueKey('__reminder3_${_template}__'),
                  viewModel: viewModel,
                  enabled: settings.enableReminder3,
                  numDays: settings.numDaysReminder3,
                  schedule: settings.scheduleReminder3,
                  feeAmount: settings.lateFeeAmount3,
                  feePercent: settings.lateFeePercent3,
                  onChanged: (enabled, days, schedule, feeAmount, feePercent) =>
                      viewModel.onSettingsChanged(settings.rebuild((b) => b
                        ..enableReminder3 = enabled
                        ..numDaysReminder3 = days
                        ..scheduleReminder3 = schedule
                        ..lateFeeAmount3 = feeAmount
                        ..lateFeePercent3 = feePercent)),
                ),
              if (_template == kEmailTemplateReminder4)
                FormCard(
                  children: <Widget>[
                    BoolDropdownButton(
                      label: localization.sendEmail,
                      value: settings.enableReminder4,
                      onChanged: (value) => viewModel.onSettingsChanged(
                          settings.rebuild((b) => b..enableReminder4 = value)),
                      iconData: FontAwesomeIcons.solidEnvelope,
                    ),
                    AppDropdownButton(
                        labelText: localization.frequency,
                        value: settings.endlessReminderFrequencyId,
                        onChanged: (value) => viewModel.onSettingsChanged(
                            settings.rebuild(
                                (b) => b..endlessReminderFrequencyId = value)),
                        items: kFrequencies
                            .map((id, frequency) =>
                                MapEntry<String, DropdownMenuItem<String>>(
                                    id,
                                    DropdownMenuItem<String>(
                                      child:
                                          Text(localization.lookup(frequency)),
                                      value: id,
                                    )))
                            .values
                            .toList()),
                  ],
                ),
            ],
          ),
          TemplatePreview(_getUrl(_template)),
        ],
      ),
    );
  }
}

class ReminderSettings extends StatefulWidget {
  const ReminderSettings({
    Key key,
    @required this.viewModel,
    @required this.enabled,
    @required this.schedule,
    @required this.onChanged,
    @required this.numDays,
    @required this.feeAmount,
    @required this.feePercent,
  }) : super(key: key);

  final TemplatesAndRemindersVM viewModel;
  final bool enabled;
  final int numDays;
  final double feeAmount;
  final double feePercent;
  final String schedule;
  final Function(bool, int, String, double, double) onChanged;

  @override
  _ReminderSettingsState createState() => _ReminderSettingsState();
}

class _ReminderSettingsState extends State<ReminderSettings> {
  final _daysController = TextEditingController();
  final _feeAmountController = TextEditingController();
  final _feePercentController = TextEditingController();

  bool _enabled;
  String _schedule;

  List<TextEditingController> _controllers = [];
  final _debouncer = Debouncer();

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onTextChanged);
      controller.dispose();
    });
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _enabled = widget.enabled;
    _schedule = widget.schedule;

    _controllers = [
      _daysController,
      _feeAmountController,
      _feePercentController,
    ];

    _controllers.forEach(
        (dynamic controller) => controller.removeListener(_onTextChanged));

    _daysController.text = '${widget.numDays ?? ''}';
    _feeAmountController.text = formatNumber(widget.feeAmount, context,
        formatNumberType: FormatNumberType.input);
    _feePercentController.text = formatNumber(widget.feePercent, context,
        formatNumberType: FormatNumberType.input);

    _controllers.forEach(
        (dynamic controller) => controller.addListener(_onTextChanged));

    super.didChangeDependencies();
  }

  void _onTextChanged() {
    _debouncer.run(() {
      _onChanged();
    });
  }

  void _onChanged() {
    final int days = parseDouble(_daysController.text.trim()).toInt();
    final feeAmount = parseDouble(_feeAmountController.text.trim());
    final feePercent = parseDouble(_feePercentController.text.trim());

    widget.onChanged(_enabled, days, _schedule, feeAmount, feePercent);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              label: localization.days,
              controller: _daysController,
            ),
            AppDropdownButton(
              value: widget.schedule,
              labelText: localization.schedule,
              onChanged: (value) {
                _schedule = value;
                _onChanged();
              },
              items: [
                DropdownMenuItem(
                  child: Text(localization.afterInvoiceDate),
                  value: kReminderScheduleAfterInvoiceDate,
                ),
                DropdownMenuItem(
                  child: Text(localization.beforeDueDate),
                  value: kReminderScheduleBeforeDueDate,
                ),
                DropdownMenuItem(
                  child: Text(localization.afterDueDate),
                  value: kReminderScheduleAfterDueDate,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: BoolDropdownButton(
                label: localization.sendEmail,
                value: widget.enabled,
                onChanged: (value) {
                  _enabled = value;
                  _onChanged();
                },
                iconData: FontAwesomeIcons.solidEnvelope,
              ),
            ),
            DecoratedFormField(
              label: localization.lateFeeAmount,
              controller: _feeAmountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            DecoratedFormField(
              label: localization.lateFeePercent,
              controller: _feePercentController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ],
    );
  }
}

class TemplatePreview extends StatefulWidget {
  const TemplatePreview(this.html);

  final String html;

  @override
  _TemplatePreviewState createState() => _TemplatePreviewState();
}

class _TemplatePreviewState extends State<TemplatePreview>
    with AutomaticKeepAliveClientMixin<TemplatePreview> {
  WebViewController _webViewController;

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.html != oldWidget.html) {
      _webViewController.loadUrl(widget.html);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: WebView(
        debuggingEnabled: true,
        initialUrl: widget.html,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
        },
        //onPageFinished: (String url) {},
        javascriptMode: JavascriptMode.disabled,
      ),
    );
  }
}
