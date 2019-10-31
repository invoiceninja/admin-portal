import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_form.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String kExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

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

  FocusScopeNode _focusNode;

  bool autoValidate = false;

  WebViewController _controller;

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

    //_subjectController.text =  ;
    //_bodyController.text = widget.body;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    final str =
        '<b>${_subjectController.text.trim()}</b><br/><br/>${_bodyController.text.trim()}';
    final String contentBase64 = base64Encode(const Utf8Encoder().convert(str));
    final url = 'data:text/html;base64,$contentBase64';
    print('url: $url');

    _controller.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    /*
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(kExamplePage));
    final url = 'data:text/html;base64,$contentBase64';
    print('url: $url');
    */

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
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                //javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
