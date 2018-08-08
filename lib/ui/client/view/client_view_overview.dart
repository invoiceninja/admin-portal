import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/ui/app/icon_message.dart';
import 'package:invoiceninja_flutter/ui/app/two_value_header.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientOverview extends StatelessWidget {
  const ClientOverview({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ClientViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final client = viewModel.client;
    final company = viewModel.company;
    final state = StoreProvider
        .of<AppState>(context)
        .state;
    final statics = state.staticState;
    final fields = <String, String>{};

    if (client.languageId > 0 && client.languageId != company.languageId) {
      fields[ClientFields.language] =
          statics.languageMap[client.languageId].name;
    }

    if (client.currencyId > 0 && client.currencyId != company.currencyId) {
      fields[ClientFields.currency] =
          statics.currencyMap[client.currencyId].name;
    }

    if (client.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.client1);
      fields[label1] = client.customValue1;
    }

    if (client.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.client2);
      fields[label2] = client.customValue2;
    }

    final List<Widget> fieldWidgets = [];
    fields.forEach((field, value) {
      if (value != null && value.isNotEmpty) {
        fieldWidgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                localization.lookup(field),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ],
        ));
      }
    });

    return ListView(
      children: <Widget>[
        TwoValueHeader(
          label1: localization.paidToDate,
          value1: formatNumber(client.paidToDate, context, clientId: client.id),
          label2: localization.balanceDue,
          value2: formatNumber(client.balance, context, clientId: client.id),
        ),
        client.privateNotes != null && client.privateNotes.isNotEmpty
            ? IconMessage(client.privateNotes)
            : Container(),
        fieldWidgets.isNotEmpty
            ? Column(
          children: <Widget>[
            Container(
              color: Theme
                  .of(context)
                  .canvasColor,
              child: Padding(
                padding:
                EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  crossAxisCount: 2,
                  children: fieldWidgets,
                  childAspectRatio: 3.5,
                ),
              ),
            ),
            Container(
              color: Theme
                  .of(context)
                  .backgroundColor,
              height: 12.0,
            ),
          ],
        )
            : Container(),
        Divider(
          height: 1.0,
        ),
        Material(
          color: Theme
              .of(context)
              .canvasColor,
          child: ListTile(
            title: Text(localization.invoices),
            subtitle: Text(memoizedInvoiceStatsForClient(
                client.id, state.invoiceState.map, localization.active,
                localization.archived)),
            leading: Icon(FontAwesomeIcons.filePdfO, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () => viewModel.onInvoicesPressed(context),
          ),
        ),
        Divider(
          height: 1.0,
        ),
        /*
        Material(
          color: Theme
              .of(context)
              .canvasColor,
          child: ListTile(
            title: Text(localization.payments),
            leading: Icon(FontAwesomeIcons.creditCard, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
        ),
        Divider(
          height: 1.0,
        ),
        Material(
          color: Theme
              .of(context)
              .canvasColor,
          child: ListTile(
            title: Text(localization.quotes),
            leading: Icon(FontAwesomeIcons.fileAltO, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
        ),
        Divider(
          height: 1.0,
        ),
        Material(
          color: Theme
              .of(context)
              .canvasColor,
          child: ListTile(
            title: Text(localization.projects),
            leading: Icon(FontAwesomeIcons.briefcase, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
        ),
        Divider(
          height: 1.0,
        ),
        Material(
          color: Theme
              .of(context)
              .canvasColor,
          child: ListTile(
            title: Text(localization.tasks),
            leading: Icon(FontAwesomeIcons.clockO, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
        ),
        Divider(
          height: 1.0,
        ),
        Material(
          color: Theme
              .of(context)
              .canvasColor,
          child: ListTile(
            title: Text(localization.expenses),
            leading: Icon(FontAwesomeIcons.fileImageO, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
        ),
        Divider(
          height: 1.0,
        ),
        Material(
          color: Theme
              .of(context)
              .canvasColor,
          child: ListTile(
            title: Text(localization.vendors),
            leading: Icon(FontAwesomeIcons.building, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
        ),
        Divider(
          height: 1.0,
        ),
        */
      ],
    );
  }
}