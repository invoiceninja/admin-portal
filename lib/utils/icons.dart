// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/data/models/system_log_model.dart';

IconData getEntityActionIcon(EntityAction entityAction) {
  switch (entityAction) {
    case EntityAction.edit:
      return MdiIcons.circleEditOutline;
    case EntityAction.viewStatement:
    case EntityAction.viewPdf:
    case EntityAction.bulkDownload:
      return Icons.picture_as_pdf;
    case EntityAction.printPdf:
      return Icons.print;
    case EntityAction.download:
    case EntityAction.documents:
      return Icons.download;
    case EntityAction.clientPortal:
      return Icons.cloud_circle;
    case EntityAction.clone:
    case EntityAction.cloneToOther:
    case EntityAction.cloneToInvoice:
    case EntityAction.cloneToExpense:
    case EntityAction.cloneToQuote:
    case EntityAction.cloneToCredit:
    case EntityAction.cloneToRecurring:
      return Icons.control_point_duplicate;
    case EntityAction.markSent:
      return Icons.public;
    case EntityAction.markPaid:
      return Icons.payment;
    case EntityAction.bulkEmailCredit:
    case EntityAction.bulkEmailInvoice:
    case EntityAction.bulkEmailQuote:
    case EntityAction.emailQuote:
    case EntityAction.emailInvoice:
    case EntityAction.emailCredit:
    case EntityAction.emailPayment:
    case EntityAction.resendInvite:
      return Icons.send;
    case EntityAction.archive:
      return Icons.archive;
    case EntityAction.delete:
      return Icons.delete;
    case EntityAction.remove:
      return Icons.remove_circle_outline;
    case EntityAction.restore:
      return Icons.restore;
    case EntityAction.convertToInvoice:
      return Icons.content_copy;
    case EntityAction.approve:
      return Icons.check_circle_outline;
    case EntityAction.newInvoice:
    case EntityAction.newExpense:
    case EntityAction.newTask:
    case EntityAction.newClient:
    case EntityAction.newPayment:
    case EntityAction.newQuote:
    case EntityAction.newCredit:
    case EntityAction.newRecurringInvoice:
    case EntityAction.newRecurringQuote:
    case EntityAction.newRecurringExpense:
    case EntityAction.invoiceTask:
    case EntityAction.invoiceExpense:
    case EntityAction.invoiceProject:
    case EntityAction.addToInvoice:
      return Icons.add_circle_outline;
    case EntityAction.resume:
    case EntityAction.start:
      return Icons.play_arrow;
    case EntityAction.stop:
      return Icons.stop;
    case EntityAction.settings:
      return Icons.settings;
    case EntityAction.refundPayment:
    case EntityAction.cancelInvoice:
      return Icons.remove_circle_outline;
    case EntityAction.reverse:
      return Icons.undo;
    case EntityAction.copy:
      return Icons.content_copy;
    case EntityAction.applyPayment:
    case EntityAction.applyCredit:
      return Icons.payment;
    case EntityAction.disconnect:
      return MdiIcons.lanDisconnect;
    case EntityAction.purge:
      return Icons.delete_forever;
    case EntityAction.viewInvoice:
      return MdiIcons.fileAccount;
    case EntityAction.changeStatus:
      return Icons.adjust;
    case EntityAction.cancel:
      return Icons.cancel;
    case EntityAction.save:
      return Icons.cloud_upload;
    default:
      return null;
  }
}

IconData getEntityIcon(EntityType entityType) {
  switch (entityType) {
    case EntityType.dashboard:
      return MdiIcons.viewDashboard;
    case EntityType.reports:
      return MdiIcons.chartLine;
    case EntityType.settings:
      return MdiIcons.cog;
    case EntityType.product:
      return MdiIcons.cube;
    case EntityType.project:
      return MdiIcons.briefcase;
    case EntityType.client:
      return Icons.people;
    case EntityType.invoice:
      return MdiIcons.fileAccount;
    case EntityType.recurringInvoice:
    case EntityType.recurringExpense:
    case EntityType.recurringQuote:
      return MdiIcons.fileRestore;
    case EntityType.payment:
      return MdiIcons.creditCard;
    case EntityType.companyGateway:
      return MdiIcons.contactlessPaymentCircle;
    case EntityType.quote:
      return MdiIcons.fileAccountOutline;
    case EntityType.vendor:
      return Icons.business;
    case EntityType.expense:
      return MdiIcons.fileImage;
    case EntityType.task:
      return MdiIcons.clock;
    case EntityType.group:
      return MdiIcons.group;
    case EntityType.user:
      return Icons.person;
    case EntityType.credit:
      return MdiIcons.fileUndo;
    case EntityType.design:
      return MdiIcons.stamper;
    case EntityType.paymentTerm:
      return MdiIcons.calendarCheck;
    case EntityType.token:
      return MdiIcons.key;
    case EntityType.webhook:
      return MdiIcons.link;
    case EntityType.expenseCategory:
    case EntityType.taskStatus:
      return MdiIcons.label;
    case EntityType.subscription:
      return MdiIcons.shopping;
    default:
      return MdiIcons.crosshairsQuestion;
  }
}

IconData getFileTypeIcon(String type) {
  switch (type) {
    case 'pdf':
      return MdiIcons.filePdfBox;
    case 'psd':
      return MdiIcons.fileImage;
    case 'txt':
      return MdiIcons.file;
    case 'doc':
    case 'docx':
      return MdiIcons.fileWord;
    case 'xls':
    case 'xlsx':
      return MdiIcons.fileExcel;
    case 'ppt':
    case 'pptt':
      return MdiIcons.filePowerpoint;
    default:
      return null;
  }
}

IconData getSettingIcon(String section) {
  switch (section) {
    case kSettingsCompanyDetails:
      return Icons.business;
    case kSettingsUserDetails:
      return Icons.person;
    case kSettingsLocalization:
      return Icons.language;
    case kSettingsOnlinePayments:
    case kSettingsCompanyGateways:
      return MdiIcons.creditCard;
    case kSettingsTaxSettings:
    case kSettingsTaxRates:
      return MdiIcons.percent;
    case kSettingsImportExport:
      return Icons.import_export;
    case kSettingsDeviceSettings:
      return Icons.settings;
    case kSettingsGroupSettings:
      return MdiIcons.group;
    case kSettingsGeneratedNumbers:
      return MdiIcons.formatListNumbered;
    case kSettingsCustomFields:
      return MdiIcons.formatText;
    case kSettingsCustomDesigns:
      return MdiIcons.stamper;
    case kSettingsInvoiceDesign:
      return MdiIcons.brush;
    case kSettingsWorkflowSettings:
      return MdiIcons.sourceBranch;
    case kSettingsClientPortal:
      return MdiIcons.cloud;
    case kSettingsEmailSettings:
      return Icons.mail;
    case kSettingsTemplatesAndReminders:
      return MdiIcons.reminder;
    case kSettingsCreditCardsAndBanks:
      return MdiIcons.link;
    case kSettingsDataVisualizations:
      return MdiIcons.link;
    case kSettingsUserManagement:
      return Icons.people;
    case kSettingsAccountManagement:
      return MdiIcons.shieldAccount;
    case kSettingsProducts:
      return getEntityIcon(EntityType.product);
    case kSettingsExpenses:
    case kSettingsExpenseCategories:
      return getEntityIcon(EntityType.expense);
    case kSettingsTasks:
    case kSettingsTaskStatuses:
      return getEntityIcon(EntityType.task);
    case kSettingsSubscriptions:
      return getEntityIcon(EntityType.subscription);
    default:
      return null;
  }
}

IconData getActivityIcon(int categoryId) {
  switch (categoryId) {
    case SystemLogEntity.CATEGORY_EMAIL:
      return Icons.email;
    case SystemLogEntity.CATEGORY_PAYMENT:
      return Icons.credit_card;
    case SystemLogEntity.CATEGORY_PDF:
      return Icons.picture_as_pdf;
    case SystemLogEntity.CATEGORY_SECURITY:
      return Icons.security;
    case SystemLogEntity.CATEGORY_WEBHOOK:
      return MdiIcons.link;
    default:
      return MdiIcons.crosshairsQuestion;
  }
}
