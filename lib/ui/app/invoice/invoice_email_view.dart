import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_email_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/lists/activity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_scaffold.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

//import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:html/parser.dart';

class InvoiceEmailView extends StatefulWidget {
  const InvoiceEmailView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final EmailEntityVM viewModel;

  @override
  _InvoiceEmailViewState createState() => new _InvoiceEmailViewState();
}

class _InvoiceEmailViewState extends State<InvoiceEmailView> {
  EmailTemplate selectedTemplate;
  String emailSubject;
  String emailBody;

  final _debouncer = Debouncer();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  List<TextEditingController> _controllers = [];

  @override
  void didChangeDependencies() {
    _controllers = [
      _subjectController,
      _bodyController,
    ];

    final invoice = widget.viewModel.invoice;
    final client = widget.viewModel.client;

    loadTemplate(client.getNextEmailTemplate(invoice.id));

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
    _debouncer.run(() {
      setState(() {
        emailSubject = _subjectController.text;
        emailBody = _bodyController.text;
        updateTemplate();
      });
    });
  }

  void loadTemplate(EmailTemplate template) {
    final viewModel = widget.viewModel;
    final company = viewModel.company;

    selectedTemplate = template;

    switch (template) {
      case EmailTemplate.initial:
        if (false) {
          emailSubject = company.settings.emailSubjectQuote;
          emailBody = company.settings.emailBodyQuote;
        } else {
          emailSubject = company.settings.emailSubjectInvoice;
          emailBody = company.settings.emailBodyInvoice;
        }
        break;
      case EmailTemplate.reminder1:
        emailSubject = company.settings.emailSubjectReminder1;
        emailBody = company.settings.emailBodyReminder1;
        break;
      case EmailTemplate.reminder2:
        emailSubject = company.settings.emailSubjectReminder2;
        emailBody = company.settings.emailBodyReminder2;
        break;
      case EmailTemplate.reminder3:
        emailSubject = company.settings.emailSubjectReminder3;
        emailBody = company.settings.emailBodyReminder3;
        break;
    }

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _subjectController.text = emailSubject;
    _bodyController.text = (emailBody ?? '').replaceAll('</div>', '</div>\n');

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    updateTemplate();
  }

  void updateTemplate() {
    // TODO implement server-side solution
    //final viewModel = widget.viewModel;
    //emailSubject = processTemplate(emailSubject, viewModel.invoice, context);
    //emailBody = processTemplate(emailBody, viewModel.invoice, context);

    emailBody = '';
    emailSubject = '';
  }

  Widget _buildPreview(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Container(
      //color: Colors.white,
      child: Column(
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
                          setState(() => loadTemplate(template)),
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
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  //color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, top: 26.0, right: 14.0, bottom: 24.0),
                    child: Text(
                      emailSubject,
                      style: TextStyle(
                        //color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  //color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                        parse(emailBody.replaceAll('</div>', '\n')).body.text),
                  ),
                  /*
                  child: HtmlView(
                    data: emailBody,
                  ),
                  */
                ),
              ],
            ),
          ),
        ],
      ),
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
      return Center(
        child: Text(localization.noHistory,
            style: TextStyle(fontSize: 26, color: Colors.grey)),
      );
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
                key: ValueKey(
                    '__email_invoice_${widget.viewModel.invoice.id}__'),
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
