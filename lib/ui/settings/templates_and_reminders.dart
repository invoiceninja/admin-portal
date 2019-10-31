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

  final _nameController = TextEditingController();

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
    _controllers = [_nameController];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    /*
    final product = widget.viewModel.product;
    _productKeyController.text = product.productKey;
      */

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  void _onChanged() {
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final settings = viewModel.settings;

    final String contentBase64 =
    base64Encode(const Utf8Encoder().convert(kExamplePage));
    final url = 'data:text/html;base64,$contentBase64';
    print('url: $url');


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
                    //controller: _subjectController,
                  ),
                  DecoratedFormField(
                    label: localization.body,
                    //controller: _bodyController,
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
                initialUrl: url,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TemplateEditor extends StatefulWidget {
  const TemplateEditor({this.subject, this.body});

  final String subject;
  final String body;

  @override
  _TemplateEditorState createState() => _TemplateEditorState();
}

class _TemplateEditorState extends State<TemplateEditor> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _subjectController,
      _bodyController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _subjectController.text = widget.subject;
    _bodyController.text = widget.body;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });
    super.dispose();
  }

  void _onChanged() {
    print('## CHANGED: ${_subjectController.text} - ${_bodyController.text}');
    /*
    final product = widget.viewModel.product.rebuild((b) => b
      ..customValue2 = _custom2Controller.text.trim());
    if (product != widget.viewModel.product) {
      widget.viewModel.onChanged(product);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListView(
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
        FormCard(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            WebView(
              //initialUrl: url,
              initialUrl: 'https://flutter.dev',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
            ),
            Text('subject'),
            SizedBox(height: 15),
            Text('body'),
          ],
        ),
      ],
    );
  }
}
