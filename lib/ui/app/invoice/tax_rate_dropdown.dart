import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja/data/models/company_model.dart';
import 'package:invoiceninja/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja/utils/formatting.dart';

class TaxRateDropdown extends StatefulWidget {
  const TaxRateDropdown({
    @required this.taxRates,
    @required this.labelText,
    @required this.onSelected,
    this.initialTaxName = '',
    this.initialTaxRate = 0.0,
  });

  final BuiltList<TaxRateEntity> taxRates;
  final String labelText;
  final Function(TaxRateEntity) onSelected;
  final String initialTaxName;
  final double initialTaxRate;

  @override
  _TaxRateDropdownState createState() => new _TaxRateDropdownState();
}

class _TaxRateDropdownState extends State<TaxRateDropdown> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.initialTaxName;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TaxRateEntity selectedTaxRate;
    if (widget.initialTaxRate != 0) {
      selectedTaxRate = widget.taxRates.firstWhere(
          (taxRate) =>
              taxRate.name == widget.initialTaxName &&
              taxRate.rate == widget.initialTaxRate,
          orElse: () => TaxRateEntity().rebuild((b) => b
            ..rate = widget.initialTaxRate
            ..name = widget.initialTaxName));
    }

    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      final options = widget.taxRates
          .where(
              (taxRate) => taxRate.archivedAt == null && !taxRate.isInclusive)
          .map((taxRate) => PopupMenuItem<TaxRateEntity>(
                value: taxRate,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 70.0,
                      child: Text(formatNumber(taxRate.rate, store.state,
                          formatNumberType: FormatNumberType.percent)),
                    ),
                    Text(taxRate.name),
                  ],
                ),
                //child: Text(
                //'${formatNumber(taxRate.rate, store.state, formatNumberType: FormatNumberType.percent)} ${taxRate.name}'),
              ))
          .toList();

      options.insert(0, PopupMenuItem<TaxRateEntity>(
        value: TaxRateEntity(),
        child: Container(),
      ));

      return PopupMenuButton<TaxRateEntity>(
        padding: EdgeInsets.zero,
        initialValue: selectedTaxRate,
        onSelected: (taxRate) {
          _textController.text =
              '${formatNumber(taxRate.rate, store.state, formatNumberType: FormatNumberType.percent)} ${taxRate.name}';
          widget.onSelected(taxRate);
        },
        child: InkWell(
          child: IgnorePointer(
            child: TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: widget.labelText,
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
            ),
          ),
        ),
        itemBuilder: (BuildContext context) => options,
      );
    });
  }
}
