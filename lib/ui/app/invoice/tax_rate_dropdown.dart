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
    @required this.state,
    @required this.labelText,
    @required this.onSelected,
    this.initialTaxName = '',
    this.initialTaxRate = 0.0,
  });

  final AppState state;
  final String labelText;
  final Function(TaxRateEntity) onSelected;
  final String initialTaxName;
  final double initialTaxRate;

  @override
  _TaxRateDropdownState createState() => new _TaxRateDropdownState();
}

class _TaxRateDropdownState extends State<TaxRateDropdown> {
  final _textController = TextEditingController();
  TaxRateEntity _selectedTaxRate;

  @override
  void initState() {
    super.initState();
    final taxRates = widget.state.selectedCompany.taxRates;

    if (widget.initialTaxRate != 0) {
      _selectedTaxRate = taxRates.firstWhere(
              (taxRate) =>
          taxRate.name == widget.initialTaxName &&
              taxRate.rate == widget.initialTaxRate,
          orElse: () => TaxRateEntity().rebuild((b) => b
            ..rate = widget.initialTaxRate
            ..name = widget.initialTaxName));
    }
    
    _textController.text = _formatTaxRate(_selectedTaxRate, widget.state);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  String _formatTaxRate(TaxRateEntity taxRate, AppState state) {
    return '${formatNumber(taxRate.rate, state,
        formatNumberType: FormatNumberType.percent)} ${taxRate.name}';
  }

  @override
  Widget build(BuildContext context) {
    final taxRates = widget.state.selectedCompany.taxRates;

    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      final options = taxRates
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
              ))
          .toList();

      options.insert(0, PopupMenuItem<TaxRateEntity>(
        value: TaxRateEntity(),
        child: Container(),
      ));

      return PopupMenuButton<TaxRateEntity>(
        padding: EdgeInsets.zero,
        initialValue: _selectedTaxRate,
        onSelected: (taxRate) {
          if (taxRate.rate == 0) {
            _textController.text = '';
          } else {
            _textController.text = _formatTaxRate(taxRate, store.state);
          }
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
