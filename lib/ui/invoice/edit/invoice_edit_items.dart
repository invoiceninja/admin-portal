import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/form_card.dart';

class InvoiceEditItems extends StatefulWidget {
  InvoiceEditItems({
    Key key,
    @required this.invoice,
  }) : super(key: key);

  final InvoiceEntity invoice;

  @override
  InvoiceEditItemsState createState() => new InvoiceEditItemsState();
}

class InvoiceEditItemsState extends State<InvoiceEditItems>
    with AutomaticKeepAliveClientMixin {
      
  List<InvoiceItemEntity> invoiceItems;
  List<GlobalKey<ItemEditDetailsState>> invoiceItemKeys;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('invoice');
    var invoice = widget.invoice;
    invoiceItems = invoice.invoiceItems.toList();
    invoiceItemKeys = invoice.invoiceItems
        .map((invoiceItem) => GlobalKey<ItemEditDetailsState>())
        .toList();
  }

  List<InvoiceItemEntity> getItems() {
    List<InvoiceItemEntity> invoiceItems = [];
    invoiceItemKeys.forEach((invoiceItemKey) {
      if (invoiceItemKey.currentState != null) {
        invoiceItems.add(invoiceItemKey.currentState.getItem());
      }
    });
    return invoiceItems;
  }

  _onAddPressed() {
    setState(() {
      invoiceItems.add(InvoiceItemEntity());
      invoiceItemKeys.add(GlobalKey<ItemEditDetailsState>());
    });
  }

  _onRemovePressed(GlobalKey<ItemEditDetailsState> key) {
    setState(() {
      var index = invoiceItemKeys.indexOf(key);
      invoiceItemKeys.removeAt(index);
      invoiceItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    List<Widget> invoiceItems = [];

    for (var i = 0; i < invoiceItems.length; i++) {
      var invoiceItem = invoiceItems[i];
      var invoiceItemKey = invoiceItemKeys[i];
      invoiceItems.add(ItemEditDetails(
        //invoiceItem: invoiceItem,
        key: invoiceItemKey,
        onRemovePressed: (key) => _onRemovePressed(key),
        isRemoveVisible: invoiceItems.length > 1,
      ));
    }

    invoiceItems.add(Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
      child: RaisedButton(
        elevation: 4.0,
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).secondaryHeaderColor,
        child: Text(localization.addContact.toUpperCase()),
        onPressed: _onAddPressed,
      ),
    ));

    return ListView(
      children: invoiceItems,
    );
  }
}

class ItemEditDetails extends StatefulWidget {
  ItemEditDetails({
    Key key,
    @required this.invoiceItem,
    @required this.onRemovePressed,
    @required this.isRemoveVisible,
  }) : super(key: key);

  final InvoiceItemEntity invoiceItem;
  final Function(GlobalKey<ItemEditDetailsState>) onRemovePressed;
  final bool isRemoveVisible;

  @override
  ItemEditDetailsState createState() => ItemEditDetailsState();
}

class ItemEditDetailsState extends State<ItemEditDetails> {
  String _productKey;
  String _notes;
  double _cost;
  double _qty;

  InvoiceItemEntity getItem() {
    return widget.invoiceItem.rebuild((b) => b
      //..phone = _phone
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);

    _confirmDelete() {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              semanticLabel: localization.areYouSure,
              title: Text(localization.areYouSure),
              actions: <Widget>[
                new FlatButton(
                    child: Text(localization.cancel.toUpperCase()),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                new FlatButton(
                    child: Text(localization.ok.toUpperCase()),
                    onPressed: () {
                      widget.onRemovePressed(widget.key);
                      Navigator.pop(context);
                    })
              ],
            ),
      );
    }

    return FormCard(
      children: <Widget>[
        TextFormField(
          autocorrect: false,
          initialValue: widget.invoiceItem.productKey,
          onSaved: (value) => _productKey = value.trim(),
          decoration: InputDecoration(
            labelText: localization.product,
          ),
        ),
        TextFormField(
          autocorrect: false,
          initialValue: widget.invoiceItem.notes,
          maxLines: 4,
          onSaved: (value) => _notes = value.trim(),
          decoration: InputDecoration(
            labelText: localization.description,
          ),
        ),
        TextFormField(
          autocorrect: false,
          initialValue: widget.invoiceItem.cost?.toStringAsFixed(2),
          onSaved: (value) => _cost = double.tryParse(value) ?? 0.0,
          decoration: InputDecoration(
            labelText: localization.unitCost,
          ),
        ),
        TextFormField(
          autocorrect: false,
          initialValue: widget.invoiceItem.qty?.toStringAsFixed(2),
          onSaved: (value) => _qty = double.tryParse(value) ?? 0.0,
          decoration: InputDecoration(
            labelText: localization.quantity,
          ),
        ),
        widget.isRemoveVisible
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: FlatButton(
                      child: Text(
                        localization.remove,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      onPressed: _confirmDelete,
                    ),
                  )
                ],
              )
            : Container(),
      ],
    );
  }
}
