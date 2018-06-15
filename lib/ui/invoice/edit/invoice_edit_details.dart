import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/ui/app/entity_dropdown.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:invoiceninja/utils/localization.dart';

class InvoiceEditDetails extends StatefulWidget {
  InvoiceEditDetails({
    Key key,
    @required this.invoice,
    @required this.clientList,
    @required this.clientMap,
  }) : super(key: key);

  final InvoiceEntity invoice;
  final List<int> clientList;
  final BuiltMap<int, ClientEntity> clientMap;

  @override
  InvoiceEditDetailsState createState() => new InvoiceEditDetailsState();
}

class InvoiceEditDetailsState extends State<InvoiceEditDetails>
    with AutomaticKeepAliveClientMixin {
  int clientId;
  String invoiceDate;
  String dueDate;
  double partial;
  String partialDate;
  String invoiceNumber;
  String poNumber;
  double discount;
  bool isAmountDiscount;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var invoice = widget.invoice;

    return ListView(
      children: <Widget>[
        FormCard(
          children: <Widget>[
            invoice.isNew()
                ? EntityDropdown(
                    labelText: localization.client,
                    entityList: widget.clientList,
                    entityMap: widget.clientMap,
                ) : TextFormField(
                    autocorrect: false,
                    onSaved: (value) => invoiceNumber = value.trim(),
                    initialValue: invoice.invoiceNumber,
                    decoration: InputDecoration(
                      labelText: localization.invoiceNumber,
                    ),
                  ),
            TextFormField(
              autocorrect: false,
              onSaved: (value) => poNumber = value.trim(),
              initialValue: invoice.poNumber,
              decoration: InputDecoration(
                labelText: localization.poNumber,
              ),
            ),
            TextFormField(
              autocorrect: false,
              onSaved: (value) => discount = double.tryParse(value) ?? 0.0,
              initialValue: invoice.discount?.toStringAsFixed(2),
              decoration: InputDecoration(
                labelText: localization.discount,
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              autocorrect: false,
              onSaved: (value) => partial = double.tryParse(value) ?? 0.0,
              initialValue: invoice.partial?.toStringAsFixed(2),
              decoration: InputDecoration(
                labelText: localization.partial,
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }
}
