// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'decorated_form_field.dart';

class DiscountField extends StatelessWidget {
  const DiscountField({
    required this.controller,
    required this.value,
    required this.isAmountDiscount,
    required this.onTypeChanged,
    this.label,
  });

  final TextEditingController controller;
  final double value;
  final bool isAmountDiscount;
  final Function(bool? value) onTypeChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: DecoratedFormField(
            label: label ?? localization.discount,
            controller: controller,
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<bool>(
            value: isAmountDiscount,
            items: [
              DropdownMenuItem<bool>(
                child: Text(
                  localization.percent,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                value: false,
              ),
              DropdownMenuItem<bool>(
                child: Text(
                  localization.amount,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                value: true,
              )
            ],
            onChanged: onTypeChanged,
          ),
        ),
      ],
    );
  }
}
