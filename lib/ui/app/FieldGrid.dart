import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class FieldGrid extends StatelessWidget {
  const FieldGrid(this.fields);

  final Map<String, String> fields;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final textColor = Theme.of(context).primaryTextTheme.bodyText1.color;
    final List<Widget> fieldWidgets = [];

    fields.forEach((field, value) {
      if (value != null && value.isNotEmpty) {
        fieldWidgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                localization.lookup(field),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: textColor.withOpacity(.65),
                ),
              ),
            ),
            SizedBox(height: 6),
            Flexible(
                child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            )),
          ],
        ));
      }
    });

    if (fieldWidgets.isEmpty) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: true,
              crossAxisCount: 2,
              children: fieldWidgets,
              childAspectRatio: 3.5,
            ),
          ),
        ),
        ListDivider(),
      ],
    );
  }
}
