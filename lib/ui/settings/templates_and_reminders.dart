import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
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

class _TemplatesAndRemindersState extends State<TemplatesAndReminders> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _template = kEmailTemplateInvoice;
  FocusScopeNode _focusNode;
  WebViewController _controller;
  final _debouncer = Debouncer(milliseconds: 500);

  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
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

    _loadTemplate(kEmailTemplateInvoice);

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
      }

      widget.viewModel.onSettingsChanged(settings);

      final str =
          '<b>${_subjectController.text.trim()}</b><br/><br/>${_bodyController.text.trim()}';
      final String contentBase64 =
          base64Encode(const Utf8Encoder().convert(str));
      final url = 'data:text/html;base64,$contentBase64';
      _controller.loadUrl(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    return SettingsScaffold(
      title: localization.templatesAndReminders,
      onSavePressed: viewModel.onSavePressed,
      body: Column(
        children: <Widget>[
          AppForm(
            formKey: _formKey,
            children: <Widget>[
              FormCard(
                children: <Widget>[
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
                ],
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: WebView(
                //initialUrl: url,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
                //onPageFinished: (String url) {},
                //javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
