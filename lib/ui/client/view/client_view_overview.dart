import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_selectors.dart';
import 'package:invoiceninja_flutter/redux/payment/payment_selectors.dart';
import 'package:invoiceninja_flutter/redux/quote/quote_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
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
    final state = StoreProvider.of<AppState>(context).state;
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
        FieldGrid(fields),
        Divider(
          height: 1.0,
        ),
        EntityListTile(
          icon: FontAwesomeIcons.filePdf,
          title: localization.invoices,
          onTap: () => viewModel.onEntityPressed(context, EntityType.invoice),
          subtitle: memoizedInvoiceStatsForClient(
              client.id,
              state.invoiceState.map,
              localization.active,
              localization.archived),
        ),
        EntityListTile(
          icon: FontAwesomeIcons.creditCard,
          title: localization.payments,
          onTap: () => viewModel.onEntityPressed(context, EntityType.payment),
          subtitle: memoizedPaymentStatsForClient(
              client.id,
              state.paymentState.map,
              state.invoiceState.map,
              localization.active,
              localization.archived),
        ),
        company.isModuleEnabled(EntityType.quote) ? EntityListTile(
          icon: FontAwesomeIcons.fileAlt,
          title: localization.quotes,
          onTap: () => viewModel.onEntityPressed(context, EntityType.quote),
          subtitle: memoizedQuoteStatsForClient(
              client.id,
              state.quoteState.map,
              localization.active,
              localization.archived),
        ) : Container(),
      ],
    );
  }
}

class EntityListTile extends StatelessWidget {
  const EntityListTile({this.icon, this.onTap, this.title, this.subtitle});

  final Function onTap;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Theme.of(context).canvasColor,
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            leading: Icon(icon, size: 18.0),
            trailing: Icon(Icons.navigate_next),
            onTap: onTap,
          ),
        ),
        Divider(),
      ],
    );
  }
}
