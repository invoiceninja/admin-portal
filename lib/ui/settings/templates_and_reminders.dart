// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:html2md/html2md.dart' as html2md;

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_webview.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/bool_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/variables.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/super_editor/super_editor.dart';
import 'package:invoiceninja_flutter/utils/templates.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TemplatesAndReminders extends StatefulWidget {
  const TemplatesAndReminders({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final TemplatesAndRemindersVM viewModel;

  @override
  _TemplatesAndRemindersState createState() => _TemplatesAndRemindersState();
}

class _TemplatesAndRemindersState extends State<TemplatesAndReminders>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_templatesAndReminders');
  final _debouncer = Debouncer();

  EmailTemplate? _selectedTemplate;
  int _selectedIndex = 0;
  String _bodyMarkdown = '';

  String? _lastSubject;
  String? _lastBody;
  String _subjectPreview = '';
  String _bodyPreview = '';
  String _emailPreview = '';
  String _defaultSubject = '';
  String _defaultBody = '';

  bool _isLoading = false;
  FocusScopeNode? _focusNode;
  TabController? _controller;
  bool _updateReminders = false;

  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    final company = state.company;
    final settingsUIState = state.settingsUIState;
    final length = company.markdownEmailEnabled ? 3 : 2;

    _focusNode = FocusScopeNode();
    _controller = TabController(
        vsync: this, length: length, initialIndex: settingsUIState.tabIndex);
    _controller!.addListener(_onTabChanged);

    _controllers = [
      _subjectController,
      _bodyController,
    ];

    _subjectController.addListener(_onTextChanged);
    _bodyController.addListener(_onTextChanged);

    if (settingsUIState.tabIndex == length - 1) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        _renderTemplate();
      });
    }
  }

  @override
  void didChangeDependencies() {
    _loadTemplate(widget.viewModel.selectedTemplate);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onTextChanged);
      controller.dispose();
    });
    super.dispose();
  }

  void _loadTemplate(EmailTemplate emailTemplate) {
    _selectedTemplate = emailTemplate;

    final viewModel = widget.viewModel;
    final settings = viewModel.settings;
    final state = viewModel.state;
    final templateMap = state.staticState.templateMap;
    final template = templateMap[emailTemplate.name] ?? TemplateEntity();

    _bodyController.removeListener(_onTextChanged);
    _subjectController.removeListener(_onTextChanged);

    _bodyController.text = settings.getEmailBody(emailTemplate) ?? '';
    _subjectController.text = settings.getEmailSubject(emailTemplate) ?? '';

    if (_subjectController.text.isEmpty) {
      _subjectController.text = template.subject;
    }

    if (_bodyController.text.isEmpty) {
      _bodyController.text = template.body;
    }

    if (viewModel.state.company.markdownEmailEnabled &&
        _bodyController.text.trim().startsWith('<')) {
      _bodyController.text = html2md.convert(_bodyController.text);

      // TODO remove this, it's currently needed to fix $start\_date
      if (emailTemplate.name == EmailTemplate.statement.name) {
        _bodyController.text =
            _bodyController.text.replaceAll('\\_date', '_date');
      }
    }

    _bodyController.addListener(_onTextChanged);
    _subjectController.addListener(_onTextChanged);

    setState(() {
      _defaultSubject = template.subject;
      _defaultBody = template.body;
      _bodyMarkdown = _bodyController.text;
      _subjectPreview = '';
      _bodyPreview = '';
      _emailPreview = '';

      if (state.company.markdownEmailEnabled &&
          _defaultBody.trim().startsWith('<')) {
        _defaultBody = html2md.convert(_defaultBody);
      }
    });
  }

  void _onTextChanged() {
    _debouncer.run(() {
      _onChanged();
    });
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final templateMap = viewModel.state.staticState.templateMap;
    final template = templateMap[_selectedTemplate!.name] ?? TemplateEntity();

    SettingsEntity settings = widget.viewModel.settings;
    String? body = _bodyController.text.trim();
    String? subject = _subjectController.text.trim();

    if (subject.isEmpty || subject == template.subject) {
      subject = null;
    }

    if (body.isEmpty ||
        body == template.body ||
        body == html2md.convert(template.body)) {
      body = null;
    }

    if (_selectedTemplate == EmailTemplate.invoice) {
      settings = settings.rebuild((b) => b
        ..emailBodyInvoice = body
        ..emailSubjectInvoice = subject);
    } else if (_selectedTemplate == EmailTemplate.quote) {
      settings = settings.rebuild((b) => b
        ..emailBodyQuote = body
        ..emailSubjectQuote = subject);
    } else if (_selectedTemplate == EmailTemplate.credit) {
      settings = settings.rebuild((b) => b
        ..emailBodyCredit = body
        ..emailSubjectCredit = subject);
    } else if (_selectedTemplate == EmailTemplate.payment) {
      settings = settings.rebuild((b) => b
        ..emailBodyPayment = body
        ..emailSubjectPayment = subject);
    } else if (_selectedTemplate == EmailTemplate.payment_partial) {
      settings = settings.rebuild((b) => b
        ..emailBodyPaymentPartial = body
        ..emailSubjectPaymentPartial = subject);
    } else if (_selectedTemplate == EmailTemplate.reminder1) {
      settings = settings.rebuild((b) => b
        ..emailBodyReminder1 = body
        ..emailSubjectReminder1 = subject);
    } else if (_selectedTemplate == EmailTemplate.reminder2) {
      settings = settings.rebuild((b) => b
        ..emailBodyReminder2 = body
        ..emailSubjectReminder2 = subject);
    } else if (_selectedTemplate == EmailTemplate.reminder3) {
      settings = settings.rebuild((b) => b
        ..emailBodyReminder3 = body
        ..emailSubjectReminder3 = subject);
    } else if (_selectedTemplate == EmailTemplate.reminder_endless) {
      settings = settings.rebuild((b) => b
        ..emailBodyReminderEndless = body
        ..emailSubjectReminderEndless = subject);
    } else if (_selectedTemplate == EmailTemplate.custom1) {
      settings = settings.rebuild((b) => b
        ..emailBodyCustom1 = body
        ..emailSubjectCustom1 = subject);
    } else if (_selectedTemplate == EmailTemplate.custom2) {
      settings = settings.rebuild((b) => b
        ..emailBodyCustom2 = body
        ..emailSubjectCustom2 = subject);
    } else if (_selectedTemplate == EmailTemplate.custom3) {
      settings = settings.rebuild((b) => b
        ..emailBodyCustom3 = body
        ..emailSubjectCustom3 = subject);
    } else if (_selectedTemplate == EmailTemplate.statement) {
      settings = settings.rebuild((b) => b
        ..emailBodyStatement = body
        ..emailSubjectStatement = subject);
    } else if (_selectedTemplate == EmailTemplate.purchase_order) {
      settings = settings.rebuild((b) => b
        ..emailBodyPurchaseOrder = body
        ..emailSubjectPurchaseOrder = subject);
    }

    if (settings != widget.viewModel.settings) {
      widget.viewModel.onSettingsChanged(settings);
    }
  }

  void _onTabChanged() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateSettingsTab(tabIndex: _controller!.index));

    setState(() {
      _bodyMarkdown = _bodyController.text;
      _selectedIndex = _controller!.index;
    });

    final previewIndex = store.state.company.markdownEmailEnabled ? 2 : 1;

    if (_controller!.index != previewIndex) {
      return;
    }

    _renderTemplate();
  }

  void _renderTemplate() {
    final subject = _subjectController.text.trim();
    final body = _bodyController.text.trim();

    if (subject == _lastSubject && body == _lastBody) {
      return;
    } else {
      _lastSubject = subject;
      _lastBody = body;
    }

    setState(() {
      _isLoading = true;
    });

    loadEmailTemplate(
        context: context,
        template: '${widget.viewModel.selectedTemplate}',
        body: body,
        subject: subject,
        onComplete: (subject, body, email, rawSubject, rawBody) {
          if (!mounted) {
            return;
          }

          setState(() {
            _isLoading = false;
            _subjectPreview = subject!.trim();
            _bodyPreview = body!.trim();
            _emailPreview = email!.trim();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;
    final template = widget.viewModel.selectedTemplate;
    final company = state.company;
    final enableCustomEmail = state.isProPlan;

    return EditScaffold(
      title: localization.templatesAndReminders,
      onSavePressed: (context) {
        viewModel.onSavePressed(context, _updateReminders);
        _updateReminders = false;
      },
      appBarBottom: TabBar(
        key: ValueKey(state.settingsUIState.updatedAt),
        controller: _controller,
        isScrollable: false,
        tabs: [
          Tab(
            text: localization.settings,
          ),
          if (company.markdownEmailEnabled)
            Tab(
              text: localization.design,
            ),
          Tab(
            text: localization.preview,
          ),
        ],
      ),
      body: AppTabForm(
        tabBarKey: ValueKey('__${state.settingsUIState.updatedAt}__'),
        tabController: _controller,
        formKey: _formKey,
        focusNode: _focusNode,
        children: <Widget>[
          ScrollableListView(
            primary: true,
            children: <Widget>[
              FormCard(children: <Widget>[
                AppDropdownButton<EmailTemplate>(
                  labelText: localization.template,
                  value: template,
                  showBlank: false,
                  onChanged: (dynamic value) => setState(() {
                    _loadTemplate(value);
                    _onChanged();
                    viewModel.onTemplateChanged(value);
                  }),
                  items: EmailTemplate.values.where((value) {
                    if ([
                          EmailTemplate.invoice,
                          EmailTemplate.statement,
                          EmailTemplate.payment,
                          EmailTemplate.payment_partial,
                        ].contains(value) &&
                        !company.isModuleEnabled(EntityType.invoice)) {
                      return false;
                    } else if (value == EmailTemplate.quote &&
                        !company.isModuleEnabled(EntityType.quote)) {
                      return false;
                    } else if (value == EmailTemplate.credit &&
                        !company.isModuleEnabled(EntityType.credit)) {
                      return false;
                    } else if (value == EmailTemplate.purchase_order &&
                        !company.isModuleEnabled(EntityType.purchaseOrder)) {
                      return false;
                    }
                    return true;
                  }).map((item) {
                    var name = localization.lookup(item.name);
                    if (item == EmailTemplate.reminder1) {
                      name = localization.firstReminder;
                    } else if (item == EmailTemplate.reminder2) {
                      name = localization.secondReminder;
                    } else if (item == EmailTemplate.reminder3) {
                      name = localization.thirdReminder;
                    } else if (item == EmailTemplate.custom1) {
                      name = localization.firstCustom;
                    } else if (item == EmailTemplate.custom2) {
                      name = localization.secondCustom;
                    } else if (item == EmailTemplate.custom3) {
                      name = localization.thirdCustom;
                    }

                    return DropdownMenuItem<EmailTemplate>(
                      child: Text(name),
                      value: item,
                    );
                  }).toList(),
                ),
                if (!enableCustomEmail && state.isTrial)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: IconMessage(localization.customEmailsDisabledHelp),
                  ),
                DecoratedFormField(
                  label: localization.subject,
                  controller: _subjectController,
                  hint: _defaultSubject,
                  keyboardType: TextInputType.text,
                  enabled: enableCustomEmail,
                ),
                DecoratedFormField(
                  label: localization.body,
                  controller: _bodyController,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  hint: _defaultBody,
                  enabled: enableCustomEmail,
                ),
              ]),
              if (template == EmailTemplate.reminder1)
                ReminderSettings(
                    key: ValueKey('__reminder1_${template}__'),
                    viewModel: viewModel,
                    enabled: settings.enableReminder1,
                    numDays: settings.numDaysReminder1,
                    schedule: settings.scheduleReminder1,
                    feeAmount: settings.lateFeeAmount1,
                    feePercent: settings.lateFeePercent1,
                    onChanged:
                        (enabled, days, schedule, feeAmount, feePercent) {
                      _updateReminders = true;
                      viewModel.onSettingsChanged(settings.rebuild((b) => b
                        ..enableReminder1 = enabled
                        ..numDaysReminder1 = days
                        ..scheduleReminder1 = schedule
                        ..lateFeeAmount1 = feeAmount
                        ..lateFeePercent1 = feePercent));
                    }),
              if (template == EmailTemplate.reminder2)
                ReminderSettings(
                    key: ValueKey('__reminder2_${template}__'),
                    viewModel: viewModel,
                    enabled: settings.enableReminder2,
                    numDays: settings.numDaysReminder2,
                    schedule: settings.scheduleReminder2,
                    feeAmount: settings.lateFeeAmount2,
                    feePercent: settings.lateFeePercent2,
                    onChanged:
                        (enabled, days, schedule, feeAmount, feePercent) {
                      _updateReminders = true;
                      viewModel.onSettingsChanged(settings.rebuild((b) => b
                        ..enableReminder2 = enabled
                        ..numDaysReminder2 = days
                        ..scheduleReminder2 = schedule
                        ..lateFeeAmount2 = feeAmount
                        ..lateFeePercent2 = feePercent));
                    }),
              if (template == EmailTemplate.reminder3)
                ReminderSettings(
                    key: ValueKey('__reminder3_${template}__'),
                    viewModel: viewModel,
                    enabled: settings.enableReminder3,
                    numDays: settings.numDaysReminder3,
                    schedule: settings.scheduleReminder3,
                    feeAmount: settings.lateFeeAmount3,
                    feePercent: settings.lateFeePercent3,
                    onChanged:
                        (enabled, days, schedule, feeAmount, feePercent) {
                      _updateReminders = true;
                      viewModel.onSettingsChanged(settings.rebuild((b) => b
                        ..enableReminder3 = enabled
                        ..numDaysReminder3 = days
                        ..scheduleReminder3 = schedule
                        ..lateFeeAmount3 = feeAmount
                        ..lateFeePercent3 = feePercent));
                    }),
              if (template == EmailTemplate.reminder_endless)
                FormCard(
                  children: <Widget>[
                    BoolDropdownButton(
                      label: localization.sendEmail,
                      value: settings.enableReminderEndless,
                      onChanged: (value) {
                        _updateReminders = true;
                        viewModel.onSettingsChanged(settings
                            .rebuild((b) => b..enableReminderEndless = value));
                      },
                      iconData: Icons.email,
                    ),
                    AppDropdownButton(
                        labelText: localization.frequency,
                        value: settings.endlessReminderFrequencyId == '0'
                            ? null
                            : settings.endlessReminderFrequencyId,
                        onChanged: (dynamic value) {
                          _updateReminders = true;
                          viewModel.onSettingsChanged(settings.rebuild(
                              (b) => b..endlessReminderFrequencyId = value));
                        },
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
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: OutlinedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconText(
                      text: localization.viewDocs.toUpperCase(),
                      icon: MdiIcons.openInNew,
                    ),
                  ),
                  onPressed: () => launchUrl(Uri.parse(kDocsEmailVariablesUrl)),
                ),
              ),
              VariablesHelp(
                showInvoiceAsQuote: template == EmailTemplate.quote,
                showInvoiceAsInvoices: [
                  EmailTemplate.payment,
                  EmailTemplate.payment_partial,
                ].contains(template),
              ),
              SizedBox(height: 16),
            ],
          ),
          if (company.markdownEmailEnabled)
            ColoredBox(
              color: Colors.white,
              child: ExampleEditor(
                key: ValueKey('__tab_${_selectedIndex}__'),
                value: _bodyMarkdown,
                onChanged: (value) {
                  if (value.trim() != _bodyController.text.trim()) {
                    _bodyPreview = '';
                    _emailPreview = '';
                    _bodyController.text = value;
                  }
                },
              ),
            ),
          if (supportsInlineBrowser())
            EmailPreview(
              isLoading: _isLoading,
              subject: _subjectPreview,
              body: _emailPreview,
            )
          else
            Stack(
              alignment: Alignment.topCenter,
              children: [
                if (_isLoading || _bodyPreview.isEmpty)
                  LoadingIndicator()
                else
                  IgnorePointer(
                    child: ColoredBox(
                      color: Colors.white,
                      child: ExampleEditor(
                        value: html2md.convert(_bodyPreview),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class ReminderSettings extends StatefulWidget {
  const ReminderSettings({
    Key? key,
    required this.viewModel,
    required this.enabled,
    required this.schedule,
    required this.onChanged,
    required this.numDays,
    required this.feeAmount,
    required this.feePercent,
  }) : super(key: key);

  final TemplatesAndRemindersVM viewModel;
  final bool? enabled;
  final int? numDays;
  final double? feeAmount;
  final double? feePercent;
  final String? schedule;
  final Function(bool?, int?, String?, double?, double?) onChanged;

  @override
  _ReminderSettingsState createState() => _ReminderSettingsState();
}

class _ReminderSettingsState extends State<ReminderSettings> {
  final _daysController = TextEditingController();
  final _feeAmountController = TextEditingController();
  final _feePercentController = TextEditingController();

  bool? _enabled;
  String? _schedule;

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
        formatNumberType: FormatNumberType.inputMoney)!;
    _feePercentController.text = formatNumber(widget.feePercent, context,
        formatNumberType: FormatNumberType.inputMoney)!;

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
    final int? days = parseInt(_daysController.text.trim(), zeroIsNull: true);
    final feeAmount =
        parseDouble(_feeAmountController.text.trim(), zeroIsNull: true);
    final feePercent =
        parseDouble(_feePercentController.text.trim(), zeroIsNull: true);

    widget.onChanged(_enabled, days, _schedule, feeAmount, feePercent);
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.viewModel.state;
    final localization = AppLocalization.of(context)!;

    return Column(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            DecoratedFormField(
              label: localization.days,
              controller: _daysController,
              keyboardType: TextInputType.number,
            ),
            AppDropdownButton(
              showBlank: true,
              blankLabel:
                  state.settingsUIState.isFiltered ? '' : localization.disabled,
              value: widget.schedule,
              labelText: localization.schedule,
              onChanged: (dynamic value) {
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
                iconData: Icons.email,
              ),
            ),
            DecoratedFormField(
              label: localization.lateFeeAmount,
              controller: _feeAmountController,
              isMoney: true,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
            ),
            DecoratedFormField(
              label: localization.lateFeePercent,
              controller: _feePercentController,
              isPercent: true,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: true),
            ),
          ],
        ),
      ],
    );
  }
}

class EmailPreview extends StatelessWidget {
  const EmailPreview({
    required this.subject,
    required this.body,
    required this.isLoading,
  });

  final String subject;
  final String body;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListDivider(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 10, top: 12, bottom: 12),
                child: Text(
                  subject,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                ),
              ),
              Expanded(
                child: AppWebView(html: body),
              ),
            ],
          ),
          if (isLoading)
            SizedBox(
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
