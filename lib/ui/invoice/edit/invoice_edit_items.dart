import 'dart:math';

import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:invoiceninja/ui/invoice/edit/invoice_edit_items_vm.dart';
import 'package:invoiceninja/utils/formatting.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/utils/localization.dart';
import 'package:invoiceninja/ui/app/form_card.dart';
import 'package:redux/redux.dart';

class InvoiceEditItems extends StatelessWidget {
  InvoiceEditItems({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final InvoiceEditItemsVM viewModel;

  _showAddItemDialog(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return ItemSelector(viewModel.state);
    });
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var invoice = viewModel.invoice;
    var invoiceItems = invoice.invoiceItems.map((invoiceItem) =>
        ItemEditDetails(
            viewModel: viewModel,
            key: Key('__${EntityType.invoiceItem}_${invoiceItem.id}__'),
            invoiceItem: invoiceItem,
            index: invoice.invoiceItems.indexOf(invoiceItem)));

    return ListView(
      children: []
        ..addAll(invoiceItems)
        ..add(Padding(
          padding: const EdgeInsets.all(14.0),
          child: RaisedButton(
            elevation: 4.0,
            color: Theme.of(context).primaryColorDark,
            textColor: Theme.of(context).secondaryHeaderColor,
            child: Text(localization.addItem.toUpperCase()),
            onPressed: () => _showAddItemDialog(context),
          ),
        )),
    );
  }
}

class ItemEditDetails extends StatefulWidget {
  ItemEditDetails({
    Key key,
    @required this.index,
    @required this.invoiceItem,
    @required this.viewModel,
  }) : super(key: key);

  final int index;
  final InvoiceItemEntity invoiceItem;
  final InvoiceEditItemsVM viewModel;

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

    var invoiceItem = widget.invoiceItem;
    _productKeyController.text = invoiceItem.productKey;
    _notesController.text = invoiceItem.notes;
    _costController.text = formatNumber(
        invoiceItem.cost, widget.viewModel.state,
        formatNumberType: FormatNumberType.input);
    _qtyController.text = formatNumber(invoiceItem.qty, widget.viewModel.state,
        formatNumberType: FormatNumberType.input);

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
    var invoiceItem = widget.invoiceItem.rebuild((b) => b
      ..productKey = _productKeyController.text.trim()
      ..notes = _notesController.text.trim()
      ..cost = double.tryParse(_costController.text) ?? 0.0
      ..qty = double.tryParse(_qtyController.text) ?? 0.0);
    if (invoiceItem != widget.invoiceItem) {
      widget.viewModel.onChangedInvoiceItem(invoiceItem, widget.index);
    }
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
                      widget.viewModel.onRemoveInvoiceItemPressed(widget.index);
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
          controller: _productKeyController,
          decoration: InputDecoration(
            labelText: localization.product,
          ),
        ),
        TextFormField(
          autocorrect: false,
          controller: _notesController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: localization.description,
          ),
        ),
        TextFormField(
          autocorrect: false,
          controller: _costController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: localization.unitCost,
          ),
        ),
        TextFormField(
          autocorrect: false,
          controller: _qtyController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: localization.quantity,
          ),
        ),
        Row(
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
        ),
      ],
    );
  }
}

class ItemSelector extends StatefulWidget {

  ItemSelector(this.state);

  final AppState state;

  @override
  _ItemSelectorState createState() => new _ItemSelectorState();
}

class _ItemSelectorState extends State<ItemSelector> {

  List<int> _selectedIds = [];
  final _textController = TextEditingController();
  EntityType selectedEntityType = EntityType.product;

  /*
  @override
  void initState() {
    super.initState();
    _textController.text = widget.initialValue;
  }
  */

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _headerRow() {
      return Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Icon(Icons.search),
            /*
                  child: DropdownButton(
                    value: 'Products',
                    onChanged: (value) {
                      //
                    },
                    items: <String>['Products', 'Tasks', 'Expenses']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                  */
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              //onChanged: (value) => widget.onFilterChanged(value),
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                //hintText: localization.filter,
              ),
            ),
          ),
          _selectedIds.length > 0 ? Row(
            mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {

                  },
                  child: Text('add'),
                )
              ],
          ) :
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    }

    _entityList() {
      var localization = AppLocalization.of(context);
      var state = widget.state.selectedCompanyState.productState;

      return Column(
          mainAxisSize: MainAxisSize.min,
          children: state.list
              .getRange(0, min(6, state.list.length))
              .map((entityId) {
            var entity = state.map[entityId];
            var filter =
                widget.state.getUIState(selectedEntityType).dropdownFilter;
            var subtitle = null;
            var matchField = entity.matchesSearchField(filter);
            if (matchField != null) {
              var field = localization.lookup(matchField);
              var value = entity.matchesSearchValue(filter);
              subtitle = '$field: $value';
            }
            return ListTile(
              dense: true,
              leading: Checkbox(
                value: _selectedIds.contains(entityId),
                onChanged: (bool value) {
                  setState(() {
                    if (value) {
                      _selectedIds.add(entityId);
                    } else {
                      _selectedIds.remove(entityId);
                    }
                  });
                },
              ),
              title: Text(entity.listDisplayName),
              subtitle: subtitle != null ? Text(subtitle) : null,
              onTap: () {
                _textController.text =
                    state.map[entityId].listDisplayName;
                //widget.onSelected(entityId);
                Navigator.pop(context);
              },
            );
          }).toList());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Material(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              _headerRow(),
              _entityList(),
            ]),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
