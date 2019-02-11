import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

IconData getEntityActionIcon(EntityAction entityAction) {
  switch (entityAction) {
    case EntityAction.edit:
      return Icons.edit;
    case EntityAction.pdf:
      return Icons.picture_as_pdf;
    case EntityAction.clientPortal:
      return Icons.cloud_circle;
    case EntityAction.clone:
    case EntityAction.cloneToInvoice:
    case EntityAction.cloneToQuote:
      return Icons.control_point_duplicate;
    case EntityAction.markSent:
      return Icons.publish;
    case EntityAction.sendEmail:
      return Icons.send;
    case EntityAction.archive:
      return Icons.archive;
    case EntityAction.delete:
      return Icons.delete;
    case EntityAction.restore:
      return Icons.restore;
    case EntityAction.convert:
      return Icons.check_box;
    case EntityAction.viewInvoice:
      return Icons.insert_drive_file;
    case EntityAction.newInvoice:
    case EntityAction.enterPayment:
      return Icons.add_circle_outline;
    case EntityAction.resume:
    case EntityAction.start:
      return Icons.play_arrow;
    case EntityAction.stop:
      return Icons.stop;
    default:
      return null;
  }
}

IconData getEntityIcon(EntityType entityType) {
  switch (entityType) {
    case EntityType.product:
      return FontAwesomeIcons.cube;
    case EntityType.project:
      return FontAwesomeIcons.cube;
    case EntityType.client:
      return FontAwesomeIcons.users;
    case EntityType.invoice:
      return FontAwesomeIcons.filePdf;
    case EntityType.payment:
      return FontAwesomeIcons.creditCard;
    case EntityType.credit:
      return FontAwesomeIcons.creditCard;
    case EntityType.quote:
      return FontAwesomeIcons.fileAlt;
    case EntityType.vendor:
      return FontAwesomeIcons.building;
    case EntityType.expense:
      return FontAwesomeIcons.fileImage;
    case EntityType.task:
      return FontAwesomeIcons.clock;
    default:
      return null;
  }
}
