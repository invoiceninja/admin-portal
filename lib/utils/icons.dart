import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

IconData getIconData(EntityType entityType) {
  switch (entityType) {
    case EntityType.client:
      return FontAwesomeIcons.users;
    case EntityType.invoice:
      return FontAwesomeIcons.filePdfO;
    case EntityType.payment:
      return FontAwesomeIcons.creditCard;
    case EntityType.credit:
      return FontAwesomeIcons.creditCard;
    case EntityType.quote:
      return FontAwesomeIcons.fileAltO;
    case EntityType.vendor:
      return FontAwesomeIcons.building;
    case EntityType.expense:
      return FontAwesomeIcons.fileImageO;
    case EntityType.task:
      return FontAwesomeIcons.clockO;
    default:
      return null;
  }
}
