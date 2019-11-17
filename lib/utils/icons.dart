import 'package:flutter/foundation.dart';
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
    case EntityAction.newPayment:
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
  if (kIsWeb) {
    switch (entityType) {
      case EntityType.product:
        return Icons.widgets;
      case EntityType.project:
        return Icons.work;
      case EntityType.client:
        return Icons.people;
      case EntityType.invoice:
        return Icons.book;
      case EntityType.payment:
      case EntityType.companyGateway:
        return Icons.payment;
      case EntityType.credit:
        return Icons.book;
      case EntityType.quote:
        return Icons.book;
      case EntityType.vendor:
        return Icons.business;
      case EntityType.expense:
        return Icons.image;
      case EntityType.task:
        return Icons.timer;
      case EntityType.group:
        return Icons.layers;
      case EntityType.user:
        return Icons.person;
      default:
        return null;
    }
  }

  switch (entityType) {
    case EntityType.product:
      return FontAwesomeIcons.cube;
    case EntityType.project:
      return FontAwesomeIcons.briefcase;
    case EntityType.client:
      return FontAwesomeIcons.users;
    case EntityType.invoice:
      return FontAwesomeIcons.fileInvoice;
    case EntityType.payment:
    case EntityType.companyGateway:
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
    case EntityType.user:
      return FontAwesomeIcons.user;
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
  if (kIsWeb) {
    switch (section) {
      case kSettingsCompanyDetails:
        return Icons.business;
      case kSettingsUserDetails:
        return Icons.person;
      case kSettingsLocalization:
        return Icons.language;
      case kSettingsOnlinePayments:
        return Icons.payment;
      case kSettingsTaxSettings:
      case kSettingsTaxRates:
        return Icons.account_balance;
      case kSettingsProducts:
        return Icons.widgets;
      case kSettingsNotifications:
        return Icons.notifications;
      case kSettingsImportExport:
        return Icons.import_export;
      case kSettingsDeviceSettings:
        return Icons.desktop_mac;
      case kSettingsGroupSettings:
        return Icons.layers;
      case kSettingsGeneratedNumbers:
        return Icons.format_list_numbered;
      case kSettingsCustomFields:
        return Icons.text_fields;
      case kSettingsInvoiceDesign:
        return Icons.palette;
      case kSettingsWorkflowSettings:
        return Icons.autorenew;
      case kSettingsClientPortal:
        return Icons.cloud;
      case kSettingsBuyNowButtons:
        return Icons.add_shopping_cart;
      case kSettingsEmailSettings:
        return Icons.email;
      case kSettingsTemplatesAndReminders:
        return Icons.insert_drive_file;
      case kSettingsCreditCardsAndBanks:
        return Icons.link;
      case kSettingsDataVisualizations:
        return Icons.link;
      case kSettingsUserManagement:
        return Icons.supervised_user_circle;
      default:
        return null;
    }
  }

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
