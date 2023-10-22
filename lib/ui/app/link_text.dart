// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

class LinkTextRelatedEntity extends StatefulWidget {
  const LinkTextRelatedEntity({
    Key? key,
    required this.entity,
    required this.relation,
  }) : super(key: key);

  final BaseEntity? entity;
  final BaseEntity? relation;

  @override
  State<LinkTextRelatedEntity> createState() => _LinkTextRelatedEntityState();
}

class _LinkTextRelatedEntityState extends State<LinkTextRelatedEntity> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.entity == null || widget.relation == null) {
      return SizedBox();
    }

    return MouseRegion(
      onHover: (event) {
        setState(() => _isHovered = true);
      },
      onExit: (event) {
        setState(() => _isHovered = false);
      },
      child: GestureDetector(
        child: Text(
          widget.entity!.listDisplayName,
          style: TextStyle(
            decoration:
                _isHovered ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
        onTap: () {
          final entity = widget.entity!;
          if (entity.entityType == EntityType.company ||
              entity.entityType == null) {
            viewEntitiesByType(entityType: EntityType.settings);
          } else if (entity.entityType!.hasFullWidthViewer) {
            viewEntity(entity: entity);
          } else {
            viewEntity(entity: widget.relation!);
            viewEntity(entity: entity, addToStack: true);
          }
        },
        onLongPress: () {
          editEntity(entity: widget.entity!);
        },
      ),
    );
  }
}

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle? style, String? url, String? text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(Uri.parse(url!));
              });
}
