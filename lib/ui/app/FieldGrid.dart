import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class FieldGrid extends StatelessWidget {
  const FieldGrid(this.fields, {this.fieldConverter});

  final Map<String, String> fields;
  final Function(String) fieldConverter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final List<Widget> fieldWidgets = [];

    fields.forEach((field, value) {
      if (fieldConverter != null) {
        field = fieldConverter(field);
      }
      if (value != null && value.isNotEmpty) {
        fieldWidgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                localization.lookup(field),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Flexible(
                child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
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
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
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
        Container(
          color: Theme.of(context).backgroundColor,
          height: 12.0,
        ),
      ],
    );
  }
}
