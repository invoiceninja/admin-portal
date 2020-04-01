import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/settings/templates_and_reminders.dart';
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
  String _bodyPreview = '';
  String _subjectPreview = '';
  bool _isLoading = false;

  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  TabController _controller;
  List<TextEditingController> _controllers = [];

  static const kTabPreview = 0;

  //static const kTabEdit = 1;
  //static const kTabHistory = 2;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    _controller.addListener(_loadTemplate);
    _controllers = [
      _subjectController,
      _bodyController,
    ];

    switch (widget.viewModel.invoice.entityType) {
      case EntityType.invoice:
        selectedTemplate = EmailTemplate.invoice;
        break;
      case EntityType.quote:
        selectedTemplate = EmailTemplate.quote;
        break;
      case EntityType.credit:
        selectedTemplate = EmailTemplate.credit;
        break;
    }
  }

  @override
  void didChangeDependencies() {
    _loadTemplate();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadTemplate);
    _controller.dispose();
    _controllers.forEach((dynamic controller) {
      controller.dispose();
    });

    super.dispose();
  }

  void _loadTemplate() {
    if (_isLoading || _controller.index != kTabPreview) {
      return;
    }

    final origSubject = _subjectController.text.trim();
    final origBody = _bodyController.text.trim();

    setState(() {
      _isLoading = true;
    });

    loadEmailTemplate(
        context: context,
        subject: origSubject,
        body: origBody,
        template: '$selectedTemplate',
        invoice: widget.viewModel.invoice,
        onComplete: (subject, body, wrapper) {
          setState(() {
            _isLoading = false;
            _subjectPreview = subject.trim();
            _bodyPreview = wrapper.replaceFirst('\$body', body).trim();

            if (origSubject.isEmpty && origBody.isEmpty) {
              _subjectController.text = subject.trim();
              _bodyController.text = body.trim();
            }
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
                    onChanged: (template) {
                      setState(() {
                        _subjectController.text = '';
                        _bodyController.text = '';
                        selectedTemplate = template;
                        _loadTemplate();
                      });
                    },
                    items: [
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.initialEmail),
                        value: widget.viewModel.invoice.emailTemplate,
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
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.firstCustom),
                        value: EmailTemplate.custom1,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.secondCustom),
                        value: EmailTemplate.custom2,
                      ),
                      DropdownMenuItem<EmailTemplate>(
                        child: Text(localization.thirdCustom),
                        value: EmailTemplate.custom3,
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

  /*
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
   */

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final invoice = viewModel.invoice;

    return DefaultTabController(
      length: 2,
      child: EditScaffold(
        entity: invoice,
        title: localization.sendEmail,
        onCancelPressed: (context) =>
            viewEntity(context: context, entity: invoice),
        appBarBottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(text: localization.preview),
            Tab(text: localization.customize),
            //Tab(text: localization.history),
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
                children: [
                  _buildPreview(context),
                  _buildEdit(context),
                  //_buildHistory(context),
                ],
              ),
      ),
    );
  }
}
