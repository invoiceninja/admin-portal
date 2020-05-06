import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    @required this.entity,
    @required this.action1,
    @required this.action2,
  });

  final BaseEntity entity;
  final EntityAction action1;
  final EntityAction action2;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AppBorder(
      isTop: true,
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                handleEntityAction(context, entity, action1);
              },
              child: SizedBox(
                height: 44,
                child: Center(
                  child: Text(
                    localization.lookup('$action1'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: AppBorder(
              isLeft: true,
              child: InkWell(
                onTap: () {
                  handleEntityAction(context, entity, action2);
                },
                child: SizedBox(
                  height: 44,
                  child: Center(
                    child: Text(
                      localization.lookup('$action2'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
