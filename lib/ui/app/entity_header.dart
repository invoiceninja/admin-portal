import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_status_chip.dart';

class EntityHeader extends StatelessWidget {
  const EntityHeader({
    @required this.entity,
    @required this.label,
    @required this.value,
    this.secondLabel,
    this.secondValue,
    this.statusLabel,
    this.statusColor,
  });

  final BaseEntity entity;
  final Color statusColor;
  final String statusLabel;
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
          Text(
            value ?? '',
            style: TextStyle(
              fontSize: 30.0,
              //fontWeight: FontWeight.bold,
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
          Text(
            secondValue ?? '',
            style: TextStyle(
              fontSize: 30.0,
            ),
          )
        ],
      );
    }

    final isVertical = value.length > 12 || (secondValue ?? '').length > 12;

    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isVertical
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _value1()),
                      if (secondValue != null) Expanded(child: _value2()),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _value1()),
                      if (secondValue != null) Expanded(child: _value2()),
                    ],
                  ),
            if (statusLabel != null)
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 5),
                child: EntityStatusChip(
                  entity: entity,
                  width: 120,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
