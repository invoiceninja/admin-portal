import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';

part 'settings_model.g.dart';

abstract class SettingsEntity
    implements Built<SettingsEntity, SettingsEntityBuilder> {
  factory SettingsEntity({
    SettingsEntity companySettings,
    SettingsEntity groupSettings,
    SettingsEntity clientSettings,
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
      defaultInvoiceTerms: clientSettings?.defaultInvoiceTerms ??
          groupSettings?.defaultInvoiceTerms ??
          companySettings?.defaultInvoiceTerms,
      defaultInvoiceFooter: clientSettings?.defaultInvoiceFooter ??
          groupSettings?.defaultInvoiceFooter ??
          companySettings?.defaultInvoiceFooter,
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
    );
  }

  SettingsEntity._();

  @override
  @memoized
  int get hashCode;

  static const EMAIL_SENDING_METHOD_DEFAULT = 'default';
  static const EMAIL_SENDING_METHOD_GMAIL = 'gmail';

  static const LOCK_INVOICES_OFF = 'off';
  static const LOCK_INVOICES_SENT = 'when_sent';
  static const LOCK_INVOICES_PAID = 'when_paid';

  static const AUTO_BILL_OFF = 'off';
  static const AUTO_BILL_OPT_IN = 'optin';
  static const AUTO_BILL_OPT_OUT = 'optout';
  static const AUTO_BILL_ALWAYS = 'always';

  static const AUTO_BILL_ON_SEND_DATE = 'on_send_date';
  static const AUTO_BILL_ON_DUE_DATE = 'on_due_date';

  @nullable
  @BuiltValueField(wireName: 'timezone_id')
  String get timezoneId;

  @nullable
  @BuiltValueField(wireName: 'date_format_id')
  String get dateFormatId;

  @nullable
  @BuiltValueField(wireName: 'military_time')
  bool get enableMilitaryTime;

  @nullable
  @BuiltValueField(wireName: 'language_id')
  String get languageId;

  @nullable
  @BuiltValueField(wireName: 'show_currency_code')
  bool get showCurrencyCode;

  @nullable
  @BuiltValueField(wireName: 'currency_id')
  String get currencyId;

  @nullable
  @BuiltValueField(wireName: 'custom_value1')
  String get customValue1;

  @nullable
  @BuiltValueField(wireName: 'custom_value2')
  String get customValue2;

  @nullable
  @BuiltValueField(wireName: 'custom_value3')
  String get customValue3;

  @nullable
  @BuiltValueField(wireName: 'custom_value4')
  String get customValue4;

  @nullable
  @BuiltValueField(wireName: 'payment_terms')
  String get defaultPaymentTerms;

  @nullable
  @BuiltValueField(wireName: 'valid_until')
  String get defaultValidUntil;

  @nullable
  @BuiltValueField(wireName: 'company_gateway_ids')
  String get companyGatewayIds;

  @nullable
  @BuiltValueField(wireName: 'default_task_rate')
  double get defaultTaskRate;

  @nullable
  @BuiltValueField(wireName: 'send_reminders')
  bool get sendReminders;

  @nullable
  @BuiltValueField(wireName: 'enable_client_portal')
  bool get enablePortal;

  @nullable
  @BuiltValueField(wireName: 'enable_client_portal_dashboard')
  bool get enablePortalDashboard;

  @nullable
  @BuiltValueField(wireName: 'enable_client_portal_tasks')
  bool get enablePortalTasks;

  @nullable
  @BuiltValueField(wireName: 'client_portal_enable_uploads')
  bool get enablePortalUploads;

  @nullable
  @BuiltValueField(wireName: 'email_style')
  String get emailStyle;

  @nullable
  @BuiltValueField(wireName: 'reply_to_email')
  String get replyToEmail;

  @nullable
  @BuiltValueField(wireName: 'reply_to_name')
  String get replyToName;

  @nullable
  @BuiltValueField(wireName: 'bcc_email')
  String get bccEmail;

  @nullable
  @BuiltValueField(wireName: 'pdf_email_attachment')
  bool get pdfEmailAttachment;

  @nullable
  @BuiltValueField(wireName: 'ubl_email_attachment')
  bool get ublEmailAttachment;

  @nullable
  @BuiltValueField(wireName: 'document_email_attachment')
  bool get documentEmailAttachment;

  @nullable
  @BuiltValueField(wireName: 'email_style_custom')
  String get emailStyleCustom;

  @nullable
  @BuiltValueField(wireName: 'custom_message_dashboard')
  String get customMessageDashboard;

  @nullable
  @BuiltValueField(wireName: 'custom_message_unpaid_invoice')
  String get customMessageUnpaidInvoice;

  @nullable
  @BuiltValueField(wireName: 'custom_message_paid_invoice')
  String get customMessagePaidInvoice;

  @nullable
  @BuiltValueField(wireName: 'custom_message_unapproved_quote')
  String get customMessageUnapprovedQuote;

  @nullable
  @BuiltValueField(wireName: 'auto_archive_invoice')
  bool get autoArchiveInvoice;

  @nullable
  @BuiltValueField(wireName: 'auto_archive_quote')
  bool get autoArchiveQuote;

  @nullable
  @BuiltValueField(wireName: 'auto_email_invoice')
  bool get autoEmailInvoice;

  @nullable
  @BuiltValueField(wireName: 'auto_convert_quote')
  bool get autoConvertQuote;

  @nullable
  @BuiltValueField(wireName: 'inclusive_taxes')
  bool get enableInclusiveTaxes;

  @nullable
  BuiltMap<String, String> get translations;

  @nullable
  @BuiltValueField(wireName: 'task_number_pattern')
  String get taskNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'task_number_counter')
  int get taskNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'expense_number_pattern')
  String get expenseNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'expense_number_counter')
  int get expenseNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'vendor_number_pattern')
  String get vendorNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'vendor_number_counter')
  int get vendorNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'ticket_number_pattern')
  String get ticketNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'ticket_number_counter')
  int get ticketNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'payment_number_pattern')
  String get paymentNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'payment_number_counter')
  int get paymentNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'project_number_pattern')
  String get projectNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'project_number_counter')
  int get projectNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'invoice_number_pattern')
  String get invoiceNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'invoice_number_counter')
  int get invoiceNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'recurring_invoice_number_pattern')
  String get recurringInvoiceNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'recurring_invoice_number_counter')
  int get recurringInvoiceNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'quote_number_pattern')
  String get quoteNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'quote_number_counter')
  int get quoteNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'client_number_pattern')
  String get clientNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'client_number_counter')
  int get clientNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'credit_number_pattern')
  String get creditNumberPattern;

  @nullable
  @BuiltValueField(wireName: 'credit_number_counter')
  int get creditNumberCounter;

  @nullable
  @BuiltValueField(wireName: 'recurring_number_prefix')
  String get recurringNumberPrefix;

  @nullable
  @BuiltValueField(wireName: 'reset_counter_frequency_id')
  String get resetCounterFrequencyId;

  @nullable
  @BuiltValueField(wireName: 'reset_counter_date')
  String get resetCounterDate;

  @nullable
  @BuiltValueField(wireName: 'counter_padding')
  int get counterPadding;

  @nullable
  @BuiltValueField(wireName: 'shared_invoice_quote_counter')
  bool get sharedInvoiceQuoteCounter;

  @nullable
  @BuiltValueField(wireName: 'shared_invoice_credit_counter')
  bool get sharedInvoiceCreditCounter;

  @nullable
  @BuiltValueField(wireName: 'invoice_terms')
  String get defaultInvoiceTerms;

  @nullable
  @BuiltValueField(wireName: 'quote_terms')
  String get defaultQuoteTerms;

  @nullable
  @BuiltValueField(wireName: 'quote_footer')
  String get defaultQuoteFooter;

  @nullable
  @BuiltValueField(wireName: 'credit_terms')
  String get defaultCreditTerms;

  @nullable
  @BuiltValueField(wireName: 'credit_footer')
  String get defaultCreditFooter;

  @nullable
  @BuiltValueField(wireName: 'invoice_design_id')
  String get defaultInvoiceDesignId;

  @nullable
  @BuiltValueField(wireName: 'quote_design_id')
  String get defaultQuoteDesignId;

  @nullable
  @BuiltValueField(wireName: 'credit_design_id')
  String get defaultCreditDesignId;

  @nullable
  @BuiltValueField(wireName: 'invoice_footer')
  String get defaultInvoiceFooter;

  @nullable
  @BuiltValueField(wireName: 'tax_name1')
  String get defaultTaxName1;

  @nullable
  @BuiltValueField(wireName: 'tax_rate1')
  double get defaultTaxRate1;

  @nullable
  @BuiltValueField(wireName: 'tax_name2')
  String get defaultTaxName2;

  @nullable
  @BuiltValueField(wireName: 'tax_rate2')
  double get defaultTaxRate2;

  @nullable
  @BuiltValueField(wireName: 'tax_name3')
  String get defaultTaxName3;

  @nullable
  @BuiltValueField(wireName: 'tax_rate3')
  double get defaultTaxRate3;

  @nullable
  @BuiltValueField(wireName: 'payment_type_id')
  String get defaultPaymentTypeId;

  @nullable
  @BuiltValueField(wireName: 'pdf_variables')
  BuiltMap<String, BuiltList<String>> get pdfVariables;

  @nullable
  @BuiltValueField(wireName: 'email_signature')
  String get emailSignature;

  @nullable
  @BuiltValueField(wireName: 'email_subject_invoice')
  String get emailSubjectInvoice;

  @nullable
  @BuiltValueField(wireName: 'email_subject_quote')
  String get emailSubjectQuote;

  @nullable
  @BuiltValueField(wireName: 'email_subject_credit')
  String get emailSubjectCredit;

  @nullable
  @BuiltValueField(wireName: 'email_subject_payment')
  String get emailSubjectPayment;

  @nullable
  @BuiltValueField(wireName: 'email_subject_payment_partial')
  String get emailSubjectPaymentPartial;

  @nullable
  @BuiltValueField(wireName: 'email_template_invoice')
  String get emailBodyInvoice;

  @nullable
  @BuiltValueField(wireName: 'email_template_quote')
  String get emailBodyQuote;

  @nullable
  @BuiltValueField(wireName: 'email_template_credit')
  String get emailBodyCredit;

  @nullable
  @BuiltValueField(wireName: 'email_template_payment')
  String get emailBodyPayment;

  @nullable
  @BuiltValueField(wireName: 'email_template_payment_partial')
  String get emailBodyPaymentPartial;

  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder1')
  String get emailSubjectReminder1;

  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder2')
  String get emailSubjectReminder2;

  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder3')
  String get emailSubjectReminder3;

  @nullable
  @BuiltValueField(wireName: 'email_template_reminder1')
  String get emailBodyReminder1;

  @nullable
  @BuiltValueField(wireName: 'email_template_reminder2')
  String get emailBodyReminder2;

  @nullable
  @BuiltValueField(wireName: 'email_template_reminder3')
  String get emailBodyReminder3;

  @nullable
  @BuiltValueField(wireName: 'email_subject_custom1')
  String get emailSubjectCustom1;

  @nullable
  @BuiltValueField(wireName: 'email_template_custom1')
  String get emailBodyCustom1;

  @nullable
  @BuiltValueField(wireName: 'email_subject_custom2')
  String get emailSubjectCustom2;

  @nullable
  @BuiltValueField(wireName: 'email_template_custom2')
  String get emailBodyCustom2;

  @nullable
  @BuiltValueField(wireName: 'email_subject_custom3')
  String get emailSubjectCustom3;

  @nullable
  @BuiltValueField(wireName: 'email_template_custom3')
  String get emailBodyCustom3;

  @nullable
  @BuiltValueField(wireName: 'email_subject_statement')
  String get emailSubjectStatement;

  @nullable
  @BuiltValueField(wireName: 'email_template_statement')
  String get emailBodyStatement;

  @nullable
  @BuiltValueField(wireName: 'enable_client_portal_password')
  bool get enablePortalPassword;

  @nullable
  @BuiltValueField(wireName: 'signature_on_pdf')
  bool get signatureOnPdf;

  @nullable
  @BuiltValueField(wireName: 'enable_email_markup')
  bool get enableEmailMarkup;

  @nullable
  @BuiltValueField(wireName: 'show_accept_invoice_terms')
  bool get showAcceptInvoiceTerms;

  @nullable
  @BuiltValueField(wireName: 'show_accept_quote_terms')
  bool get showAcceptQuoteTerms;

  @nullable
  @BuiltValueField(wireName: 'require_invoice_signature')
  bool get requireInvoiceSignature;

  @nullable
  @BuiltValueField(wireName: 'require_quote_signature')
  bool get requireQuoteSignature;

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: 'company_logo')
  String get companyLogo;

  @nullable
  @BuiltValueField(wireName: 'website')
  String get website;

  @nullable
  String get address1;

  @nullable
  String get address2;

  @nullable
  String get city;

  @nullable
  String get state;

  @nullable
  @BuiltValueField(wireName: 'postal_code')
  String get postalCode;

  @nullable
  String get phone;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'country_id')
  String get countryId;

  @nullable
  @BuiltValueField(wireName: 'vat_number')
  String get vatNumber;

  @nullable
  @BuiltValueField(wireName: 'id_number')
  String get idNumber;

  @nullable
  @BuiltValueField(wireName: 'page_size')
  String get pageSize;

  @nullable
  @BuiltValueField(wireName: 'page_layout')
  String get pageLayout;

  @nullable
  @BuiltValueField(wireName: 'font_size')
  int get fontSize;

  @nullable
  @BuiltValueField(wireName: 'primary_color')
  String get primaryColor;

  @nullable
  @BuiltValueField(wireName: 'secondary_color')
  String get secondaryColor;

  @nullable
  @BuiltValueField(wireName: 'primary_font')
  String get primaryFont;

  @nullable
  @BuiltValueField(wireName: 'secondary_font')
  String get secondaryFont;

  @nullable
  @BuiltValueField(wireName: 'hide_paid_to_date')
  bool get hidePaidToDate;

  @nullable
  @BuiltValueField(wireName: 'embed_documents')
  bool get embedDocuments;

  @nullable
  @BuiltValueField(wireName: 'all_pages_header')
  bool get allPagesHeader;

  @nullable
  @BuiltValueField(wireName: 'all_pages_footer')
  bool get allPagesFooter;

  @nullable
  @BuiltValueField(wireName: 'enable_reminder1')
  bool get enableReminder1;

  @nullable
  @BuiltValueField(wireName: 'enable_reminder2')
  bool get enableReminder2;

  @nullable
  @BuiltValueField(wireName: 'enable_reminder3')
  bool get enableReminder3;

  @nullable
  @BuiltValueField(wireName: 'enable_reminder_endless')
  bool get enableReminderEndless;

  @nullable
  @BuiltValueField(wireName: 'num_days_reminder1')
  int get numDaysReminder1;

  @nullable
  @BuiltValueField(wireName: 'num_days_reminder2')
  int get numDaysReminder2;

  @nullable
  @BuiltValueField(wireName: 'num_days_reminder3')
  int get numDaysReminder3;

  @nullable
  @BuiltValueField(wireName: 'schedule_reminder1')
  String get scheduleReminder1;

  @nullable
  @BuiltValueField(wireName: 'schedule_reminder2')
  String get scheduleReminder2;

  @nullable
  @BuiltValueField(wireName: 'schedule_reminder3')
  String get scheduleReminder3;

  @nullable
  @BuiltValueField(wireName: 'endless_reminder_frequency_id')
  String get endlessReminderFrequencyId;

  @nullable
  @BuiltValueField(wireName: 'late_fee_amount1')
  double get lateFeeAmount1;

  @nullable
  @BuiltValueField(wireName: 'late_fee_amount2')
  double get lateFeeAmount2;

  @nullable
  @BuiltValueField(wireName: 'late_fee_amount3')
  double get lateFeeAmount3;

  @nullable
  @BuiltValueField(wireName: 'late_fee_endless_amount')
  double get lateFeeAmountEndless;

  @nullable
  @BuiltValueField(wireName: 'late_fee_percent1')
  double get lateFeePercent1;

  @nullable
  @BuiltValueField(wireName: 'late_fee_percent2')
  double get lateFeePercent2;

  @nullable
  @BuiltValueField(wireName: 'late_fee_percent3')
  double get lateFeePercent3;

  @nullable
  @BuiltValueField(wireName: 'late_fee_endless_percent')
  double get lateFeePercentEndless;

  @nullable
  @BuiltValueField(wireName: 'email_subject_reminder_endless')
  String get emailSubjectReminderEndless;

  @nullable
  @BuiltValueField(wireName: 'email_template_reminder_endless')
  String get emailBodyReminderEndless;

  @nullable
  @BuiltValueField(wireName: 'client_online_payment_notification')
  bool get clientOnlinePaymentNotification;

  @nullable
  @BuiltValueField(wireName: 'client_manual_payment_notification')
  bool get clientManualPaymentNotification;

  @nullable
  @BuiltValueField(wireName: 'counter_number_applied')
  String get counterNumberApplied;

  @nullable
  @BuiltValueField(wireName: 'email_sending_method')
  String get emailSendingMethod;

  @nullable
  @BuiltValueField(wireName: 'gmail_sending_user_id')
  String get gmailSendingUserId;

  @nullable
  @BuiltValueField(wireName: 'client_portal_terms')
  String get clientPortalTerms;

  @nullable
  @BuiltValueField(wireName: 'client_portal_privacy_policy')
  String get clientPortalPrivacy;

  @nullable
  @BuiltValueField(wireName: 'lock_invoices')
  String get lockInvoices;

  @nullable
  @BuiltValueField(wireName: 'auto_bill')
  String get autoBill;

  @nullable
  @BuiltValueField(wireName: 'client_portal_allow_under_payment')
  bool get clientPortalAllowUnderPayment;

  @nullable
  @BuiltValueField(wireName: 'client_portal_allow_over_payment')
  bool get clientPortalAllowOverPayment;

  @nullable
  @BuiltValueField(wireName: 'auto_bill_date')
  String get autoBillDate;

  @nullable
  @BuiltValueField(wireName: 'client_portal_under_payment_minimum')
  double get clientPortalUnderPaymentMinimum;

  @nullable
  @BuiltValueField(wireName: 'use_credits_payment')
  String get useCreditsPayment;

  @nullable
  @BuiltValueField(wireName: 'portal_custom_head')
  String get clientPortalCustomHeader;

  @nullable
  @BuiltValueField(wireName: 'portal_custom_css')
  String get clientPortalCustomCss;

  @nullable
  @BuiltValueField(wireName: 'portal_custom_footer')
  String get clientPortalCustomFooter;

  @nullable
  @BuiltValueField(wireName: 'portal_custom_js')
  String get clientPortalCustomJs;

  @nullable
  @BuiltValueField(wireName: 'hide_empty_columns_on_pdf')
  bool get hideEmptyColumnsOnPdf;

  // TODO remove this field
  @nullable
  @BuiltValueField(wireName: 'has_custom_design1_HIDDEN')
  bool get hasCustomDesign1;

  // TODO remove this field
  @nullable
  @BuiltValueField(wireName: 'has_custom_design2_HIDDEN')
  bool get hasCustomDesign2;

  // TODO remove this field
  @nullable
  @BuiltValueField(wireName: 'has_custom_design3_HIDDEN')
  bool get hasCustomDesign3;

  bool get hasAddress => address1 != null && address1.isNotEmpty;

  bool get hasLogo => companyLogo != null && companyLogo.isNotEmpty;

  bool get hasTimezone => timezoneId != null && timezoneId.isNotEmpty;

  bool get hasDateFormat => dateFormatId != null && dateFormatId.isNotEmpty;

  bool get hasLanguage => languageId != null && languageId.isNotEmpty;

  bool get hasCurrency => currencyId != null && currencyId.isNotEmpty;

  bool get hasDefaultPaymentTypeId =>
      defaultPaymentTypeId != null && defaultPaymentTypeId.isNotEmpty;

  List<String> getFieldsForSection(String section) =>
      pdfVariables != null && pdfVariables.containsKey(section)
          ? pdfVariables[section].toList()
          : [];

  SettingsEntity setFieldsForSection(String section, List<String> fields) {
    if (pdfVariables == null) {
      return rebuild((b) => b..pdfVariables.replace({section: fields}));
    } else {
      return rebuild((b) => b..pdfVariables[section] = BuiltList(fields));
    }
  }

  String getDefaultTerms(EntityType entityType) {
    switch (entityType) {
      case EntityType.invoice:
        return defaultInvoiceTerms;
      case EntityType.quote:
        return defaultQuoteTerms;
      case EntityType.credit:
        return defaultCreditTerms;
      default:
        print('## Error: getDefaultTerms not defined for $entityType');
        return '';
    }
  }

  String getDefaultFooter(EntityType entityType) {
    switch (entityType) {
      case EntityType.invoice:
        return defaultInvoiceFooter;
      case EntityType.quote:
        return defaultQuoteFooter;
      case EntityType.credit:
        return defaultCreditFooter;
      default:
        print('## Error: getDefaultFooter not defined for $entityType');
        return '';
    }
  }

  String getEmailSubject(EmailTemplate emailTemplate) {
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
      case EmailTemplate.custom1:
        return emailSubjectCustom1;
      case EmailTemplate.custom2:
        return emailSubjectCustom2;
      case EmailTemplate.custom3:
        return emailSubjectCustom3;
      default:
        return 'Error: template not defined for $emailTemplate';
    }
  }

  String getEmailBody(EmailTemplate template) {
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
      case EmailTemplate.custom1:
        return emailBodyCustom1;
      case EmailTemplate.custom2:
        return emailBodyCustom2;
      case EmailTemplate.custom3:
        return emailBodyCustom3;
      default:
        return 'Error: template not defined for $template';
    }
  }

  static Serializer<SettingsEntity> get serializer =>
      _$settingsEntitySerializer;
}
