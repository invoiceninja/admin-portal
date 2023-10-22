// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaxRateField extends StatelessWidget {
  const TaxRateField({
    Key? key,
    required this.onNameChanged,
    required this.onAmountChanged,
    required this.initialTaxName,
    required this.initialTaxAmount,
  }) : super(key: key);

  final Function(String) onNameChanged;
  final Function(double?) onAmountChanged;
  final String initialTaxName;
  final double initialTaxAmount;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return Row(
      children: [
        Expanded(
          child: DecoratedFormField(
            label: localization.taxName,
            initialValue: initialTaxName,
            onChanged: (value) => onNameChanged(value),
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(
          width: kTableColumnGap,
        ),
        Expanded(
          child: DecoratedFormField(
            label: localization.taxAmount,
            initialValue: formatNumber(
              initialTaxAmount,
              context,
              formatNumberType: FormatNumberType.inputMoney,
            ),
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            onChanged: (value) => onAmountChanged(parseDouble(value)),
            //textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
