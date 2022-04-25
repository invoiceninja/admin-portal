// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

class LinkTextRelatedEntity extends StatelessWidget {
  const LinkTextRelatedEntity({
    Key key,
    @required this.entity,
    @required this.relation,
  }) : super(key: key);

  final BaseEntity entity;
  final BaseEntity relation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        entity.listDisplayName,
        textAlign: TextAlign.center,
        style: TextStyle(decoration: TextDecoration.underline),
      ),
      onTap: () {
        viewEntity(entity: relation);
        viewEntity(entity: entity, addToStack: true);
      },
    );
  }
}

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch(url, forceSafariVC: false);
              });
}
