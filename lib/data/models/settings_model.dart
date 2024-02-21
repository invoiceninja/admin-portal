// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'settings_model.g.dart';

abstract class SettingsEntity
    implements Built<SettingsEntity, SettingsEntityBuilder> {
  factory SettingsEntity({
    SettingsEntity? companySettings,
    SettingsEntity? groupSettings,
    SettingsEntity? clientSettings,
  }) {
    return _$SettingsEntity._(
      defaultInvoiceDesignId: clientSettings?.defaultInvoiceDesignId ??
          groupSettings?.defaultInvoiceDesignId ??
          companySettings?.defaultInvoiceDesignId,
      defaultQuoteDesignId: clientSettings?.defaultQuoteDesignId ??
          groupSettings?.defaultQuoteDesignId ??
          companySettings?.defaultQuoteDesignId,
      defaultCreditDesignId: clientSettings?.defaultCreditDesignId ??
          groupSettings?.defaultCreditDesignId ??
          companySettings?.defaultCreditDesignId,
      defaultPurchaseOrderDesignId:
          clientSettings?.defaultPurchaseOrderDesignId ??
              groupSettings?.defaultPurchaseOrderDesignId ??
              companySettings?.defaultPurchaseOrderDesignId,
      defaultStatementDesignId: clientSettings?.defaultStatementDesignId ??
          groupSettings?.defaultStatementDesignId ??
          companySettings?.defaultStatementDesignId,
      defaultDeliveryNoteDesignId:
          clientSettings?.defaultDeliveryNoteDesignId ??
              groupSettings?.defaultDeliveryNoteDesignId ??
              companySettings?.defaultDeliveryNoteDesignId,
      defaultPaymentReceiptDesignId:
          clientSettings?.defaultPaymentReceiptDesignId ??
              groupSettings?.defaultPaymentReceiptDesignId ??
              companySettings?.defaultPaymentReceiptDesignId,
      defaultPaymentRefundDesignId:
          clientSettings?.defaultPaymentRefundDesignId ??
              groupSettings?.defaultPaymentRefundDesignId ??
              companySettings?.defaultPaymentRefundDesignId,
      defaultInvoiceTerms: clientSettings?.defaultInvoiceTerms ??
          groupSettings?.defaultInvoiceTerms ??
          companySettings?.defaultInvoiceTerms,
      defaultInvoiceFooter: clientSettings?.defaultInvoiceFooter ??
          groupSettings?.defaultInvoiceFooter ??
          companySettings?.defaultInvoiceFooter,
      defaultQuoteTerms: clientSettings?.defaultQuoteTerms ??
          groupSettings?.defaultQuoteTerms ??
          companySettings?.defaultQuoteTerms,
      defaultQuoteFooter: clientSettings?.defaultQuoteFooter ??
          groupSettings?.defaultQuoteFooter ??
          companySettings?.defaultQuoteFooter,
      defaultCreditTerms: clientSettings?.defaultCreditTerms ??
          groupSettings?.defaultCreditTerms ??
          companySettings?.defaultCreditTerms,
      defaultCreditFooter: clientSettings?.defaultCreditFooter ??
          groupSettings?.defaultCreditFooter ??
          companySettings?.defaultCreditFooter,
      lockInvoices: clientSettings?.lockInvoices ??
          groupSettings?.lockInvoices ??
          companySettings?.lockInvoices,
      emailSubjectCustom1: clientSettings?.emailSubjectCustom1 ??
          groupSettings?.emailSubjectCustom1 ??
          companySettings?.emailSubjectCustom1,
      emailSubjectCustom2: clientSettings?.emailSubjectCustom2 ??
          groupSettings?.emailSubjectCustom2 ??
          companySettings?.emailSubjectCustom2,
      emailSubjectCustom3: clientSettings?.emailSubjectCustom3 ??
          groupSettings?.emailSubjectCustom3 ??
          companySettings?.emailSubjectCustom3,
      defaultPaymentTerms: clientSettings?.defaultPaymentTerms ??
          groupSettings?.defaultPaymentTerms ??
          companySettings?.defaultPaymentTerms,
      defaultValidUntil: clientSettings?.defaultValidUntil ??
          groupSettings?.defaultValidUntil ??
          companySettings?.defaultValidUntil,
      defaultTaxRate1: clientSettings?.defaultTaxRate1 ??
          groupSettings?.defaultTaxRate1 ??
          companySettings?.defaultTaxRate1,
      defaultTaxName1: clientSettings?.defaultTaxName1 ??
          groupSettings?.defaultTaxName1 ??
          companySettings?.defaultTaxName1,
      defaultTaxRate2: clientSettings?.defaultTaxRate2 ??
          groupSettings?.defaultTaxRate2 ??
          companySettings?.defaultTaxRate2,
      defaultTaxName2: clientSettings?.defaultTaxName2 ??
          groupSettings?.defaultTaxName2 ??
          companySettings?.defaultTaxName2,
      defaultTaxRate3: clientSettings?.defaultTaxRate3 ??
          groupSettings?.defaultTaxRate3 ??
          companySettings?.defaultTaxRate3,
      defaultTaxName3: clientSettings?.defaultTaxName3 ??
          groupSettings?.defaultTaxName3 ??
          companySettings?.defaultTaxName3,
      clientManualPaymentNotification:
          clientSettings?.clientManualPaymentNotification ??
              groupSettings?.clientManualPaymentNotification ??
              companySettings?.clientManualPaymentNotification,
      defaultPaymentTypeId: clientSettings?.defaultPaymentTypeId ??
          groupSettings?.defaultPaymentTypeId ??
          companySettings?.defaultPaymentTypeId,
      autoBillStandardInvoices: clientSettings?.autoBillStandardInvoices ??
          groupSettings?.autoBillStandardInvoices ??
          companySettings?.autoBillStandardInvoices,
    );
  }

  SettingsEntity._();

  @override
  @memoized
  int get hashCode;

  static const PAGE_NUMBER_ALIGN_LEFT = 'L';
  static const PAGE_NUMBER_ALIGN_RIGHT = 'R';
  static const PAGE_NUMBER_ALIGN_CENTER = 'C';

  static const EMAIL_SENDING_METHOD_DEFAULT = 'default';
  static const EMAIL_SENDING_METHOD_GMAIL = 'gmail';
  static const EMAIL_SENDING_METHOD_MICROSOFT = 'office365';
  static const EMAIL_SENDING_METHOD_POSTMARK = 'client_postmark';
  static const EMAIL_SENDING_METHOD_MAILGUN = 'client_mailgun';
  static const EMAIL_SENDING_METHOD_SMTP = 'smtp';

  static const LOCK_INVOICES_OFF = 'off';
  static const LOCK_INVOICES_SENT = 'when_sent';
  static const LOCK_INVOICES_PAID = 'when_paid';

  static const AUTO_BILL_ALWAYS = 'always';
  static const AUTO_BILL_OPT_IN = 'optin';
  static const AUTO_BILL_OPT_OUT = 'optout';
  static const AUTO_BILL_OFF = 'off';

  static const AUTO_BILL_ON_SEND_DATE = 'on_send_date';
  static const AUTO_BILL_ON_DUE_DATE = 'on_due_date';

  static const PORTAL_TASKS_ALL = 'all';
  static const PORTAL_TASKS_INVOICED = 'invoiced';
  static const PORTAL_TASKS_UNINVOICED = 'uninvoiced';

  static const EMAIL_ALIGNMENT_CENTER = 'center';
  static const EMAIL_ALIGNMENT_LEFT = 'left';
  static const EMAIL_ALIGNMENT_RIGHT = 'right';

  static const MAILGUN_ENDPOINT_US = 'api.mailgun.net';
  static const MAILGUN_ENDPOINT_EU = 'api.eu.mailgun.net';

  @BuiltValueField(wireName: 'timezone_id')
  String? get timezoneId;

  @BuiltValueField(wireName: 'date_format_id')
  String? get dateFormatId;

  @BuiltValueField(wireName: 'military_time')
  bool? get enableMilitaryTime;

  @BuiltValueField(wireName: 'language_id')
  String? get languageId;

  @BuiltValueField(wireName: 'show_currency_code')
  bool? get showCurrencyCode;

  @BuiltValueField(wireName: 'currency_id')
  String? get currencyId;

  @BuiltValueField(wireName: 'custom_value1')
  String? get customValue1;

  @BuiltValueField(wireName: 'custom_value2')
  String? get customValue2;

  @BuiltValueField(wireName: 'custom_value3')
  String? get customValue3;

  @BuiltValueField(wireName: 'custom_value4')
  String? get customValue4;

  @BuiltValueField(wireName: 'payment_terms')
  String? get defaultPaymentTerms;

  @BuiltValueField(wireName: 'valid_until')
  String? get defaultValidUntil;

  @BuiltValueField(wireName: 'company_gateway_ids')
  String? get companyGatewayIds;

  @BuiltValueField(wireName: 'default_task_rate')
  double? get defaultTaskRate;

  @BuiltValueField(wireName: 'send_reminders')
  bool? get sendReminders;

  @BuiltValueField(wireName: 'enable_client_portal')
  bool? get enablePortal;

  @BuiltValueField(wireName: 'enable_client_portal_dashboard')
  bool? get enablePortalDashboard;

  @BuiltValueField(wireName: 'enable_client_portal_tasks')
  bool? get enablePortalTasks;

  @BuiltValueField(wireName: 'client_portal_enable_uploads')
  bool? get enableClientPortalUploads;

  @BuiltValueField(wireName: 'vendor_portal_enable_uploads')
  bool? get enableVendorPortalUploads;

  @BuiltValueField(wireName: 'email_style')
  String? get emailStyle;

  @BuiltValueField(wireName: 'reply_to_email')
  String? get replyToEmail;

  @BuiltValueField(wireName: 'reply_to_name')
  String? get replyToName;

  @BuiltValueField(wireName: 'email_from_name')
  String? get emailFromName;

  @BuiltValueField(wireName: 'bcc_email')
  String? get bccEmail;

  @BuiltValueField(wireName: 'pdf_email_attachment')
  bool? get pdfEmailAttachment;

  @BuiltValueField(wireName: 'ubl_email_attachment')
  bool? get ublEmailAttachment;

  @BuiltValueField(wireName: 'document_email_attachment')
  bool? get documentEmailAttachment;

  @BuiltValueField(wireName: 'email_style_custom')
  String? get emailStyleCustom;

  @BuiltValueField(wireName: 'custom_message_dashboard')
  String? get customMessageDashboard;

  @BuiltValueField(wireName: 'custom_message_unpaid_invoice')
  String? get customMessageUnpaidInvoice;

  @BuiltValueField(wireName: 'custom_message_paid_invoice')
  String? get customMessagePaidInvoice;

  @BuiltValueField(wireName: 'custom_message_unapproved_quote')
  String? get customMessageUnapprovedQuote;

  @BuiltValueField(wireName: 'auto_archive_invoice')
  bool? get autoArchiveInvoice;

  @BuiltValueField(wireName: 'auto_archive_invoice_cancelled')
  bool? get autoArchiveInvoiceCancelled;

  @BuiltValueField(wireName: 'auto_archive_quote')
  bool? get autoArchiveQuote;

  @BuiltValueField(wireName: 'auto_email_invoice')
  bool? get autoEmailInvoice;

  @BuiltValueField(wireName: 'auto_convert_quote')
  bool? get autoConvertQuote;

  @BuiltValueField(wireName: 'inclusive_taxes')
  bool? get enableInclusiveTaxes;

  BuiltMap<String?, String>? get translations;

  @BuiltValueField(wireName: 'task_number_pattern')
  String? get taskNumberPattern;

  @BuiltValueField(wireName: 'task_number_counter')
  int? get taskNumberCounter;

  @BuiltValueField(wireName: 'expense_number_pattern')
  String? get expenseNumberPattern;

  @BuiltValueField(wireName: 'expense_number_counter')
  int? get expenseNumberCounter;

  @BuiltValueField(wireName: 'recurring_expense_number_pattern')
  String? get recurringExpenseNumberPattern;

  @BuiltValueField(wireName: 'recurring_expense_number_counter')
  int? get recurringExpenseNumberCounter;

  @BuiltValueField(wireName: 'vendor_number_pattern')
  String? get vendorNumberPattern;

  @BuiltValueField(wireName: 'vendor_number_counter')
  int? get vendorNumberCounter;

  @BuiltValueField(wireName: 'ticket_number_pattern')
  String? get ticketNumberPattern;

  @BuiltValueField(wireName: 'ticket_number_counter')
  int? get ticketNumberCounter;

  @BuiltValueField(wireName: 'payment_number_pattern')
  String? get paymentNumberPattern;

  @BuiltValueField(wireName: 'payment_number_counter')
  int? get paymentNumberCounter;

  @BuiltValueField(wireName: 'project_number_pattern')
  String? get projectNumberPattern;

  @BuiltValueField(wireName: 'project_number_counter')
  int? get projectNumberCounter;

  @BuiltValueField(wireName: 'invoice_number_pattern')
  String? get invoiceNumberPattern;

  @BuiltValueField(wireName: 'invoice_number_counter')
  int? get invoiceNumberCounter;

  @BuiltValueField(wireName: 'recurring_invoice_number_pattern')
  String? get recurringInvoiceNumberPattern;

  @BuiltValueField(wireName: 'recurring_invoice_number_counter')
  int? get recurringInvoiceNumberCounter;

  @BuiltValueField(wireName: 'quote_number_pattern')
  String? get quoteNumberPattern;

  @BuiltValueField(wireName: 'quote_number_counter')
  int? get quoteNumberCounter;

  @BuiltValueField(wireName: 'client_number_pattern')
  String? get clientNumberPattern;

  @BuiltValueField(wireName: 'client_number_counter')
  int? get clientNumberCounter;

  @BuiltValueField(wireName: 'credit_number_pattern')
  String? get creditNumberPattern;

  @BuiltValueField(wireName: 'credit_number_counter')
  int? get creditNumberCounter;

  @BuiltValueField(wireName: 'recurring_number_prefix')
  String? get recurringNumberPrefix;

  @BuiltValueField(wireName: 'reset_counter_frequency_id')
  String? get resetCounterFrequencyId;

  @BuiltValueField(wireName: 'reset_counter_date')
  String? get resetCounterDate;

  @BuiltValueField(wireName: 'counter_padding')
  int? get counterPadding;

  @BuiltValueField(wireName: 'shared_invoice_quote_counter')
  bool? get sharedInvoiceQuoteCounter;

  @BuiltValueField(wireName: 'shared_invoice_credit_counter')
  bool? get sharedInvoiceCreditCounter;

  @BuiltValueField(wireName: 'invoice_terms')
  String? get defaultInvoiceTerms;

  @BuiltValueField(wireName: 'quote_terms')
  String? get defaultQuoteTerms;

  @BuiltValueField(wireName: 'quote_footer')
  String? get defaultQuoteFooter;

  @BuiltValueField(wireName: 'credit_terms')
  String? get defaultCreditTerms;

  @BuiltValueField(wireName: 'credit_footer')
  String? get defaultCreditFooter;

  @BuiltValueField(wireName: 'invoice_design_id')
  String? get defaultInvoiceDesignId;

  @BuiltValueField(wireName: 'quote_design_id')
  String? get defaultQuoteDesignId;

  @BuiltValueField(wireName: 'credit_design_id')
  String? get defaultCreditDesignId;

  @BuiltValueField(wireName: 'delivery_note_design_id')
  String? get defaultDeliveryNoteDesignId;

  @BuiltValueField(wireName: 'statement_design_id')
  String? get defaultStatementDesignId;

  @BuiltValueField(wireName: 'payment_receipt_design_id')
  String? get defaultPaymentReceiptDesignId;

  @BuiltValueField(wireName: 'payment_refund_design_id')
  String? get defaultPaymentRefundDesignId;

  @BuiltValueField(wireName: 'invoice_footer')
  String? get defaultInvoiceFooter;

  @BuiltValueField(wireName: 'tax_name1')
  String? get defaultTaxName1;

  @BuiltValueField(wireName: 'tax_rate1')
  double? get defaultTaxRate1;

  @BuiltValueField(wireName: 'tax_name2')
  String? get defaultTaxName2;

  @BuiltValueField(wireName: 'tax_rate2')
  double? get defaultTaxRate2;

  @BuiltValueField(wireName: 'tax_name3')
  String? get defaultTaxName3;

  @BuiltValueField(wireName: 'tax_rate3')
  double? get defaultTaxRate3;

  @BuiltValueField(wireName: 'payment_type_id')
  String? get defaultPaymentTypeId;

  @BuiltValueField(wireName: 'pdf_variables')
  BuiltMap<String, BuiltList<String>>? get pdfVariables;

  @BuiltValueField(wireName: 'email_signature')
  String? get emailSignature;

  @BuiltValueField(wireName: 'email_subject_invoice')
  String? get emailSubjectInvoice;

  @BuiltValueField(wireName: 'email_subject_quote')
  String? get emailSubjectQuote;

  @BuiltValueField(wireName: 'email_subject_credit')
  String? get emailSubjectCredit;

  @BuiltValueField(wireName: 'email_subject_payment')
  String? get emailSubjectPayment;

  @BuiltValueField(wireName: 'email_subject_payment_partial')
  String? get emailSubjectPaymentPartial;

  @BuiltValueField(wireName: 'email_template_invoice')
  String? get emailBodyInvoice;

  @BuiltValueField(wireName: 'email_template_quote')
  String? get emailBodyQuote;

  @BuiltValueField(wireName: 'email_template_credit')
  String? get emailBodyCredit;

  @BuiltValueField(wireName: 'email_template_payment')
  String? get emailBodyPayment;

  @BuiltValueField(wireName: 'email_template_payment_partial')
  String? get emailBodyPaymentPartial;

  @BuiltValueField(wireName: 'email_subject_reminder1')
  String? get emailSubjectReminder1;

  @BuiltValueField(wireName: 'email_subject_reminder2')
  String? get emailSubjectReminder2;

  @BuiltValueField(wireName: 'email_subject_reminder3')
  String? get emailSubjectReminder3;

  @BuiltValueField(wireName: 'email_template_reminder1')
  String? get emailBodyReminder1;

  @BuiltValueField(wireName: 'email_template_reminder2')
  String? get emailBodyReminder2;

  @BuiltValueField(wireName: 'email_template_reminder3')
  String? get emailBodyReminder3;

  @BuiltValueField(wireName: 'email_subject_custom1')
  String? get emailSubjectCustom1;

  @BuiltValueField(wireName: 'email_template_custom1')
  String? get emailBodyCustom1;

  @BuiltValueField(wireName: 'email_subject_custom2')
  String? get emailSubjectCustom2;

  @BuiltValueField(wireName: 'email_template_custom2')
  String? get emailBodyCustom2;

  @BuiltValueField(wireName: 'email_subject_custom3')
  String? get emailSubjectCustom3;

  @BuiltValueField(wireName: 'email_template_custom3')
  String? get emailBodyCustom3;

  @BuiltValueField(wireName: 'email_subject_statement')
  String? get emailSubjectStatement;

  @BuiltValueField(wireName: 'email_template_statement')
  String? get emailBodyStatement;

  @BuiltValueField(wireName: 'email_subject_purchase_order')
  String? get emailSubjectPurchaseOrder;

  @BuiltValueField(wireName: 'email_template_purchase_order')
  String? get emailBodyPurchaseOrder;

  @BuiltValueField(wireName: 'enable_client_portal_password')
  bool? get enablePortalPassword;

  @BuiltValueField(wireName: 'signature_on_pdf')
  bool? get signatureOnPdf;

  @BuiltValueField(wireName: 'enable_email_markup')
  bool? get enableEmailMarkup;

  @BuiltValueField(wireName: 'show_accept_invoice_terms')
  bool? get showAcceptInvoiceTerms;

  @BuiltValueField(wireName: 'show_accept_quote_terms')
  bool? get showAcceptQuoteTerms;

  @BuiltValueField(wireName: 'require_invoice_signature')
  bool? get requireInvoiceSignature;

  @BuiltValueField(wireName: 'require_quote_signature')
  bool? get requireQuoteSignature;

  String? get name;

  @BuiltValueField(wireName: 'company_logo')
  String? get companyLogo;

  @BuiltValueField(wireName: 'website')
  String? get website;

  String? get address1;

  String? get address2;

  String? get city;

  String? get state;

  @BuiltValueField(wireName: 'postal_code')
  String? get postalCode;

  String? get phone;

  String? get email;

  @BuiltValueField(wireName: 'country_id')
  String? get countryId;

  @BuiltValueField(wireName: 'vat_number')
  String? get vatNumber;

  @BuiltValueField(wireName: 'id_number')
  String? get idNumber;

  @BuiltValueField(wireName: 'page_size')
  String? get pageSize;

  @BuiltValueField(wireName: 'page_layout')
  String? get pageLayout;

  @BuiltValueField(wireName: 'font_size')
  int? get fontSize;

  @BuiltValueField(wireName: 'primary_color')
  String? get primaryColor;

  @BuiltValueField(wireName: 'secondary_color')
  String? get secondaryColor;

  @BuiltValueField(wireName: 'primary_font')
  String? get primaryFont;

  @BuiltValueField(wireName: 'secondary_font')
  String? get secondaryFont;

  @BuiltValueField(wireName: 'hide_paid_to_date')
  bool? get hidePaidToDate;

  @BuiltValueField(wireName: 'embed_documents')
  bool? get embedDocuments;

  @BuiltValueField(wireName: 'all_pages_header')
  bool? get allPagesHeader;

  @BuiltValueField(wireName: 'all_pages_footer')
  bool? get allPagesFooter;

  @BuiltValueField(wireName: 'enable_reminder1')
  bool? get enableReminder1;

  @BuiltValueField(wireName: 'enable_reminder2')
  bool? get enableReminder2;

  @BuiltValueField(wireName: 'enable_reminder3')
  bool? get enableReminder3;

  @BuiltValueField(wireName: 'enable_reminder_endless')
  bool? get enableReminderEndless;

  @BuiltValueField(wireName: 'num_days_reminder1')
  int? get numDaysReminder1;

  @BuiltValueField(wireName: 'num_days_reminder2')
  int? get numDaysReminder2;

  @BuiltValueField(wireName: 'num_days_reminder3')
  int? get numDaysReminder3;

  @BuiltValueField(wireName: 'schedule_reminder1')
  String? get scheduleReminder1;

  @BuiltValueField(wireName: 'schedule_reminder2')
  String? get scheduleReminder2;

  @BuiltValueField(wireName: 'schedule_reminder3')
  String? get scheduleReminder3;

  @BuiltValueField(wireName: 'endless_reminder_frequency_id')
  String? get endlessReminderFrequencyId;

  @BuiltValueField(wireName: 'late_fee_amount1')
  double? get lateFeeAmount1;

  @BuiltValueField(wireName: 'late_fee_amount2')
  double? get lateFeeAmount2;

  @BuiltValueField(wireName: 'late_fee_amount3')
  double? get lateFeeAmount3;

  @BuiltValueField(wireName: 'late_fee_endless_amount')
  double? get lateFeeAmountEndless;

  @BuiltValueField(wireName: 'late_fee_percent1')
  double? get lateFeePercent1;

  @BuiltValueField(wireName: 'late_fee_percent2')
  double? get lateFeePercent2;

  @BuiltValueField(wireName: 'late_fee_percent3')
  double? get lateFeePercent3;

  @BuiltValueField(wireName: 'late_fee_endless_percent')
  double? get lateFeePercentEndless;

  @BuiltValueField(wireName: 'email_subject_reminder_endless')
  String? get emailSubjectReminderEndless;

  @BuiltValueField(wireName: 'email_template_reminder_endless')
  String? get emailBodyReminderEndless;

  @BuiltValueField(wireName: 'client_online_payment_notification')
  bool? get clientOnlinePaymentNotification;

  @BuiltValueField(wireName: 'client_manual_payment_notification')
  bool? get clientManualPaymentNotification;

  @BuiltValueField(wireName: 'send_email_on_mark_paid')
  bool? get clientMarkPaidPaymentNotification;

  @BuiltValueField(wireName: 'counter_number_applied')
  String? get counterNumberApplied;

  @BuiltValueField(wireName: 'email_sending_method')
  String? get emailSendingMethod;

  @BuiltValueField(wireName: 'gmail_sending_user_id')
  String? get gmailSendingUserId;

  @BuiltValueField(wireName: 'client_portal_terms')
  String? get clientPortalTerms;

  @BuiltValueField(wireName: 'client_portal_privacy_policy')
  String? get clientPortalPrivacy;

  @BuiltValueField(wireName: 'lock_invoices')
  String? get lockInvoices;

  @BuiltValueField(wireName: 'auto_bill')
  String? get autoBill;

  @BuiltValueField(wireName: 'auto_bill_standard_invoices')
  bool? get autoBillStandardInvoices;

  @BuiltValueField(wireName: 'client_portal_allow_under_payment')
  bool? get clientPortalAllowUnderPayment;

  @BuiltValueField(wireName: 'client_portal_allow_over_payment')
  bool? get clientPortalAllowOverPayment;

  @BuiltValueField(wireName: 'auto_bill_date')
  String? get autoBillDate;

  @BuiltValueField(wireName: 'client_portal_under_payment_minimum')
  double? get clientPortalUnderPaymentMinimum;

  @BuiltValueField(wireName: 'use_credits_payment')
  String? get useCreditsPayment;

  @BuiltValueField(wireName: 'portal_custom_head')
  String? get clientPortalCustomHeader;

  @BuiltValueField(wireName: 'portal_custom_css')
  String? get clientPortalCustomCss;

  @BuiltValueField(wireName: 'portal_custom_footer')
  String? get clientPortalCustomFooter;

  @BuiltValueField(wireName: 'portal_custom_js')
  String? get clientPortalCustomJs;

  @BuiltValueField(wireName: 'hide_empty_columns_on_pdf')
  bool? get hideEmptyColumnsOnPdf;

  @BuiltValueField(wireName: 'entity_send_time')
  int? get entitySendTime;

  @BuiltValueField(wireName: 'show_all_tasks_client_portal')
  String? get clientPortalTasks;

  @BuiltValueField(wireName: 'page_numbering')
  bool? get pageNumbering;

  @BuiltValueField(wireName: 'page_numbering_alignment')
  String? get pageNumberingAlignment;

  @BuiltValueField(wireName: 'require_purchase_order_signature')
  bool? get requirePurchaseOrderSignature;

  @BuiltValueField(wireName: 'purchase_order_terms')
  String? get defaultPurchaseOrderTerms;

  @BuiltValueField(wireName: 'purchase_order_design_id')
  String? get defaultPurchaseOrderDesignId;

  @BuiltValueField(wireName: 'purchase_order_footer')
  String? get defaultPurchaseOrderFooter;

  @BuiltValueField(wireName: 'purchase_order_number_pattern')
  String? get purchaseOrderNumberPattern;

  @BuiltValueField(wireName: 'purchase_order_number_counter')
  int? get purchaseOrderNumberCounter;

  @BuiltValueField(wireName: 'qr_iban')
  String? get qrIban;

  @BuiltValueField(wireName: 'besr_id')
  String? get besrId;

  @BuiltValueField(wireName: 'postmark_secret')
  String? get postmarkSecret;

  @BuiltValueField(wireName: 'mailgun_secret')
  String? get mailgunSecret;

  @BuiltValueField(wireName: 'mailgun_domain')
  String? get mailgunDomain;

  @BuiltValueField(wireName: 'mailgun_endpoint')
  String? get mailgunEndpoint;

  @BuiltValueField(wireName: 'email_alignment')
  String? get emailAlignment;

  @BuiltValueField(wireName: 'show_email_footer')
  bool? get showEmailFooter;

  @BuiltValueField(wireName: 'company_logo_size')
  String? get companyLogoSize;

  @BuiltValueField(wireName: 'show_paid_stamp')
  bool? get showPaidStamp;

  @BuiltValueField(wireName: 'show_shipping_address')
  bool? get showShippingAddress;

  @BuiltValueField(wireName: 'custom_sending_email')
  String? get customSendingEmail;

  @BuiltValueField(wireName: 'accept_client_input_quote_approval')
  bool? get acceptPurchaseOrderNumber;

  @BuiltValueField(wireName: 'client_initiated_payments')
  bool? get clientInitiatedPayments;

  @BuiltValueField(wireName: 'client_initiated_payments_minimum')
  double? get clientInitiatedPaymentsMinimum;

  @BuiltValueField(wireName: 'sync_invoice_quote_columns')
  bool? get shareInvoiceQuoteColumns;

  @BuiltValueField(wireName: 'allow_billable_task_items')
  bool? get allowBillableTaskItems;

  @BuiltValueField(wireName: 'show_task_item_description')
  bool? get showTaskItemDescription;

  @BuiltValueField(wireName: 'enable_e_invoice')
  bool? get enableEInvoice;

  @BuiltValueField(wireName: 'e_invoice_type')
  String? get eInvoiceType;

  @BuiltValueField(wireName: 'default_expense_payment_type_id')
  String? get defaultExpensePaymentTypeId;

  String? get classification;

  @BuiltValueField(wireName: 'payment_email_all_contacts')
  bool? get paymentEmailAllContacts;

  @BuiltValueField(wireName: 'show_pdfhtml_on_mobile')
  bool? get showPdfhtmlOnMobile;

  @BuiltValueField(wireName: 'use_unapplied_payment')
  String? get useUnappliedPayment;

  bool get hasAddress => address1 != null && address1!.isNotEmpty;

  bool get hasLogo => companyLogo != null && companyLogo!.isNotEmpty;

  bool get hasTimezone => timezoneId != null && timezoneId!.isNotEmpty;

  bool get hasDateFormat => dateFormatId != null && dateFormatId!.isNotEmpty;

  bool get hasLanguage => languageId != null && languageId!.isNotEmpty;

  bool get hasCurrency => currencyId != null && currencyId!.isNotEmpty;

  bool get hasDefaultPaymentTypeId =>
      defaultPaymentTypeId != null && defaultPaymentTypeId!.isNotEmpty;

  List<String> getFieldsForSection(String section) =>
      pdfVariables != null && pdfVariables!.containsKey(section)
          ? pdfVariables![section]!.toList()
          : [];

  SettingsEntity setFieldsForSection(String section, List<String> fields) {
    if (pdfVariables == null) {
      return rebuild(
          (b) => b..pdfVariables.replace({section: BuiltList<String>(fields)}));
    } else {
      return rebuild((b) => b..pdfVariables[section] = BuiltList(fields));
    }
  }

  String? getDesignId(EntityType entityType) {
    switch (entityType) {
      case EntityType.invoice:
        return defaultInvoiceDesignId;
      case EntityType.quote:
        return defaultQuoteDesignId;
      case EntityType.credit:
        return defaultCreditDesignId;
      case EntityType.purchaseOrder:
        return defaultPurchaseOrderDesignId;
    }

    print('## Error: unhandled entity type: $entityType for design id');

    return '';
  }

  String? getDefaultTerms(EntityType? entityType) {
    switch (entityType) {
      case EntityType.invoice:
      case EntityType.recurringInvoice:
        return defaultInvoiceTerms;
      case EntityType.quote:
        return defaultQuoteTerms;
      case EntityType.credit:
        return defaultCreditTerms;
      case EntityType.purchaseOrder:
        return defaultPurchaseOrderTerms;
      default:
        print('## ERROR: getDefaultTerms not defined for $entityType');
        return '';
    }
  }

  String? getDefaultFooter(EntityType? entityType) {
    switch (entityType) {
      case EntityType.invoice:
      case EntityType.recurringInvoice:
        return defaultInvoiceFooter;
      case EntityType.quote:
        return defaultQuoteFooter;
      case EntityType.credit:
        return defaultCreditFooter;
      case EntityType.purchaseOrder:
        return defaultPurchaseOrderFooter;
      default:
        print('## ERROR: getDefaultFooter not defined for $entityType');
        return '';
    }
  }

  String? getEmailSubject(EmailTemplate emailTemplate) {
    switch (emailTemplate) {
      case EmailTemplate.invoice:
        return emailSubjectInvoice;
      case EmailTemplate.quote:
        return emailSubjectQuote;
      case EmailTemplate.credit:
        return emailSubjectCredit;
      case EmailTemplate.payment:
        return emailSubjectPayment;
      case EmailTemplate.payment_partial:
        return emailSubjectPaymentPartial;
      case EmailTemplate.reminder1:
        return emailSubjectReminder1;
      case EmailTemplate.reminder2:
        return emailSubjectReminder2;
      case EmailTemplate.reminder3:
        return emailSubjectReminder3;
      case EmailTemplate.reminder_endless:
        return emailSubjectReminderEndless;
      case EmailTemplate.statement:
        return emailSubjectStatement;
      case EmailTemplate.custom1:
        return emailSubjectCustom1;
      case EmailTemplate.custom2:
        return emailSubjectCustom2;
      case EmailTemplate.custom3:
        return emailSubjectCustom3;
      case EmailTemplate.purchase_order:
        return emailSubjectPurchaseOrder;
      default:
        return 'Error: template not defined for $emailTemplate';
    }
  }

  String? getEmailBody(EmailTemplate template) {
    switch (template) {
      case EmailTemplate.invoice:
        return emailBodyInvoice;
      case EmailTemplate.quote:
        return emailBodyQuote;
      case EmailTemplate.credit:
        return emailBodyCredit;
      case EmailTemplate.payment:
        return emailBodyPayment;
      case EmailTemplate.payment_partial:
        return emailBodyPaymentPartial;
      case EmailTemplate.reminder1:
        return emailBodyReminder1;
      case EmailTemplate.reminder2:
        return emailBodyReminder2;
      case EmailTemplate.reminder3:
        return emailBodyReminder3;
      case EmailTemplate.reminder_endless:
        return emailBodyReminderEndless;
      case EmailTemplate.statement:
        return emailBodyStatement;
      case EmailTemplate.custom1:
        return emailBodyCustom1;
      case EmailTemplate.custom2:
        return emailBodyCustom2;
      case EmailTemplate.custom3:
        return emailBodyCustom3;
      case EmailTemplate.purchase_order:
        return emailBodyPurchaseOrder;
      default:
        return 'Error: template not defined for $template';
    }
  }

  static Serializer<SettingsEntity> get serializer =>
      _$settingsEntitySerializer;
}

abstract class PdfPreviewRequest
    implements Built<PdfPreviewRequest, PdfPreviewRequestBuilder> {
  factory PdfPreviewRequest({
    required String entityType,
    required String settingsType,
    required SettingsEntity settings,
    required String groupId,
    required String clientId,
  }) {
    return _$PdfPreviewRequest._(
      entityType: entityType,
      settingsType: settingsType,
      settings: settings,
      groupId: groupId,
      clientId: clientId,
    );
  }

  PdfPreviewRequest._();

  @override
  @memoized
  int get hashCode;

  @BuiltValueField(wireName: 'entity_type')
  String get entityType;

  @BuiltValueField(wireName: 'settings_type')
  String get settingsType;

  SettingsEntity get settings;

  @BuiltValueField(wireName: 'group_id')
  String get groupId;

  @BuiltValueField(wireName: 'client_id')
  String get clientId;

  static Serializer<PdfPreviewRequest> get serializer =>
      _$pdfPreviewRequestSerializer;
}
