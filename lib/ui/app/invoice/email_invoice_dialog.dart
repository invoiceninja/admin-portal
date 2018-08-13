import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/email_invoice_dialog_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:invoiceninja_flutter/utils/templates.dart';

class EmailInvoiceView extends StatefulWidget {
  final EmailInvoiceDialogVM viewModel;

  const EmailInvoiceView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _EmailInvoiceViewState createState() => new _EmailInvoiceViewState();
}

class _EmailInvoiceViewState extends State<EmailInvoiceView> {
  EmailTemplate selectedTemplate;
  String emailSubject;
  String emailBody;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localization = AppLocalization.of(context);
    final company = widget.viewModel.company;

    selectedTemplate = EmailTemplate.initial;
    emailSubject = company.emailSubjectInvoice;
    emailBody = company.emailBodyInvoice;
    updateTemplate();
  }

  void updateTemplate() {
    final viewModel = widget.viewModel;

    emailSubject = processTemplate(
        emailSubject, viewModel.invoice, context);
    emailBody = processTemplate(
        emailBody, viewModel.invoice, context);
  }

  Widget _buildSend(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              DropdownButtonHideUnderline(
                child: DropdownButton<EmailTemplate>(
                  value: selectedTemplate,
                  onChanged: (value) {
                    setState(() {
                      final viewModel = widget.viewModel;
                      final localization = AppLocalization.of(context);
                      final company = viewModel.company;
                      selectedTemplate = value;

                      switch (value) {
                        case EmailTemplate.initial:
                          emailSubject = company.emailSubjectInvoice;
                          emailBody = company.emailBodyInvoice;
                          break;
                        case EmailTemplate.reminder1:
                          emailSubject = company.emailSubjectReminder1;
                          emailBody = company.emailBodyReminder1;
                          break;
                        case EmailTemplate.reminder2:
                          emailSubject = company.emailSubjectReminder2;
                          emailBody = company.emailBodyReminder2;
                          break;
                        case EmailTemplate.reminder3:
                          emailSubject = company.emailSubjectReminder3;
                          emailBody = company.emailBodyReminder3;
                          break;
                      }

                      updateTemplate();
                    });
                  },
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
              SizedBox(
                width: 10.0,
              ),
              ElevatedButton(
                label: localization.send,
                color: Colors.orange,
                onPressed: () {},
              )
            ],
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(
                  emailSubject,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: HtmlView(
                //data: widget.viewModel.company.emailBodyInvoice,
                data: emailBody,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final client = viewModel.client;
    //final company = viewModel.company;

    if (client.areActivitiesStale) {
      return SimpleDialog(children: <Widget>[LoadingDialog()]);
    }

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.send)),
                    Tab(icon: Icon(Icons.edit)),
                    Tab(icon: Icon(Icons.history)),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildSend(context),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
