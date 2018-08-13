import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/email_invoice_dialog_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

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
  String selectedTemplate;
  String emailSubject;
  String emailBody;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localization = AppLocalization.of(context);
    final company = widget.viewModel.company;

    selectedTemplate = localization.initialEmail;
    emailSubject = company.emailSubjectInvoice;
    emailBody = company.emailBodyInvoice;
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
                child: DropdownButton<String>(
                  value: selectedTemplate,
                  onChanged: (value) {
                    setState(() {
                      final localization = AppLocalization.of(context);
                      final company = widget.viewModel.company;
                      selectedTemplate = value;

                      switch (value) {
                        //case const :
                      }
                      selectedTemplate = localization.initialEmail;
                      emailSubject = company.emailSubjectInvoice;
                      emailBody = company.emailBodyInvoice;
                    });
                  },
                  items: [
                    DropdownMenuItem<String>(
                      child: Text(localization.initialEmail),
                      value: localization.initialEmail,
                    ),
                    DropdownMenuItem<String>(
                      child: Text(localization.firstReminder),
                      value: localization.firstReminder,
                    ),
                    DropdownMenuItem<String>(
                      child: Text(localization.secondReminder),
                      value: localization.secondReminder,
                    ),
                    DropdownMenuItem<String>(
                      child: Text(localization.thirdReminder),
                      value: localization.thirdReminder,
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
