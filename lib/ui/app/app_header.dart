import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    @required this.label,
    @required this.value,
    this.secondLabel,
    this.secondValue,
  });

  final String label;
  final String value;
  final String secondLabel;
  final String secondValue;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText1.color;

    Widget _value1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label,
              style: TextStyle(
                fontSize: 16.0,
                color: textColor.withOpacity(.65),
              )),
          SizedBox(
            height: 8,
          ),
          FittedBox(
            child: Text(
              (value ?? '').isEmpty ? ' ' : value,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          )
        ],
      );
    }

    Widget _value2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(secondLabel,
              style: TextStyle(
                fontSize: 16.0,
                color: textColor.withOpacity(.65),
              )),
          SizedBox(
            height: 8,
          ),
          FittedBox(
            child: Text(
              (secondValue ?? '').isEmpty ? ' ' : secondValue,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          )
        ],
      );
    }

    return FormCard(
      child: Row(
        children: [
          Expanded(child: _value1()),
          if ((secondValue ?? '').isNotEmpty) ...[
            SizedBox(width: 8),
            Expanded(child: _value2()),
          ],
        ],
      ),
    );
  }
}
