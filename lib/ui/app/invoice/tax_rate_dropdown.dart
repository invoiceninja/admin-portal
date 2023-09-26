// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class TaxRateDropdown extends StatefulWidget {
  const TaxRateDropdown({
    Key? key,
    required this.labelText,
    required this.onSelected,
    this.initialTaxName = '',
    this.initialTaxRate = 0.0,
  }) : super(key: key);

  final String? labelText;
  final Function(TaxRateEntity) onSelected;
  final String? initialTaxName;
  final double? initialTaxRate;

  @override
  _TaxRateDropdownState createState() => _TaxRateDropdownState();
}

class _TaxRateDropdownState extends State<TaxRateDropdown> {
  final _textController = TextEditingController();

  TaxRateEntity? _selectedTaxRate;

  @override
  void didChangeDependencies() {
    final taxState = StoreProvider.of<AppState>(context).state.taxRateState;
    final taxRates = taxState.list.map((id) => taxState.map[id]).toList();

    _selectedTaxRate = taxRates.firstWhere(
        (taxRate) =>
            taxRate!.name == widget.initialTaxName &&
            taxRate.rate == widget.initialTaxRate,
        orElse: () => TaxRateEntity(
            name: widget.initialTaxName, rate: widget.initialTaxRate));

    if (_selectedTaxRate!.rate != 0) {
      _textController.text = _formatTaxRate(_selectedTaxRate!);
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
    final state = StoreProvider.of<AppState>(context).state;
    final taxState = state.taxRateState;
    final taxRates = taxState.list
        .where((id) => taxState.map[id]!.isActive)
        .map((id) => taxState.map[id])
        .toList();

    if (taxRates.isEmpty) {
      return SizedBox();
    }

    final taxRate = taxRates.firstWhere(
        (taxRate) =>
            taxRate!.name == widget.initialTaxName &&
            taxRate.rate == widget.initialTaxRate,
        orElse: () => TaxRateEntity(
            name: widget.initialTaxName, rate: widget.initialTaxRate))!;

    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
      isEmpty: taxRate.isEmpty,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TaxRateEntity>(
            value: taxRate,
            isExpanded: true,
            isDense: true,
            onChanged: (rate) => widget.onSelected(rate!),
            items: [
              if (!taxRate.isEmpty)
                DropdownMenuItem(
                  child: Text(''),
                  value: TaxRateEntity(),
                ),
              if (taxRate.isNew)
                DropdownMenuItem(
                  child: Text(taxRate.isEmpty ? '' : _formatTaxRate(taxRate)),
                  value: taxRate,
                ),
              ...taxRates
                  .map((taxRate) => DropdownMenuItem(
                        child: Text(
                            taxRate!.isEmpty ? '' : _formatTaxRate(taxRate)),
                        value: taxRate,
                      ))
                  .toList()
            ]),
      ),
    );
  }
}
