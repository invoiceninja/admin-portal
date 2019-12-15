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
import 'package:invoiceninja_flutter/ui/settings/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/templates.dart';

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
  String _lastSubject;
  String _lastBody;
  String _bodyPreview = '';
  String _subjectPreview = '';
  bool _isLoading = false;

  final _debouncer = Debouncer();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  TabController _controller;
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

    _emailSubject = company.settings.getEmailSubject(template) ?? '';
    _emailBody = company.settings.getEmailBody(template) ?? '';

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _subjectController.text = _emailSubject;
    _bodyController.text = (_emailBody ?? '').replaceAll('</div>', '</div>\n');

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    _handleTabSelection();
  }

  void _handleTabSelection() {
    if (_isLoading || _controller.index != kTabPreview) {
      return;
    }

    final subject = _subjectController.text.trim();
    final body = _bodyController.text.trim();

    if (subject == _lastSubject && body == _lastBody) {
      return;
    } else {
      _lastSubject = subject;
      _lastBody = body;
    }

    loadTemplate(
        context: context,
        subject: subject,
        body: body,
        onStart: (subject, body) {
          setState(() {
            _isLoading = true;
            _subjectPreview = subject;
            _bodyPreview = body;
          });
        },
        onComplete: (subject, body) {
          setState(() {
            _isLoading = false;
            _subjectPreview = subject;
            _bodyPreview = body;
          });
        });
  }

  Widget _buildPreview(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
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
                        value: widget.viewModel.invoice.emailTemplate,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.firstReminder),
                        value: EmailTemplate.firstReminder,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.secondReminder),
                        value: EmailTemplate.secondReminder,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.thirdReminder),
                        value: EmailTemplate.thirdReminder,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.firstCustom),
                        value: EmailTemplate.firstCustom,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.secondCustom),
                        value: EmailTemplate.secondCustom,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.thirdCustom),
                        value: EmailTemplate.thirdCustom,
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
          child: EmailPreview(
            isLoading: _isLoading,
            subject: _subjectPreview,
            body: _bodyPreview,
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
      child: EditScaffold(
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
