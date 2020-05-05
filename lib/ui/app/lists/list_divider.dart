import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';

class ListDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: convertHexStringToColor(kDefaultBorderColor),
      thickness: 1.5,
      height: 1.5,
    );
  }
}
