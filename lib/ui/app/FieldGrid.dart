import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class FieldGrid extends StatelessWidget {
  const FieldGrid(this.fields);

  final Map<String, String> fields;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final textColor = Theme.of(context).textTheme.bodyText1.color;
    final List<Widget> fieldWidgets = [];

    fields.forEach((field, value) {
      if (value != null && value.isNotEmpty) {
        fieldWidgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                localization.lookup(field),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor.withOpacity(.65),
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ));
      }
    });

    if (fieldWidgets.isEmpty) {
      return Container();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              shrinkWrap: true,
              primary: true,
              crossAxisCount: 2,
              children: fieldWidgets,
              childAspectRatio: 2.5,
            ),
          ),
        ),
        ListDivider(),
      ],
    );
  }
}
