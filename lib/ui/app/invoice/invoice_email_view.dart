import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

//import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:invoiceninja_flutter/utils/templates.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InvoiceEmailView extends StatefulWidget {
  const InvoiceEmailView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EmailEntityVM viewModel;

  @override
  _InvoiceEmailViewState createState() => new _InvoiceEmailViewState();
}

class _InvoiceEmailViewState extends State<InvoiceEmailView>
    with SingleTickerProviderStateMixin {
  EmailTemplate selectedTemplate;
  String _emailSubject;
  String _emailBody;
  String _lastTemplate = '';
  String _templatePreview = '';
  bool _isLoading = false;

  final _debouncer = Debouncer();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  TabController _controller;
  WebViewController _webViewController;
  List<TextEditingController> _controllers = [];

  static const kTabPreview = 0;
  static const kTabEdit = 1;
  static const kTabHistory = 2;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
    _controller.addListener(_handleTabSelection);
  }

  @override
  void didChangeDependencies() {
    _controllers = [
      _subjectController,
      _bodyController,
    ];

    final invoice = widget.viewModel.invoice;
    final client = widget.viewModel.client;

    _loadTemplate(client.getNextEmailTemplate(invoice.id));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabSelection);
    _controller.dispose();
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    _debouncer.run(() {
      setState(() {
        _emailSubject = _subjectController.text;
        _emailBody = _bodyController.text;
      });
    });
  }

  void _loadTemplate(EmailTemplate template) {
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    selectedTemplate = template;

    switch (template) {
      case EmailTemplate.initial:
        if (false) {
          _emailSubject = company.settings.emailSubjectQuote;
          _emailBody = company.settings.emailBodyQuote;
        } else {
          _emailSubject = company.settings.emailSubjectInvoice;
          _emailBody = company.settings.emailBodyInvoice;
        }
        break;
      case EmailTemplate.reminder1:
        _emailSubject = company.settings.emailSubjectReminder1;
        _emailBody = company.settings.emailBodyReminder1;
        break;
      case EmailTemplate.reminder2:
        _emailSubject = company.settings.emailSubjectReminder2;
        _emailBody = company.settings.emailBodyReminder2;
        break;
      case EmailTemplate.reminder3:
        _emailSubject = company.settings.emailSubjectReminder3;
        _emailBody = company.settings.emailBodyReminder3;
        break;
    }

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _subjectController.text = _emailSubject;
    _bodyController.text = (_emailBody ?? '').replaceAll('</div>', '</div>\n');

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));
  }

  void _handleTabSelection() {
    print('## _handleTabSelection... index: ${_controller.index}');
    if (_isLoading || _controller.index != kTabPreview) {
      print('## skipping');
      return;
    }

    final str =
        '<b>${_subjectController.text.trim()}</b><br/><br/>${_bodyController.text.trim()}';

    if (str == _lastTemplate) {
      return;
    } else {
      _lastTemplate = str;
    }

    setState(() {
      _isLoading = true;
    });

    loadTemplate(
        context: context,
        template: str,
        onSuccess: (response) {
          setState(() {
            _isLoading = false;
            _templatePreview = 'data:text/html;base64,$response';
          });
        },
        onError: (response) {
          setState(() {
            _isLoading = false;
          });
        });
  }

  Widget _buildPreview(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                DropdownButtonHideUnderline(
                  child: DropdownButton<EmailTemplate>(
                    value: selectedTemplate,
                    onChanged: (template) =>
                        setState(() => _loadTemplate(template)),
                    items: [
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.initialEmail),
                        value: EmailTemplate.initial,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.firstReminder),
                        value: EmailTemplate.reminder1,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.secondReminder),
                        value: EmailTemplate.reminder2,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.thirdReminder),
                        value: EmailTemplate.reminder3,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TemplatePreview(_templatePreview),
              ),
              if (_isLoading)
                SizedBox(
                  height: 4.0,
                  child: LinearProgressIndicator(),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEdit(BuildContext context) {
    final localization = AppLocalization.of(context);

    return SingleChildScrollView(
      child: FormCard(
        children: <Widget>[
          DecoratedFormField(
            controller: _subjectController,
            label: localization.subject,
          ),
          DecoratedFormField(
            controller: _bodyController,
            label: localization.body,
            maxLines: 12,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }

  Widget _buildHistory(BuildContext context) {
    final localization = AppLocalization.of(context);
    final invoice = widget.viewModel.invoice;
    final client = widget.viewModel.client;
    final activities = client.getActivities(
        invoiceId: invoice.id, typeId: kActivityEmailInvoice);

    if (activities.isEmpty) {
      return HelpText(localization.noHistory);
    }

    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (BuildContext context, index) {
        final ActivityEntity activity = activities.elementAt(index);
        return ActivityListTile(activity: activity, enableNavigation: false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;

    return DefaultTabController(
      length: 3,
      child: SettingsScaffold(
        title: localization.sendEmail,
        onCancelPressed: (context) =>
            viewEntity(context: context, entity: widget.viewModel.invoice),
        appBarBottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(text: localization.preview),
            Tab(text: localization.customize),
            Tab(text: localization.history),
          ],
        ),
        saveLabel: localization.send,
        onSavePressed: (context) {
          viewModel.onSendPressed(context, selectedTemplate,
              _subjectController.text, _bodyController.text);
        },
        body: viewModel.isLoading
            ? LoadingIndicator()
            : TabBarView(
                controller: _controller,
                key: ValueKey('__invoice_${widget.viewModel.invoice.id}__'),
                children: [
                  _buildPreview(context),
                  _buildEdit(context),
                  _buildHistory(context),
                ],
              ),
      ),
    );
  }
}
