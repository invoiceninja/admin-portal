// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';

class ProgressButton extends StatelessWidget {
  const ProgressButton({
    Key? key,
    required this.label,
    required this.isLoading,
    required this.onPressed,
    this.padding,
  }) : super(key: key);

  final String label;
  final bool isLoading;
  final Function onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: SizedBox(
              height: 48,
              width: 48,
              child: CircularProgressIndicator(),
            ),
          )
        : AppButton(
            width: double.infinity,
            label: label,
            onPressed: () => onPressed(),
          );
  }
}
