import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/invoice/email_invoice_dialog_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

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

  Widget _buildSend(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(localization.template,
                    style: Theme.of(context).textTheme.subhead,
                  )
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: localization.initialEmail,
                  onChanged: (template) {

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
            ],
          ),
        )
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
          ),        ),
      ),
    );
  }
}
