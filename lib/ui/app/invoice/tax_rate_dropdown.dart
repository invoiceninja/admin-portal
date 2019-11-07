import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class TaxRateDropdown extends StatefulWidget {
  const TaxRateDropdown({
    @required this.labelText,
    @required this.onSelected,
    this.initialTaxName = '',
    this.initialTaxRate = 0.0,
  });

  final String labelText;
  final Function(TaxRateEntity) onSelected;
  final String initialTaxName;
  final double initialTaxRate;

  @override
  _TaxRateDropdownState createState() => _TaxRateDropdownState();
}

class _TaxRateDropdownState extends State<TaxRateDropdown> {
  final _textController = TextEditingController();
  TaxRateEntity _selectedTaxRate;

  @override
  void didChangeDependencies() {
    final taxState = StoreProvider.of<AppState>(context).state.taxRateState;
    final taxRates = taxState.list.map((id) => taxState.map[id]).toList();

    _selectedTaxRate = taxRates.firstWhere(
        (taxRate) =>
            taxRate.name == widget.initialTaxName &&
            taxRate.rate == widget.initialTaxRate,
        orElse: () => TaxRateEntity(
            name: widget.initialTaxName, rate: widget.initialTaxRate));

    if (_selectedTaxRate.rate != 0) {
      _textController.text = _formatTaxRate(_selectedTaxRate);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  String _formatTaxRate(TaxRateEntity taxRate) {
    return '${formatNumber(taxRate.rate, context, formatNumberType: FormatNumberType.percent)} ${taxRate.name}';
  }

  @override
  Widget build(BuildContext context) {
    final taxState = StoreProvider.of<AppState>(context).state.taxRateState;
    final taxRates = taxState.list.map((id) => taxState.map[id]).toList();

    if (taxRates.isEmpty) {
      return Container();
    }

    final options = taxRates
        .where((taxRate) => taxRate.archivedAt == null)
        .map((taxRate) => PopupMenuItem<TaxRateEntity>(
              value: taxRate,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 70.0,
                    child: Text(formatNumber(taxRate.rate, context,
                        formatNumberType: FormatNumberType.percent)),
                  ),
                  Text(taxRate.name),
                ],
              ),
            ))
        .toList();

    options.insert(
        0,
        PopupMenuItem<TaxRateEntity>(
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
          _textController.text = _formatTaxRate(taxRate);
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
  }
}
