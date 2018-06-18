import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/form_card.dart';

class InvoiceEditItems extends StatelessWidget {
  InvoiceEditItems({
    Key key,
    @required this.invoice,
    @required this.onChanged,
  }) : super(key: key);

  final InvoiceEntity invoice;
  final Function(InvoiceEntity) onChanged;

  @override
  Widget build(BuildContext context) {
    return new Container();
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

  final _productKeyController = TextEditingController();
  final _notesController = TextEditingController();
  final _costController = TextEditingController();
  final _qtyController = TextEditingController();

  var _controllers = [];

  @override
  void didChangeDependencies() {

    _controllers = [
      _productKeyController,
      _notesController,
      _costController,
      _qtyController,
    ];

    _controllers.forEach((controller) => controller.removeListener(_onChanged));

    //var client = widget.client;
    //_nameController.text = client.name;

    _controllers.forEach((controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  _onChanged() {
    /*
    var client = widget.client.rebuild((b) => b
      ..name = _nameController.text.trim()
    );
    if (client != widget.client) {
      widget.onChanged(client);
    }
    */
  }

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
          decoration: InputDecoration(
            labelText: localization.product,
          ),
        ),
        TextFormField(
          autocorrect: false,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: localization.description,
          ),
        ),
        TextFormField(
          autocorrect: false,
          decoration: InputDecoration(
            labelText: localization.unitCost,
          ),
        ),
        TextFormField(
          autocorrect: false,
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
