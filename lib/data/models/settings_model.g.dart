// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SettingsEntity> _$settingsEntitySerializer =
    new _$SettingsEntitySerializer();
Serializer<PdfPreviewRequest> _$pdfPreviewRequestSerializer =
    new _$PdfPreviewRequestSerializer();

class _$SettingsEntitySerializer
    implements StructuredSerializer<SettingsEntity> {
  @override
  final Iterable<Type> types = const [SettingsEntity, _$SettingsEntity];
  @override
  final String wireName = 'SettingsEntity';

  @override
  Iterable<Object?> serialize(Serializers serializers, SettingsEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.timezoneId;
    if (value != null) {
      result
        ..add('timezone_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.dateFormatId;
    if (value != null) {
      result
        ..add('date_format_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.enableMilitaryTime;
    if (value != null) {
      result
        ..add('military_time')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.languageId;
    if (value != null) {
      result
        ..add('language_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.showCurrencyCode;
    if (value != null) {
      result
        ..add('show_currency_code')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.currencyId;
    if (value != null) {
      result
        ..add('currency_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customValue1;
    if (value != null) {
      result
        ..add('custom_value1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customValue2;
    if (value != null) {
      result
        ..add('custom_value2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customValue3;
    if (value != null) {
      result
        ..add('custom_value3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customValue4;
    if (value != null) {
      result
        ..add('custom_value4')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultPaymentTerms;
    if (value != null) {
      result
        ..add('payment_terms')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultValidUntil;
    if (value != null) {
      result
        ..add('valid_until')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.companyGatewayIds;
    if (value != null) {
      result
        ..add('company_gateway_ids')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultTaskRate;
    if (value != null) {
      result
        ..add('default_task_rate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.sendReminders;
    if (value != null) {
      result
        ..add('send_reminders')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enablePortal;
    if (value != null) {
      result
        ..add('enable_client_portal')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enablePortalDashboard;
    if (value != null) {
      result
        ..add('enable_client_portal_dashboard')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enablePortalTasks;
    if (value != null) {
      result
        ..add('enable_client_portal_tasks')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enableClientPortalUploads;
    if (value != null) {
      result
        ..add('client_portal_enable_uploads')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enableVendorPortalUploads;
    if (value != null) {
      result
        ..add('vendor_portal_enable_uploads')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.emailStyle;
    if (value != null) {
      result
        ..add('email_style')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.replyToEmail;
    if (value != null) {
      result
        ..add('reply_to_email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.replyToName;
    if (value != null) {
      result
        ..add('reply_to_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailFromName;
    if (value != null) {
      result
        ..add('email_from_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.bccEmail;
    if (value != null) {
      result
        ..add('bcc_email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pdfEmailAttachment;
    if (value != null) {
      result
        ..add('pdf_email_attachment')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.ublEmailAttachment;
    if (value != null) {
      result
        ..add('ubl_email_attachment')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.documentEmailAttachment;
    if (value != null) {
      result
        ..add('document_email_attachment')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.emailStyleCustom;
    if (value != null) {
      result
        ..add('email_style_custom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customMessageDashboard;
    if (value != null) {
      result
        ..add('custom_message_dashboard')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customMessageUnpaidInvoice;
    if (value != null) {
      result
        ..add('custom_message_unpaid_invoice')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customMessagePaidInvoice;
    if (value != null) {
      result
        ..add('custom_message_paid_invoice')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customMessageUnapprovedQuote;
    if (value != null) {
      result
        ..add('custom_message_unapproved_quote')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.autoArchiveInvoice;
    if (value != null) {
      result
        ..add('auto_archive_invoice')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.autoArchiveInvoiceCancelled;
    if (value != null) {
      result
        ..add('auto_archive_invoice_cancelled')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.autoArchiveQuote;
    if (value != null) {
      result
        ..add('auto_archive_quote')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.autoEmailInvoice;
    if (value != null) {
      result
        ..add('auto_email_invoice')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.autoConvertQuote;
    if (value != null) {
      result
        ..add('auto_convert_quote')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enableInclusiveTaxes;
    if (value != null) {
      result
        ..add('inclusive_taxes')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.translations;
    if (value != null) {
      result
        ..add('translations')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap, const [
              const FullType.nullable(String),
              const FullType(String)
            ])));
    }
    value = object.taskNumberPattern;
    if (value != null) {
      result
        ..add('task_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.taskNumberCounter;
    if (value != null) {
      result
        ..add('task_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.expenseNumberPattern;
    if (value != null) {
      result
        ..add('expense_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.expenseNumberCounter;
    if (value != null) {
      result
        ..add('expense_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.recurringExpenseNumberPattern;
    if (value != null) {
      result
        ..add('recurring_expense_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.recurringExpenseNumberCounter;
    if (value != null) {
      result
        ..add('recurring_expense_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.vendorNumberPattern;
    if (value != null) {
      result
        ..add('vendor_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.vendorNumberCounter;
    if (value != null) {
      result
        ..add('vendor_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.ticketNumberPattern;
    if (value != null) {
      result
        ..add('ticket_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ticketNumberCounter;
    if (value != null) {
      result
        ..add('ticket_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.paymentNumberPattern;
    if (value != null) {
      result
        ..add('payment_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.paymentNumberCounter;
    if (value != null) {
      result
        ..add('payment_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.projectNumberPattern;
    if (value != null) {
      result
        ..add('project_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.projectNumberCounter;
    if (value != null) {
      result
        ..add('project_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.invoiceNumberPattern;
    if (value != null) {
      result
        ..add('invoice_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.invoiceNumberCounter;
    if (value != null) {
      result
        ..add('invoice_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.recurringInvoiceNumberPattern;
    if (value != null) {
      result
        ..add('recurring_invoice_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.recurringInvoiceNumberCounter;
    if (value != null) {
      result
        ..add('recurring_invoice_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.quoteNumberPattern;
    if (value != null) {
      result
        ..add('quote_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.quoteNumberCounter;
    if (value != null) {
      result
        ..add('quote_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.clientNumberPattern;
    if (value != null) {
      result
        ..add('client_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientNumberCounter;
    if (value != null) {
      result
        ..add('client_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.creditNumberPattern;
    if (value != null) {
      result
        ..add('credit_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.creditNumberCounter;
    if (value != null) {
      result
        ..add('credit_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.recurringNumberPrefix;
    if (value != null) {
      result
        ..add('recurring_number_prefix')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.resetCounterFrequencyId;
    if (value != null) {
      result
        ..add('reset_counter_frequency_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.resetCounterDate;
    if (value != null) {
      result
        ..add('reset_counter_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.counterPadding;
    if (value != null) {
      result
        ..add('counter_padding')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.sharedInvoiceQuoteCounter;
    if (value != null) {
      result
        ..add('shared_invoice_quote_counter')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.sharedInvoiceCreditCounter;
    if (value != null) {
      result
        ..add('shared_invoice_credit_counter')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.defaultInvoiceTerms;
    if (value != null) {
      result
        ..add('invoice_terms')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultQuoteTerms;
    if (value != null) {
      result
        ..add('quote_terms')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultQuoteFooter;
    if (value != null) {
      result
        ..add('quote_footer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultCreditTerms;
    if (value != null) {
      result
        ..add('credit_terms')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultCreditFooter;
    if (value != null) {
      result
        ..add('credit_footer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultInvoiceDesignId;
    if (value != null) {
      result
        ..add('invoice_design_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultQuoteDesignId;
    if (value != null) {
      result
        ..add('quote_design_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultCreditDesignId;
    if (value != null) {
      result
        ..add('credit_design_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultDeliveryNoteDesignId;
    if (value != null) {
      result
        ..add('delivery_note_design_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultStatementDesignId;
    if (value != null) {
      result
        ..add('statement_design_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultPaymentReceiptDesignId;
    if (value != null) {
      result
        ..add('payment_receipt_design_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultPaymentRefundDesignId;
    if (value != null) {
      result
        ..add('payment_refund_design_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultInvoiceFooter;
    if (value != null) {
      result
        ..add('invoice_footer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultTaxName1;
    if (value != null) {
      result
        ..add('tax_name1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultTaxRate1;
    if (value != null) {
      result
        ..add('tax_rate1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.defaultTaxName2;
    if (value != null) {
      result
        ..add('tax_name2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultTaxRate2;
    if (value != null) {
      result
        ..add('tax_rate2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.defaultTaxName3;
    if (value != null) {
      result
        ..add('tax_name3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultTaxRate3;
    if (value != null) {
      result
        ..add('tax_rate3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.defaultPaymentTypeId;
    if (value != null) {
      result
        ..add('payment_type_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pdfVariables;
    if (value != null) {
      result
        ..add('pdf_variables')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(BuiltList, const [const FullType(String)])
            ])));
    }
    value = object.emailSignature;
    if (value != null) {
      result
        ..add('email_signature')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectInvoice;
    if (value != null) {
      result
        ..add('email_subject_invoice')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectQuote;
    if (value != null) {
      result
        ..add('email_subject_quote')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectCredit;
    if (value != null) {
      result
        ..add('email_subject_credit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectPayment;
    if (value != null) {
      result
        ..add('email_subject_payment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectPaymentPartial;
    if (value != null) {
      result
        ..add('email_subject_payment_partial')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyInvoice;
    if (value != null) {
      result
        ..add('email_template_invoice')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyQuote;
    if (value != null) {
      result
        ..add('email_template_quote')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyCredit;
    if (value != null) {
      result
        ..add('email_template_credit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyPayment;
    if (value != null) {
      result
        ..add('email_template_payment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyPaymentPartial;
    if (value != null) {
      result
        ..add('email_template_payment_partial')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectReminder1;
    if (value != null) {
      result
        ..add('email_subject_reminder1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectReminder2;
    if (value != null) {
      result
        ..add('email_subject_reminder2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectReminder3;
    if (value != null) {
      result
        ..add('email_subject_reminder3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyReminder1;
    if (value != null) {
      result
        ..add('email_template_reminder1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyReminder2;
    if (value != null) {
      result
        ..add('email_template_reminder2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyReminder3;
    if (value != null) {
      result
        ..add('email_template_reminder3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectCustom1;
    if (value != null) {
      result
        ..add('email_subject_custom1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyCustom1;
    if (value != null) {
      result
        ..add('email_template_custom1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectCustom2;
    if (value != null) {
      result
        ..add('email_subject_custom2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyCustom2;
    if (value != null) {
      result
        ..add('email_template_custom2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectCustom3;
    if (value != null) {
      result
        ..add('email_subject_custom3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyCustom3;
    if (value != null) {
      result
        ..add('email_template_custom3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectStatement;
    if (value != null) {
      result
        ..add('email_subject_statement')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyStatement;
    if (value != null) {
      result
        ..add('email_template_statement')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSubjectPurchaseOrder;
    if (value != null) {
      result
        ..add('email_subject_purchase_order')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyPurchaseOrder;
    if (value != null) {
      result
        ..add('email_template_purchase_order')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.enablePortalPassword;
    if (value != null) {
      result
        ..add('enable_client_portal_password')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.signatureOnPdf;
    if (value != null) {
      result
        ..add('signature_on_pdf')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enableEmailMarkup;
    if (value != null) {
      result
        ..add('enable_email_markup')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.showAcceptInvoiceTerms;
    if (value != null) {
      result
        ..add('show_accept_invoice_terms')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.showAcceptQuoteTerms;
    if (value != null) {
      result
        ..add('show_accept_quote_terms')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.requireInvoiceSignature;
    if (value != null) {
      result
        ..add('require_invoice_signature')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.requireQuoteSignature;
    if (value != null) {
      result
        ..add('require_quote_signature')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.companyLogo;
    if (value != null) {
      result
        ..add('company_logo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.website;
    if (value != null) {
      result
        ..add('website')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.address1;
    if (value != null) {
      result
        ..add('address1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.address2;
    if (value != null) {
      result
        ..add('address2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.city;
    if (value != null) {
      result
        ..add('city')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.state;
    if (value != null) {
      result
        ..add('state')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postalCode;
    if (value != null) {
      result
        ..add('postal_code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.countryId;
    if (value != null) {
      result
        ..add('country_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.vatNumber;
    if (value != null) {
      result
        ..add('vat_number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.idNumber;
    if (value != null) {
      result
        ..add('id_number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pageSize;
    if (value != null) {
      result
        ..add('page_size')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pageLayout;
    if (value != null) {
      result
        ..add('page_layout')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fontSize;
    if (value != null) {
      result
        ..add('font_size')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.primaryColor;
    if (value != null) {
      result
        ..add('primary_color')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.secondaryColor;
    if (value != null) {
      result
        ..add('secondary_color')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.primaryFont;
    if (value != null) {
      result
        ..add('primary_font')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.secondaryFont;
    if (value != null) {
      result
        ..add('secondary_font')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.hidePaidToDate;
    if (value != null) {
      result
        ..add('hide_paid_to_date')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.embedDocuments;
    if (value != null) {
      result
        ..add('embed_documents')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.allPagesHeader;
    if (value != null) {
      result
        ..add('all_pages_header')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.allPagesFooter;
    if (value != null) {
      result
        ..add('all_pages_footer')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enableReminder1;
    if (value != null) {
      result
        ..add('enable_reminder1')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enableReminder2;
    if (value != null) {
      result
        ..add('enable_reminder2')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enableReminder3;
    if (value != null) {
      result
        ..add('enable_reminder3')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enableReminderEndless;
    if (value != null) {
      result
        ..add('enable_reminder_endless')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.numDaysReminder1;
    if (value != null) {
      result
        ..add('num_days_reminder1')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.numDaysReminder2;
    if (value != null) {
      result
        ..add('num_days_reminder2')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.numDaysReminder3;
    if (value != null) {
      result
        ..add('num_days_reminder3')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.scheduleReminder1;
    if (value != null) {
      result
        ..add('schedule_reminder1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.scheduleReminder2;
    if (value != null) {
      result
        ..add('schedule_reminder2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.scheduleReminder3;
    if (value != null) {
      result
        ..add('schedule_reminder3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.endlessReminderFrequencyId;
    if (value != null) {
      result
        ..add('endless_reminder_frequency_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lateFeeAmount1;
    if (value != null) {
      result
        ..add('late_fee_amount1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.lateFeeAmount2;
    if (value != null) {
      result
        ..add('late_fee_amount2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.lateFeeAmount3;
    if (value != null) {
      result
        ..add('late_fee_amount3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.lateFeeAmountEndless;
    if (value != null) {
      result
        ..add('late_fee_endless_amount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.lateFeePercent1;
    if (value != null) {
      result
        ..add('late_fee_percent1')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.lateFeePercent2;
    if (value != null) {
      result
        ..add('late_fee_percent2')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.lateFeePercent3;
    if (value != null) {
      result
        ..add('late_fee_percent3')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.lateFeePercentEndless;
    if (value != null) {
      result
        ..add('late_fee_endless_percent')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.emailSubjectReminderEndless;
    if (value != null) {
      result
        ..add('email_subject_reminder_endless')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailBodyReminderEndless;
    if (value != null) {
      result
        ..add('email_template_reminder_endless')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientOnlinePaymentNotification;
    if (value != null) {
      result
        ..add('client_online_payment_notification')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.clientManualPaymentNotification;
    if (value != null) {
      result
        ..add('client_manual_payment_notification')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.clientMarkPaidPaymentNotification;
    if (value != null) {
      result
        ..add('send_email_on_mark_paid')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.counterNumberApplied;
    if (value != null) {
      result
        ..add('counter_number_applied')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailSendingMethod;
    if (value != null) {
      result
        ..add('email_sending_method')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.gmailSendingUserId;
    if (value != null) {
      result
        ..add('gmail_sending_user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientPortalTerms;
    if (value != null) {
      result
        ..add('client_portal_terms')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientPortalPrivacy;
    if (value != null) {
      result
        ..add('client_portal_privacy_policy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lockInvoices;
    if (value != null) {
      result
        ..add('lock_invoices')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.autoBill;
    if (value != null) {
      result
        ..add('auto_bill')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.autoBillStandardInvoices;
    if (value != null) {
      result
        ..add('auto_bill_standard_invoices')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.clientPortalAllowUnderPayment;
    if (value != null) {
      result
        ..add('client_portal_allow_under_payment')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.clientPortalAllowOverPayment;
    if (value != null) {
      result
        ..add('client_portal_allow_over_payment')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.autoBillDate;
    if (value != null) {
      result
        ..add('auto_bill_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientPortalUnderPaymentMinimum;
    if (value != null) {
      result
        ..add('client_portal_under_payment_minimum')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.useCreditsPayment;
    if (value != null) {
      result
        ..add('use_credits_payment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientPortalCustomHeader;
    if (value != null) {
      result
        ..add('portal_custom_head')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientPortalCustomCss;
    if (value != null) {
      result
        ..add('portal_custom_css')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientPortalCustomFooter;
    if (value != null) {
      result
        ..add('portal_custom_footer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.clientPortalCustomJs;
    if (value != null) {
      result
        ..add('portal_custom_js')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.hideEmptyColumnsOnPdf;
    if (value != null) {
      result
        ..add('hide_empty_columns_on_pdf')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.entitySendTime;
    if (value != null) {
      result
        ..add('entity_send_time')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.clientPortalTasks;
    if (value != null) {
      result
        ..add('show_all_tasks_client_portal')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pageNumbering;
    if (value != null) {
      result
        ..add('page_numbering')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.pageNumberingAlignment;
    if (value != null) {
      result
        ..add('page_numbering_alignment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.requirePurchaseOrderSignature;
    if (value != null) {
      result
        ..add('require_purchase_order_signature')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.defaultPurchaseOrderTerms;
    if (value != null) {
      result
        ..add('purchase_order_terms')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultPurchaseOrderDesignId;
    if (value != null) {
      result
        ..add('purchase_order_design_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultPurchaseOrderFooter;
    if (value != null) {
      result
        ..add('purchase_order_footer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.purchaseOrderNumberPattern;
    if (value != null) {
      result
        ..add('purchase_order_number_pattern')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.purchaseOrderNumberCounter;
    if (value != null) {
      result
        ..add('purchase_order_number_counter')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.qrIban;
    if (value != null) {
      result
        ..add('qr_iban')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.besrId;
    if (value != null) {
      result
        ..add('besr_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.postmarkSecret;
    if (value != null) {
      result
        ..add('postmark_secret')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mailgunSecret;
    if (value != null) {
      result
        ..add('mailgun_secret')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mailgunDomain;
    if (value != null) {
      result
        ..add('mailgun_domain')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mailgunEndpoint;
    if (value != null) {
      result
        ..add('mailgun_endpoint')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailAlignment;
    if (value != null) {
      result
        ..add('email_alignment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.showEmailFooter;
    if (value != null) {
      result
        ..add('show_email_footer')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.companyLogoSize;
    if (value != null) {
      result
        ..add('company_logo_size')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.showPaidStamp;
    if (value != null) {
      result
        ..add('show_paid_stamp')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.showShippingAddress;
    if (value != null) {
      result
        ..add('show_shipping_address')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.customSendingEmail;
    if (value != null) {
      result
        ..add('custom_sending_email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.acceptPurchaseOrderNumber;
    if (value != null) {
      result
        ..add('accept_client_input_quote_approval')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.clientInitiatedPayments;
    if (value != null) {
      result
        ..add('client_initiated_payments')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.clientInitiatedPaymentsMinimum;
    if (value != null) {
      result
        ..add('client_initiated_payments_minimum')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.shareInvoiceQuoteColumns;
    if (value != null) {
      result
        ..add('sync_invoice_quote_columns')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.allowBillableTaskItems;
    if (value != null) {
      result
        ..add('allow_billable_task_items')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.showTaskItemDescription;
    if (value != null) {
      result
        ..add('show_task_item_description')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.enableEInvoice;
    if (value != null) {
      result
        ..add('enable_e_invoice')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.eInvoiceType;
    if (value != null) {
      result
        ..add('e_invoice_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.defaultExpensePaymentTypeId;
    if (value != null) {
      result
        ..add('default_expense_payment_type_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.classification;
    if (value != null) {
      result
        ..add('classification')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.paymentEmailAllContacts;
    if (value != null) {
      result
        ..add('payment_email_all_contacts')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.showPdfhtmlOnMobile;
    if (value != null) {
      result
        ..add('show_pdfhtml_on_mobile')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.useUnappliedPayment;
    if (value != null) {
      result
        ..add('use_unapplied_payment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SettingsEntity deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingsEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'timezone_id':
          result.timezoneId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'date_format_id':
          result.dateFormatId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'military_time':
          result.enableMilitaryTime = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'language_id':
          result.languageId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'show_currency_code':
          result.showCurrencyCode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'payment_terms':
          result.defaultPaymentTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'valid_until':
          result.defaultValidUntil = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'company_gateway_ids':
          result.companyGatewayIds = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'default_task_rate':
          result.defaultTaskRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'send_reminders':
          result.sendReminders = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'enable_client_portal':
          result.enablePortal = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'enable_client_portal_dashboard':
          result.enablePortalDashboard = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'enable_client_portal_tasks':
          result.enablePortalTasks = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'client_portal_enable_uploads':
          result.enableClientPortalUploads = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'vendor_portal_enable_uploads':
          result.enableVendorPortalUploads = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'email_style':
          result.emailStyle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'reply_to_email':
          result.replyToEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'reply_to_name':
          result.replyToName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_from_name':
          result.emailFromName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'bcc_email':
          result.bccEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'pdf_email_attachment':
          result.pdfEmailAttachment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'ubl_email_attachment':
          result.ublEmailAttachment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'document_email_attachment':
          result.documentEmailAttachment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'email_style_custom':
          result.emailStyleCustom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'custom_message_dashboard':
          result.customMessageDashboard = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'custom_message_unpaid_invoice':
          result.customMessageUnpaidInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'custom_message_paid_invoice':
          result.customMessagePaidInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'custom_message_unapproved_quote':
          result.customMessageUnapprovedQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'auto_archive_invoice':
          result.autoArchiveInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'auto_archive_invoice_cancelled':
          result.autoArchiveInvoiceCancelled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'auto_archive_quote':
          result.autoArchiveQuote = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'auto_email_invoice':
          result.autoEmailInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'auto_convert_quote':
          result.autoConvertQuote = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'inclusive_taxes':
          result.enableInclusiveTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'translations':
          result.translations.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType.nullable(String),
                const FullType(String)
              ]))!);
          break;
        case 'task_number_pattern':
          result.taskNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'task_number_counter':
          result.taskNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'expense_number_pattern':
          result.expenseNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'expense_number_counter':
          result.expenseNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'recurring_expense_number_pattern':
          result.recurringExpenseNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'recurring_expense_number_counter':
          result.recurringExpenseNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'vendor_number_pattern':
          result.vendorNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'vendor_number_counter':
          result.vendorNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'ticket_number_pattern':
          result.ticketNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'ticket_number_counter':
          result.ticketNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'payment_number_pattern':
          result.paymentNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'payment_number_counter':
          result.paymentNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'project_number_pattern':
          result.projectNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'project_number_counter':
          result.projectNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'invoice_number_pattern':
          result.invoiceNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'invoice_number_counter':
          result.invoiceNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'recurring_invoice_number_pattern':
          result.recurringInvoiceNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'recurring_invoice_number_counter':
          result.recurringInvoiceNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'quote_number_pattern':
          result.quoteNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'quote_number_counter':
          result.quoteNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'client_number_pattern':
          result.clientNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'client_number_counter':
          result.clientNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'credit_number_pattern':
          result.creditNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'credit_number_counter':
          result.creditNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'recurring_number_prefix':
          result.recurringNumberPrefix = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'reset_counter_frequency_id':
          result.resetCounterFrequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'reset_counter_date':
          result.resetCounterDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'counter_padding':
          result.counterPadding = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'shared_invoice_quote_counter':
          result.sharedInvoiceQuoteCounter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'shared_invoice_credit_counter':
          result.sharedInvoiceCreditCounter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'invoice_terms':
          result.defaultInvoiceTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'quote_terms':
          result.defaultQuoteTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'quote_footer':
          result.defaultQuoteFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'credit_terms':
          result.defaultCreditTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'credit_footer':
          result.defaultCreditFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'invoice_design_id':
          result.defaultInvoiceDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'quote_design_id':
          result.defaultQuoteDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'credit_design_id':
          result.defaultCreditDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'delivery_note_design_id':
          result.defaultDeliveryNoteDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'statement_design_id':
          result.defaultStatementDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'payment_receipt_design_id':
          result.defaultPaymentReceiptDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'payment_refund_design_id':
          result.defaultPaymentRefundDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'invoice_footer':
          result.defaultInvoiceFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tax_name1':
          result.defaultTaxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tax_rate1':
          result.defaultTaxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'tax_name2':
          result.defaultTaxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tax_rate2':
          result.defaultTaxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'tax_name3':
          result.defaultTaxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tax_rate3':
          result.defaultTaxRate3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'payment_type_id':
          result.defaultPaymentTypeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'pdf_variables':
          result.pdfVariables.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(String)])
              ]))!);
          break;
        case 'email_signature':
          result.emailSignature = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_invoice':
          result.emailSubjectInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_quote':
          result.emailSubjectQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_credit':
          result.emailSubjectCredit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_payment':
          result.emailSubjectPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_payment_partial':
          result.emailSubjectPaymentPartial = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_invoice':
          result.emailBodyInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_quote':
          result.emailBodyQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_credit':
          result.emailBodyCredit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_payment':
          result.emailBodyPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_payment_partial':
          result.emailBodyPaymentPartial = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_reminder1':
          result.emailSubjectReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_reminder2':
          result.emailSubjectReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_reminder3':
          result.emailSubjectReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_reminder1':
          result.emailBodyReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_reminder2':
          result.emailBodyReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_reminder3':
          result.emailBodyReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_custom1':
          result.emailSubjectCustom1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_custom1':
          result.emailBodyCustom1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_custom2':
          result.emailSubjectCustom2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_custom2':
          result.emailBodyCustom2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_custom3':
          result.emailSubjectCustom3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_custom3':
          result.emailBodyCustom3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_statement':
          result.emailSubjectStatement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_statement':
          result.emailBodyStatement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_subject_purchase_order':
          result.emailSubjectPurchaseOrder = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_purchase_order':
          result.emailBodyPurchaseOrder = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'enable_client_portal_password':
          result.enablePortalPassword = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'signature_on_pdf':
          result.signatureOnPdf = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'enable_email_markup':
          result.enableEmailMarkup = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'show_accept_invoice_terms':
          result.showAcceptInvoiceTerms = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'show_accept_quote_terms':
          result.showAcceptQuoteTerms = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'require_invoice_signature':
          result.requireInvoiceSignature = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'require_quote_signature':
          result.requireQuoteSignature = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'company_logo':
          result.companyLogo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'address1':
          result.address1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'address2':
          result.address2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'postal_code':
          result.postalCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'country_id':
          result.countryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'vat_number':
          result.vatNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id_number':
          result.idNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'page_size':
          result.pageSize = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'page_layout':
          result.pageLayout = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'font_size':
          result.fontSize = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'primary_color':
          result.primaryColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'secondary_color':
          result.secondaryColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'primary_font':
          result.primaryFont = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'secondary_font':
          result.secondaryFont = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'hide_paid_to_date':
          result.hidePaidToDate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'embed_documents':
          result.embedDocuments = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'all_pages_header':
          result.allPagesHeader = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'all_pages_footer':
          result.allPagesFooter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'enable_reminder1':
          result.enableReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'enable_reminder2':
          result.enableReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'enable_reminder3':
          result.enableReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'enable_reminder_endless':
          result.enableReminderEndless = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'num_days_reminder1':
          result.numDaysReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'num_days_reminder2':
          result.numDaysReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'num_days_reminder3':
          result.numDaysReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'schedule_reminder1':
          result.scheduleReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'schedule_reminder2':
          result.scheduleReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'schedule_reminder3':
          result.scheduleReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'endless_reminder_frequency_id':
          result.endlessReminderFrequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'late_fee_amount1':
          result.lateFeeAmount1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'late_fee_amount2':
          result.lateFeeAmount2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'late_fee_amount3':
          result.lateFeeAmount3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'late_fee_endless_amount':
          result.lateFeeAmountEndless = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'late_fee_percent1':
          result.lateFeePercent1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'late_fee_percent2':
          result.lateFeePercent2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'late_fee_percent3':
          result.lateFeePercent3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'late_fee_endless_percent':
          result.lateFeePercentEndless = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'email_subject_reminder_endless':
          result.emailSubjectReminderEndless = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_template_reminder_endless':
          result.emailBodyReminderEndless = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'client_online_payment_notification':
          result.clientOnlinePaymentNotification = serializers
              .deserialize(value, specifiedType: const FullType(bool)) as bool?;
          break;
        case 'client_manual_payment_notification':
          result.clientManualPaymentNotification = serializers
              .deserialize(value, specifiedType: const FullType(bool)) as bool?;
          break;
        case 'send_email_on_mark_paid':
          result.clientMarkPaidPaymentNotification = serializers
              .deserialize(value, specifiedType: const FullType(bool)) as bool?;
          break;
        case 'counter_number_applied':
          result.counterNumberApplied = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_sending_method':
          result.emailSendingMethod = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'gmail_sending_user_id':
          result.gmailSendingUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'client_portal_terms':
          result.clientPortalTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'client_portal_privacy_policy':
          result.clientPortalPrivacy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'lock_invoices':
          result.lockInvoices = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'auto_bill':
          result.autoBill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'auto_bill_standard_invoices':
          result.autoBillStandardInvoices = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'client_portal_allow_under_payment':
          result.clientPortalAllowUnderPayment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'client_portal_allow_over_payment':
          result.clientPortalAllowOverPayment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'auto_bill_date':
          result.autoBillDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'client_portal_under_payment_minimum':
          result.clientPortalUnderPaymentMinimum = serializers.deserialize(
              value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'use_credits_payment':
          result.useCreditsPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'portal_custom_head':
          result.clientPortalCustomHeader = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'portal_custom_css':
          result.clientPortalCustomCss = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'portal_custom_footer':
          result.clientPortalCustomFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'portal_custom_js':
          result.clientPortalCustomJs = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'hide_empty_columns_on_pdf':
          result.hideEmptyColumnsOnPdf = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'entity_send_time':
          result.entitySendTime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'show_all_tasks_client_portal':
          result.clientPortalTasks = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'page_numbering':
          result.pageNumbering = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'page_numbering_alignment':
          result.pageNumberingAlignment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'require_purchase_order_signature':
          result.requirePurchaseOrderSignature = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'purchase_order_terms':
          result.defaultPurchaseOrderTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'purchase_order_design_id':
          result.defaultPurchaseOrderDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'purchase_order_footer':
          result.defaultPurchaseOrderFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'purchase_order_number_pattern':
          result.purchaseOrderNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'purchase_order_number_counter':
          result.purchaseOrderNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'qr_iban':
          result.qrIban = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'besr_id':
          result.besrId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'postmark_secret':
          result.postmarkSecret = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mailgun_secret':
          result.mailgunSecret = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mailgun_domain':
          result.mailgunDomain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mailgun_endpoint':
          result.mailgunEndpoint = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_alignment':
          result.emailAlignment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'show_email_footer':
          result.showEmailFooter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'company_logo_size':
          result.companyLogoSize = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'show_paid_stamp':
          result.showPaidStamp = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'show_shipping_address':
          result.showShippingAddress = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'custom_sending_email':
          result.customSendingEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'accept_client_input_quote_approval':
          result.acceptPurchaseOrderNumber = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'client_initiated_payments':
          result.clientInitiatedPayments = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'client_initiated_payments_minimum':
          result.clientInitiatedPaymentsMinimum = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'sync_invoice_quote_columns':
          result.shareInvoiceQuoteColumns = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'allow_billable_task_items':
          result.allowBillableTaskItems = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'show_task_item_description':
          result.showTaskItemDescription = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'enable_e_invoice':
          result.enableEInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'e_invoice_type':
          result.eInvoiceType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'default_expense_payment_type_id':
          result.defaultExpensePaymentTypeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'classification':
          result.classification = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'payment_email_all_contacts':
          result.paymentEmailAllContacts = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'show_pdfhtml_on_mobile':
          result.showPdfhtmlOnMobile = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'use_unapplied_payment':
          result.useUnappliedPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$PdfPreviewRequestSerializer
    implements StructuredSerializer<PdfPreviewRequest> {
  @override
  final Iterable<Type> types = const [PdfPreviewRequest, _$PdfPreviewRequest];
  @override
  final String wireName = 'PdfPreviewRequest';

  @override
  Iterable<Object?> serialize(Serializers serializers, PdfPreviewRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'entity_type',
      serializers.serialize(object.entityType,
          specifiedType: const FullType(String)),
      'settings_type',
      serializers.serialize(object.settingsType,
          specifiedType: const FullType(String)),
      'settings',
      serializers.serialize(object.settings,
          specifiedType: const FullType(SettingsEntity)),
      'group_id',
      serializers.serialize(object.groupId,
          specifiedType: const FullType(String)),
      'client_id',
      serializers.serialize(object.clientId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  PdfPreviewRequest deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PdfPreviewRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'entity_type':
          result.entityType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'settings_type':
          result.settingsType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'settings':
          result.settings.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SettingsEntity))!
              as SettingsEntity);
          break;
        case 'group_id':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'client_id':
          result.clientId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SettingsEntity extends SettingsEntity {
  @override
  final String? timezoneId;
  @override
  final String? dateFormatId;
  @override
  final bool? enableMilitaryTime;
  @override
  final String? languageId;
  @override
  final bool? showCurrencyCode;
  @override
  final String? currencyId;
  @override
  final String? customValue1;
  @override
  final String? customValue2;
  @override
  final String? customValue3;
  @override
  final String? customValue4;
  @override
  final String? defaultPaymentTerms;
  @override
  final String? defaultValidUntil;
  @override
  final String? companyGatewayIds;
  @override
  final double? defaultTaskRate;
  @override
  final bool? sendReminders;
  @override
  final bool? enablePortal;
  @override
  final bool? enablePortalDashboard;
  @override
  final bool? enablePortalTasks;
  @override
  final bool? enableClientPortalUploads;
  @override
  final bool? enableVendorPortalUploads;
  @override
  final String? emailStyle;
  @override
  final String? replyToEmail;
  @override
  final String? replyToName;
  @override
  final String? emailFromName;
  @override
  final String? bccEmail;
  @override
  final bool? pdfEmailAttachment;
  @override
  final bool? ublEmailAttachment;
  @override
  final bool? documentEmailAttachment;
  @override
  final String? emailStyleCustom;
  @override
  final String? customMessageDashboard;
  @override
  final String? customMessageUnpaidInvoice;
  @override
  final String? customMessagePaidInvoice;
  @override
  final String? customMessageUnapprovedQuote;
  @override
  final bool? autoArchiveInvoice;
  @override
  final bool? autoArchiveInvoiceCancelled;
  @override
  final bool? autoArchiveQuote;
  @override
  final bool? autoEmailInvoice;
  @override
  final bool? autoConvertQuote;
  @override
  final bool? enableInclusiveTaxes;
  @override
  final BuiltMap<String?, String>? translations;
  @override
  final String? taskNumberPattern;
  @override
  final int? taskNumberCounter;
  @override
  final String? expenseNumberPattern;
  @override
  final int? expenseNumberCounter;
  @override
  final String? recurringExpenseNumberPattern;
  @override
  final int? recurringExpenseNumberCounter;
  @override
  final String? vendorNumberPattern;
  @override
  final int? vendorNumberCounter;
  @override
  final String? ticketNumberPattern;
  @override
  final int? ticketNumberCounter;
  @override
  final String? paymentNumberPattern;
  @override
  final int? paymentNumberCounter;
  @override
  final String? projectNumberPattern;
  @override
  final int? projectNumberCounter;
  @override
  final String? invoiceNumberPattern;
  @override
  final int? invoiceNumberCounter;
  @override
  final String? recurringInvoiceNumberPattern;
  @override
  final int? recurringInvoiceNumberCounter;
  @override
  final String? quoteNumberPattern;
  @override
  final int? quoteNumberCounter;
  @override
  final String? clientNumberPattern;
  @override
  final int? clientNumberCounter;
  @override
  final String? creditNumberPattern;
  @override
  final int? creditNumberCounter;
  @override
  final String? recurringNumberPrefix;
  @override
  final String? resetCounterFrequencyId;
  @override
  final String? resetCounterDate;
  @override
  final int? counterPadding;
  @override
  final bool? sharedInvoiceQuoteCounter;
  @override
  final bool? sharedInvoiceCreditCounter;
  @override
  final String? defaultInvoiceTerms;
  @override
  final String? defaultQuoteTerms;
  @override
  final String? defaultQuoteFooter;
  @override
  final String? defaultCreditTerms;
  @override
  final String? defaultCreditFooter;
  @override
  final String? defaultInvoiceDesignId;
  @override
  final String? defaultQuoteDesignId;
  @override
  final String? defaultCreditDesignId;
  @override
  final String? defaultDeliveryNoteDesignId;
  @override
  final String? defaultStatementDesignId;
  @override
  final String? defaultPaymentReceiptDesignId;
  @override
  final String? defaultPaymentRefundDesignId;
  @override
  final String? defaultInvoiceFooter;
  @override
  final String? defaultTaxName1;
  @override
  final double? defaultTaxRate1;
  @override
  final String? defaultTaxName2;
  @override
  final double? defaultTaxRate2;
  @override
  final String? defaultTaxName3;
  @override
  final double? defaultTaxRate3;
  @override
  final String? defaultPaymentTypeId;
  @override
  final BuiltMap<String, BuiltList<String>>? pdfVariables;
  @override
  final String? emailSignature;
  @override
  final String? emailSubjectInvoice;
  @override
  final String? emailSubjectQuote;
  @override
  final String? emailSubjectCredit;
  @override
  final String? emailSubjectPayment;
  @override
  final String? emailSubjectPaymentPartial;
  @override
  final String? emailBodyInvoice;
  @override
  final String? emailBodyQuote;
  @override
  final String? emailBodyCredit;
  @override
  final String? emailBodyPayment;
  @override
  final String? emailBodyPaymentPartial;
  @override
  final String? emailSubjectReminder1;
  @override
  final String? emailSubjectReminder2;
  @override
  final String? emailSubjectReminder3;
  @override
  final String? emailBodyReminder1;
  @override
  final String? emailBodyReminder2;
  @override
  final String? emailBodyReminder3;
  @override
  final String? emailSubjectCustom1;
  @override
  final String? emailBodyCustom1;
  @override
  final String? emailSubjectCustom2;
  @override
  final String? emailBodyCustom2;
  @override
  final String? emailSubjectCustom3;
  @override
  final String? emailBodyCustom3;
  @override
  final String? emailSubjectStatement;
  @override
  final String? emailBodyStatement;
  @override
  final String? emailSubjectPurchaseOrder;
  @override
  final String? emailBodyPurchaseOrder;
  @override
  final bool? enablePortalPassword;
  @override
  final bool? signatureOnPdf;
  @override
  final bool? enableEmailMarkup;
  @override
  final bool? showAcceptInvoiceTerms;
  @override
  final bool? showAcceptQuoteTerms;
  @override
  final bool? requireInvoiceSignature;
  @override
  final bool? requireQuoteSignature;
  @override
  final String? name;
  @override
  final String? companyLogo;
  @override
  final String? website;
  @override
  final String? address1;
  @override
  final String? address2;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? postalCode;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? countryId;
  @override
  final String? vatNumber;
  @override
  final String? idNumber;
  @override
  final String? pageSize;
  @override
  final String? pageLayout;
  @override
  final int? fontSize;
  @override
  final String? primaryColor;
  @override
  final String? secondaryColor;
  @override
  final String? primaryFont;
  @override
  final String? secondaryFont;
  @override
  final bool? hidePaidToDate;
  @override
  final bool? embedDocuments;
  @override
  final bool? allPagesHeader;
  @override
  final bool? allPagesFooter;
  @override
  final bool? enableReminder1;
  @override
  final bool? enableReminder2;
  @override
  final bool? enableReminder3;
  @override
  final bool? enableReminderEndless;
  @override
  final int? numDaysReminder1;
  @override
  final int? numDaysReminder2;
  @override
  final int? numDaysReminder3;
  @override
  final String? scheduleReminder1;
  @override
  final String? scheduleReminder2;
  @override
  final String? scheduleReminder3;
  @override
  final String? endlessReminderFrequencyId;
  @override
  final double? lateFeeAmount1;
  @override
  final double? lateFeeAmount2;
  @override
  final double? lateFeeAmount3;
  @override
  final double? lateFeeAmountEndless;
  @override
  final double? lateFeePercent1;
  @override
  final double? lateFeePercent2;
  @override
  final double? lateFeePercent3;
  @override
  final double? lateFeePercentEndless;
  @override
  final String? emailSubjectReminderEndless;
  @override
  final String? emailBodyReminderEndless;
  @override
  final bool? clientOnlinePaymentNotification;
  @override
  final bool? clientManualPaymentNotification;
  @override
  final bool? clientMarkPaidPaymentNotification;
  @override
  final String? counterNumberApplied;
  @override
  final String? emailSendingMethod;
  @override
  final String? gmailSendingUserId;
  @override
  final String? clientPortalTerms;
  @override
  final String? clientPortalPrivacy;
  @override
  final String? lockInvoices;
  @override
  final String? autoBill;
  @override
  final bool? autoBillStandardInvoices;
  @override
  final bool? clientPortalAllowUnderPayment;
  @override
  final bool? clientPortalAllowOverPayment;
  @override
  final String? autoBillDate;
  @override
  final double? clientPortalUnderPaymentMinimum;
  @override
  final String? useCreditsPayment;
  @override
  final String? clientPortalCustomHeader;
  @override
  final String? clientPortalCustomCss;
  @override
  final String? clientPortalCustomFooter;
  @override
  final String? clientPortalCustomJs;
  @override
  final bool? hideEmptyColumnsOnPdf;
  @override
  final int? entitySendTime;
  @override
  final String? clientPortalTasks;
  @override
  final bool? pageNumbering;
  @override
  final String? pageNumberingAlignment;
  @override
  final bool? requirePurchaseOrderSignature;
  @override
  final String? defaultPurchaseOrderTerms;
  @override
  final String? defaultPurchaseOrderDesignId;
  @override
  final String? defaultPurchaseOrderFooter;
  @override
  final String? purchaseOrderNumberPattern;
  @override
  final int? purchaseOrderNumberCounter;
  @override
  final String? qrIban;
  @override
  final String? besrId;
  @override
  final String? postmarkSecret;
  @override
  final String? mailgunSecret;
  @override
  final String? mailgunDomain;
  @override
  final String? mailgunEndpoint;
  @override
  final String? emailAlignment;
  @override
  final bool? showEmailFooter;
  @override
  final String? companyLogoSize;
  @override
  final bool? showPaidStamp;
  @override
  final bool? showShippingAddress;
  @override
  final String? customSendingEmail;
  @override
  final bool? acceptPurchaseOrderNumber;
  @override
  final bool? clientInitiatedPayments;
  @override
  final double? clientInitiatedPaymentsMinimum;
  @override
  final bool? shareInvoiceQuoteColumns;
  @override
  final bool? allowBillableTaskItems;
  @override
  final bool? showTaskItemDescription;
  @override
  final bool? enableEInvoice;
  @override
  final String? eInvoiceType;
  @override
  final String? defaultExpensePaymentTypeId;
  @override
  final String? classification;
  @override
  final bool? paymentEmailAllContacts;
  @override
  final bool? showPdfhtmlOnMobile;
  @override
  final String? useUnappliedPayment;

  factory _$SettingsEntity([void Function(SettingsEntityBuilder)? updates]) =>
      (new SettingsEntityBuilder()..update(updates))._build();

  _$SettingsEntity._(
      {this.timezoneId,
      this.dateFormatId,
      this.enableMilitaryTime,
      this.languageId,
      this.showCurrencyCode,
      this.currencyId,
      this.customValue1,
      this.customValue2,
      this.customValue3,
      this.customValue4,
      this.defaultPaymentTerms,
      this.defaultValidUntil,
      this.companyGatewayIds,
      this.defaultTaskRate,
      this.sendReminders,
      this.enablePortal,
      this.enablePortalDashboard,
      this.enablePortalTasks,
      this.enableClientPortalUploads,
      this.enableVendorPortalUploads,
      this.emailStyle,
      this.replyToEmail,
      this.replyToName,
      this.emailFromName,
      this.bccEmail,
      this.pdfEmailAttachment,
      this.ublEmailAttachment,
      this.documentEmailAttachment,
      this.emailStyleCustom,
      this.customMessageDashboard,
      this.customMessageUnpaidInvoice,
      this.customMessagePaidInvoice,
      this.customMessageUnapprovedQuote,
      this.autoArchiveInvoice,
      this.autoArchiveInvoiceCancelled,
      this.autoArchiveQuote,
      this.autoEmailInvoice,
      this.autoConvertQuote,
      this.enableInclusiveTaxes,
      this.translations,
      this.taskNumberPattern,
      this.taskNumberCounter,
      this.expenseNumberPattern,
      this.expenseNumberCounter,
      this.recurringExpenseNumberPattern,
      this.recurringExpenseNumberCounter,
      this.vendorNumberPattern,
      this.vendorNumberCounter,
      this.ticketNumberPattern,
      this.ticketNumberCounter,
      this.paymentNumberPattern,
      this.paymentNumberCounter,
      this.projectNumberPattern,
      this.projectNumberCounter,
      this.invoiceNumberPattern,
      this.invoiceNumberCounter,
      this.recurringInvoiceNumberPattern,
      this.recurringInvoiceNumberCounter,
      this.quoteNumberPattern,
      this.quoteNumberCounter,
      this.clientNumberPattern,
      this.clientNumberCounter,
      this.creditNumberPattern,
      this.creditNumberCounter,
      this.recurringNumberPrefix,
      this.resetCounterFrequencyId,
      this.resetCounterDate,
      this.counterPadding,
      this.sharedInvoiceQuoteCounter,
      this.sharedInvoiceCreditCounter,
      this.defaultInvoiceTerms,
      this.defaultQuoteTerms,
      this.defaultQuoteFooter,
      this.defaultCreditTerms,
      this.defaultCreditFooter,
      this.defaultInvoiceDesignId,
      this.defaultQuoteDesignId,
      this.defaultCreditDesignId,
      this.defaultDeliveryNoteDesignId,
      this.defaultStatementDesignId,
      this.defaultPaymentReceiptDesignId,
      this.defaultPaymentRefundDesignId,
      this.defaultInvoiceFooter,
      this.defaultTaxName1,
      this.defaultTaxRate1,
      this.defaultTaxName2,
      this.defaultTaxRate2,
      this.defaultTaxName3,
      this.defaultTaxRate3,
      this.defaultPaymentTypeId,
      this.pdfVariables,
      this.emailSignature,
      this.emailSubjectInvoice,
      this.emailSubjectQuote,
      this.emailSubjectCredit,
      this.emailSubjectPayment,
      this.emailSubjectPaymentPartial,
      this.emailBodyInvoice,
      this.emailBodyQuote,
      this.emailBodyCredit,
      this.emailBodyPayment,
      this.emailBodyPaymentPartial,
      this.emailSubjectReminder1,
      this.emailSubjectReminder2,
      this.emailSubjectReminder3,
      this.emailBodyReminder1,
      this.emailBodyReminder2,
      this.emailBodyReminder3,
      this.emailSubjectCustom1,
      this.emailBodyCustom1,
      this.emailSubjectCustom2,
      this.emailBodyCustom2,
      this.emailSubjectCustom3,
      this.emailBodyCustom3,
      this.emailSubjectStatement,
      this.emailBodyStatement,
      this.emailSubjectPurchaseOrder,
      this.emailBodyPurchaseOrder,
      this.enablePortalPassword,
      this.signatureOnPdf,
      this.enableEmailMarkup,
      this.showAcceptInvoiceTerms,
      this.showAcceptQuoteTerms,
      this.requireInvoiceSignature,
      this.requireQuoteSignature,
      this.name,
      this.companyLogo,
      this.website,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postalCode,
      this.phone,
      this.email,
      this.countryId,
      this.vatNumber,
      this.idNumber,
      this.pageSize,
      this.pageLayout,
      this.fontSize,
      this.primaryColor,
      this.secondaryColor,
      this.primaryFont,
      this.secondaryFont,
      this.hidePaidToDate,
      this.embedDocuments,
      this.allPagesHeader,
      this.allPagesFooter,
      this.enableReminder1,
      this.enableReminder2,
      this.enableReminder3,
      this.enableReminderEndless,
      this.numDaysReminder1,
      this.numDaysReminder2,
      this.numDaysReminder3,
      this.scheduleReminder1,
      this.scheduleReminder2,
      this.scheduleReminder3,
      this.endlessReminderFrequencyId,
      this.lateFeeAmount1,
      this.lateFeeAmount2,
      this.lateFeeAmount3,
      this.lateFeeAmountEndless,
      this.lateFeePercent1,
      this.lateFeePercent2,
      this.lateFeePercent3,
      this.lateFeePercentEndless,
      this.emailSubjectReminderEndless,
      this.emailBodyReminderEndless,
      this.clientOnlinePaymentNotification,
      this.clientManualPaymentNotification,
      this.clientMarkPaidPaymentNotification,
      this.counterNumberApplied,
      this.emailSendingMethod,
      this.gmailSendingUserId,
      this.clientPortalTerms,
      this.clientPortalPrivacy,
      this.lockInvoices,
      this.autoBill,
      this.autoBillStandardInvoices,
      this.clientPortalAllowUnderPayment,
      this.clientPortalAllowOverPayment,
      this.autoBillDate,
      this.clientPortalUnderPaymentMinimum,
      this.useCreditsPayment,
      this.clientPortalCustomHeader,
      this.clientPortalCustomCss,
      this.clientPortalCustomFooter,
      this.clientPortalCustomJs,
      this.hideEmptyColumnsOnPdf,
      this.entitySendTime,
      this.clientPortalTasks,
      this.pageNumbering,
      this.pageNumberingAlignment,
      this.requirePurchaseOrderSignature,
      this.defaultPurchaseOrderTerms,
      this.defaultPurchaseOrderDesignId,
      this.defaultPurchaseOrderFooter,
      this.purchaseOrderNumberPattern,
      this.purchaseOrderNumberCounter,
      this.qrIban,
      this.besrId,
      this.postmarkSecret,
      this.mailgunSecret,
      this.mailgunDomain,
      this.mailgunEndpoint,
      this.emailAlignment,
      this.showEmailFooter,
      this.companyLogoSize,
      this.showPaidStamp,
      this.showShippingAddress,
      this.customSendingEmail,
      this.acceptPurchaseOrderNumber,
      this.clientInitiatedPayments,
      this.clientInitiatedPaymentsMinimum,
      this.shareInvoiceQuoteColumns,
      this.allowBillableTaskItems,
      this.showTaskItemDescription,
      this.enableEInvoice,
      this.eInvoiceType,
      this.defaultExpensePaymentTypeId,
      this.classification,
      this.paymentEmailAllContacts,
      this.showPdfhtmlOnMobile,
      this.useUnappliedPayment})
      : super._();

  @override
  SettingsEntity rebuild(void Function(SettingsEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsEntityBuilder toBuilder() =>
      new SettingsEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsEntity &&
        timezoneId == other.timezoneId &&
        dateFormatId == other.dateFormatId &&
        enableMilitaryTime == other.enableMilitaryTime &&
        languageId == other.languageId &&
        showCurrencyCode == other.showCurrencyCode &&
        currencyId == other.currencyId &&
        customValue1 == other.customValue1 &&
        customValue2 == other.customValue2 &&
        customValue3 == other.customValue3 &&
        customValue4 == other.customValue4 &&
        defaultPaymentTerms == other.defaultPaymentTerms &&
        defaultValidUntil == other.defaultValidUntil &&
        companyGatewayIds == other.companyGatewayIds &&
        defaultTaskRate == other.defaultTaskRate &&
        sendReminders == other.sendReminders &&
        enablePortal == other.enablePortal &&
        enablePortalDashboard == other.enablePortalDashboard &&
        enablePortalTasks == other.enablePortalTasks &&
        enableClientPortalUploads == other.enableClientPortalUploads &&
        enableVendorPortalUploads == other.enableVendorPortalUploads &&
        emailStyle == other.emailStyle &&
        replyToEmail == other.replyToEmail &&
        replyToName == other.replyToName &&
        emailFromName == other.emailFromName &&
        bccEmail == other.bccEmail &&
        pdfEmailAttachment == other.pdfEmailAttachment &&
        ublEmailAttachment == other.ublEmailAttachment &&
        documentEmailAttachment == other.documentEmailAttachment &&
        emailStyleCustom == other.emailStyleCustom &&
        customMessageDashboard == other.customMessageDashboard &&
        customMessageUnpaidInvoice == other.customMessageUnpaidInvoice &&
        customMessagePaidInvoice == other.customMessagePaidInvoice &&
        customMessageUnapprovedQuote == other.customMessageUnapprovedQuote &&
        autoArchiveInvoice == other.autoArchiveInvoice &&
        autoArchiveInvoiceCancelled == other.autoArchiveInvoiceCancelled &&
        autoArchiveQuote == other.autoArchiveQuote &&
        autoEmailInvoice == other.autoEmailInvoice &&
        autoConvertQuote == other.autoConvertQuote &&
        enableInclusiveTaxes == other.enableInclusiveTaxes &&
        translations == other.translations &&
        taskNumberPattern == other.taskNumberPattern &&
        taskNumberCounter == other.taskNumberCounter &&
        expenseNumberPattern == other.expenseNumberPattern &&
        expenseNumberCounter == other.expenseNumberCounter &&
        recurringExpenseNumberPattern == other.recurringExpenseNumberPattern &&
        recurringExpenseNumberCounter == other.recurringExpenseNumberCounter &&
        vendorNumberPattern == other.vendorNumberPattern &&
        vendorNumberCounter == other.vendorNumberCounter &&
        ticketNumberPattern == other.ticketNumberPattern &&
        ticketNumberCounter == other.ticketNumberCounter &&
        paymentNumberPattern == other.paymentNumberPattern &&
        paymentNumberCounter == other.paymentNumberCounter &&
        projectNumberPattern == other.projectNumberPattern &&
        projectNumberCounter == other.projectNumberCounter &&
        invoiceNumberPattern == other.invoiceNumberPattern &&
        invoiceNumberCounter == other.invoiceNumberCounter &&
        recurringInvoiceNumberPattern == other.recurringInvoiceNumberPattern &&
        recurringInvoiceNumberCounter == other.recurringInvoiceNumberCounter &&
        quoteNumberPattern == other.quoteNumberPattern &&
        quoteNumberCounter == other.quoteNumberCounter &&
        clientNumberPattern == other.clientNumberPattern &&
        clientNumberCounter == other.clientNumberCounter &&
        creditNumberPattern == other.creditNumberPattern &&
        creditNumberCounter == other.creditNumberCounter &&
        recurringNumberPrefix == other.recurringNumberPrefix &&
        resetCounterFrequencyId == other.resetCounterFrequencyId &&
        resetCounterDate == other.resetCounterDate &&
        counterPadding == other.counterPadding &&
        sharedInvoiceQuoteCounter == other.sharedInvoiceQuoteCounter &&
        sharedInvoiceCreditCounter == other.sharedInvoiceCreditCounter &&
        defaultInvoiceTerms == other.defaultInvoiceTerms &&
        defaultQuoteTerms == other.defaultQuoteTerms &&
        defaultQuoteFooter == other.defaultQuoteFooter &&
        defaultCreditTerms == other.defaultCreditTerms &&
        defaultCreditFooter == other.defaultCreditFooter &&
        defaultInvoiceDesignId == other.defaultInvoiceDesignId &&
        defaultQuoteDesignId == other.defaultQuoteDesignId &&
        defaultCreditDesignId == other.defaultCreditDesignId &&
        defaultDeliveryNoteDesignId == other.defaultDeliveryNoteDesignId &&
        defaultStatementDesignId == other.defaultStatementDesignId &&
        defaultPaymentReceiptDesignId == other.defaultPaymentReceiptDesignId &&
        defaultPaymentRefundDesignId == other.defaultPaymentRefundDesignId &&
        defaultInvoiceFooter == other.defaultInvoiceFooter &&
        defaultTaxName1 == other.defaultTaxName1 &&
        defaultTaxRate1 == other.defaultTaxRate1 &&
        defaultTaxName2 == other.defaultTaxName2 &&
        defaultTaxRate2 == other.defaultTaxRate2 &&
        defaultTaxName3 == other.defaultTaxName3 &&
        defaultTaxRate3 == other.defaultTaxRate3 &&
        defaultPaymentTypeId == other.defaultPaymentTypeId &&
        pdfVariables == other.pdfVariables &&
        emailSignature == other.emailSignature &&
        emailSubjectInvoice == other.emailSubjectInvoice &&
        emailSubjectQuote == other.emailSubjectQuote &&
        emailSubjectCredit == other.emailSubjectCredit &&
        emailSubjectPayment == other.emailSubjectPayment &&
        emailSubjectPaymentPartial == other.emailSubjectPaymentPartial &&
        emailBodyInvoice == other.emailBodyInvoice &&
        emailBodyQuote == other.emailBodyQuote &&
        emailBodyCredit == other.emailBodyCredit &&
        emailBodyPayment == other.emailBodyPayment &&
        emailBodyPaymentPartial == other.emailBodyPaymentPartial &&
        emailSubjectReminder1 == other.emailSubjectReminder1 &&
        emailSubjectReminder2 == other.emailSubjectReminder2 &&
        emailSubjectReminder3 == other.emailSubjectReminder3 &&
        emailBodyReminder1 == other.emailBodyReminder1 &&
        emailBodyReminder2 == other.emailBodyReminder2 &&
        emailBodyReminder3 == other.emailBodyReminder3 &&
        emailSubjectCustom1 == other.emailSubjectCustom1 &&
        emailBodyCustom1 == other.emailBodyCustom1 &&
        emailSubjectCustom2 == other.emailSubjectCustom2 &&
        emailBodyCustom2 == other.emailBodyCustom2 &&
        emailSubjectCustom3 == other.emailSubjectCustom3 &&
        emailBodyCustom3 == other.emailBodyCustom3 &&
        emailSubjectStatement == other.emailSubjectStatement &&
        emailBodyStatement == other.emailBodyStatement &&
        emailSubjectPurchaseOrder == other.emailSubjectPurchaseOrder &&
        emailBodyPurchaseOrder == other.emailBodyPurchaseOrder &&
        enablePortalPassword == other.enablePortalPassword &&
        signatureOnPdf == other.signatureOnPdf &&
        enableEmailMarkup == other.enableEmailMarkup &&
        showAcceptInvoiceTerms == other.showAcceptInvoiceTerms &&
        showAcceptQuoteTerms == other.showAcceptQuoteTerms &&
        requireInvoiceSignature == other.requireInvoiceSignature &&
        requireQuoteSignature == other.requireQuoteSignature &&
        name == other.name &&
        companyLogo == other.companyLogo &&
        website == other.website &&
        address1 == other.address1 &&
        address2 == other.address2 &&
        city == other.city &&
        state == other.state &&
        postalCode == other.postalCode &&
        phone == other.phone &&
        email == other.email &&
        countryId == other.countryId &&
        vatNumber == other.vatNumber &&
        idNumber == other.idNumber &&
        pageSize == other.pageSize &&
        pageLayout == other.pageLayout &&
        fontSize == other.fontSize &&
        primaryColor == other.primaryColor &&
        secondaryColor == other.secondaryColor &&
        primaryFont == other.primaryFont &&
        secondaryFont == other.secondaryFont &&
        hidePaidToDate == other.hidePaidToDate &&
        embedDocuments == other.embedDocuments &&
        allPagesHeader == other.allPagesHeader &&
        allPagesFooter == other.allPagesFooter &&
        enableReminder1 == other.enableReminder1 &&
        enableReminder2 == other.enableReminder2 &&
        enableReminder3 == other.enableReminder3 &&
        enableReminderEndless == other.enableReminderEndless &&
        numDaysReminder1 == other.numDaysReminder1 &&
        numDaysReminder2 == other.numDaysReminder2 &&
        numDaysReminder3 == other.numDaysReminder3 &&
        scheduleReminder1 == other.scheduleReminder1 &&
        scheduleReminder2 == other.scheduleReminder2 &&
        scheduleReminder3 == other.scheduleReminder3 &&
        endlessReminderFrequencyId == other.endlessReminderFrequencyId &&
        lateFeeAmount1 == other.lateFeeAmount1 &&
        lateFeeAmount2 == other.lateFeeAmount2 &&
        lateFeeAmount3 == other.lateFeeAmount3 &&
        lateFeeAmountEndless == other.lateFeeAmountEndless &&
        lateFeePercent1 == other.lateFeePercent1 &&
        lateFeePercent2 == other.lateFeePercent2 &&
        lateFeePercent3 == other.lateFeePercent3 &&
        lateFeePercentEndless == other.lateFeePercentEndless &&
        emailSubjectReminderEndless == other.emailSubjectReminderEndless &&
        emailBodyReminderEndless == other.emailBodyReminderEndless &&
        clientOnlinePaymentNotification ==
            other.clientOnlinePaymentNotification &&
        clientManualPaymentNotification ==
            other.clientManualPaymentNotification &&
        clientMarkPaidPaymentNotification ==
            other.clientMarkPaidPaymentNotification &&
        counterNumberApplied == other.counterNumberApplied &&
        emailSendingMethod == other.emailSendingMethod &&
        gmailSendingUserId == other.gmailSendingUserId &&
        clientPortalTerms == other.clientPortalTerms &&
        clientPortalPrivacy == other.clientPortalPrivacy &&
        lockInvoices == other.lockInvoices &&
        autoBill == other.autoBill &&
        autoBillStandardInvoices == other.autoBillStandardInvoices &&
        clientPortalAllowUnderPayment == other.clientPortalAllowUnderPayment &&
        clientPortalAllowOverPayment == other.clientPortalAllowOverPayment &&
        autoBillDate == other.autoBillDate &&
        clientPortalUnderPaymentMinimum ==
            other.clientPortalUnderPaymentMinimum &&
        useCreditsPayment == other.useCreditsPayment &&
        clientPortalCustomHeader == other.clientPortalCustomHeader &&
        clientPortalCustomCss == other.clientPortalCustomCss &&
        clientPortalCustomFooter == other.clientPortalCustomFooter &&
        clientPortalCustomJs == other.clientPortalCustomJs &&
        hideEmptyColumnsOnPdf == other.hideEmptyColumnsOnPdf &&
        entitySendTime == other.entitySendTime &&
        clientPortalTasks == other.clientPortalTasks &&
        pageNumbering == other.pageNumbering &&
        pageNumberingAlignment == other.pageNumberingAlignment &&
        requirePurchaseOrderSignature == other.requirePurchaseOrderSignature &&
        defaultPurchaseOrderTerms == other.defaultPurchaseOrderTerms &&
        defaultPurchaseOrderDesignId == other.defaultPurchaseOrderDesignId &&
        defaultPurchaseOrderFooter == other.defaultPurchaseOrderFooter &&
        purchaseOrderNumberPattern == other.purchaseOrderNumberPattern &&
        purchaseOrderNumberCounter == other.purchaseOrderNumberCounter &&
        qrIban == other.qrIban &&
        besrId == other.besrId &&
        postmarkSecret == other.postmarkSecret &&
        mailgunSecret == other.mailgunSecret &&
        mailgunDomain == other.mailgunDomain &&
        mailgunEndpoint == other.mailgunEndpoint &&
        emailAlignment == other.emailAlignment &&
        showEmailFooter == other.showEmailFooter &&
        companyLogoSize == other.companyLogoSize &&
        showPaidStamp == other.showPaidStamp &&
        showShippingAddress == other.showShippingAddress &&
        customSendingEmail == other.customSendingEmail &&
        acceptPurchaseOrderNumber == other.acceptPurchaseOrderNumber &&
        clientInitiatedPayments == other.clientInitiatedPayments &&
        clientInitiatedPaymentsMinimum ==
            other.clientInitiatedPaymentsMinimum &&
        shareInvoiceQuoteColumns == other.shareInvoiceQuoteColumns &&
        allowBillableTaskItems == other.allowBillableTaskItems &&
        showTaskItemDescription == other.showTaskItemDescription &&
        enableEInvoice == other.enableEInvoice &&
        eInvoiceType == other.eInvoiceType &&
        defaultExpensePaymentTypeId == other.defaultExpensePaymentTypeId &&
        classification == other.classification &&
        paymentEmailAllContacts == other.paymentEmailAllContacts &&
        showPdfhtmlOnMobile == other.showPdfhtmlOnMobile &&
        useUnappliedPayment == other.useUnappliedPayment;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, timezoneId.hashCode);
    _$hash = $jc(_$hash, dateFormatId.hashCode);
    _$hash = $jc(_$hash, enableMilitaryTime.hashCode);
    _$hash = $jc(_$hash, languageId.hashCode);
    _$hash = $jc(_$hash, showCurrencyCode.hashCode);
    _$hash = $jc(_$hash, currencyId.hashCode);
    _$hash = $jc(_$hash, customValue1.hashCode);
    _$hash = $jc(_$hash, customValue2.hashCode);
    _$hash = $jc(_$hash, customValue3.hashCode);
    _$hash = $jc(_$hash, customValue4.hashCode);
    _$hash = $jc(_$hash, defaultPaymentTerms.hashCode);
    _$hash = $jc(_$hash, defaultValidUntil.hashCode);
    _$hash = $jc(_$hash, companyGatewayIds.hashCode);
    _$hash = $jc(_$hash, defaultTaskRate.hashCode);
    _$hash = $jc(_$hash, sendReminders.hashCode);
    _$hash = $jc(_$hash, enablePortal.hashCode);
    _$hash = $jc(_$hash, enablePortalDashboard.hashCode);
    _$hash = $jc(_$hash, enablePortalTasks.hashCode);
    _$hash = $jc(_$hash, enableClientPortalUploads.hashCode);
    _$hash = $jc(_$hash, enableVendorPortalUploads.hashCode);
    _$hash = $jc(_$hash, emailStyle.hashCode);
    _$hash = $jc(_$hash, replyToEmail.hashCode);
    _$hash = $jc(_$hash, replyToName.hashCode);
    _$hash = $jc(_$hash, emailFromName.hashCode);
    _$hash = $jc(_$hash, bccEmail.hashCode);
    _$hash = $jc(_$hash, pdfEmailAttachment.hashCode);
    _$hash = $jc(_$hash, ublEmailAttachment.hashCode);
    _$hash = $jc(_$hash, documentEmailAttachment.hashCode);
    _$hash = $jc(_$hash, emailStyleCustom.hashCode);
    _$hash = $jc(_$hash, customMessageDashboard.hashCode);
    _$hash = $jc(_$hash, customMessageUnpaidInvoice.hashCode);
    _$hash = $jc(_$hash, customMessagePaidInvoice.hashCode);
    _$hash = $jc(_$hash, customMessageUnapprovedQuote.hashCode);
    _$hash = $jc(_$hash, autoArchiveInvoice.hashCode);
    _$hash = $jc(_$hash, autoArchiveInvoiceCancelled.hashCode);
    _$hash = $jc(_$hash, autoArchiveQuote.hashCode);
    _$hash = $jc(_$hash, autoEmailInvoice.hashCode);
    _$hash = $jc(_$hash, autoConvertQuote.hashCode);
    _$hash = $jc(_$hash, enableInclusiveTaxes.hashCode);
    _$hash = $jc(_$hash, translations.hashCode);
    _$hash = $jc(_$hash, taskNumberPattern.hashCode);
    _$hash = $jc(_$hash, taskNumberCounter.hashCode);
    _$hash = $jc(_$hash, expenseNumberPattern.hashCode);
    _$hash = $jc(_$hash, expenseNumberCounter.hashCode);
    _$hash = $jc(_$hash, recurringExpenseNumberPattern.hashCode);
    _$hash = $jc(_$hash, recurringExpenseNumberCounter.hashCode);
    _$hash = $jc(_$hash, vendorNumberPattern.hashCode);
    _$hash = $jc(_$hash, vendorNumberCounter.hashCode);
    _$hash = $jc(_$hash, ticketNumberPattern.hashCode);
    _$hash = $jc(_$hash, ticketNumberCounter.hashCode);
    _$hash = $jc(_$hash, paymentNumberPattern.hashCode);
    _$hash = $jc(_$hash, paymentNumberCounter.hashCode);
    _$hash = $jc(_$hash, projectNumberPattern.hashCode);
    _$hash = $jc(_$hash, projectNumberCounter.hashCode);
    _$hash = $jc(_$hash, invoiceNumberPattern.hashCode);
    _$hash = $jc(_$hash, invoiceNumberCounter.hashCode);
    _$hash = $jc(_$hash, recurringInvoiceNumberPattern.hashCode);
    _$hash = $jc(_$hash, recurringInvoiceNumberCounter.hashCode);
    _$hash = $jc(_$hash, quoteNumberPattern.hashCode);
    _$hash = $jc(_$hash, quoteNumberCounter.hashCode);
    _$hash = $jc(_$hash, clientNumberPattern.hashCode);
    _$hash = $jc(_$hash, clientNumberCounter.hashCode);
    _$hash = $jc(_$hash, creditNumberPattern.hashCode);
    _$hash = $jc(_$hash, creditNumberCounter.hashCode);
    _$hash = $jc(_$hash, recurringNumberPrefix.hashCode);
    _$hash = $jc(_$hash, resetCounterFrequencyId.hashCode);
    _$hash = $jc(_$hash, resetCounterDate.hashCode);
    _$hash = $jc(_$hash, counterPadding.hashCode);
    _$hash = $jc(_$hash, sharedInvoiceQuoteCounter.hashCode);
    _$hash = $jc(_$hash, sharedInvoiceCreditCounter.hashCode);
    _$hash = $jc(_$hash, defaultInvoiceTerms.hashCode);
    _$hash = $jc(_$hash, defaultQuoteTerms.hashCode);
    _$hash = $jc(_$hash, defaultQuoteFooter.hashCode);
    _$hash = $jc(_$hash, defaultCreditTerms.hashCode);
    _$hash = $jc(_$hash, defaultCreditFooter.hashCode);
    _$hash = $jc(_$hash, defaultInvoiceDesignId.hashCode);
    _$hash = $jc(_$hash, defaultQuoteDesignId.hashCode);
    _$hash = $jc(_$hash, defaultCreditDesignId.hashCode);
    _$hash = $jc(_$hash, defaultDeliveryNoteDesignId.hashCode);
    _$hash = $jc(_$hash, defaultStatementDesignId.hashCode);
    _$hash = $jc(_$hash, defaultPaymentReceiptDesignId.hashCode);
    _$hash = $jc(_$hash, defaultPaymentRefundDesignId.hashCode);
    _$hash = $jc(_$hash, defaultInvoiceFooter.hashCode);
    _$hash = $jc(_$hash, defaultTaxName1.hashCode);
    _$hash = $jc(_$hash, defaultTaxRate1.hashCode);
    _$hash = $jc(_$hash, defaultTaxName2.hashCode);
    _$hash = $jc(_$hash, defaultTaxRate2.hashCode);
    _$hash = $jc(_$hash, defaultTaxName3.hashCode);
    _$hash = $jc(_$hash, defaultTaxRate3.hashCode);
    _$hash = $jc(_$hash, defaultPaymentTypeId.hashCode);
    _$hash = $jc(_$hash, pdfVariables.hashCode);
    _$hash = $jc(_$hash, emailSignature.hashCode);
    _$hash = $jc(_$hash, emailSubjectInvoice.hashCode);
    _$hash = $jc(_$hash, emailSubjectQuote.hashCode);
    _$hash = $jc(_$hash, emailSubjectCredit.hashCode);
    _$hash = $jc(_$hash, emailSubjectPayment.hashCode);
    _$hash = $jc(_$hash, emailSubjectPaymentPartial.hashCode);
    _$hash = $jc(_$hash, emailBodyInvoice.hashCode);
    _$hash = $jc(_$hash, emailBodyQuote.hashCode);
    _$hash = $jc(_$hash, emailBodyCredit.hashCode);
    _$hash = $jc(_$hash, emailBodyPayment.hashCode);
    _$hash = $jc(_$hash, emailBodyPaymentPartial.hashCode);
    _$hash = $jc(_$hash, emailSubjectReminder1.hashCode);
    _$hash = $jc(_$hash, emailSubjectReminder2.hashCode);
    _$hash = $jc(_$hash, emailSubjectReminder3.hashCode);
    _$hash = $jc(_$hash, emailBodyReminder1.hashCode);
    _$hash = $jc(_$hash, emailBodyReminder2.hashCode);
    _$hash = $jc(_$hash, emailBodyReminder3.hashCode);
    _$hash = $jc(_$hash, emailSubjectCustom1.hashCode);
    _$hash = $jc(_$hash, emailBodyCustom1.hashCode);
    _$hash = $jc(_$hash, emailSubjectCustom2.hashCode);
    _$hash = $jc(_$hash, emailBodyCustom2.hashCode);
    _$hash = $jc(_$hash, emailSubjectCustom3.hashCode);
    _$hash = $jc(_$hash, emailBodyCustom3.hashCode);
    _$hash = $jc(_$hash, emailSubjectStatement.hashCode);
    _$hash = $jc(_$hash, emailBodyStatement.hashCode);
    _$hash = $jc(_$hash, emailSubjectPurchaseOrder.hashCode);
    _$hash = $jc(_$hash, emailBodyPurchaseOrder.hashCode);
    _$hash = $jc(_$hash, enablePortalPassword.hashCode);
    _$hash = $jc(_$hash, signatureOnPdf.hashCode);
    _$hash = $jc(_$hash, enableEmailMarkup.hashCode);
    _$hash = $jc(_$hash, showAcceptInvoiceTerms.hashCode);
    _$hash = $jc(_$hash, showAcceptQuoteTerms.hashCode);
    _$hash = $jc(_$hash, requireInvoiceSignature.hashCode);
    _$hash = $jc(_$hash, requireQuoteSignature.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, companyLogo.hashCode);
    _$hash = $jc(_$hash, website.hashCode);
    _$hash = $jc(_$hash, address1.hashCode);
    _$hash = $jc(_$hash, address2.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, postalCode.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, countryId.hashCode);
    _$hash = $jc(_$hash, vatNumber.hashCode);
    _$hash = $jc(_$hash, idNumber.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, pageLayout.hashCode);
    _$hash = $jc(_$hash, fontSize.hashCode);
    _$hash = $jc(_$hash, primaryColor.hashCode);
    _$hash = $jc(_$hash, secondaryColor.hashCode);
    _$hash = $jc(_$hash, primaryFont.hashCode);
    _$hash = $jc(_$hash, secondaryFont.hashCode);
    _$hash = $jc(_$hash, hidePaidToDate.hashCode);
    _$hash = $jc(_$hash, embedDocuments.hashCode);
    _$hash = $jc(_$hash, allPagesHeader.hashCode);
    _$hash = $jc(_$hash, allPagesFooter.hashCode);
    _$hash = $jc(_$hash, enableReminder1.hashCode);
    _$hash = $jc(_$hash, enableReminder2.hashCode);
    _$hash = $jc(_$hash, enableReminder3.hashCode);
    _$hash = $jc(_$hash, enableReminderEndless.hashCode);
    _$hash = $jc(_$hash, numDaysReminder1.hashCode);
    _$hash = $jc(_$hash, numDaysReminder2.hashCode);
    _$hash = $jc(_$hash, numDaysReminder3.hashCode);
    _$hash = $jc(_$hash, scheduleReminder1.hashCode);
    _$hash = $jc(_$hash, scheduleReminder2.hashCode);
    _$hash = $jc(_$hash, scheduleReminder3.hashCode);
    _$hash = $jc(_$hash, endlessReminderFrequencyId.hashCode);
    _$hash = $jc(_$hash, lateFeeAmount1.hashCode);
    _$hash = $jc(_$hash, lateFeeAmount2.hashCode);
    _$hash = $jc(_$hash, lateFeeAmount3.hashCode);
    _$hash = $jc(_$hash, lateFeeAmountEndless.hashCode);
    _$hash = $jc(_$hash, lateFeePercent1.hashCode);
    _$hash = $jc(_$hash, lateFeePercent2.hashCode);
    _$hash = $jc(_$hash, lateFeePercent3.hashCode);
    _$hash = $jc(_$hash, lateFeePercentEndless.hashCode);
    _$hash = $jc(_$hash, emailSubjectReminderEndless.hashCode);
    _$hash = $jc(_$hash, emailBodyReminderEndless.hashCode);
    _$hash = $jc(_$hash, clientOnlinePaymentNotification.hashCode);
    _$hash = $jc(_$hash, clientManualPaymentNotification.hashCode);
    _$hash = $jc(_$hash, clientMarkPaidPaymentNotification.hashCode);
    _$hash = $jc(_$hash, counterNumberApplied.hashCode);
    _$hash = $jc(_$hash, emailSendingMethod.hashCode);
    _$hash = $jc(_$hash, gmailSendingUserId.hashCode);
    _$hash = $jc(_$hash, clientPortalTerms.hashCode);
    _$hash = $jc(_$hash, clientPortalPrivacy.hashCode);
    _$hash = $jc(_$hash, lockInvoices.hashCode);
    _$hash = $jc(_$hash, autoBill.hashCode);
    _$hash = $jc(_$hash, autoBillStandardInvoices.hashCode);
    _$hash = $jc(_$hash, clientPortalAllowUnderPayment.hashCode);
    _$hash = $jc(_$hash, clientPortalAllowOverPayment.hashCode);
    _$hash = $jc(_$hash, autoBillDate.hashCode);
    _$hash = $jc(_$hash, clientPortalUnderPaymentMinimum.hashCode);
    _$hash = $jc(_$hash, useCreditsPayment.hashCode);
    _$hash = $jc(_$hash, clientPortalCustomHeader.hashCode);
    _$hash = $jc(_$hash, clientPortalCustomCss.hashCode);
    _$hash = $jc(_$hash, clientPortalCustomFooter.hashCode);
    _$hash = $jc(_$hash, clientPortalCustomJs.hashCode);
    _$hash = $jc(_$hash, hideEmptyColumnsOnPdf.hashCode);
    _$hash = $jc(_$hash, entitySendTime.hashCode);
    _$hash = $jc(_$hash, clientPortalTasks.hashCode);
    _$hash = $jc(_$hash, pageNumbering.hashCode);
    _$hash = $jc(_$hash, pageNumberingAlignment.hashCode);
    _$hash = $jc(_$hash, requirePurchaseOrderSignature.hashCode);
    _$hash = $jc(_$hash, defaultPurchaseOrderTerms.hashCode);
    _$hash = $jc(_$hash, defaultPurchaseOrderDesignId.hashCode);
    _$hash = $jc(_$hash, defaultPurchaseOrderFooter.hashCode);
    _$hash = $jc(_$hash, purchaseOrderNumberPattern.hashCode);
    _$hash = $jc(_$hash, purchaseOrderNumberCounter.hashCode);
    _$hash = $jc(_$hash, qrIban.hashCode);
    _$hash = $jc(_$hash, besrId.hashCode);
    _$hash = $jc(_$hash, postmarkSecret.hashCode);
    _$hash = $jc(_$hash, mailgunSecret.hashCode);
    _$hash = $jc(_$hash, mailgunDomain.hashCode);
    _$hash = $jc(_$hash, mailgunEndpoint.hashCode);
    _$hash = $jc(_$hash, emailAlignment.hashCode);
    _$hash = $jc(_$hash, showEmailFooter.hashCode);
    _$hash = $jc(_$hash, companyLogoSize.hashCode);
    _$hash = $jc(_$hash, showPaidStamp.hashCode);
    _$hash = $jc(_$hash, showShippingAddress.hashCode);
    _$hash = $jc(_$hash, customSendingEmail.hashCode);
    _$hash = $jc(_$hash, acceptPurchaseOrderNumber.hashCode);
    _$hash = $jc(_$hash, clientInitiatedPayments.hashCode);
    _$hash = $jc(_$hash, clientInitiatedPaymentsMinimum.hashCode);
    _$hash = $jc(_$hash, shareInvoiceQuoteColumns.hashCode);
    _$hash = $jc(_$hash, allowBillableTaskItems.hashCode);
    _$hash = $jc(_$hash, showTaskItemDescription.hashCode);
    _$hash = $jc(_$hash, enableEInvoice.hashCode);
    _$hash = $jc(_$hash, eInvoiceType.hashCode);
    _$hash = $jc(_$hash, defaultExpensePaymentTypeId.hashCode);
    _$hash = $jc(_$hash, classification.hashCode);
    _$hash = $jc(_$hash, paymentEmailAllContacts.hashCode);
    _$hash = $jc(_$hash, showPdfhtmlOnMobile.hashCode);
    _$hash = $jc(_$hash, useUnappliedPayment.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SettingsEntity')
          ..add('timezoneId', timezoneId)
          ..add('dateFormatId', dateFormatId)
          ..add('enableMilitaryTime', enableMilitaryTime)
          ..add('languageId', languageId)
          ..add('showCurrencyCode', showCurrencyCode)
          ..add('currencyId', currencyId)
          ..add('customValue1', customValue1)
          ..add('customValue2', customValue2)
          ..add('customValue3', customValue3)
          ..add('customValue4', customValue4)
          ..add('defaultPaymentTerms', defaultPaymentTerms)
          ..add('defaultValidUntil', defaultValidUntil)
          ..add('companyGatewayIds', companyGatewayIds)
          ..add('defaultTaskRate', defaultTaskRate)
          ..add('sendReminders', sendReminders)
          ..add('enablePortal', enablePortal)
          ..add('enablePortalDashboard', enablePortalDashboard)
          ..add('enablePortalTasks', enablePortalTasks)
          ..add('enableClientPortalUploads', enableClientPortalUploads)
          ..add('enableVendorPortalUploads', enableVendorPortalUploads)
          ..add('emailStyle', emailStyle)
          ..add('replyToEmail', replyToEmail)
          ..add('replyToName', replyToName)
          ..add('emailFromName', emailFromName)
          ..add('bccEmail', bccEmail)
          ..add('pdfEmailAttachment', pdfEmailAttachment)
          ..add('ublEmailAttachment', ublEmailAttachment)
          ..add('documentEmailAttachment', documentEmailAttachment)
          ..add('emailStyleCustom', emailStyleCustom)
          ..add('customMessageDashboard', customMessageDashboard)
          ..add('customMessageUnpaidInvoice', customMessageUnpaidInvoice)
          ..add('customMessagePaidInvoice', customMessagePaidInvoice)
          ..add('customMessageUnapprovedQuote', customMessageUnapprovedQuote)
          ..add('autoArchiveInvoice', autoArchiveInvoice)
          ..add('autoArchiveInvoiceCancelled', autoArchiveInvoiceCancelled)
          ..add('autoArchiveQuote', autoArchiveQuote)
          ..add('autoEmailInvoice', autoEmailInvoice)
          ..add('autoConvertQuote', autoConvertQuote)
          ..add('enableInclusiveTaxes', enableInclusiveTaxes)
          ..add('translations', translations)
          ..add('taskNumberPattern', taskNumberPattern)
          ..add('taskNumberCounter', taskNumberCounter)
          ..add('expenseNumberPattern', expenseNumberPattern)
          ..add('expenseNumberCounter', expenseNumberCounter)
          ..add('recurringExpenseNumberPattern', recurringExpenseNumberPattern)
          ..add('recurringExpenseNumberCounter', recurringExpenseNumberCounter)
          ..add('vendorNumberPattern', vendorNumberPattern)
          ..add('vendorNumberCounter', vendorNumberCounter)
          ..add('ticketNumberPattern', ticketNumberPattern)
          ..add('ticketNumberCounter', ticketNumberCounter)
          ..add('paymentNumberPattern', paymentNumberPattern)
          ..add('paymentNumberCounter', paymentNumberCounter)
          ..add('projectNumberPattern', projectNumberPattern)
          ..add('projectNumberCounter', projectNumberCounter)
          ..add('invoiceNumberPattern', invoiceNumberPattern)
          ..add('invoiceNumberCounter', invoiceNumberCounter)
          ..add('recurringInvoiceNumberPattern', recurringInvoiceNumberPattern)
          ..add('recurringInvoiceNumberCounter', recurringInvoiceNumberCounter)
          ..add('quoteNumberPattern', quoteNumberPattern)
          ..add('quoteNumberCounter', quoteNumberCounter)
          ..add('clientNumberPattern', clientNumberPattern)
          ..add('clientNumberCounter', clientNumberCounter)
          ..add('creditNumberPattern', creditNumberPattern)
          ..add('creditNumberCounter', creditNumberCounter)
          ..add('recurringNumberPrefix', recurringNumberPrefix)
          ..add('resetCounterFrequencyId', resetCounterFrequencyId)
          ..add('resetCounterDate', resetCounterDate)
          ..add('counterPadding', counterPadding)
          ..add('sharedInvoiceQuoteCounter', sharedInvoiceQuoteCounter)
          ..add('sharedInvoiceCreditCounter', sharedInvoiceCreditCounter)
          ..add('defaultInvoiceTerms', defaultInvoiceTerms)
          ..add('defaultQuoteTerms', defaultQuoteTerms)
          ..add('defaultQuoteFooter', defaultQuoteFooter)
          ..add('defaultCreditTerms', defaultCreditTerms)
          ..add('defaultCreditFooter', defaultCreditFooter)
          ..add('defaultInvoiceDesignId', defaultInvoiceDesignId)
          ..add('defaultQuoteDesignId', defaultQuoteDesignId)
          ..add('defaultCreditDesignId', defaultCreditDesignId)
          ..add('defaultDeliveryNoteDesignId', defaultDeliveryNoteDesignId)
          ..add('defaultStatementDesignId', defaultStatementDesignId)
          ..add('defaultPaymentReceiptDesignId', defaultPaymentReceiptDesignId)
          ..add('defaultPaymentRefundDesignId', defaultPaymentRefundDesignId)
          ..add('defaultInvoiceFooter', defaultInvoiceFooter)
          ..add('defaultTaxName1', defaultTaxName1)
          ..add('defaultTaxRate1', defaultTaxRate1)
          ..add('defaultTaxName2', defaultTaxName2)
          ..add('defaultTaxRate2', defaultTaxRate2)
          ..add('defaultTaxName3', defaultTaxName3)
          ..add('defaultTaxRate3', defaultTaxRate3)
          ..add('defaultPaymentTypeId', defaultPaymentTypeId)
          ..add('pdfVariables', pdfVariables)
          ..add('emailSignature', emailSignature)
          ..add('emailSubjectInvoice', emailSubjectInvoice)
          ..add('emailSubjectQuote', emailSubjectQuote)
          ..add('emailSubjectCredit', emailSubjectCredit)
          ..add('emailSubjectPayment', emailSubjectPayment)
          ..add('emailSubjectPaymentPartial', emailSubjectPaymentPartial)
          ..add('emailBodyInvoice', emailBodyInvoice)
          ..add('emailBodyQuote', emailBodyQuote)
          ..add('emailBodyCredit', emailBodyCredit)
          ..add('emailBodyPayment', emailBodyPayment)
          ..add('emailBodyPaymentPartial', emailBodyPaymentPartial)
          ..add('emailSubjectReminder1', emailSubjectReminder1)
          ..add('emailSubjectReminder2', emailSubjectReminder2)
          ..add('emailSubjectReminder3', emailSubjectReminder3)
          ..add('emailBodyReminder1', emailBodyReminder1)
          ..add('emailBodyReminder2', emailBodyReminder2)
          ..add('emailBodyReminder3', emailBodyReminder3)
          ..add('emailSubjectCustom1', emailSubjectCustom1)
          ..add('emailBodyCustom1', emailBodyCustom1)
          ..add('emailSubjectCustom2', emailSubjectCustom2)
          ..add('emailBodyCustom2', emailBodyCustom2)
          ..add('emailSubjectCustom3', emailSubjectCustom3)
          ..add('emailBodyCustom3', emailBodyCustom3)
          ..add('emailSubjectStatement', emailSubjectStatement)
          ..add('emailBodyStatement', emailBodyStatement)
          ..add('emailSubjectPurchaseOrder', emailSubjectPurchaseOrder)
          ..add('emailBodyPurchaseOrder', emailBodyPurchaseOrder)
          ..add('enablePortalPassword', enablePortalPassword)
          ..add('signatureOnPdf', signatureOnPdf)
          ..add('enableEmailMarkup', enableEmailMarkup)
          ..add('showAcceptInvoiceTerms', showAcceptInvoiceTerms)
          ..add('showAcceptQuoteTerms', showAcceptQuoteTerms)
          ..add('requireInvoiceSignature', requireInvoiceSignature)
          ..add('requireQuoteSignature', requireQuoteSignature)
          ..add('name', name)
          ..add('companyLogo', companyLogo)
          ..add('website', website)
          ..add('address1', address1)
          ..add('address2', address2)
          ..add('city', city)
          ..add('state', state)
          ..add('postalCode', postalCode)
          ..add('phone', phone)
          ..add('email', email)
          ..add('countryId', countryId)
          ..add('vatNumber', vatNumber)
          ..add('idNumber', idNumber)
          ..add('pageSize', pageSize)
          ..add('pageLayout', pageLayout)
          ..add('fontSize', fontSize)
          ..add('primaryColor', primaryColor)
          ..add('secondaryColor', secondaryColor)
          ..add('primaryFont', primaryFont)
          ..add('secondaryFont', secondaryFont)
          ..add('hidePaidToDate', hidePaidToDate)
          ..add('embedDocuments', embedDocuments)
          ..add('allPagesHeader', allPagesHeader)
          ..add('allPagesFooter', allPagesFooter)
          ..add('enableReminder1', enableReminder1)
          ..add('enableReminder2', enableReminder2)
          ..add('enableReminder3', enableReminder3)
          ..add('enableReminderEndless', enableReminderEndless)
          ..add('numDaysReminder1', numDaysReminder1)
          ..add('numDaysReminder2', numDaysReminder2)
          ..add('numDaysReminder3', numDaysReminder3)
          ..add('scheduleReminder1', scheduleReminder1)
          ..add('scheduleReminder2', scheduleReminder2)
          ..add('scheduleReminder3', scheduleReminder3)
          ..add('endlessReminderFrequencyId', endlessReminderFrequencyId)
          ..add('lateFeeAmount1', lateFeeAmount1)
          ..add('lateFeeAmount2', lateFeeAmount2)
          ..add('lateFeeAmount3', lateFeeAmount3)
          ..add('lateFeeAmountEndless', lateFeeAmountEndless)
          ..add('lateFeePercent1', lateFeePercent1)
          ..add('lateFeePercent2', lateFeePercent2)
          ..add('lateFeePercent3', lateFeePercent3)
          ..add('lateFeePercentEndless', lateFeePercentEndless)
          ..add('emailSubjectReminderEndless', emailSubjectReminderEndless)
          ..add('emailBodyReminderEndless', emailBodyReminderEndless)
          ..add('clientOnlinePaymentNotification',
              clientOnlinePaymentNotification)
          ..add('clientManualPaymentNotification',
              clientManualPaymentNotification)
          ..add('clientMarkPaidPaymentNotification',
              clientMarkPaidPaymentNotification)
          ..add('counterNumberApplied', counterNumberApplied)
          ..add('emailSendingMethod', emailSendingMethod)
          ..add('gmailSendingUserId', gmailSendingUserId)
          ..add('clientPortalTerms', clientPortalTerms)
          ..add('clientPortalPrivacy', clientPortalPrivacy)
          ..add('lockInvoices', lockInvoices)
          ..add('autoBill', autoBill)
          ..add('autoBillStandardInvoices', autoBillStandardInvoices)
          ..add('clientPortalAllowUnderPayment', clientPortalAllowUnderPayment)
          ..add('clientPortalAllowOverPayment', clientPortalAllowOverPayment)
          ..add('autoBillDate', autoBillDate)
          ..add('clientPortalUnderPaymentMinimum',
              clientPortalUnderPaymentMinimum)
          ..add('useCreditsPayment', useCreditsPayment)
          ..add('clientPortalCustomHeader', clientPortalCustomHeader)
          ..add('clientPortalCustomCss', clientPortalCustomCss)
          ..add('clientPortalCustomFooter', clientPortalCustomFooter)
          ..add('clientPortalCustomJs', clientPortalCustomJs)
          ..add('hideEmptyColumnsOnPdf', hideEmptyColumnsOnPdf)
          ..add('entitySendTime', entitySendTime)
          ..add('clientPortalTasks', clientPortalTasks)
          ..add('pageNumbering', pageNumbering)
          ..add('pageNumberingAlignment', pageNumberingAlignment)
          ..add('requirePurchaseOrderSignature', requirePurchaseOrderSignature)
          ..add('defaultPurchaseOrderTerms', defaultPurchaseOrderTerms)
          ..add('defaultPurchaseOrderDesignId', defaultPurchaseOrderDesignId)
          ..add('defaultPurchaseOrderFooter', defaultPurchaseOrderFooter)
          ..add('purchaseOrderNumberPattern', purchaseOrderNumberPattern)
          ..add('purchaseOrderNumberCounter', purchaseOrderNumberCounter)
          ..add('qrIban', qrIban)
          ..add('besrId', besrId)
          ..add('postmarkSecret', postmarkSecret)
          ..add('mailgunSecret', mailgunSecret)
          ..add('mailgunDomain', mailgunDomain)
          ..add('mailgunEndpoint', mailgunEndpoint)
          ..add('emailAlignment', emailAlignment)
          ..add('showEmailFooter', showEmailFooter)
          ..add('companyLogoSize', companyLogoSize)
          ..add('showPaidStamp', showPaidStamp)
          ..add('showShippingAddress', showShippingAddress)
          ..add('customSendingEmail', customSendingEmail)
          ..add('acceptPurchaseOrderNumber', acceptPurchaseOrderNumber)
          ..add('clientInitiatedPayments', clientInitiatedPayments)
          ..add(
              'clientInitiatedPaymentsMinimum', clientInitiatedPaymentsMinimum)
          ..add('shareInvoiceQuoteColumns', shareInvoiceQuoteColumns)
          ..add('allowBillableTaskItems', allowBillableTaskItems)
          ..add('showTaskItemDescription', showTaskItemDescription)
          ..add('enableEInvoice', enableEInvoice)
          ..add('eInvoiceType', eInvoiceType)
          ..add('defaultExpensePaymentTypeId', defaultExpensePaymentTypeId)
          ..add('classification', classification)
          ..add('paymentEmailAllContacts', paymentEmailAllContacts)
          ..add('showPdfhtmlOnMobile', showPdfhtmlOnMobile)
          ..add('useUnappliedPayment', useUnappliedPayment))
        .toString();
  }
}

class SettingsEntityBuilder
    implements Builder<SettingsEntity, SettingsEntityBuilder> {
  _$SettingsEntity? _$v;

  String? _timezoneId;
  String? get timezoneId => _$this._timezoneId;
  set timezoneId(String? timezoneId) => _$this._timezoneId = timezoneId;

  String? _dateFormatId;
  String? get dateFormatId => _$this._dateFormatId;
  set dateFormatId(String? dateFormatId) => _$this._dateFormatId = dateFormatId;

  bool? _enableMilitaryTime;
  bool? get enableMilitaryTime => _$this._enableMilitaryTime;
  set enableMilitaryTime(bool? enableMilitaryTime) =>
      _$this._enableMilitaryTime = enableMilitaryTime;

  String? _languageId;
  String? get languageId => _$this._languageId;
  set languageId(String? languageId) => _$this._languageId = languageId;

  bool? _showCurrencyCode;
  bool? get showCurrencyCode => _$this._showCurrencyCode;
  set showCurrencyCode(bool? showCurrencyCode) =>
      _$this._showCurrencyCode = showCurrencyCode;

  String? _currencyId;
  String? get currencyId => _$this._currencyId;
  set currencyId(String? currencyId) => _$this._currencyId = currencyId;

  String? _customValue1;
  String? get customValue1 => _$this._customValue1;
  set customValue1(String? customValue1) => _$this._customValue1 = customValue1;

  String? _customValue2;
  String? get customValue2 => _$this._customValue2;
  set customValue2(String? customValue2) => _$this._customValue2 = customValue2;

  String? _customValue3;
  String? get customValue3 => _$this._customValue3;
  set customValue3(String? customValue3) => _$this._customValue3 = customValue3;

  String? _customValue4;
  String? get customValue4 => _$this._customValue4;
  set customValue4(String? customValue4) => _$this._customValue4 = customValue4;

  String? _defaultPaymentTerms;
  String? get defaultPaymentTerms => _$this._defaultPaymentTerms;
  set defaultPaymentTerms(String? defaultPaymentTerms) =>
      _$this._defaultPaymentTerms = defaultPaymentTerms;

  String? _defaultValidUntil;
  String? get defaultValidUntil => _$this._defaultValidUntil;
  set defaultValidUntil(String? defaultValidUntil) =>
      _$this._defaultValidUntil = defaultValidUntil;

  String? _companyGatewayIds;
  String? get companyGatewayIds => _$this._companyGatewayIds;
  set companyGatewayIds(String? companyGatewayIds) =>
      _$this._companyGatewayIds = companyGatewayIds;

  double? _defaultTaskRate;
  double? get defaultTaskRate => _$this._defaultTaskRate;
  set defaultTaskRate(double? defaultTaskRate) =>
      _$this._defaultTaskRate = defaultTaskRate;

  bool? _sendReminders;
  bool? get sendReminders => _$this._sendReminders;
  set sendReminders(bool? sendReminders) =>
      _$this._sendReminders = sendReminders;

  bool? _enablePortal;
  bool? get enablePortal => _$this._enablePortal;
  set enablePortal(bool? enablePortal) => _$this._enablePortal = enablePortal;

  bool? _enablePortalDashboard;
  bool? get enablePortalDashboard => _$this._enablePortalDashboard;
  set enablePortalDashboard(bool? enablePortalDashboard) =>
      _$this._enablePortalDashboard = enablePortalDashboard;

  bool? _enablePortalTasks;
  bool? get enablePortalTasks => _$this._enablePortalTasks;
  set enablePortalTasks(bool? enablePortalTasks) =>
      _$this._enablePortalTasks = enablePortalTasks;

  bool? _enableClientPortalUploads;
  bool? get enableClientPortalUploads => _$this._enableClientPortalUploads;
  set enableClientPortalUploads(bool? enableClientPortalUploads) =>
      _$this._enableClientPortalUploads = enableClientPortalUploads;

  bool? _enableVendorPortalUploads;
  bool? get enableVendorPortalUploads => _$this._enableVendorPortalUploads;
  set enableVendorPortalUploads(bool? enableVendorPortalUploads) =>
      _$this._enableVendorPortalUploads = enableVendorPortalUploads;

  String? _emailStyle;
  String? get emailStyle => _$this._emailStyle;
  set emailStyle(String? emailStyle) => _$this._emailStyle = emailStyle;

  String? _replyToEmail;
  String? get replyToEmail => _$this._replyToEmail;
  set replyToEmail(String? replyToEmail) => _$this._replyToEmail = replyToEmail;

  String? _replyToName;
  String? get replyToName => _$this._replyToName;
  set replyToName(String? replyToName) => _$this._replyToName = replyToName;

  String? _emailFromName;
  String? get emailFromName => _$this._emailFromName;
  set emailFromName(String? emailFromName) =>
      _$this._emailFromName = emailFromName;

  String? _bccEmail;
  String? get bccEmail => _$this._bccEmail;
  set bccEmail(String? bccEmail) => _$this._bccEmail = bccEmail;

  bool? _pdfEmailAttachment;
  bool? get pdfEmailAttachment => _$this._pdfEmailAttachment;
  set pdfEmailAttachment(bool? pdfEmailAttachment) =>
      _$this._pdfEmailAttachment = pdfEmailAttachment;

  bool? _ublEmailAttachment;
  bool? get ublEmailAttachment => _$this._ublEmailAttachment;
  set ublEmailAttachment(bool? ublEmailAttachment) =>
      _$this._ublEmailAttachment = ublEmailAttachment;

  bool? _documentEmailAttachment;
  bool? get documentEmailAttachment => _$this._documentEmailAttachment;
  set documentEmailAttachment(bool? documentEmailAttachment) =>
      _$this._documentEmailAttachment = documentEmailAttachment;

  String? _emailStyleCustom;
  String? get emailStyleCustom => _$this._emailStyleCustom;
  set emailStyleCustom(String? emailStyleCustom) =>
      _$this._emailStyleCustom = emailStyleCustom;

  String? _customMessageDashboard;
  String? get customMessageDashboard => _$this._customMessageDashboard;
  set customMessageDashboard(String? customMessageDashboard) =>
      _$this._customMessageDashboard = customMessageDashboard;

  String? _customMessageUnpaidInvoice;
  String? get customMessageUnpaidInvoice => _$this._customMessageUnpaidInvoice;
  set customMessageUnpaidInvoice(String? customMessageUnpaidInvoice) =>
      _$this._customMessageUnpaidInvoice = customMessageUnpaidInvoice;

  String? _customMessagePaidInvoice;
  String? get customMessagePaidInvoice => _$this._customMessagePaidInvoice;
  set customMessagePaidInvoice(String? customMessagePaidInvoice) =>
      _$this._customMessagePaidInvoice = customMessagePaidInvoice;

  String? _customMessageUnapprovedQuote;
  String? get customMessageUnapprovedQuote =>
      _$this._customMessageUnapprovedQuote;
  set customMessageUnapprovedQuote(String? customMessageUnapprovedQuote) =>
      _$this._customMessageUnapprovedQuote = customMessageUnapprovedQuote;

  bool? _autoArchiveInvoice;
  bool? get autoArchiveInvoice => _$this._autoArchiveInvoice;
  set autoArchiveInvoice(bool? autoArchiveInvoice) =>
      _$this._autoArchiveInvoice = autoArchiveInvoice;

  bool? _autoArchiveInvoiceCancelled;
  bool? get autoArchiveInvoiceCancelled => _$this._autoArchiveInvoiceCancelled;
  set autoArchiveInvoiceCancelled(bool? autoArchiveInvoiceCancelled) =>
      _$this._autoArchiveInvoiceCancelled = autoArchiveInvoiceCancelled;

  bool? _autoArchiveQuote;
  bool? get autoArchiveQuote => _$this._autoArchiveQuote;
  set autoArchiveQuote(bool? autoArchiveQuote) =>
      _$this._autoArchiveQuote = autoArchiveQuote;

  bool? _autoEmailInvoice;
  bool? get autoEmailInvoice => _$this._autoEmailInvoice;
  set autoEmailInvoice(bool? autoEmailInvoice) =>
      _$this._autoEmailInvoice = autoEmailInvoice;

  bool? _autoConvertQuote;
  bool? get autoConvertQuote => _$this._autoConvertQuote;
  set autoConvertQuote(bool? autoConvertQuote) =>
      _$this._autoConvertQuote = autoConvertQuote;

  bool? _enableInclusiveTaxes;
  bool? get enableInclusiveTaxes => _$this._enableInclusiveTaxes;
  set enableInclusiveTaxes(bool? enableInclusiveTaxes) =>
      _$this._enableInclusiveTaxes = enableInclusiveTaxes;

  MapBuilder<String?, String>? _translations;
  MapBuilder<String?, String> get translations =>
      _$this._translations ??= new MapBuilder<String?, String>();
  set translations(MapBuilder<String?, String>? translations) =>
      _$this._translations = translations;

  String? _taskNumberPattern;
  String? get taskNumberPattern => _$this._taskNumberPattern;
  set taskNumberPattern(String? taskNumberPattern) =>
      _$this._taskNumberPattern = taskNumberPattern;

  int? _taskNumberCounter;
  int? get taskNumberCounter => _$this._taskNumberCounter;
  set taskNumberCounter(int? taskNumberCounter) =>
      _$this._taskNumberCounter = taskNumberCounter;

  String? _expenseNumberPattern;
  String? get expenseNumberPattern => _$this._expenseNumberPattern;
  set expenseNumberPattern(String? expenseNumberPattern) =>
      _$this._expenseNumberPattern = expenseNumberPattern;

  int? _expenseNumberCounter;
  int? get expenseNumberCounter => _$this._expenseNumberCounter;
  set expenseNumberCounter(int? expenseNumberCounter) =>
      _$this._expenseNumberCounter = expenseNumberCounter;

  String? _recurringExpenseNumberPattern;
  String? get recurringExpenseNumberPattern =>
      _$this._recurringExpenseNumberPattern;
  set recurringExpenseNumberPattern(String? recurringExpenseNumberPattern) =>
      _$this._recurringExpenseNumberPattern = recurringExpenseNumberPattern;

  int? _recurringExpenseNumberCounter;
  int? get recurringExpenseNumberCounter =>
      _$this._recurringExpenseNumberCounter;
  set recurringExpenseNumberCounter(int? recurringExpenseNumberCounter) =>
      _$this._recurringExpenseNumberCounter = recurringExpenseNumberCounter;

  String? _vendorNumberPattern;
  String? get vendorNumberPattern => _$this._vendorNumberPattern;
  set vendorNumberPattern(String? vendorNumberPattern) =>
      _$this._vendorNumberPattern = vendorNumberPattern;

  int? _vendorNumberCounter;
  int? get vendorNumberCounter => _$this._vendorNumberCounter;
  set vendorNumberCounter(int? vendorNumberCounter) =>
      _$this._vendorNumberCounter = vendorNumberCounter;

  String? _ticketNumberPattern;
  String? get ticketNumberPattern => _$this._ticketNumberPattern;
  set ticketNumberPattern(String? ticketNumberPattern) =>
      _$this._ticketNumberPattern = ticketNumberPattern;

  int? _ticketNumberCounter;
  int? get ticketNumberCounter => _$this._ticketNumberCounter;
  set ticketNumberCounter(int? ticketNumberCounter) =>
      _$this._ticketNumberCounter = ticketNumberCounter;

  String? _paymentNumberPattern;
  String? get paymentNumberPattern => _$this._paymentNumberPattern;
  set paymentNumberPattern(String? paymentNumberPattern) =>
      _$this._paymentNumberPattern = paymentNumberPattern;

  int? _paymentNumberCounter;
  int? get paymentNumberCounter => _$this._paymentNumberCounter;
  set paymentNumberCounter(int? paymentNumberCounter) =>
      _$this._paymentNumberCounter = paymentNumberCounter;

  String? _projectNumberPattern;
  String? get projectNumberPattern => _$this._projectNumberPattern;
  set projectNumberPattern(String? projectNumberPattern) =>
      _$this._projectNumberPattern = projectNumberPattern;

  int? _projectNumberCounter;
  int? get projectNumberCounter => _$this._projectNumberCounter;
  set projectNumberCounter(int? projectNumberCounter) =>
      _$this._projectNumberCounter = projectNumberCounter;

  String? _invoiceNumberPattern;
  String? get invoiceNumberPattern => _$this._invoiceNumberPattern;
  set invoiceNumberPattern(String? invoiceNumberPattern) =>
      _$this._invoiceNumberPattern = invoiceNumberPattern;

  int? _invoiceNumberCounter;
  int? get invoiceNumberCounter => _$this._invoiceNumberCounter;
  set invoiceNumberCounter(int? invoiceNumberCounter) =>
      _$this._invoiceNumberCounter = invoiceNumberCounter;

  String? _recurringInvoiceNumberPattern;
  String? get recurringInvoiceNumberPattern =>
      _$this._recurringInvoiceNumberPattern;
  set recurringInvoiceNumberPattern(String? recurringInvoiceNumberPattern) =>
      _$this._recurringInvoiceNumberPattern = recurringInvoiceNumberPattern;

  int? _recurringInvoiceNumberCounter;
  int? get recurringInvoiceNumberCounter =>
      _$this._recurringInvoiceNumberCounter;
  set recurringInvoiceNumberCounter(int? recurringInvoiceNumberCounter) =>
      _$this._recurringInvoiceNumberCounter = recurringInvoiceNumberCounter;

  String? _quoteNumberPattern;
  String? get quoteNumberPattern => _$this._quoteNumberPattern;
  set quoteNumberPattern(String? quoteNumberPattern) =>
      _$this._quoteNumberPattern = quoteNumberPattern;

  int? _quoteNumberCounter;
  int? get quoteNumberCounter => _$this._quoteNumberCounter;
  set quoteNumberCounter(int? quoteNumberCounter) =>
      _$this._quoteNumberCounter = quoteNumberCounter;

  String? _clientNumberPattern;
  String? get clientNumberPattern => _$this._clientNumberPattern;
  set clientNumberPattern(String? clientNumberPattern) =>
      _$this._clientNumberPattern = clientNumberPattern;

  int? _clientNumberCounter;
  int? get clientNumberCounter => _$this._clientNumberCounter;
  set clientNumberCounter(int? clientNumberCounter) =>
      _$this._clientNumberCounter = clientNumberCounter;

  String? _creditNumberPattern;
  String? get creditNumberPattern => _$this._creditNumberPattern;
  set creditNumberPattern(String? creditNumberPattern) =>
      _$this._creditNumberPattern = creditNumberPattern;

  int? _creditNumberCounter;
  int? get creditNumberCounter => _$this._creditNumberCounter;
  set creditNumberCounter(int? creditNumberCounter) =>
      _$this._creditNumberCounter = creditNumberCounter;

  String? _recurringNumberPrefix;
  String? get recurringNumberPrefix => _$this._recurringNumberPrefix;
  set recurringNumberPrefix(String? recurringNumberPrefix) =>
      _$this._recurringNumberPrefix = recurringNumberPrefix;

  String? _resetCounterFrequencyId;
  String? get resetCounterFrequencyId => _$this._resetCounterFrequencyId;
  set resetCounterFrequencyId(String? resetCounterFrequencyId) =>
      _$this._resetCounterFrequencyId = resetCounterFrequencyId;

  String? _resetCounterDate;
  String? get resetCounterDate => _$this._resetCounterDate;
  set resetCounterDate(String? resetCounterDate) =>
      _$this._resetCounterDate = resetCounterDate;

  int? _counterPadding;
  int? get counterPadding => _$this._counterPadding;
  set counterPadding(int? counterPadding) =>
      _$this._counterPadding = counterPadding;

  bool? _sharedInvoiceQuoteCounter;
  bool? get sharedInvoiceQuoteCounter => _$this._sharedInvoiceQuoteCounter;
  set sharedInvoiceQuoteCounter(bool? sharedInvoiceQuoteCounter) =>
      _$this._sharedInvoiceQuoteCounter = sharedInvoiceQuoteCounter;

  bool? _sharedInvoiceCreditCounter;
  bool? get sharedInvoiceCreditCounter => _$this._sharedInvoiceCreditCounter;
  set sharedInvoiceCreditCounter(bool? sharedInvoiceCreditCounter) =>
      _$this._sharedInvoiceCreditCounter = sharedInvoiceCreditCounter;

  String? _defaultInvoiceTerms;
  String? get defaultInvoiceTerms => _$this._defaultInvoiceTerms;
  set defaultInvoiceTerms(String? defaultInvoiceTerms) =>
      _$this._defaultInvoiceTerms = defaultInvoiceTerms;

  String? _defaultQuoteTerms;
  String? get defaultQuoteTerms => _$this._defaultQuoteTerms;
  set defaultQuoteTerms(String? defaultQuoteTerms) =>
      _$this._defaultQuoteTerms = defaultQuoteTerms;

  String? _defaultQuoteFooter;
  String? get defaultQuoteFooter => _$this._defaultQuoteFooter;
  set defaultQuoteFooter(String? defaultQuoteFooter) =>
      _$this._defaultQuoteFooter = defaultQuoteFooter;

  String? _defaultCreditTerms;
  String? get defaultCreditTerms => _$this._defaultCreditTerms;
  set defaultCreditTerms(String? defaultCreditTerms) =>
      _$this._defaultCreditTerms = defaultCreditTerms;

  String? _defaultCreditFooter;
  String? get defaultCreditFooter => _$this._defaultCreditFooter;
  set defaultCreditFooter(String? defaultCreditFooter) =>
      _$this._defaultCreditFooter = defaultCreditFooter;

  String? _defaultInvoiceDesignId;
  String? get defaultInvoiceDesignId => _$this._defaultInvoiceDesignId;
  set defaultInvoiceDesignId(String? defaultInvoiceDesignId) =>
      _$this._defaultInvoiceDesignId = defaultInvoiceDesignId;

  String? _defaultQuoteDesignId;
  String? get defaultQuoteDesignId => _$this._defaultQuoteDesignId;
  set defaultQuoteDesignId(String? defaultQuoteDesignId) =>
      _$this._defaultQuoteDesignId = defaultQuoteDesignId;

  String? _defaultCreditDesignId;
  String? get defaultCreditDesignId => _$this._defaultCreditDesignId;
  set defaultCreditDesignId(String? defaultCreditDesignId) =>
      _$this._defaultCreditDesignId = defaultCreditDesignId;

  String? _defaultDeliveryNoteDesignId;
  String? get defaultDeliveryNoteDesignId =>
      _$this._defaultDeliveryNoteDesignId;
  set defaultDeliveryNoteDesignId(String? defaultDeliveryNoteDesignId) =>
      _$this._defaultDeliveryNoteDesignId = defaultDeliveryNoteDesignId;

  String? _defaultStatementDesignId;
  String? get defaultStatementDesignId => _$this._defaultStatementDesignId;
  set defaultStatementDesignId(String? defaultStatementDesignId) =>
      _$this._defaultStatementDesignId = defaultStatementDesignId;

  String? _defaultPaymentReceiptDesignId;
  String? get defaultPaymentReceiptDesignId =>
      _$this._defaultPaymentReceiptDesignId;
  set defaultPaymentReceiptDesignId(String? defaultPaymentReceiptDesignId) =>
      _$this._defaultPaymentReceiptDesignId = defaultPaymentReceiptDesignId;

  String? _defaultPaymentRefundDesignId;
  String? get defaultPaymentRefundDesignId =>
      _$this._defaultPaymentRefundDesignId;
  set defaultPaymentRefundDesignId(String? defaultPaymentRefundDesignId) =>
      _$this._defaultPaymentRefundDesignId = defaultPaymentRefundDesignId;

  String? _defaultInvoiceFooter;
  String? get defaultInvoiceFooter => _$this._defaultInvoiceFooter;
  set defaultInvoiceFooter(String? defaultInvoiceFooter) =>
      _$this._defaultInvoiceFooter = defaultInvoiceFooter;

  String? _defaultTaxName1;
  String? get defaultTaxName1 => _$this._defaultTaxName1;
  set defaultTaxName1(String? defaultTaxName1) =>
      _$this._defaultTaxName1 = defaultTaxName1;

  double? _defaultTaxRate1;
  double? get defaultTaxRate1 => _$this._defaultTaxRate1;
  set defaultTaxRate1(double? defaultTaxRate1) =>
      _$this._defaultTaxRate1 = defaultTaxRate1;

  String? _defaultTaxName2;
  String? get defaultTaxName2 => _$this._defaultTaxName2;
  set defaultTaxName2(String? defaultTaxName2) =>
      _$this._defaultTaxName2 = defaultTaxName2;

  double? _defaultTaxRate2;
  double? get defaultTaxRate2 => _$this._defaultTaxRate2;
  set defaultTaxRate2(double? defaultTaxRate2) =>
      _$this._defaultTaxRate2 = defaultTaxRate2;

  String? _defaultTaxName3;
  String? get defaultTaxName3 => _$this._defaultTaxName3;
  set defaultTaxName3(String? defaultTaxName3) =>
      _$this._defaultTaxName3 = defaultTaxName3;

  double? _defaultTaxRate3;
  double? get defaultTaxRate3 => _$this._defaultTaxRate3;
  set defaultTaxRate3(double? defaultTaxRate3) =>
      _$this._defaultTaxRate3 = defaultTaxRate3;

  String? _defaultPaymentTypeId;
  String? get defaultPaymentTypeId => _$this._defaultPaymentTypeId;
  set defaultPaymentTypeId(String? defaultPaymentTypeId) =>
      _$this._defaultPaymentTypeId = defaultPaymentTypeId;

  MapBuilder<String, BuiltList<String>>? _pdfVariables;
  MapBuilder<String, BuiltList<String>> get pdfVariables =>
      _$this._pdfVariables ??= new MapBuilder<String, BuiltList<String>>();
  set pdfVariables(MapBuilder<String, BuiltList<String>>? pdfVariables) =>
      _$this._pdfVariables = pdfVariables;

  String? _emailSignature;
  String? get emailSignature => _$this._emailSignature;
  set emailSignature(String? emailSignature) =>
      _$this._emailSignature = emailSignature;

  String? _emailSubjectInvoice;
  String? get emailSubjectInvoice => _$this._emailSubjectInvoice;
  set emailSubjectInvoice(String? emailSubjectInvoice) =>
      _$this._emailSubjectInvoice = emailSubjectInvoice;

  String? _emailSubjectQuote;
  String? get emailSubjectQuote => _$this._emailSubjectQuote;
  set emailSubjectQuote(String? emailSubjectQuote) =>
      _$this._emailSubjectQuote = emailSubjectQuote;

  String? _emailSubjectCredit;
  String? get emailSubjectCredit => _$this._emailSubjectCredit;
  set emailSubjectCredit(String? emailSubjectCredit) =>
      _$this._emailSubjectCredit = emailSubjectCredit;

  String? _emailSubjectPayment;
  String? get emailSubjectPayment => _$this._emailSubjectPayment;
  set emailSubjectPayment(String? emailSubjectPayment) =>
      _$this._emailSubjectPayment = emailSubjectPayment;

  String? _emailSubjectPaymentPartial;
  String? get emailSubjectPaymentPartial => _$this._emailSubjectPaymentPartial;
  set emailSubjectPaymentPartial(String? emailSubjectPaymentPartial) =>
      _$this._emailSubjectPaymentPartial = emailSubjectPaymentPartial;

  String? _emailBodyInvoice;
  String? get emailBodyInvoice => _$this._emailBodyInvoice;
  set emailBodyInvoice(String? emailBodyInvoice) =>
      _$this._emailBodyInvoice = emailBodyInvoice;

  String? _emailBodyQuote;
  String? get emailBodyQuote => _$this._emailBodyQuote;
  set emailBodyQuote(String? emailBodyQuote) =>
      _$this._emailBodyQuote = emailBodyQuote;

  String? _emailBodyCredit;
  String? get emailBodyCredit => _$this._emailBodyCredit;
  set emailBodyCredit(String? emailBodyCredit) =>
      _$this._emailBodyCredit = emailBodyCredit;

  String? _emailBodyPayment;
  String? get emailBodyPayment => _$this._emailBodyPayment;
  set emailBodyPayment(String? emailBodyPayment) =>
      _$this._emailBodyPayment = emailBodyPayment;

  String? _emailBodyPaymentPartial;
  String? get emailBodyPaymentPartial => _$this._emailBodyPaymentPartial;
  set emailBodyPaymentPartial(String? emailBodyPaymentPartial) =>
      _$this._emailBodyPaymentPartial = emailBodyPaymentPartial;

  String? _emailSubjectReminder1;
  String? get emailSubjectReminder1 => _$this._emailSubjectReminder1;
  set emailSubjectReminder1(String? emailSubjectReminder1) =>
      _$this._emailSubjectReminder1 = emailSubjectReminder1;

  String? _emailSubjectReminder2;
  String? get emailSubjectReminder2 => _$this._emailSubjectReminder2;
  set emailSubjectReminder2(String? emailSubjectReminder2) =>
      _$this._emailSubjectReminder2 = emailSubjectReminder2;

  String? _emailSubjectReminder3;
  String? get emailSubjectReminder3 => _$this._emailSubjectReminder3;
  set emailSubjectReminder3(String? emailSubjectReminder3) =>
      _$this._emailSubjectReminder3 = emailSubjectReminder3;

  String? _emailBodyReminder1;
  String? get emailBodyReminder1 => _$this._emailBodyReminder1;
  set emailBodyReminder1(String? emailBodyReminder1) =>
      _$this._emailBodyReminder1 = emailBodyReminder1;

  String? _emailBodyReminder2;
  String? get emailBodyReminder2 => _$this._emailBodyReminder2;
  set emailBodyReminder2(String? emailBodyReminder2) =>
      _$this._emailBodyReminder2 = emailBodyReminder2;

  String? _emailBodyReminder3;
  String? get emailBodyReminder3 => _$this._emailBodyReminder3;
  set emailBodyReminder3(String? emailBodyReminder3) =>
      _$this._emailBodyReminder3 = emailBodyReminder3;

  String? _emailSubjectCustom1;
  String? get emailSubjectCustom1 => _$this._emailSubjectCustom1;
  set emailSubjectCustom1(String? emailSubjectCustom1) =>
      _$this._emailSubjectCustom1 = emailSubjectCustom1;

  String? _emailBodyCustom1;
  String? get emailBodyCustom1 => _$this._emailBodyCustom1;
  set emailBodyCustom1(String? emailBodyCustom1) =>
      _$this._emailBodyCustom1 = emailBodyCustom1;

  String? _emailSubjectCustom2;
  String? get emailSubjectCustom2 => _$this._emailSubjectCustom2;
  set emailSubjectCustom2(String? emailSubjectCustom2) =>
      _$this._emailSubjectCustom2 = emailSubjectCustom2;

  String? _emailBodyCustom2;
  String? get emailBodyCustom2 => _$this._emailBodyCustom2;
  set emailBodyCustom2(String? emailBodyCustom2) =>
      _$this._emailBodyCustom2 = emailBodyCustom2;

  String? _emailSubjectCustom3;
  String? get emailSubjectCustom3 => _$this._emailSubjectCustom3;
  set emailSubjectCustom3(String? emailSubjectCustom3) =>
      _$this._emailSubjectCustom3 = emailSubjectCustom3;

  String? _emailBodyCustom3;
  String? get emailBodyCustom3 => _$this._emailBodyCustom3;
  set emailBodyCustom3(String? emailBodyCustom3) =>
      _$this._emailBodyCustom3 = emailBodyCustom3;

  String? _emailSubjectStatement;
  String? get emailSubjectStatement => _$this._emailSubjectStatement;
  set emailSubjectStatement(String? emailSubjectStatement) =>
      _$this._emailSubjectStatement = emailSubjectStatement;

  String? _emailBodyStatement;
  String? get emailBodyStatement => _$this._emailBodyStatement;
  set emailBodyStatement(String? emailBodyStatement) =>
      _$this._emailBodyStatement = emailBodyStatement;

  String? _emailSubjectPurchaseOrder;
  String? get emailSubjectPurchaseOrder => _$this._emailSubjectPurchaseOrder;
  set emailSubjectPurchaseOrder(String? emailSubjectPurchaseOrder) =>
      _$this._emailSubjectPurchaseOrder = emailSubjectPurchaseOrder;

  String? _emailBodyPurchaseOrder;
  String? get emailBodyPurchaseOrder => _$this._emailBodyPurchaseOrder;
  set emailBodyPurchaseOrder(String? emailBodyPurchaseOrder) =>
      _$this._emailBodyPurchaseOrder = emailBodyPurchaseOrder;

  bool? _enablePortalPassword;
  bool? get enablePortalPassword => _$this._enablePortalPassword;
  set enablePortalPassword(bool? enablePortalPassword) =>
      _$this._enablePortalPassword = enablePortalPassword;

  bool? _signatureOnPdf;
  bool? get signatureOnPdf => _$this._signatureOnPdf;
  set signatureOnPdf(bool? signatureOnPdf) =>
      _$this._signatureOnPdf = signatureOnPdf;

  bool? _enableEmailMarkup;
  bool? get enableEmailMarkup => _$this._enableEmailMarkup;
  set enableEmailMarkup(bool? enableEmailMarkup) =>
      _$this._enableEmailMarkup = enableEmailMarkup;

  bool? _showAcceptInvoiceTerms;
  bool? get showAcceptInvoiceTerms => _$this._showAcceptInvoiceTerms;
  set showAcceptInvoiceTerms(bool? showAcceptInvoiceTerms) =>
      _$this._showAcceptInvoiceTerms = showAcceptInvoiceTerms;

  bool? _showAcceptQuoteTerms;
  bool? get showAcceptQuoteTerms => _$this._showAcceptQuoteTerms;
  set showAcceptQuoteTerms(bool? showAcceptQuoteTerms) =>
      _$this._showAcceptQuoteTerms = showAcceptQuoteTerms;

  bool? _requireInvoiceSignature;
  bool? get requireInvoiceSignature => _$this._requireInvoiceSignature;
  set requireInvoiceSignature(bool? requireInvoiceSignature) =>
      _$this._requireInvoiceSignature = requireInvoiceSignature;

  bool? _requireQuoteSignature;
  bool? get requireQuoteSignature => _$this._requireQuoteSignature;
  set requireQuoteSignature(bool? requireQuoteSignature) =>
      _$this._requireQuoteSignature = requireQuoteSignature;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _companyLogo;
  String? get companyLogo => _$this._companyLogo;
  set companyLogo(String? companyLogo) => _$this._companyLogo = companyLogo;

  String? _website;
  String? get website => _$this._website;
  set website(String? website) => _$this._website = website;

  String? _address1;
  String? get address1 => _$this._address1;
  set address1(String? address1) => _$this._address1 = address1;

  String? _address2;
  String? get address2 => _$this._address2;
  set address2(String? address2) => _$this._address2 = address2;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _postalCode;
  String? get postalCode => _$this._postalCode;
  set postalCode(String? postalCode) => _$this._postalCode = postalCode;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _countryId;
  String? get countryId => _$this._countryId;
  set countryId(String? countryId) => _$this._countryId = countryId;

  String? _vatNumber;
  String? get vatNumber => _$this._vatNumber;
  set vatNumber(String? vatNumber) => _$this._vatNumber = vatNumber;

  String? _idNumber;
  String? get idNumber => _$this._idNumber;
  set idNumber(String? idNumber) => _$this._idNumber = idNumber;

  String? _pageSize;
  String? get pageSize => _$this._pageSize;
  set pageSize(String? pageSize) => _$this._pageSize = pageSize;

  String? _pageLayout;
  String? get pageLayout => _$this._pageLayout;
  set pageLayout(String? pageLayout) => _$this._pageLayout = pageLayout;

  int? _fontSize;
  int? get fontSize => _$this._fontSize;
  set fontSize(int? fontSize) => _$this._fontSize = fontSize;

  String? _primaryColor;
  String? get primaryColor => _$this._primaryColor;
  set primaryColor(String? primaryColor) => _$this._primaryColor = primaryColor;

  String? _secondaryColor;
  String? get secondaryColor => _$this._secondaryColor;
  set secondaryColor(String? secondaryColor) =>
      _$this._secondaryColor = secondaryColor;

  String? _primaryFont;
  String? get primaryFont => _$this._primaryFont;
  set primaryFont(String? primaryFont) => _$this._primaryFont = primaryFont;

  String? _secondaryFont;
  String? get secondaryFont => _$this._secondaryFont;
  set secondaryFont(String? secondaryFont) =>
      _$this._secondaryFont = secondaryFont;

  bool? _hidePaidToDate;
  bool? get hidePaidToDate => _$this._hidePaidToDate;
  set hidePaidToDate(bool? hidePaidToDate) =>
      _$this._hidePaidToDate = hidePaidToDate;

  bool? _embedDocuments;
  bool? get embedDocuments => _$this._embedDocuments;
  set embedDocuments(bool? embedDocuments) =>
      _$this._embedDocuments = embedDocuments;

  bool? _allPagesHeader;
  bool? get allPagesHeader => _$this._allPagesHeader;
  set allPagesHeader(bool? allPagesHeader) =>
      _$this._allPagesHeader = allPagesHeader;

  bool? _allPagesFooter;
  bool? get allPagesFooter => _$this._allPagesFooter;
  set allPagesFooter(bool? allPagesFooter) =>
      _$this._allPagesFooter = allPagesFooter;

  bool? _enableReminder1;
  bool? get enableReminder1 => _$this._enableReminder1;
  set enableReminder1(bool? enableReminder1) =>
      _$this._enableReminder1 = enableReminder1;

  bool? _enableReminder2;
  bool? get enableReminder2 => _$this._enableReminder2;
  set enableReminder2(bool? enableReminder2) =>
      _$this._enableReminder2 = enableReminder2;

  bool? _enableReminder3;
  bool? get enableReminder3 => _$this._enableReminder3;
  set enableReminder3(bool? enableReminder3) =>
      _$this._enableReminder3 = enableReminder3;

  bool? _enableReminderEndless;
  bool? get enableReminderEndless => _$this._enableReminderEndless;
  set enableReminderEndless(bool? enableReminderEndless) =>
      _$this._enableReminderEndless = enableReminderEndless;

  int? _numDaysReminder1;
  int? get numDaysReminder1 => _$this._numDaysReminder1;
  set numDaysReminder1(int? numDaysReminder1) =>
      _$this._numDaysReminder1 = numDaysReminder1;

  int? _numDaysReminder2;
  int? get numDaysReminder2 => _$this._numDaysReminder2;
  set numDaysReminder2(int? numDaysReminder2) =>
      _$this._numDaysReminder2 = numDaysReminder2;

  int? _numDaysReminder3;
  int? get numDaysReminder3 => _$this._numDaysReminder3;
  set numDaysReminder3(int? numDaysReminder3) =>
      _$this._numDaysReminder3 = numDaysReminder3;

  String? _scheduleReminder1;
  String? get scheduleReminder1 => _$this._scheduleReminder1;
  set scheduleReminder1(String? scheduleReminder1) =>
      _$this._scheduleReminder1 = scheduleReminder1;

  String? _scheduleReminder2;
  String? get scheduleReminder2 => _$this._scheduleReminder2;
  set scheduleReminder2(String? scheduleReminder2) =>
      _$this._scheduleReminder2 = scheduleReminder2;

  String? _scheduleReminder3;
  String? get scheduleReminder3 => _$this._scheduleReminder3;
  set scheduleReminder3(String? scheduleReminder3) =>
      _$this._scheduleReminder3 = scheduleReminder3;

  String? _endlessReminderFrequencyId;
  String? get endlessReminderFrequencyId => _$this._endlessReminderFrequencyId;
  set endlessReminderFrequencyId(String? endlessReminderFrequencyId) =>
      _$this._endlessReminderFrequencyId = endlessReminderFrequencyId;

  double? _lateFeeAmount1;
  double? get lateFeeAmount1 => _$this._lateFeeAmount1;
  set lateFeeAmount1(double? lateFeeAmount1) =>
      _$this._lateFeeAmount1 = lateFeeAmount1;

  double? _lateFeeAmount2;
  double? get lateFeeAmount2 => _$this._lateFeeAmount2;
  set lateFeeAmount2(double? lateFeeAmount2) =>
      _$this._lateFeeAmount2 = lateFeeAmount2;

  double? _lateFeeAmount3;
  double? get lateFeeAmount3 => _$this._lateFeeAmount3;
  set lateFeeAmount3(double? lateFeeAmount3) =>
      _$this._lateFeeAmount3 = lateFeeAmount3;

  double? _lateFeeAmountEndless;
  double? get lateFeeAmountEndless => _$this._lateFeeAmountEndless;
  set lateFeeAmountEndless(double? lateFeeAmountEndless) =>
      _$this._lateFeeAmountEndless = lateFeeAmountEndless;

  double? _lateFeePercent1;
  double? get lateFeePercent1 => _$this._lateFeePercent1;
  set lateFeePercent1(double? lateFeePercent1) =>
      _$this._lateFeePercent1 = lateFeePercent1;

  double? _lateFeePercent2;
  double? get lateFeePercent2 => _$this._lateFeePercent2;
  set lateFeePercent2(double? lateFeePercent2) =>
      _$this._lateFeePercent2 = lateFeePercent2;

  double? _lateFeePercent3;
  double? get lateFeePercent3 => _$this._lateFeePercent3;
  set lateFeePercent3(double? lateFeePercent3) =>
      _$this._lateFeePercent3 = lateFeePercent3;

  double? _lateFeePercentEndless;
  double? get lateFeePercentEndless => _$this._lateFeePercentEndless;
  set lateFeePercentEndless(double? lateFeePercentEndless) =>
      _$this._lateFeePercentEndless = lateFeePercentEndless;

  String? _emailSubjectReminderEndless;
  String? get emailSubjectReminderEndless =>
      _$this._emailSubjectReminderEndless;
  set emailSubjectReminderEndless(String? emailSubjectReminderEndless) =>
      _$this._emailSubjectReminderEndless = emailSubjectReminderEndless;

  String? _emailBodyReminderEndless;
  String? get emailBodyReminderEndless => _$this._emailBodyReminderEndless;
  set emailBodyReminderEndless(String? emailBodyReminderEndless) =>
      _$this._emailBodyReminderEndless = emailBodyReminderEndless;

  bool? _clientOnlinePaymentNotification;
  bool? get clientOnlinePaymentNotification =>
      _$this._clientOnlinePaymentNotification;
  set clientOnlinePaymentNotification(bool? clientOnlinePaymentNotification) =>
      _$this._clientOnlinePaymentNotification = clientOnlinePaymentNotification;

  bool? _clientManualPaymentNotification;
  bool? get clientManualPaymentNotification =>
      _$this._clientManualPaymentNotification;
  set clientManualPaymentNotification(bool? clientManualPaymentNotification) =>
      _$this._clientManualPaymentNotification = clientManualPaymentNotification;

  bool? _clientMarkPaidPaymentNotification;
  bool? get clientMarkPaidPaymentNotification =>
      _$this._clientMarkPaidPaymentNotification;
  set clientMarkPaidPaymentNotification(
          bool? clientMarkPaidPaymentNotification) =>
      _$this._clientMarkPaidPaymentNotification =
          clientMarkPaidPaymentNotification;

  String? _counterNumberApplied;
  String? get counterNumberApplied => _$this._counterNumberApplied;
  set counterNumberApplied(String? counterNumberApplied) =>
      _$this._counterNumberApplied = counterNumberApplied;

  String? _emailSendingMethod;
  String? get emailSendingMethod => _$this._emailSendingMethod;
  set emailSendingMethod(String? emailSendingMethod) =>
      _$this._emailSendingMethod = emailSendingMethod;

  String? _gmailSendingUserId;
  String? get gmailSendingUserId => _$this._gmailSendingUserId;
  set gmailSendingUserId(String? gmailSendingUserId) =>
      _$this._gmailSendingUserId = gmailSendingUserId;

  String? _clientPortalTerms;
  String? get clientPortalTerms => _$this._clientPortalTerms;
  set clientPortalTerms(String? clientPortalTerms) =>
      _$this._clientPortalTerms = clientPortalTerms;

  String? _clientPortalPrivacy;
  String? get clientPortalPrivacy => _$this._clientPortalPrivacy;
  set clientPortalPrivacy(String? clientPortalPrivacy) =>
      _$this._clientPortalPrivacy = clientPortalPrivacy;

  String? _lockInvoices;
  String? get lockInvoices => _$this._lockInvoices;
  set lockInvoices(String? lockInvoices) => _$this._lockInvoices = lockInvoices;

  String? _autoBill;
  String? get autoBill => _$this._autoBill;
  set autoBill(String? autoBill) => _$this._autoBill = autoBill;

  bool? _autoBillStandardInvoices;
  bool? get autoBillStandardInvoices => _$this._autoBillStandardInvoices;
  set autoBillStandardInvoices(bool? autoBillStandardInvoices) =>
      _$this._autoBillStandardInvoices = autoBillStandardInvoices;

  bool? _clientPortalAllowUnderPayment;
  bool? get clientPortalAllowUnderPayment =>
      _$this._clientPortalAllowUnderPayment;
  set clientPortalAllowUnderPayment(bool? clientPortalAllowUnderPayment) =>
      _$this._clientPortalAllowUnderPayment = clientPortalAllowUnderPayment;

  bool? _clientPortalAllowOverPayment;
  bool? get clientPortalAllowOverPayment =>
      _$this._clientPortalAllowOverPayment;
  set clientPortalAllowOverPayment(bool? clientPortalAllowOverPayment) =>
      _$this._clientPortalAllowOverPayment = clientPortalAllowOverPayment;

  String? _autoBillDate;
  String? get autoBillDate => _$this._autoBillDate;
  set autoBillDate(String? autoBillDate) => _$this._autoBillDate = autoBillDate;

  double? _clientPortalUnderPaymentMinimum;
  double? get clientPortalUnderPaymentMinimum =>
      _$this._clientPortalUnderPaymentMinimum;
  set clientPortalUnderPaymentMinimum(
          double? clientPortalUnderPaymentMinimum) =>
      _$this._clientPortalUnderPaymentMinimum = clientPortalUnderPaymentMinimum;

  String? _useCreditsPayment;
  String? get useCreditsPayment => _$this._useCreditsPayment;
  set useCreditsPayment(String? useCreditsPayment) =>
      _$this._useCreditsPayment = useCreditsPayment;

  String? _clientPortalCustomHeader;
  String? get clientPortalCustomHeader => _$this._clientPortalCustomHeader;
  set clientPortalCustomHeader(String? clientPortalCustomHeader) =>
      _$this._clientPortalCustomHeader = clientPortalCustomHeader;

  String? _clientPortalCustomCss;
  String? get clientPortalCustomCss => _$this._clientPortalCustomCss;
  set clientPortalCustomCss(String? clientPortalCustomCss) =>
      _$this._clientPortalCustomCss = clientPortalCustomCss;

  String? _clientPortalCustomFooter;
  String? get clientPortalCustomFooter => _$this._clientPortalCustomFooter;
  set clientPortalCustomFooter(String? clientPortalCustomFooter) =>
      _$this._clientPortalCustomFooter = clientPortalCustomFooter;

  String? _clientPortalCustomJs;
  String? get clientPortalCustomJs => _$this._clientPortalCustomJs;
  set clientPortalCustomJs(String? clientPortalCustomJs) =>
      _$this._clientPortalCustomJs = clientPortalCustomJs;

  bool? _hideEmptyColumnsOnPdf;
  bool? get hideEmptyColumnsOnPdf => _$this._hideEmptyColumnsOnPdf;
  set hideEmptyColumnsOnPdf(bool? hideEmptyColumnsOnPdf) =>
      _$this._hideEmptyColumnsOnPdf = hideEmptyColumnsOnPdf;

  int? _entitySendTime;
  int? get entitySendTime => _$this._entitySendTime;
  set entitySendTime(int? entitySendTime) =>
      _$this._entitySendTime = entitySendTime;

  String? _clientPortalTasks;
  String? get clientPortalTasks => _$this._clientPortalTasks;
  set clientPortalTasks(String? clientPortalTasks) =>
      _$this._clientPortalTasks = clientPortalTasks;

  bool? _pageNumbering;
  bool? get pageNumbering => _$this._pageNumbering;
  set pageNumbering(bool? pageNumbering) =>
      _$this._pageNumbering = pageNumbering;

  String? _pageNumberingAlignment;
  String? get pageNumberingAlignment => _$this._pageNumberingAlignment;
  set pageNumberingAlignment(String? pageNumberingAlignment) =>
      _$this._pageNumberingAlignment = pageNumberingAlignment;

  bool? _requirePurchaseOrderSignature;
  bool? get requirePurchaseOrderSignature =>
      _$this._requirePurchaseOrderSignature;
  set requirePurchaseOrderSignature(bool? requirePurchaseOrderSignature) =>
      _$this._requirePurchaseOrderSignature = requirePurchaseOrderSignature;

  String? _defaultPurchaseOrderTerms;
  String? get defaultPurchaseOrderTerms => _$this._defaultPurchaseOrderTerms;
  set defaultPurchaseOrderTerms(String? defaultPurchaseOrderTerms) =>
      _$this._defaultPurchaseOrderTerms = defaultPurchaseOrderTerms;

  String? _defaultPurchaseOrderDesignId;
  String? get defaultPurchaseOrderDesignId =>
      _$this._defaultPurchaseOrderDesignId;
  set defaultPurchaseOrderDesignId(String? defaultPurchaseOrderDesignId) =>
      _$this._defaultPurchaseOrderDesignId = defaultPurchaseOrderDesignId;

  String? _defaultPurchaseOrderFooter;
  String? get defaultPurchaseOrderFooter => _$this._defaultPurchaseOrderFooter;
  set defaultPurchaseOrderFooter(String? defaultPurchaseOrderFooter) =>
      _$this._defaultPurchaseOrderFooter = defaultPurchaseOrderFooter;

  String? _purchaseOrderNumberPattern;
  String? get purchaseOrderNumberPattern => _$this._purchaseOrderNumberPattern;
  set purchaseOrderNumberPattern(String? purchaseOrderNumberPattern) =>
      _$this._purchaseOrderNumberPattern = purchaseOrderNumberPattern;

  int? _purchaseOrderNumberCounter;
  int? get purchaseOrderNumberCounter => _$this._purchaseOrderNumberCounter;
  set purchaseOrderNumberCounter(int? purchaseOrderNumberCounter) =>
      _$this._purchaseOrderNumberCounter = purchaseOrderNumberCounter;

  String? _qrIban;
  String? get qrIban => _$this._qrIban;
  set qrIban(String? qrIban) => _$this._qrIban = qrIban;

  String? _besrId;
  String? get besrId => _$this._besrId;
  set besrId(String? besrId) => _$this._besrId = besrId;

  String? _postmarkSecret;
  String? get postmarkSecret => _$this._postmarkSecret;
  set postmarkSecret(String? postmarkSecret) =>
      _$this._postmarkSecret = postmarkSecret;

  String? _mailgunSecret;
  String? get mailgunSecret => _$this._mailgunSecret;
  set mailgunSecret(String? mailgunSecret) =>
      _$this._mailgunSecret = mailgunSecret;

  String? _mailgunDomain;
  String? get mailgunDomain => _$this._mailgunDomain;
  set mailgunDomain(String? mailgunDomain) =>
      _$this._mailgunDomain = mailgunDomain;

  String? _mailgunEndpoint;
  String? get mailgunEndpoint => _$this._mailgunEndpoint;
  set mailgunEndpoint(String? mailgunEndpoint) =>
      _$this._mailgunEndpoint = mailgunEndpoint;

  String? _emailAlignment;
  String? get emailAlignment => _$this._emailAlignment;
  set emailAlignment(String? emailAlignment) =>
      _$this._emailAlignment = emailAlignment;

  bool? _showEmailFooter;
  bool? get showEmailFooter => _$this._showEmailFooter;
  set showEmailFooter(bool? showEmailFooter) =>
      _$this._showEmailFooter = showEmailFooter;

  String? _companyLogoSize;
  String? get companyLogoSize => _$this._companyLogoSize;
  set companyLogoSize(String? companyLogoSize) =>
      _$this._companyLogoSize = companyLogoSize;

  bool? _showPaidStamp;
  bool? get showPaidStamp => _$this._showPaidStamp;
  set showPaidStamp(bool? showPaidStamp) =>
      _$this._showPaidStamp = showPaidStamp;

  bool? _showShippingAddress;
  bool? get showShippingAddress => _$this._showShippingAddress;
  set showShippingAddress(bool? showShippingAddress) =>
      _$this._showShippingAddress = showShippingAddress;

  String? _customSendingEmail;
  String? get customSendingEmail => _$this._customSendingEmail;
  set customSendingEmail(String? customSendingEmail) =>
      _$this._customSendingEmail = customSendingEmail;

  bool? _acceptPurchaseOrderNumber;
  bool? get acceptPurchaseOrderNumber => _$this._acceptPurchaseOrderNumber;
  set acceptPurchaseOrderNumber(bool? acceptPurchaseOrderNumber) =>
      _$this._acceptPurchaseOrderNumber = acceptPurchaseOrderNumber;

  bool? _clientInitiatedPayments;
  bool? get clientInitiatedPayments => _$this._clientInitiatedPayments;
  set clientInitiatedPayments(bool? clientInitiatedPayments) =>
      _$this._clientInitiatedPayments = clientInitiatedPayments;

  double? _clientInitiatedPaymentsMinimum;
  double? get clientInitiatedPaymentsMinimum =>
      _$this._clientInitiatedPaymentsMinimum;
  set clientInitiatedPaymentsMinimum(double? clientInitiatedPaymentsMinimum) =>
      _$this._clientInitiatedPaymentsMinimum = clientInitiatedPaymentsMinimum;

  bool? _shareInvoiceQuoteColumns;
  bool? get shareInvoiceQuoteColumns => _$this._shareInvoiceQuoteColumns;
  set shareInvoiceQuoteColumns(bool? shareInvoiceQuoteColumns) =>
      _$this._shareInvoiceQuoteColumns = shareInvoiceQuoteColumns;

  bool? _allowBillableTaskItems;
  bool? get allowBillableTaskItems => _$this._allowBillableTaskItems;
  set allowBillableTaskItems(bool? allowBillableTaskItems) =>
      _$this._allowBillableTaskItems = allowBillableTaskItems;

  bool? _showTaskItemDescription;
  bool? get showTaskItemDescription => _$this._showTaskItemDescription;
  set showTaskItemDescription(bool? showTaskItemDescription) =>
      _$this._showTaskItemDescription = showTaskItemDescription;

  bool? _enableEInvoice;
  bool? get enableEInvoice => _$this._enableEInvoice;
  set enableEInvoice(bool? enableEInvoice) =>
      _$this._enableEInvoice = enableEInvoice;

  String? _eInvoiceType;
  String? get eInvoiceType => _$this._eInvoiceType;
  set eInvoiceType(String? eInvoiceType) => _$this._eInvoiceType = eInvoiceType;

  String? _defaultExpensePaymentTypeId;
  String? get defaultExpensePaymentTypeId =>
      _$this._defaultExpensePaymentTypeId;
  set defaultExpensePaymentTypeId(String? defaultExpensePaymentTypeId) =>
      _$this._defaultExpensePaymentTypeId = defaultExpensePaymentTypeId;

  String? _classification;
  String? get classification => _$this._classification;
  set classification(String? classification) =>
      _$this._classification = classification;

  bool? _paymentEmailAllContacts;
  bool? get paymentEmailAllContacts => _$this._paymentEmailAllContacts;
  set paymentEmailAllContacts(bool? paymentEmailAllContacts) =>
      _$this._paymentEmailAllContacts = paymentEmailAllContacts;

  bool? _showPdfhtmlOnMobile;
  bool? get showPdfhtmlOnMobile => _$this._showPdfhtmlOnMobile;
  set showPdfhtmlOnMobile(bool? showPdfhtmlOnMobile) =>
      _$this._showPdfhtmlOnMobile = showPdfhtmlOnMobile;

  String? _useUnappliedPayment;
  String? get useUnappliedPayment => _$this._useUnappliedPayment;
  set useUnappliedPayment(String? useUnappliedPayment) =>
      _$this._useUnappliedPayment = useUnappliedPayment;

  SettingsEntityBuilder();

  SettingsEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _timezoneId = $v.timezoneId;
      _dateFormatId = $v.dateFormatId;
      _enableMilitaryTime = $v.enableMilitaryTime;
      _languageId = $v.languageId;
      _showCurrencyCode = $v.showCurrencyCode;
      _currencyId = $v.currencyId;
      _customValue1 = $v.customValue1;
      _customValue2 = $v.customValue2;
      _customValue3 = $v.customValue3;
      _customValue4 = $v.customValue4;
      _defaultPaymentTerms = $v.defaultPaymentTerms;
      _defaultValidUntil = $v.defaultValidUntil;
      _companyGatewayIds = $v.companyGatewayIds;
      _defaultTaskRate = $v.defaultTaskRate;
      _sendReminders = $v.sendReminders;
      _enablePortal = $v.enablePortal;
      _enablePortalDashboard = $v.enablePortalDashboard;
      _enablePortalTasks = $v.enablePortalTasks;
      _enableClientPortalUploads = $v.enableClientPortalUploads;
      _enableVendorPortalUploads = $v.enableVendorPortalUploads;
      _emailStyle = $v.emailStyle;
      _replyToEmail = $v.replyToEmail;
      _replyToName = $v.replyToName;
      _emailFromName = $v.emailFromName;
      _bccEmail = $v.bccEmail;
      _pdfEmailAttachment = $v.pdfEmailAttachment;
      _ublEmailAttachment = $v.ublEmailAttachment;
      _documentEmailAttachment = $v.documentEmailAttachment;
      _emailStyleCustom = $v.emailStyleCustom;
      _customMessageDashboard = $v.customMessageDashboard;
      _customMessageUnpaidInvoice = $v.customMessageUnpaidInvoice;
      _customMessagePaidInvoice = $v.customMessagePaidInvoice;
      _customMessageUnapprovedQuote = $v.customMessageUnapprovedQuote;
      _autoArchiveInvoice = $v.autoArchiveInvoice;
      _autoArchiveInvoiceCancelled = $v.autoArchiveInvoiceCancelled;
      _autoArchiveQuote = $v.autoArchiveQuote;
      _autoEmailInvoice = $v.autoEmailInvoice;
      _autoConvertQuote = $v.autoConvertQuote;
      _enableInclusiveTaxes = $v.enableInclusiveTaxes;
      _translations = $v.translations?.toBuilder();
      _taskNumberPattern = $v.taskNumberPattern;
      _taskNumberCounter = $v.taskNumberCounter;
      _expenseNumberPattern = $v.expenseNumberPattern;
      _expenseNumberCounter = $v.expenseNumberCounter;
      _recurringExpenseNumberPattern = $v.recurringExpenseNumberPattern;
      _recurringExpenseNumberCounter = $v.recurringExpenseNumberCounter;
      _vendorNumberPattern = $v.vendorNumberPattern;
      _vendorNumberCounter = $v.vendorNumberCounter;
      _ticketNumberPattern = $v.ticketNumberPattern;
      _ticketNumberCounter = $v.ticketNumberCounter;
      _paymentNumberPattern = $v.paymentNumberPattern;
      _paymentNumberCounter = $v.paymentNumberCounter;
      _projectNumberPattern = $v.projectNumberPattern;
      _projectNumberCounter = $v.projectNumberCounter;
      _invoiceNumberPattern = $v.invoiceNumberPattern;
      _invoiceNumberCounter = $v.invoiceNumberCounter;
      _recurringInvoiceNumberPattern = $v.recurringInvoiceNumberPattern;
      _recurringInvoiceNumberCounter = $v.recurringInvoiceNumberCounter;
      _quoteNumberPattern = $v.quoteNumberPattern;
      _quoteNumberCounter = $v.quoteNumberCounter;
      _clientNumberPattern = $v.clientNumberPattern;
      _clientNumberCounter = $v.clientNumberCounter;
      _creditNumberPattern = $v.creditNumberPattern;
      _creditNumberCounter = $v.creditNumberCounter;
      _recurringNumberPrefix = $v.recurringNumberPrefix;
      _resetCounterFrequencyId = $v.resetCounterFrequencyId;
      _resetCounterDate = $v.resetCounterDate;
      _counterPadding = $v.counterPadding;
      _sharedInvoiceQuoteCounter = $v.sharedInvoiceQuoteCounter;
      _sharedInvoiceCreditCounter = $v.sharedInvoiceCreditCounter;
      _defaultInvoiceTerms = $v.defaultInvoiceTerms;
      _defaultQuoteTerms = $v.defaultQuoteTerms;
      _defaultQuoteFooter = $v.defaultQuoteFooter;
      _defaultCreditTerms = $v.defaultCreditTerms;
      _defaultCreditFooter = $v.defaultCreditFooter;
      _defaultInvoiceDesignId = $v.defaultInvoiceDesignId;
      _defaultQuoteDesignId = $v.defaultQuoteDesignId;
      _defaultCreditDesignId = $v.defaultCreditDesignId;
      _defaultDeliveryNoteDesignId = $v.defaultDeliveryNoteDesignId;
      _defaultStatementDesignId = $v.defaultStatementDesignId;
      _defaultPaymentReceiptDesignId = $v.defaultPaymentReceiptDesignId;
      _defaultPaymentRefundDesignId = $v.defaultPaymentRefundDesignId;
      _defaultInvoiceFooter = $v.defaultInvoiceFooter;
      _defaultTaxName1 = $v.defaultTaxName1;
      _defaultTaxRate1 = $v.defaultTaxRate1;
      _defaultTaxName2 = $v.defaultTaxName2;
      _defaultTaxRate2 = $v.defaultTaxRate2;
      _defaultTaxName3 = $v.defaultTaxName3;
      _defaultTaxRate3 = $v.defaultTaxRate3;
      _defaultPaymentTypeId = $v.defaultPaymentTypeId;
      _pdfVariables = $v.pdfVariables?.toBuilder();
      _emailSignature = $v.emailSignature;
      _emailSubjectInvoice = $v.emailSubjectInvoice;
      _emailSubjectQuote = $v.emailSubjectQuote;
      _emailSubjectCredit = $v.emailSubjectCredit;
      _emailSubjectPayment = $v.emailSubjectPayment;
      _emailSubjectPaymentPartial = $v.emailSubjectPaymentPartial;
      _emailBodyInvoice = $v.emailBodyInvoice;
      _emailBodyQuote = $v.emailBodyQuote;
      _emailBodyCredit = $v.emailBodyCredit;
      _emailBodyPayment = $v.emailBodyPayment;
      _emailBodyPaymentPartial = $v.emailBodyPaymentPartial;
      _emailSubjectReminder1 = $v.emailSubjectReminder1;
      _emailSubjectReminder2 = $v.emailSubjectReminder2;
      _emailSubjectReminder3 = $v.emailSubjectReminder3;
      _emailBodyReminder1 = $v.emailBodyReminder1;
      _emailBodyReminder2 = $v.emailBodyReminder2;
      _emailBodyReminder3 = $v.emailBodyReminder3;
      _emailSubjectCustom1 = $v.emailSubjectCustom1;
      _emailBodyCustom1 = $v.emailBodyCustom1;
      _emailSubjectCustom2 = $v.emailSubjectCustom2;
      _emailBodyCustom2 = $v.emailBodyCustom2;
      _emailSubjectCustom3 = $v.emailSubjectCustom3;
      _emailBodyCustom3 = $v.emailBodyCustom3;
      _emailSubjectStatement = $v.emailSubjectStatement;
      _emailBodyStatement = $v.emailBodyStatement;
      _emailSubjectPurchaseOrder = $v.emailSubjectPurchaseOrder;
      _emailBodyPurchaseOrder = $v.emailBodyPurchaseOrder;
      _enablePortalPassword = $v.enablePortalPassword;
      _signatureOnPdf = $v.signatureOnPdf;
      _enableEmailMarkup = $v.enableEmailMarkup;
      _showAcceptInvoiceTerms = $v.showAcceptInvoiceTerms;
      _showAcceptQuoteTerms = $v.showAcceptQuoteTerms;
      _requireInvoiceSignature = $v.requireInvoiceSignature;
      _requireQuoteSignature = $v.requireQuoteSignature;
      _name = $v.name;
      _companyLogo = $v.companyLogo;
      _website = $v.website;
      _address1 = $v.address1;
      _address2 = $v.address2;
      _city = $v.city;
      _state = $v.state;
      _postalCode = $v.postalCode;
      _phone = $v.phone;
      _email = $v.email;
      _countryId = $v.countryId;
      _vatNumber = $v.vatNumber;
      _idNumber = $v.idNumber;
      _pageSize = $v.pageSize;
      _pageLayout = $v.pageLayout;
      _fontSize = $v.fontSize;
      _primaryColor = $v.primaryColor;
      _secondaryColor = $v.secondaryColor;
      _primaryFont = $v.primaryFont;
      _secondaryFont = $v.secondaryFont;
      _hidePaidToDate = $v.hidePaidToDate;
      _embedDocuments = $v.embedDocuments;
      _allPagesHeader = $v.allPagesHeader;
      _allPagesFooter = $v.allPagesFooter;
      _enableReminder1 = $v.enableReminder1;
      _enableReminder2 = $v.enableReminder2;
      _enableReminder3 = $v.enableReminder3;
      _enableReminderEndless = $v.enableReminderEndless;
      _numDaysReminder1 = $v.numDaysReminder1;
      _numDaysReminder2 = $v.numDaysReminder2;
      _numDaysReminder3 = $v.numDaysReminder3;
      _scheduleReminder1 = $v.scheduleReminder1;
      _scheduleReminder2 = $v.scheduleReminder2;
      _scheduleReminder3 = $v.scheduleReminder3;
      _endlessReminderFrequencyId = $v.endlessReminderFrequencyId;
      _lateFeeAmount1 = $v.lateFeeAmount1;
      _lateFeeAmount2 = $v.lateFeeAmount2;
      _lateFeeAmount3 = $v.lateFeeAmount3;
      _lateFeeAmountEndless = $v.lateFeeAmountEndless;
      _lateFeePercent1 = $v.lateFeePercent1;
      _lateFeePercent2 = $v.lateFeePercent2;
      _lateFeePercent3 = $v.lateFeePercent3;
      _lateFeePercentEndless = $v.lateFeePercentEndless;
      _emailSubjectReminderEndless = $v.emailSubjectReminderEndless;
      _emailBodyReminderEndless = $v.emailBodyReminderEndless;
      _clientOnlinePaymentNotification = $v.clientOnlinePaymentNotification;
      _clientManualPaymentNotification = $v.clientManualPaymentNotification;
      _clientMarkPaidPaymentNotification = $v.clientMarkPaidPaymentNotification;
      _counterNumberApplied = $v.counterNumberApplied;
      _emailSendingMethod = $v.emailSendingMethod;
      _gmailSendingUserId = $v.gmailSendingUserId;
      _clientPortalTerms = $v.clientPortalTerms;
      _clientPortalPrivacy = $v.clientPortalPrivacy;
      _lockInvoices = $v.lockInvoices;
      _autoBill = $v.autoBill;
      _autoBillStandardInvoices = $v.autoBillStandardInvoices;
      _clientPortalAllowUnderPayment = $v.clientPortalAllowUnderPayment;
      _clientPortalAllowOverPayment = $v.clientPortalAllowOverPayment;
      _autoBillDate = $v.autoBillDate;
      _clientPortalUnderPaymentMinimum = $v.clientPortalUnderPaymentMinimum;
      _useCreditsPayment = $v.useCreditsPayment;
      _clientPortalCustomHeader = $v.clientPortalCustomHeader;
      _clientPortalCustomCss = $v.clientPortalCustomCss;
      _clientPortalCustomFooter = $v.clientPortalCustomFooter;
      _clientPortalCustomJs = $v.clientPortalCustomJs;
      _hideEmptyColumnsOnPdf = $v.hideEmptyColumnsOnPdf;
      _entitySendTime = $v.entitySendTime;
      _clientPortalTasks = $v.clientPortalTasks;
      _pageNumbering = $v.pageNumbering;
      _pageNumberingAlignment = $v.pageNumberingAlignment;
      _requirePurchaseOrderSignature = $v.requirePurchaseOrderSignature;
      _defaultPurchaseOrderTerms = $v.defaultPurchaseOrderTerms;
      _defaultPurchaseOrderDesignId = $v.defaultPurchaseOrderDesignId;
      _defaultPurchaseOrderFooter = $v.defaultPurchaseOrderFooter;
      _purchaseOrderNumberPattern = $v.purchaseOrderNumberPattern;
      _purchaseOrderNumberCounter = $v.purchaseOrderNumberCounter;
      _qrIban = $v.qrIban;
      _besrId = $v.besrId;
      _postmarkSecret = $v.postmarkSecret;
      _mailgunSecret = $v.mailgunSecret;
      _mailgunDomain = $v.mailgunDomain;
      _mailgunEndpoint = $v.mailgunEndpoint;
      _emailAlignment = $v.emailAlignment;
      _showEmailFooter = $v.showEmailFooter;
      _companyLogoSize = $v.companyLogoSize;
      _showPaidStamp = $v.showPaidStamp;
      _showShippingAddress = $v.showShippingAddress;
      _customSendingEmail = $v.customSendingEmail;
      _acceptPurchaseOrderNumber = $v.acceptPurchaseOrderNumber;
      _clientInitiatedPayments = $v.clientInitiatedPayments;
      _clientInitiatedPaymentsMinimum = $v.clientInitiatedPaymentsMinimum;
      _shareInvoiceQuoteColumns = $v.shareInvoiceQuoteColumns;
      _allowBillableTaskItems = $v.allowBillableTaskItems;
      _showTaskItemDescription = $v.showTaskItemDescription;
      _enableEInvoice = $v.enableEInvoice;
      _eInvoiceType = $v.eInvoiceType;
      _defaultExpensePaymentTypeId = $v.defaultExpensePaymentTypeId;
      _classification = $v.classification;
      _paymentEmailAllContacts = $v.paymentEmailAllContacts;
      _showPdfhtmlOnMobile = $v.showPdfhtmlOnMobile;
      _useUnappliedPayment = $v.useUnappliedPayment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SettingsEntity;
  }

  @override
  void update(void Function(SettingsEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SettingsEntity build() => _build();

  _$SettingsEntity _build() {
    _$SettingsEntity _$result;
    try {
      _$result = _$v ??
          new _$SettingsEntity._(
              timezoneId: timezoneId,
              dateFormatId: dateFormatId,
              enableMilitaryTime: enableMilitaryTime,
              languageId: languageId,
              showCurrencyCode: showCurrencyCode,
              currencyId: currencyId,
              customValue1: customValue1,
              customValue2: customValue2,
              customValue3: customValue3,
              customValue4: customValue4,
              defaultPaymentTerms: defaultPaymentTerms,
              defaultValidUntil: defaultValidUntil,
              companyGatewayIds: companyGatewayIds,
              defaultTaskRate: defaultTaskRate,
              sendReminders: sendReminders,
              enablePortal: enablePortal,
              enablePortalDashboard: enablePortalDashboard,
              enablePortalTasks: enablePortalTasks,
              enableClientPortalUploads: enableClientPortalUploads,
              enableVendorPortalUploads: enableVendorPortalUploads,
              emailStyle: emailStyle,
              replyToEmail: replyToEmail,
              replyToName: replyToName,
              emailFromName: emailFromName,
              bccEmail: bccEmail,
              pdfEmailAttachment: pdfEmailAttachment,
              ublEmailAttachment: ublEmailAttachment,
              documentEmailAttachment: documentEmailAttachment,
              emailStyleCustom: emailStyleCustom,
              customMessageDashboard: customMessageDashboard,
              customMessageUnpaidInvoice: customMessageUnpaidInvoice,
              customMessagePaidInvoice: customMessagePaidInvoice,
              customMessageUnapprovedQuote: customMessageUnapprovedQuote,
              autoArchiveInvoice: autoArchiveInvoice,
              autoArchiveInvoiceCancelled: autoArchiveInvoiceCancelled,
              autoArchiveQuote: autoArchiveQuote,
              autoEmailInvoice: autoEmailInvoice,
              autoConvertQuote: autoConvertQuote,
              enableInclusiveTaxes: enableInclusiveTaxes,
              translations: _translations?.build(),
              taskNumberPattern: taskNumberPattern,
              taskNumberCounter: taskNumberCounter,
              expenseNumberPattern: expenseNumberPattern,
              expenseNumberCounter: expenseNumberCounter,
              recurringExpenseNumberPattern: recurringExpenseNumberPattern,
              recurringExpenseNumberCounter: recurringExpenseNumberCounter,
              vendorNumberPattern: vendorNumberPattern,
              vendorNumberCounter: vendorNumberCounter,
              ticketNumberPattern: ticketNumberPattern,
              ticketNumberCounter: ticketNumberCounter,
              paymentNumberPattern: paymentNumberPattern,
              paymentNumberCounter: paymentNumberCounter,
              projectNumberPattern: projectNumberPattern,
              projectNumberCounter: projectNumberCounter,
              invoiceNumberPattern: invoiceNumberPattern,
              invoiceNumberCounter: invoiceNumberCounter,
              recurringInvoiceNumberPattern: recurringInvoiceNumberPattern,
              recurringInvoiceNumberCounter: recurringInvoiceNumberCounter,
              quoteNumberPattern: quoteNumberPattern,
              quoteNumberCounter: quoteNumberCounter,
              clientNumberPattern: clientNumberPattern,
              clientNumberCounter: clientNumberCounter,
              creditNumberPattern: creditNumberPattern,
              creditNumberCounter: creditNumberCounter,
              recurringNumberPrefix: recurringNumberPrefix,
              resetCounterFrequencyId: resetCounterFrequencyId,
              resetCounterDate: resetCounterDate,
              counterPadding: counterPadding,
              sharedInvoiceQuoteCounter: sharedInvoiceQuoteCounter,
              sharedInvoiceCreditCounter: sharedInvoiceCreditCounter,
              defaultInvoiceTerms: defaultInvoiceTerms,
              defaultQuoteTerms: defaultQuoteTerms,
              defaultQuoteFooter: defaultQuoteFooter,
              defaultCreditTerms: defaultCreditTerms,
              defaultCreditFooter: defaultCreditFooter,
              defaultInvoiceDesignId: defaultInvoiceDesignId,
              defaultQuoteDesignId: defaultQuoteDesignId,
              defaultCreditDesignId: defaultCreditDesignId,
              defaultDeliveryNoteDesignId: defaultDeliveryNoteDesignId,
              defaultStatementDesignId: defaultStatementDesignId,
              defaultPaymentReceiptDesignId: defaultPaymentReceiptDesignId,
              defaultPaymentRefundDesignId: defaultPaymentRefundDesignId,
              defaultInvoiceFooter: defaultInvoiceFooter,
              defaultTaxName1: defaultTaxName1,
              defaultTaxRate1: defaultTaxRate1,
              defaultTaxName2: defaultTaxName2,
              defaultTaxRate2: defaultTaxRate2,
              defaultTaxName3: defaultTaxName3,
              defaultTaxRate3: defaultTaxRate3,
              defaultPaymentTypeId: defaultPaymentTypeId,
              pdfVariables: _pdfVariables?.build(),
              emailSignature: emailSignature,
              emailSubjectInvoice: emailSubjectInvoice,
              emailSubjectQuote: emailSubjectQuote,
              emailSubjectCredit: emailSubjectCredit,
              emailSubjectPayment: emailSubjectPayment,
              emailSubjectPaymentPartial: emailSubjectPaymentPartial,
              emailBodyInvoice: emailBodyInvoice,
              emailBodyQuote: emailBodyQuote,
              emailBodyCredit: emailBodyCredit,
              emailBodyPayment: emailBodyPayment,
              emailBodyPaymentPartial: emailBodyPaymentPartial,
              emailSubjectReminder1: emailSubjectReminder1,
              emailSubjectReminder2: emailSubjectReminder2,
              emailSubjectReminder3: emailSubjectReminder3,
              emailBodyReminder1: emailBodyReminder1,
              emailBodyReminder2: emailBodyReminder2,
              emailBodyReminder3: emailBodyReminder3,
              emailSubjectCustom1: emailSubjectCustom1,
              emailBodyCustom1: emailBodyCustom1,
              emailSubjectCustom2: emailSubjectCustom2,
              emailBodyCustom2: emailBodyCustom2,
              emailSubjectCustom3: emailSubjectCustom3,
              emailBodyCustom3: emailBodyCustom3,
              emailSubjectStatement: emailSubjectStatement,
              emailBodyStatement: emailBodyStatement,
              emailSubjectPurchaseOrder: emailSubjectPurchaseOrder,
              emailBodyPurchaseOrder: emailBodyPurchaseOrder,
              enablePortalPassword: enablePortalPassword,
              signatureOnPdf: signatureOnPdf,
              enableEmailMarkup: enableEmailMarkup,
              showAcceptInvoiceTerms: showAcceptInvoiceTerms,
              showAcceptQuoteTerms: showAcceptQuoteTerms,
              requireInvoiceSignature: requireInvoiceSignature,
              requireQuoteSignature: requireQuoteSignature,
              name: name,
              companyLogo: companyLogo,
              website: website,
              address1: address1,
              address2: address2,
              city: city,
              state: state,
              postalCode: postalCode,
              phone: phone,
              email: email,
              countryId: countryId,
              vatNumber: vatNumber,
              idNumber: idNumber,
              pageSize: pageSize,
              pageLayout: pageLayout,
              fontSize: fontSize,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
              primaryFont: primaryFont,
              secondaryFont: secondaryFont,
              hidePaidToDate: hidePaidToDate,
              embedDocuments: embedDocuments,
              allPagesHeader: allPagesHeader,
              allPagesFooter: allPagesFooter,
              enableReminder1: enableReminder1,
              enableReminder2: enableReminder2,
              enableReminder3: enableReminder3,
              enableReminderEndless: enableReminderEndless,
              numDaysReminder1: numDaysReminder1,
              numDaysReminder2: numDaysReminder2,
              numDaysReminder3: numDaysReminder3,
              scheduleReminder1: scheduleReminder1,
              scheduleReminder2: scheduleReminder2,
              scheduleReminder3: scheduleReminder3,
              endlessReminderFrequencyId: endlessReminderFrequencyId,
              lateFeeAmount1: lateFeeAmount1,
              lateFeeAmount2: lateFeeAmount2,
              lateFeeAmount3: lateFeeAmount3,
              lateFeeAmountEndless: lateFeeAmountEndless,
              lateFeePercent1: lateFeePercent1,
              lateFeePercent2: lateFeePercent2,
              lateFeePercent3: lateFeePercent3,
              lateFeePercentEndless: lateFeePercentEndless,
              emailSubjectReminderEndless: emailSubjectReminderEndless,
              emailBodyReminderEndless: emailBodyReminderEndless,
              clientOnlinePaymentNotification: clientOnlinePaymentNotification,
              clientManualPaymentNotification: clientManualPaymentNotification,
              clientMarkPaidPaymentNotification:
                  clientMarkPaidPaymentNotification,
              counterNumberApplied: counterNumberApplied,
              emailSendingMethod: emailSendingMethod,
              gmailSendingUserId: gmailSendingUserId,
              clientPortalTerms: clientPortalTerms,
              clientPortalPrivacy: clientPortalPrivacy,
              lockInvoices: lockInvoices,
              autoBill: autoBill,
              autoBillStandardInvoices: autoBillStandardInvoices,
              clientPortalAllowUnderPayment: clientPortalAllowUnderPayment,
              clientPortalAllowOverPayment: clientPortalAllowOverPayment,
              autoBillDate: autoBillDate,
              clientPortalUnderPaymentMinimum: clientPortalUnderPaymentMinimum,
              useCreditsPayment: useCreditsPayment,
              clientPortalCustomHeader: clientPortalCustomHeader,
              clientPortalCustomCss: clientPortalCustomCss,
              clientPortalCustomFooter: clientPortalCustomFooter,
              clientPortalCustomJs: clientPortalCustomJs,
              hideEmptyColumnsOnPdf: hideEmptyColumnsOnPdf,
              entitySendTime: entitySendTime,
              clientPortalTasks: clientPortalTasks,
              pageNumbering: pageNumbering,
              pageNumberingAlignment: pageNumberingAlignment,
              requirePurchaseOrderSignature: requirePurchaseOrderSignature,
              defaultPurchaseOrderTerms: defaultPurchaseOrderTerms,
              defaultPurchaseOrderDesignId: defaultPurchaseOrderDesignId,
              defaultPurchaseOrderFooter: defaultPurchaseOrderFooter,
              purchaseOrderNumberPattern: purchaseOrderNumberPattern,
              purchaseOrderNumberCounter: purchaseOrderNumberCounter,
              qrIban: qrIban,
              besrId: besrId,
              postmarkSecret: postmarkSecret,
              mailgunSecret: mailgunSecret,
              mailgunDomain: mailgunDomain,
              mailgunEndpoint: mailgunEndpoint,
              emailAlignment: emailAlignment,
              showEmailFooter: showEmailFooter,
              companyLogoSize: companyLogoSize,
              showPaidStamp: showPaidStamp,
              showShippingAddress: showShippingAddress,
              customSendingEmail: customSendingEmail,
              acceptPurchaseOrderNumber: acceptPurchaseOrderNumber,
              clientInitiatedPayments: clientInitiatedPayments,
              clientInitiatedPaymentsMinimum: clientInitiatedPaymentsMinimum,
              shareInvoiceQuoteColumns: shareInvoiceQuoteColumns,
              allowBillableTaskItems: allowBillableTaskItems,
              showTaskItemDescription: showTaskItemDescription,
              enableEInvoice: enableEInvoice,
              eInvoiceType: eInvoiceType,
              defaultExpensePaymentTypeId: defaultExpensePaymentTypeId,
              classification: classification,
              paymentEmailAllContacts: paymentEmailAllContacts,
              showPdfhtmlOnMobile: showPdfhtmlOnMobile,
              useUnappliedPayment: useUnappliedPayment);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'translations';
        _translations?.build();

        _$failedField = 'pdfVariables';
        _pdfVariables?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SettingsEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PdfPreviewRequest extends PdfPreviewRequest {
  @override
  final String entityType;
  @override
  final String settingsType;
  @override
  final SettingsEntity settings;
  @override
  final String groupId;
  @override
  final String clientId;

  factory _$PdfPreviewRequest(
          [void Function(PdfPreviewRequestBuilder)? updates]) =>
      (new PdfPreviewRequestBuilder()..update(updates))._build();

  _$PdfPreviewRequest._(
      {required this.entityType,
      required this.settingsType,
      required this.settings,
      required this.groupId,
      required this.clientId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        entityType, r'PdfPreviewRequest', 'entityType');
    BuiltValueNullFieldError.checkNotNull(
        settingsType, r'PdfPreviewRequest', 'settingsType');
    BuiltValueNullFieldError.checkNotNull(
        settings, r'PdfPreviewRequest', 'settings');
    BuiltValueNullFieldError.checkNotNull(
        groupId, r'PdfPreviewRequest', 'groupId');
    BuiltValueNullFieldError.checkNotNull(
        clientId, r'PdfPreviewRequest', 'clientId');
  }

  @override
  PdfPreviewRequest rebuild(void Function(PdfPreviewRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PdfPreviewRequestBuilder toBuilder() =>
      new PdfPreviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PdfPreviewRequest &&
        entityType == other.entityType &&
        settingsType == other.settingsType &&
        settings == other.settings &&
        groupId == other.groupId &&
        clientId == other.clientId;
  }

  int? __hashCode;
  @override
  int get hashCode {
    if (__hashCode != null) return __hashCode!;
    var _$hash = 0;
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, settingsType.hashCode);
    _$hash = $jc(_$hash, settings.hashCode);
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jf(_$hash);
    return __hashCode ??= _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PdfPreviewRequest')
          ..add('entityType', entityType)
          ..add('settingsType', settingsType)
          ..add('settings', settings)
          ..add('groupId', groupId)
          ..add('clientId', clientId))
        .toString();
  }
}

class PdfPreviewRequestBuilder
    implements Builder<PdfPreviewRequest, PdfPreviewRequestBuilder> {
  _$PdfPreviewRequest? _$v;

  String? _entityType;
  String? get entityType => _$this._entityType;
  set entityType(String? entityType) => _$this._entityType = entityType;

  String? _settingsType;
  String? get settingsType => _$this._settingsType;
  set settingsType(String? settingsType) => _$this._settingsType = settingsType;

  SettingsEntityBuilder? _settings;
  SettingsEntityBuilder get settings =>
      _$this._settings ??= new SettingsEntityBuilder();
  set settings(SettingsEntityBuilder? settings) => _$this._settings = settings;

  String? _groupId;
  String? get groupId => _$this._groupId;
  set groupId(String? groupId) => _$this._groupId = groupId;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  PdfPreviewRequestBuilder();

  PdfPreviewRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _entityType = $v.entityType;
      _settingsType = $v.settingsType;
      _settings = $v.settings.toBuilder();
      _groupId = $v.groupId;
      _clientId = $v.clientId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PdfPreviewRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PdfPreviewRequest;
  }

  @override
  void update(void Function(PdfPreviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PdfPreviewRequest build() => _build();

  _$PdfPreviewRequest _build() {
    _$PdfPreviewRequest _$result;
    try {
      _$result = _$v ??
          new _$PdfPreviewRequest._(
              entityType: BuiltValueNullFieldError.checkNotNull(
                  entityType, r'PdfPreviewRequest', 'entityType'),
              settingsType: BuiltValueNullFieldError.checkNotNull(
                  settingsType, r'PdfPreviewRequest', 'settingsType'),
              settings: settings.build(),
              groupId: BuiltValueNullFieldError.checkNotNull(
                  groupId, r'PdfPreviewRequest', 'groupId'),
              clientId: BuiltValueNullFieldError.checkNotNull(
                  clientId, r'PdfPreviewRequest', 'clientId'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'settings';
        settings.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PdfPreviewRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
