import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/constants.dart';
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
    case EntityAction.newExpense:
    case EntityAction.newTask:
    case EntityAction.newClient:
    case EntityAction.enterPayment:
      return Icons.add_circle_outline;
    case EntityAction.resume:
    case EntityAction.start:
      return Icons.play_arrow;
    case EntityAction.stop:
      return Icons.stop;
    case EntityAction.settings:
      return Icons.settings;
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
      return FontAwesomeIcons.fileInvoice;
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
    case EntityType.group:
      return FontAwesomeIcons.layerGroup;
    default:
      return null;
  }
}

IconData getFileTypeIcon(String type) {
  switch (type) {
    case 'pdf':
      return FontAwesomeIcons.solidFilePdf;
    case 'psd':
      return FontAwesomeIcons.adobe;
    case 'txt':
      return FontAwesomeIcons.solidFileAlt;
    case 'doc':
    case 'docx':
      return FontAwesomeIcons.solidFileWord;
    case 'xls':
    case 'xlsx':
      return FontAwesomeIcons.solidFileExcel;
    case 'ppt':
    case 'pptt':
      return FontAwesomeIcons.solidFilePowerpoint;
    default:
      return null;
  }
}

IconData getSettingIcon(String section) {
  switch (section) {
    case kSettingsCompanyDetails:
      return FontAwesomeIcons.building;
    case kSettingsUserDetails:
      return FontAwesomeIcons.userAlt;
    case kSettingsLocalization:
      return FontAwesomeIcons.globe;
    case kSettingsOnlinePayments:
      return FontAwesomeIcons.creditCard;
    case kSettingsTaxSettings:
    case kSettingsTaxRates:
      return FontAwesomeIcons.percent;
    case kSettingsProducts:
      return FontAwesomeIcons.cube;
    case kSettingsNotifications:
      return FontAwesomeIcons.bell;
    case kSettingsImportExport:
      return FontAwesomeIcons.fileExport;
    case kSettingsDeviceSettings:
      return FontAwesomeIcons.desktop;
    case kSettingsGroupSettings:
      return FontAwesomeIcons.layerGroup;
    case kSettingsGeneratedNumbers:
      return FontAwesomeIcons.idBadge;
    case kSettingsCustomFields:
      return FontAwesomeIcons.heading;
    case kSettingsInvoiceDesign:
      return FontAwesomeIcons.paintBrush;
    case kSettingsWorkflowSettings:
      return FontAwesomeIcons.codeBranch;
    case kSettingsClientPortal:
      return FontAwesomeIcons.cloud;
    case kSettingsBuyNowButtons:
      return FontAwesomeIcons.link;
    case kSettingsEmailSettings:
      return FontAwesomeIcons.solidEnvelope;
    case kSettingsTemplatesAndReminders:
      return FontAwesomeIcons.file;
    case kSettingsCreditCardsAndBanks:
      return FontAwesomeIcons.link;
    case kSettingsDataVisualizations:
      return FontAwesomeIcons.link;
    case kSettingsUserManagement:
      return FontAwesomeIcons.users;
    default:
      return null;
  }
}
