// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SettingsEntity> _$settingsEntitySerializer =
    new _$SettingsEntitySerializer();

class _$SettingsEntitySerializer
    implements StructuredSerializer<SettingsEntity> {
  @override
  final Iterable<Type> types = const [SettingsEntity, _$SettingsEntity];
  @override
  final String wireName = 'SettingsEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, SettingsEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.timezoneId != null) {
      result
        ..add('timezone_id')
        ..add(serializers.serialize(object.timezoneId,
            specifiedType: const FullType(String)));
    }
    if (object.dateFormatId != null) {
      result
        ..add('date_format_id')
        ..add(serializers.serialize(object.dateFormatId,
            specifiedType: const FullType(String)));
    }
    if (object.enableMilitaryTime != null) {
      result
        ..add('military_time')
        ..add(serializers.serialize(object.enableMilitaryTime,
            specifiedType: const FullType(bool)));
    }
    if (object.languageId != null) {
      result
        ..add('language_id')
        ..add(serializers.serialize(object.languageId,
            specifiedType: const FullType(String)));
    }
    if (object.showCurrencyCode != null) {
      result
        ..add('show_currency_code')
        ..add(serializers.serialize(object.showCurrencyCode,
            specifiedType: const FullType(bool)));
    }
    if (object.currencyId != null) {
      result
        ..add('currency_id')
        ..add(serializers.serialize(object.currencyId,
            specifiedType: const FullType(String)));
    }
    if (object.customValue1 != null) {
      result
        ..add('custom_value1')
        ..add(serializers.serialize(object.customValue1,
            specifiedType: const FullType(String)));
    }
    if (object.customValue2 != null) {
      result
        ..add('custom_value2')
        ..add(serializers.serialize(object.customValue2,
            specifiedType: const FullType(String)));
    }
    if (object.customValue3 != null) {
      result
        ..add('custom_value3')
        ..add(serializers.serialize(object.customValue3,
            specifiedType: const FullType(String)));
    }
    if (object.customValue4 != null) {
      result
        ..add('custom_value4')
        ..add(serializers.serialize(object.customValue4,
            specifiedType: const FullType(String)));
    }
    if (object.defaultPaymentTerms != null) {
      result
        ..add('payment_terms')
        ..add(serializers.serialize(object.defaultPaymentTerms,
            specifiedType: const FullType(String)));
    }
    if (object.defaultValidUntil != null) {
      result
        ..add('valid_until')
        ..add(serializers.serialize(object.defaultValidUntil,
            specifiedType: const FullType(String)));
    }
    if (object.companyGatewayIds != null) {
      result
        ..add('company_gateway_ids')
        ..add(serializers.serialize(object.companyGatewayIds,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaskRate != null) {
      result
        ..add('default_task_rate')
        ..add(serializers.serialize(object.defaultTaskRate,
            specifiedType: const FullType(double)));
    }
    if (object.sendReminders != null) {
      result
        ..add('send_reminders')
        ..add(serializers.serialize(object.sendReminders,
            specifiedType: const FullType(bool)));
    }
    if (object.enablePortal != null) {
      result
        ..add('enable_client_portal')
        ..add(serializers.serialize(object.enablePortal,
            specifiedType: const FullType(bool)));
    }
    if (object.enablePortalDashboard != null) {
      result
        ..add('enable_client_portal_dashboard')
        ..add(serializers.serialize(object.enablePortalDashboard,
            specifiedType: const FullType(bool)));
    }
    if (object.enablePortalTasks != null) {
      result
        ..add('enable_client_portal_tasks')
        ..add(serializers.serialize(object.enablePortalTasks,
            specifiedType: const FullType(bool)));
    }
    if (object.enablePortalUploads != null) {
      result
        ..add('client_portal_enable_uploads')
        ..add(serializers.serialize(object.enablePortalUploads,
            specifiedType: const FullType(bool)));
    }
    if (object.emailStyle != null) {
      result
        ..add('email_style')
        ..add(serializers.serialize(object.emailStyle,
            specifiedType: const FullType(String)));
    }
    if (object.replyToEmail != null) {
      result
        ..add('reply_to_email')
        ..add(serializers.serialize(object.replyToEmail,
            specifiedType: const FullType(String)));
    }
    if (object.replyToName != null) {
      result
        ..add('reply_to_name')
        ..add(serializers.serialize(object.replyToName,
            specifiedType: const FullType(String)));
    }
    if (object.bccEmail != null) {
      result
        ..add('bcc_email')
        ..add(serializers.serialize(object.bccEmail,
            specifiedType: const FullType(String)));
    }
    if (object.pdfEmailAttachment != null) {
      result
        ..add('pdf_email_attachment')
        ..add(serializers.serialize(object.pdfEmailAttachment,
            specifiedType: const FullType(bool)));
    }
    if (object.ublEmailAttachment != null) {
      result
        ..add('ubl_email_attachment')
        ..add(serializers.serialize(object.ublEmailAttachment,
            specifiedType: const FullType(bool)));
    }
    if (object.documentEmailAttachment != null) {
      result
        ..add('document_email_attachment')
        ..add(serializers.serialize(object.documentEmailAttachment,
            specifiedType: const FullType(bool)));
    }
    if (object.emailStyleCustom != null) {
      result
        ..add('email_style_custom')
        ..add(serializers.serialize(object.emailStyleCustom,
            specifiedType: const FullType(String)));
    }
    if (object.customMessageDashboard != null) {
      result
        ..add('custom_message_dashboard')
        ..add(serializers.serialize(object.customMessageDashboard,
            specifiedType: const FullType(String)));
    }
    if (object.customMessageUnpaidInvoice != null) {
      result
        ..add('custom_message_unpaid_invoice')
        ..add(serializers.serialize(object.customMessageUnpaidInvoice,
            specifiedType: const FullType(String)));
    }
    if (object.customMessagePaidInvoice != null) {
      result
        ..add('custom_message_paid_invoice')
        ..add(serializers.serialize(object.customMessagePaidInvoice,
            specifiedType: const FullType(String)));
    }
    if (object.customMessageUnapprovedQuote != null) {
      result
        ..add('custom_message_unapproved_quote')
        ..add(serializers.serialize(object.customMessageUnapprovedQuote,
            specifiedType: const FullType(String)));
    }
    if (object.autoArchiveInvoice != null) {
      result
        ..add('auto_archive_invoice')
        ..add(serializers.serialize(object.autoArchiveInvoice,
            specifiedType: const FullType(bool)));
    }
    if (object.autoArchiveQuote != null) {
      result
        ..add('auto_archive_quote')
        ..add(serializers.serialize(object.autoArchiveQuote,
            specifiedType: const FullType(bool)));
    }
    if (object.autoEmailInvoice != null) {
      result
        ..add('auto_email_invoice')
        ..add(serializers.serialize(object.autoEmailInvoice,
            specifiedType: const FullType(bool)));
    }
    if (object.autoConvertQuote != null) {
      result
        ..add('auto_convert_quote')
        ..add(serializers.serialize(object.autoConvertQuote,
            specifiedType: const FullType(bool)));
    }
    if (object.enableInclusiveTaxes != null) {
      result
        ..add('inclusive_taxes')
        ..add(serializers.serialize(object.enableInclusiveTaxes,
            specifiedType: const FullType(bool)));
    }
    if (object.translations != null) {
      result
        ..add('translations')
        ..add(serializers.serialize(object.translations,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(String)])));
    }
    if (object.taskNumberPattern != null) {
      result
        ..add('task_number_pattern')
        ..add(serializers.serialize(object.taskNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.taskNumberCounter != null) {
      result
        ..add('task_number_counter')
        ..add(serializers.serialize(object.taskNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.expenseNumberPattern != null) {
      result
        ..add('expense_number_pattern')
        ..add(serializers.serialize(object.expenseNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.expenseNumberCounter != null) {
      result
        ..add('expense_number_counter')
        ..add(serializers.serialize(object.expenseNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.vendorNumberPattern != null) {
      result
        ..add('vendor_number_pattern')
        ..add(serializers.serialize(object.vendorNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.vendorNumberCounter != null) {
      result
        ..add('vendor_number_counter')
        ..add(serializers.serialize(object.vendorNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.ticketNumberPattern != null) {
      result
        ..add('ticket_number_pattern')
        ..add(serializers.serialize(object.ticketNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.ticketNumberCounter != null) {
      result
        ..add('ticket_number_counter')
        ..add(serializers.serialize(object.ticketNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.paymentNumberPattern != null) {
      result
        ..add('payment_number_pattern')
        ..add(serializers.serialize(object.paymentNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.paymentNumberCounter != null) {
      result
        ..add('payment_number_counter')
        ..add(serializers.serialize(object.paymentNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.projectNumberPattern != null) {
      result
        ..add('project_number_pattern')
        ..add(serializers.serialize(object.projectNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.projectNumberCounter != null) {
      result
        ..add('project_number_counter')
        ..add(serializers.serialize(object.projectNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.invoiceNumberPattern != null) {
      result
        ..add('invoice_number_pattern')
        ..add(serializers.serialize(object.invoiceNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.invoiceNumberCounter != null) {
      result
        ..add('invoice_number_counter')
        ..add(serializers.serialize(object.invoiceNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.recurringInvoiceNumberPattern != null) {
      result
        ..add('recurring_invoice_number_pattern')
        ..add(serializers.serialize(object.recurringInvoiceNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.recurringInvoiceNumberCounter != null) {
      result
        ..add('recurring_invoice_number_counter')
        ..add(serializers.serialize(object.recurringInvoiceNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.quoteNumberPattern != null) {
      result
        ..add('quote_number_pattern')
        ..add(serializers.serialize(object.quoteNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.quoteNumberCounter != null) {
      result
        ..add('quote_number_counter')
        ..add(serializers.serialize(object.quoteNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.clientNumberPattern != null) {
      result
        ..add('client_number_pattern')
        ..add(serializers.serialize(object.clientNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.clientNumberCounter != null) {
      result
        ..add('client_number_counter')
        ..add(serializers.serialize(object.clientNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.creditNumberPattern != null) {
      result
        ..add('credit_number_pattern')
        ..add(serializers.serialize(object.creditNumberPattern,
            specifiedType: const FullType(String)));
    }
    if (object.creditNumberCounter != null) {
      result
        ..add('credit_number_counter')
        ..add(serializers.serialize(object.creditNumberCounter,
            specifiedType: const FullType(int)));
    }
    if (object.recurringNumberPrefix != null) {
      result
        ..add('recurring_number_prefix')
        ..add(serializers.serialize(object.recurringNumberPrefix,
            specifiedType: const FullType(String)));
    }
    if (object.resetCounterFrequencyId != null) {
      result
        ..add('reset_counter_frequency_id')
        ..add(serializers.serialize(object.resetCounterFrequencyId,
            specifiedType: const FullType(String)));
    }
    if (object.resetCounterDate != null) {
      result
        ..add('reset_counter_date')
        ..add(serializers.serialize(object.resetCounterDate,
            specifiedType: const FullType(String)));
    }
    if (object.counterPadding != null) {
      result
        ..add('counter_padding')
        ..add(serializers.serialize(object.counterPadding,
            specifiedType: const FullType(int)));
    }
    if (object.sharedInvoiceQuoteCounter != null) {
      result
        ..add('shared_invoice_quote_counter')
        ..add(serializers.serialize(object.sharedInvoiceQuoteCounter,
            specifiedType: const FullType(bool)));
    }
    if (object.sharedInvoiceCreditCounter != null) {
      result
        ..add('shared_invoice_credit_counter')
        ..add(serializers.serialize(object.sharedInvoiceCreditCounter,
            specifiedType: const FullType(bool)));
    }
    if (object.defaultInvoiceTerms != null) {
      result
        ..add('invoice_terms')
        ..add(serializers.serialize(object.defaultInvoiceTerms,
            specifiedType: const FullType(String)));
    }
    if (object.defaultQuoteTerms != null) {
      result
        ..add('quote_terms')
        ..add(serializers.serialize(object.defaultQuoteTerms,
            specifiedType: const FullType(String)));
    }
    if (object.defaultQuoteFooter != null) {
      result
        ..add('quote_footer')
        ..add(serializers.serialize(object.defaultQuoteFooter,
            specifiedType: const FullType(String)));
    }
    if (object.defaultCreditTerms != null) {
      result
        ..add('credit_terms')
        ..add(serializers.serialize(object.defaultCreditTerms,
            specifiedType: const FullType(String)));
    }
    if (object.defaultCreditFooter != null) {
      result
        ..add('credit_footer')
        ..add(serializers.serialize(object.defaultCreditFooter,
            specifiedType: const FullType(String)));
    }
    if (object.defaultInvoiceDesignId != null) {
      result
        ..add('invoice_design_id')
        ..add(serializers.serialize(object.defaultInvoiceDesignId,
            specifiedType: const FullType(String)));
    }
    if (object.defaultQuoteDesignId != null) {
      result
        ..add('quote_design_id')
        ..add(serializers.serialize(object.defaultQuoteDesignId,
            specifiedType: const FullType(String)));
    }
    if (object.defaultCreditDesignId != null) {
      result
        ..add('credit_design_id')
        ..add(serializers.serialize(object.defaultCreditDesignId,
            specifiedType: const FullType(String)));
    }
    if (object.defaultInvoiceFooter != null) {
      result
        ..add('invoice_footer')
        ..add(serializers.serialize(object.defaultInvoiceFooter,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaxName1 != null) {
      result
        ..add('tax_name1')
        ..add(serializers.serialize(object.defaultTaxName1,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaxRate1 != null) {
      result
        ..add('tax_rate1')
        ..add(serializers.serialize(object.defaultTaxRate1,
            specifiedType: const FullType(double)));
    }
    if (object.defaultTaxName2 != null) {
      result
        ..add('tax_name2')
        ..add(serializers.serialize(object.defaultTaxName2,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaxRate2 != null) {
      result
        ..add('tax_rate2')
        ..add(serializers.serialize(object.defaultTaxRate2,
            specifiedType: const FullType(double)));
    }
    if (object.defaultTaxName3 != null) {
      result
        ..add('tax_name3')
        ..add(serializers.serialize(object.defaultTaxName3,
            specifiedType: const FullType(String)));
    }
    if (object.defaultTaxRate3 != null) {
      result
        ..add('tax_rate3')
        ..add(serializers.serialize(object.defaultTaxRate3,
            specifiedType: const FullType(double)));
    }
    if (object.defaultPaymentTypeId != null) {
      result
        ..add('payment_type_id')
        ..add(serializers.serialize(object.defaultPaymentTypeId,
            specifiedType: const FullType(String)));
    }
    if (object.pdfVariables != null) {
      result
        ..add('pdf_variables')
        ..add(serializers.serialize(object.pdfVariables,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(BuiltList, const [const FullType(String)])
            ])));
    }
    if (object.emailSignature != null) {
      result
        ..add('email_signature')
        ..add(serializers.serialize(object.emailSignature,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectInvoice != null) {
      result
        ..add('email_subject_invoice')
        ..add(serializers.serialize(object.emailSubjectInvoice,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectQuote != null) {
      result
        ..add('email_subject_quote')
        ..add(serializers.serialize(object.emailSubjectQuote,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectCredit != null) {
      result
        ..add('email_subject_credit')
        ..add(serializers.serialize(object.emailSubjectCredit,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectPayment != null) {
      result
        ..add('email_subject_payment')
        ..add(serializers.serialize(object.emailSubjectPayment,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectPaymentPartial != null) {
      result
        ..add('email_subject_payment_partial')
        ..add(serializers.serialize(object.emailSubjectPaymentPartial,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyInvoice != null) {
      result
        ..add('email_template_invoice')
        ..add(serializers.serialize(object.emailBodyInvoice,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyQuote != null) {
      result
        ..add('email_template_quote')
        ..add(serializers.serialize(object.emailBodyQuote,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyCredit != null) {
      result
        ..add('email_template_credit')
        ..add(serializers.serialize(object.emailBodyCredit,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyPayment != null) {
      result
        ..add('email_template_payment')
        ..add(serializers.serialize(object.emailBodyPayment,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyPaymentPartial != null) {
      result
        ..add('email_template_payment_partial')
        ..add(serializers.serialize(object.emailBodyPaymentPartial,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectReminder1 != null) {
      result
        ..add('email_subject_reminder1')
        ..add(serializers.serialize(object.emailSubjectReminder1,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectReminder2 != null) {
      result
        ..add('email_subject_reminder2')
        ..add(serializers.serialize(object.emailSubjectReminder2,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectReminder3 != null) {
      result
        ..add('email_subject_reminder3')
        ..add(serializers.serialize(object.emailSubjectReminder3,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyReminder1 != null) {
      result
        ..add('email_template_reminder1')
        ..add(serializers.serialize(object.emailBodyReminder1,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyReminder2 != null) {
      result
        ..add('email_template_reminder2')
        ..add(serializers.serialize(object.emailBodyReminder2,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyReminder3 != null) {
      result
        ..add('email_template_reminder3')
        ..add(serializers.serialize(object.emailBodyReminder3,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectCustom1 != null) {
      result
        ..add('email_subject_custom1')
        ..add(serializers.serialize(object.emailSubjectCustom1,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyCustom1 != null) {
      result
        ..add('email_template_custom1')
        ..add(serializers.serialize(object.emailBodyCustom1,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectCustom2 != null) {
      result
        ..add('email_subject_custom2')
        ..add(serializers.serialize(object.emailSubjectCustom2,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyCustom2 != null) {
      result
        ..add('email_template_custom2')
        ..add(serializers.serialize(object.emailBodyCustom2,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectCustom3 != null) {
      result
        ..add('email_subject_custom3')
        ..add(serializers.serialize(object.emailSubjectCustom3,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyCustom3 != null) {
      result
        ..add('email_template_custom3')
        ..add(serializers.serialize(object.emailBodyCustom3,
            specifiedType: const FullType(String)));
    }
    if (object.emailSubjectStatement != null) {
      result
        ..add('email_subject_statement')
        ..add(serializers.serialize(object.emailSubjectStatement,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyStatement != null) {
      result
        ..add('email_template_statement')
        ..add(serializers.serialize(object.emailBodyStatement,
            specifiedType: const FullType(String)));
    }
    if (object.enablePortalPassword != null) {
      result
        ..add('enable_client_portal_password')
        ..add(serializers.serialize(object.enablePortalPassword,
            specifiedType: const FullType(bool)));
    }
    if (object.signatureOnPdf != null) {
      result
        ..add('signature_on_pdf')
        ..add(serializers.serialize(object.signatureOnPdf,
            specifiedType: const FullType(bool)));
    }
    if (object.enableEmailMarkup != null) {
      result
        ..add('enable_email_markup')
        ..add(serializers.serialize(object.enableEmailMarkup,
            specifiedType: const FullType(bool)));
    }
    if (object.showAcceptInvoiceTerms != null) {
      result
        ..add('show_accept_invoice_terms')
        ..add(serializers.serialize(object.showAcceptInvoiceTerms,
            specifiedType: const FullType(bool)));
    }
    if (object.showAcceptQuoteTerms != null) {
      result
        ..add('show_accept_quote_terms')
        ..add(serializers.serialize(object.showAcceptQuoteTerms,
            specifiedType: const FullType(bool)));
    }
    if (object.requireInvoiceSignature != null) {
      result
        ..add('require_invoice_signature')
        ..add(serializers.serialize(object.requireInvoiceSignature,
            specifiedType: const FullType(bool)));
    }
    if (object.requireQuoteSignature != null) {
      result
        ..add('require_quote_signature')
        ..add(serializers.serialize(object.requireQuoteSignature,
            specifiedType: const FullType(bool)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.companyLogo != null) {
      result
        ..add('company_logo')
        ..add(serializers.serialize(object.companyLogo,
            specifiedType: const FullType(String)));
    }
    if (object.website != null) {
      result
        ..add('website')
        ..add(serializers.serialize(object.website,
            specifiedType: const FullType(String)));
    }
    if (object.address1 != null) {
      result
        ..add('address1')
        ..add(serializers.serialize(object.address1,
            specifiedType: const FullType(String)));
    }
    if (object.address2 != null) {
      result
        ..add('address2')
        ..add(serializers.serialize(object.address2,
            specifiedType: const FullType(String)));
    }
    if (object.city != null) {
      result
        ..add('city')
        ..add(serializers.serialize(object.city,
            specifiedType: const FullType(String)));
    }
    if (object.state != null) {
      result
        ..add('state')
        ..add(serializers.serialize(object.state,
            specifiedType: const FullType(String)));
    }
    if (object.postalCode != null) {
      result
        ..add('postal_code')
        ..add(serializers.serialize(object.postalCode,
            specifiedType: const FullType(String)));
    }
    if (object.phone != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(object.phone,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.countryId != null) {
      result
        ..add('country_id')
        ..add(serializers.serialize(object.countryId,
            specifiedType: const FullType(String)));
    }
    if (object.vatNumber != null) {
      result
        ..add('vat_number')
        ..add(serializers.serialize(object.vatNumber,
            specifiedType: const FullType(String)));
    }
    if (object.idNumber != null) {
      result
        ..add('id_number')
        ..add(serializers.serialize(object.idNumber,
            specifiedType: const FullType(String)));
    }
    if (object.pageSize != null) {
      result
        ..add('page_size')
        ..add(serializers.serialize(object.pageSize,
            specifiedType: const FullType(String)));
    }
    if (object.pageLayout != null) {
      result
        ..add('page_layout')
        ..add(serializers.serialize(object.pageLayout,
            specifiedType: const FullType(String)));
    }
    if (object.fontSize != null) {
      result
        ..add('font_size')
        ..add(serializers.serialize(object.fontSize,
            specifiedType: const FullType(int)));
    }
    if (object.primaryColor != null) {
      result
        ..add('primary_color')
        ..add(serializers.serialize(object.primaryColor,
            specifiedType: const FullType(String)));
    }
    if (object.secondaryColor != null) {
      result
        ..add('secondary_color')
        ..add(serializers.serialize(object.secondaryColor,
            specifiedType: const FullType(String)));
    }
    if (object.primaryFont != null) {
      result
        ..add('primary_font')
        ..add(serializers.serialize(object.primaryFont,
            specifiedType: const FullType(String)));
    }
    if (object.secondaryFont != null) {
      result
        ..add('secondary_font')
        ..add(serializers.serialize(object.secondaryFont,
            specifiedType: const FullType(String)));
    }
    if (object.hidePaidToDate != null) {
      result
        ..add('hide_paid_to_date')
        ..add(serializers.serialize(object.hidePaidToDate,
            specifiedType: const FullType(bool)));
    }
    if (object.embedDocuments != null) {
      result
        ..add('embed_documents')
        ..add(serializers.serialize(object.embedDocuments,
            specifiedType: const FullType(bool)));
    }
    if (object.allPagesHeader != null) {
      result
        ..add('all_pages_header')
        ..add(serializers.serialize(object.allPagesHeader,
            specifiedType: const FullType(bool)));
    }
    if (object.allPagesFooter != null) {
      result
        ..add('all_pages_footer')
        ..add(serializers.serialize(object.allPagesFooter,
            specifiedType: const FullType(bool)));
    }
    if (object.enableReminder1 != null) {
      result
        ..add('enable_reminder1')
        ..add(serializers.serialize(object.enableReminder1,
            specifiedType: const FullType(bool)));
    }
    if (object.enableReminder2 != null) {
      result
        ..add('enable_reminder2')
        ..add(serializers.serialize(object.enableReminder2,
            specifiedType: const FullType(bool)));
    }
    if (object.enableReminder3 != null) {
      result
        ..add('enable_reminder3')
        ..add(serializers.serialize(object.enableReminder3,
            specifiedType: const FullType(bool)));
    }
    if (object.enableReminderEndless != null) {
      result
        ..add('enable_reminder_endless')
        ..add(serializers.serialize(object.enableReminderEndless,
            specifiedType: const FullType(bool)));
    }
    if (object.numDaysReminder1 != null) {
      result
        ..add('num_days_reminder1')
        ..add(serializers.serialize(object.numDaysReminder1,
            specifiedType: const FullType(int)));
    }
    if (object.numDaysReminder2 != null) {
      result
        ..add('num_days_reminder2')
        ..add(serializers.serialize(object.numDaysReminder2,
            specifiedType: const FullType(int)));
    }
    if (object.numDaysReminder3 != null) {
      result
        ..add('num_days_reminder3')
        ..add(serializers.serialize(object.numDaysReminder3,
            specifiedType: const FullType(int)));
    }
    if (object.scheduleReminder1 != null) {
      result
        ..add('schedule_reminder1')
        ..add(serializers.serialize(object.scheduleReminder1,
            specifiedType: const FullType(String)));
    }
    if (object.scheduleReminder2 != null) {
      result
        ..add('schedule_reminder2')
        ..add(serializers.serialize(object.scheduleReminder2,
            specifiedType: const FullType(String)));
    }
    if (object.scheduleReminder3 != null) {
      result
        ..add('schedule_reminder3')
        ..add(serializers.serialize(object.scheduleReminder3,
            specifiedType: const FullType(String)));
    }
    if (object.endlessReminderFrequencyId != null) {
      result
        ..add('endless_reminder_frequency_id')
        ..add(serializers.serialize(object.endlessReminderFrequencyId,
            specifiedType: const FullType(String)));
    }
    if (object.lateFeeAmount1 != null) {
      result
        ..add('late_fee_amount1')
        ..add(serializers.serialize(object.lateFeeAmount1,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeeAmount2 != null) {
      result
        ..add('late_fee_amount2')
        ..add(serializers.serialize(object.lateFeeAmount2,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeeAmount3 != null) {
      result
        ..add('late_fee_amount3')
        ..add(serializers.serialize(object.lateFeeAmount3,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeeAmountEndless != null) {
      result
        ..add('late_fee_endless_amount')
        ..add(serializers.serialize(object.lateFeeAmountEndless,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeePercent1 != null) {
      result
        ..add('late_fee_percent1')
        ..add(serializers.serialize(object.lateFeePercent1,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeePercent2 != null) {
      result
        ..add('late_fee_percent2')
        ..add(serializers.serialize(object.lateFeePercent2,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeePercent3 != null) {
      result
        ..add('late_fee_percent3')
        ..add(serializers.serialize(object.lateFeePercent3,
            specifiedType: const FullType(double)));
    }
    if (object.lateFeePercentEndless != null) {
      result
        ..add('late_fee_endless_percent')
        ..add(serializers.serialize(object.lateFeePercentEndless,
            specifiedType: const FullType(double)));
    }
    if (object.emailSubjectReminderEndless != null) {
      result
        ..add('email_subject_reminder_endless')
        ..add(serializers.serialize(object.emailSubjectReminderEndless,
            specifiedType: const FullType(String)));
    }
    if (object.emailBodyReminderEndless != null) {
      result
        ..add('email_template_reminder_endless')
        ..add(serializers.serialize(object.emailBodyReminderEndless,
            specifiedType: const FullType(String)));
    }
    if (object.clientOnlinePaymentNotification != null) {
      result
        ..add('client_online_payment_notification')
        ..add(serializers.serialize(object.clientOnlinePaymentNotification,
            specifiedType: const FullType(bool)));
    }
    if (object.clientManualPaymentNotification != null) {
      result
        ..add('client_manual_payment_notification')
        ..add(serializers.serialize(object.clientManualPaymentNotification,
            specifiedType: const FullType(bool)));
    }
    if (object.counterNumberApplied != null) {
      result
        ..add('counter_number_applied')
        ..add(serializers.serialize(object.counterNumberApplied,
            specifiedType: const FullType(String)));
    }
    if (object.emailSendingMethod != null) {
      result
        ..add('email_sending_method')
        ..add(serializers.serialize(object.emailSendingMethod,
            specifiedType: const FullType(String)));
    }
    if (object.gmailSendingUserId != null) {
      result
        ..add('gmail_sending_user_id')
        ..add(serializers.serialize(object.gmailSendingUserId,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalTerms != null) {
      result
        ..add('client_portal_terms')
        ..add(serializers.serialize(object.clientPortalTerms,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalPrivacy != null) {
      result
        ..add('client_portal_privacy_policy')
        ..add(serializers.serialize(object.clientPortalPrivacy,
            specifiedType: const FullType(String)));
    }
    if (object.lockInvoices != null) {
      result
        ..add('lock_invoices')
        ..add(serializers.serialize(object.lockInvoices,
            specifiedType: const FullType(String)));
    }
    if (object.autoBill != null) {
      result
        ..add('auto_bill')
        ..add(serializers.serialize(object.autoBill,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalAllowUnderPayment != null) {
      result
        ..add('client_portal_allow_under_payment')
        ..add(serializers.serialize(object.clientPortalAllowUnderPayment,
            specifiedType: const FullType(bool)));
    }
    if (object.clientPortalAllowOverPayment != null) {
      result
        ..add('client_portal_allow_over_payment')
        ..add(serializers.serialize(object.clientPortalAllowOverPayment,
            specifiedType: const FullType(bool)));
    }
    if (object.autoBillDate != null) {
      result
        ..add('auto_bill_date')
        ..add(serializers.serialize(object.autoBillDate,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalUnderPaymentMinimum != null) {
      result
        ..add('client_portal_under_payment_minimum')
        ..add(serializers.serialize(object.clientPortalUnderPaymentMinimum,
            specifiedType: const FullType(double)));
    }
    if (object.useCreditsPayment != null) {
      result
        ..add('use_credits_payment')
        ..add(serializers.serialize(object.useCreditsPayment,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalCustomHeader != null) {
      result
        ..add('portal_custom_head')
        ..add(serializers.serialize(object.clientPortalCustomHeader,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalCustomCss != null) {
      result
        ..add('portal_custom_css')
        ..add(serializers.serialize(object.clientPortalCustomCss,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalCustomFooter != null) {
      result
        ..add('portal_custom_footer')
        ..add(serializers.serialize(object.clientPortalCustomFooter,
            specifiedType: const FullType(String)));
    }
    if (object.clientPortalCustomJs != null) {
      result
        ..add('portal_custom_js')
        ..add(serializers.serialize(object.clientPortalCustomJs,
            specifiedType: const FullType(String)));
    }
    if (object.hideEmptyColumnsOnPdf != null) {
      result
        ..add('hide_empty_columns_on_pdf')
        ..add(serializers.serialize(object.hideEmptyColumnsOnPdf,
            specifiedType: const FullType(bool)));
    }
    if (object.entitySendTime != null) {
      result
        ..add('entity_send_time')
        ..add(serializers.serialize(object.entitySendTime,
            specifiedType: const FullType(bool)));
    }
    if (object.hasCustomDesign1 != null) {
      result
        ..add('has_custom_design1_HIDDEN')
        ..add(serializers.serialize(object.hasCustomDesign1,
            specifiedType: const FullType(bool)));
    }
    if (object.hasCustomDesign2 != null) {
      result
        ..add('has_custom_design2_HIDDEN')
        ..add(serializers.serialize(object.hasCustomDesign2,
            specifiedType: const FullType(bool)));
    }
    if (object.hasCustomDesign3 != null) {
      result
        ..add('has_custom_design3_HIDDEN')
        ..add(serializers.serialize(object.hasCustomDesign3,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  SettingsEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingsEntityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'timezone_id':
          result.timezoneId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date_format_id':
          result.dateFormatId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'military_time':
          result.enableMilitaryTime = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'language_id':
          result.languageId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'show_currency_code':
          result.showCurrencyCode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'currency_id':
          result.currencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value1':
          result.customValue1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value2':
          result.customValue2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value3':
          result.customValue3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_value4':
          result.customValue4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_terms':
          result.defaultPaymentTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'valid_until':
          result.defaultValidUntil = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'company_gateway_ids':
          result.companyGatewayIds = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'default_task_rate':
          result.defaultTaskRate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'send_reminders':
          result.sendReminders = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_client_portal':
          result.enablePortal = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_client_portal_dashboard':
          result.enablePortalDashboard = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_client_portal_tasks':
          result.enablePortalTasks = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'client_portal_enable_uploads':
          result.enablePortalUploads = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'email_style':
          result.emailStyle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reply_to_email':
          result.replyToEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reply_to_name':
          result.replyToName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bcc_email':
          result.bccEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pdf_email_attachment':
          result.pdfEmailAttachment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'ubl_email_attachment':
          result.ublEmailAttachment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'document_email_attachment':
          result.documentEmailAttachment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'email_style_custom':
          result.emailStyleCustom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_message_dashboard':
          result.customMessageDashboard = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_message_unpaid_invoice':
          result.customMessageUnpaidInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_message_paid_invoice':
          result.customMessagePaidInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'custom_message_unapproved_quote':
          result.customMessageUnapprovedQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'auto_archive_invoice':
          result.autoArchiveInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_archive_quote':
          result.autoArchiveQuote = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_email_invoice':
          result.autoEmailInvoice = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_convert_quote':
          result.autoConvertQuote = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'inclusive_taxes':
          result.enableInclusiveTaxes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'translations':
          result.translations.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
        case 'task_number_pattern':
          result.taskNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'task_number_counter':
          result.taskNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'expense_number_pattern':
          result.expenseNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expense_number_counter':
          result.expenseNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'vendor_number_pattern':
          result.vendorNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vendor_number_counter':
          result.vendorNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'ticket_number_pattern':
          result.ticketNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ticket_number_counter':
          result.ticketNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'payment_number_pattern':
          result.paymentNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_number_counter':
          result.paymentNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'project_number_pattern':
          result.projectNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'project_number_counter':
          result.projectNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invoice_number_pattern':
          result.invoiceNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_number_counter':
          result.invoiceNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'recurring_invoice_number_pattern':
          result.recurringInvoiceNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'recurring_invoice_number_counter':
          result.recurringInvoiceNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'quote_number_pattern':
          result.quoteNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_number_counter':
          result.quoteNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'client_number_pattern':
          result.clientNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_number_counter':
          result.clientNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'credit_number_pattern':
          result.creditNumberPattern = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_number_counter':
          result.creditNumberCounter = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'recurring_number_prefix':
          result.recurringNumberPrefix = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reset_counter_frequency_id':
          result.resetCounterFrequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reset_counter_date':
          result.resetCounterDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'counter_padding':
          result.counterPadding = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'shared_invoice_quote_counter':
          result.sharedInvoiceQuoteCounter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'shared_invoice_credit_counter':
          result.sharedInvoiceCreditCounter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'invoice_terms':
          result.defaultInvoiceTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_terms':
          result.defaultQuoteTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_footer':
          result.defaultQuoteFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_terms':
          result.defaultCreditTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_footer':
          result.defaultCreditFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_design_id':
          result.defaultInvoiceDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quote_design_id':
          result.defaultQuoteDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'credit_design_id':
          result.defaultCreditDesignId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'invoice_footer':
          result.defaultInvoiceFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_name1':
          result.defaultTaxName1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate1':
          result.defaultTaxRate1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name2':
          result.defaultTaxName2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate2':
          result.defaultTaxRate2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tax_name3':
          result.defaultTaxName3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tax_rate3':
          result.defaultTaxRate3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'payment_type_id':
          result.defaultPaymentTypeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pdf_variables':
          result.pdfVariables.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(String)])
              ])));
          break;
        case 'email_signature':
          result.emailSignature = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_invoice':
          result.emailSubjectInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_quote':
          result.emailSubjectQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_credit':
          result.emailSubjectCredit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_payment':
          result.emailSubjectPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_payment_partial':
          result.emailSubjectPaymentPartial = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_invoice':
          result.emailBodyInvoice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_quote':
          result.emailBodyQuote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_credit':
          result.emailBodyCredit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_payment':
          result.emailBodyPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_payment_partial':
          result.emailBodyPaymentPartial = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_reminder1':
          result.emailSubjectReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_reminder2':
          result.emailSubjectReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_reminder3':
          result.emailSubjectReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder1':
          result.emailBodyReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder2':
          result.emailBodyReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder3':
          result.emailBodyReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_custom1':
          result.emailSubjectCustom1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_custom1':
          result.emailBodyCustom1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_custom2':
          result.emailSubjectCustom2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_custom2':
          result.emailBodyCustom2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_custom3':
          result.emailSubjectCustom3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_custom3':
          result.emailBodyCustom3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_subject_statement':
          result.emailSubjectStatement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_statement':
          result.emailBodyStatement = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'enable_client_portal_password':
          result.enablePortalPassword = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'signature_on_pdf':
          result.signatureOnPdf = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_email_markup':
          result.enableEmailMarkup = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'show_accept_invoice_terms':
          result.showAcceptInvoiceTerms = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'show_accept_quote_terms':
          result.showAcceptQuoteTerms = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_invoice_signature':
          result.requireInvoiceSignature = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'require_quote_signature':
          result.requireQuoteSignature = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'company_logo':
          result.companyLogo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address1':
          result.address1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address2':
          result.address2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'postal_code':
          result.postalCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country_id':
          result.countryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vat_number':
          result.vatNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id_number':
          result.idNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'page_size':
          result.pageSize = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'page_layout':
          result.pageLayout = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'font_size':
          result.fontSize = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'primary_color':
          result.primaryColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'secondary_color':
          result.secondaryColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'primary_font':
          result.primaryFont = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'secondary_font':
          result.secondaryFont = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hide_paid_to_date':
          result.hidePaidToDate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'embed_documents':
          result.embedDocuments = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'all_pages_header':
          result.allPagesHeader = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'all_pages_footer':
          result.allPagesFooter = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_reminder1':
          result.enableReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_reminder2':
          result.enableReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_reminder3':
          result.enableReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'enable_reminder_endless':
          result.enableReminderEndless = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'num_days_reminder1':
          result.numDaysReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'num_days_reminder2':
          result.numDaysReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'num_days_reminder3':
          result.numDaysReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'schedule_reminder1':
          result.scheduleReminder1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'schedule_reminder2':
          result.scheduleReminder2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'schedule_reminder3':
          result.scheduleReminder3 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'endless_reminder_frequency_id':
          result.endlessReminderFrequencyId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'late_fee_amount1':
          result.lateFeeAmount1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_amount2':
          result.lateFeeAmount2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_amount3':
          result.lateFeeAmount3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_endless_amount':
          result.lateFeeAmountEndless = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_percent1':
          result.lateFeePercent1 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_percent2':
          result.lateFeePercent2 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_percent3':
          result.lateFeePercent3 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'late_fee_endless_percent':
          result.lateFeePercentEndless = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'email_subject_reminder_endless':
          result.emailSubjectReminderEndless = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_template_reminder_endless':
          result.emailBodyReminderEndless = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_online_payment_notification':
          result.clientOnlinePaymentNotification = serializers
              .deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'client_manual_payment_notification':
          result.clientManualPaymentNotification = serializers
              .deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'counter_number_applied':
          result.counterNumberApplied = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email_sending_method':
          result.emailSendingMethod = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'gmail_sending_user_id':
          result.gmailSendingUserId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_portal_terms':
          result.clientPortalTerms = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_portal_privacy_policy':
          result.clientPortalPrivacy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lock_invoices':
          result.lockInvoices = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'auto_bill':
          result.autoBill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_portal_allow_under_payment':
          result.clientPortalAllowUnderPayment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'client_portal_allow_over_payment':
          result.clientPortalAllowOverPayment = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'auto_bill_date':
          result.autoBillDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_portal_under_payment_minimum':
          result.clientPortalUnderPaymentMinimum = serializers.deserialize(
              value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'use_credits_payment':
          result.useCreditsPayment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_custom_head':
          result.clientPortalCustomHeader = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_custom_css':
          result.clientPortalCustomCss = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_custom_footer':
          result.clientPortalCustomFooter = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portal_custom_js':
          result.clientPortalCustomJs = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hide_empty_columns_on_pdf':
          result.hideEmptyColumnsOnPdf = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'entity_send_time':
          result.entitySendTime = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_custom_design1_HIDDEN':
          result.hasCustomDesign1 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_custom_design2_HIDDEN':
          result.hasCustomDesign2 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'has_custom_design3_HIDDEN':
          result.hasCustomDesign3 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$SettingsEntity extends SettingsEntity {
  @override
  final String timezoneId;
  @override
  final String dateFormatId;
  @override
  final bool enableMilitaryTime;
  @override
  final String languageId;
  @override
  final bool showCurrencyCode;
  @override
  final String currencyId;
  @override
  final String customValue1;
  @override
  final String customValue2;
  @override
  final String customValue3;
  @override
  final String customValue4;
  @override
  final String defaultPaymentTerms;
  @override
  final String defaultValidUntil;
  @override
  final String companyGatewayIds;
  @override
  final double defaultTaskRate;
  @override
  final bool sendReminders;
  @override
  final bool enablePortal;
  @override
  final bool enablePortalDashboard;
  @override
  final bool enablePortalTasks;
  @override
  final bool enablePortalUploads;
  @override
  final String emailStyle;
  @override
  final String replyToEmail;
  @override
  final String replyToName;
  @override
  final String bccEmail;
  @override
  final bool pdfEmailAttachment;
  @override
  final bool ublEmailAttachment;
  @override
  final bool documentEmailAttachment;
  @override
  final String emailStyleCustom;
  @override
  final String customMessageDashboard;
  @override
  final String customMessageUnpaidInvoice;
  @override
  final String customMessagePaidInvoice;
  @override
  final String customMessageUnapprovedQuote;
  @override
  final bool autoArchiveInvoice;
  @override
  final bool autoArchiveQuote;
  @override
  final bool autoEmailInvoice;
  @override
  final bool autoConvertQuote;
  @override
  final bool enableInclusiveTaxes;
  @override
  final BuiltMap<String, String> translations;
  @override
  final String taskNumberPattern;
  @override
  final int taskNumberCounter;
  @override
  final String expenseNumberPattern;
  @override
  final int expenseNumberCounter;
  @override
  final String vendorNumberPattern;
  @override
  final int vendorNumberCounter;
  @override
  final String ticketNumberPattern;
  @override
  final int ticketNumberCounter;
  @override
  final String paymentNumberPattern;
  @override
  final int paymentNumberCounter;
  @override
  final String projectNumberPattern;
  @override
  final int projectNumberCounter;
  @override
  final String invoiceNumberPattern;
  @override
  final int invoiceNumberCounter;
  @override
  final String recurringInvoiceNumberPattern;
  @override
  final int recurringInvoiceNumberCounter;
  @override
  final String quoteNumberPattern;
  @override
  final int quoteNumberCounter;
  @override
  final String clientNumberPattern;
  @override
  final int clientNumberCounter;
  @override
  final String creditNumberPattern;
  @override
  final int creditNumberCounter;
  @override
  final String recurringNumberPrefix;
  @override
  final String resetCounterFrequencyId;
  @override
  final String resetCounterDate;
  @override
  final int counterPadding;
  @override
  final bool sharedInvoiceQuoteCounter;
  @override
  final bool sharedInvoiceCreditCounter;
  @override
  final String defaultInvoiceTerms;
  @override
  final String defaultQuoteTerms;
  @override
  final String defaultQuoteFooter;
  @override
  final String defaultCreditTerms;
  @override
  final String defaultCreditFooter;
  @override
  final String defaultInvoiceDesignId;
  @override
  final String defaultQuoteDesignId;
  @override
  final String defaultCreditDesignId;
  @override
  final String defaultInvoiceFooter;
  @override
  final String defaultTaxName1;
  @override
  final double defaultTaxRate1;
  @override
  final String defaultTaxName2;
  @override
  final double defaultTaxRate2;
  @override
  final String defaultTaxName3;
  @override
  final double defaultTaxRate3;
  @override
  final String defaultPaymentTypeId;
  @override
  final BuiltMap<String, BuiltList<String>> pdfVariables;
  @override
  final String emailSignature;
  @override
  final String emailSubjectInvoice;
  @override
  final String emailSubjectQuote;
  @override
  final String emailSubjectCredit;
  @override
  final String emailSubjectPayment;
  @override
  final String emailSubjectPaymentPartial;
  @override
  final String emailBodyInvoice;
  @override
  final String emailBodyQuote;
  @override
  final String emailBodyCredit;
  @override
  final String emailBodyPayment;
  @override
  final String emailBodyPaymentPartial;
  @override
  final String emailSubjectReminder1;
  @override
  final String emailSubjectReminder2;
  @override
  final String emailSubjectReminder3;
  @override
  final String emailBodyReminder1;
  @override
  final String emailBodyReminder2;
  @override
  final String emailBodyReminder3;
  @override
  final String emailSubjectCustom1;
  @override
  final String emailBodyCustom1;
  @override
  final String emailSubjectCustom2;
  @override
  final String emailBodyCustom2;
  @override
  final String emailSubjectCustom3;
  @override
  final String emailBodyCustom3;
  @override
  final String emailSubjectStatement;
  @override
  final String emailBodyStatement;
  @override
  final bool enablePortalPassword;
  @override
  final bool signatureOnPdf;
  @override
  final bool enableEmailMarkup;
  @override
  final bool showAcceptInvoiceTerms;
  @override
  final bool showAcceptQuoteTerms;
  @override
  final bool requireInvoiceSignature;
  @override
  final bool requireQuoteSignature;
  @override
  final String name;
  @override
  final String companyLogo;
  @override
  final String website;
  @override
  final String address1;
  @override
  final String address2;
  @override
  final String city;
  @override
  final String state;
  @override
  final String postalCode;
  @override
  final String phone;
  @override
  final String email;
  @override
  final String countryId;
  @override
  final String vatNumber;
  @override
  final String idNumber;
  @override
  final String pageSize;
  @override
  final String pageLayout;
  @override
  final int fontSize;
  @override
  final String primaryColor;
  @override
  final String secondaryColor;
  @override
  final String primaryFont;
  @override
  final String secondaryFont;
  @override
  final bool hidePaidToDate;
  @override
  final bool embedDocuments;
  @override
  final bool allPagesHeader;
  @override
  final bool allPagesFooter;
  @override
  final bool enableReminder1;
  @override
  final bool enableReminder2;
  @override
  final bool enableReminder3;
  @override
  final bool enableReminderEndless;
  @override
  final int numDaysReminder1;
  @override
  final int numDaysReminder2;
  @override
  final int numDaysReminder3;
  @override
  final String scheduleReminder1;
  @override
  final String scheduleReminder2;
  @override
  final String scheduleReminder3;
  @override
  final String endlessReminderFrequencyId;
  @override
  final double lateFeeAmount1;
  @override
  final double lateFeeAmount2;
  @override
  final double lateFeeAmount3;
  @override
  final double lateFeeAmountEndless;
  @override
  final double lateFeePercent1;
  @override
  final double lateFeePercent2;
  @override
  final double lateFeePercent3;
  @override
  final double lateFeePercentEndless;
  @override
  final String emailSubjectReminderEndless;
  @override
  final String emailBodyReminderEndless;
  @override
  final bool clientOnlinePaymentNotification;
  @override
  final bool clientManualPaymentNotification;
  @override
  final String counterNumberApplied;
  @override
  final String emailSendingMethod;
  @override
  final String gmailSendingUserId;
  @override
  final String clientPortalTerms;
  @override
  final String clientPortalPrivacy;
  @override
  final String lockInvoices;
  @override
  final String autoBill;
  @override
  final bool clientPortalAllowUnderPayment;
  @override
  final bool clientPortalAllowOverPayment;
  @override
  final String autoBillDate;
  @override
  final double clientPortalUnderPaymentMinimum;
  @override
  final String useCreditsPayment;
  @override
  final String clientPortalCustomHeader;
  @override
  final String clientPortalCustomCss;
  @override
  final String clientPortalCustomFooter;
  @override
  final String clientPortalCustomJs;
  @override
  final bool hideEmptyColumnsOnPdf;
  @override
  final bool entitySendTime;
  @override
  final bool hasCustomDesign1;
  @override
  final bool hasCustomDesign2;
  @override
  final bool hasCustomDesign3;

  factory _$SettingsEntity([void Function(SettingsEntityBuilder) updates]) =>
      (new SettingsEntityBuilder()..update(updates)).build();

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
      this.enablePortalUploads,
      this.emailStyle,
      this.replyToEmail,
      this.replyToName,
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
      this.autoArchiveQuote,
      this.autoEmailInvoice,
      this.autoConvertQuote,
      this.enableInclusiveTaxes,
      this.translations,
      this.taskNumberPattern,
      this.taskNumberCounter,
      this.expenseNumberPattern,
      this.expenseNumberCounter,
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
      this.counterNumberApplied,
      this.emailSendingMethod,
      this.gmailSendingUserId,
      this.clientPortalTerms,
      this.clientPortalPrivacy,
      this.lockInvoices,
      this.autoBill,
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
      this.hasCustomDesign1,
      this.hasCustomDesign2,
      this.hasCustomDesign3})
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
        enablePortalUploads == other.enablePortalUploads &&
        emailStyle == other.emailStyle &&
        replyToEmail == other.replyToEmail &&
        replyToName == other.replyToName &&
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
        autoArchiveQuote == other.autoArchiveQuote &&
        autoEmailInvoice == other.autoEmailInvoice &&
        autoConvertQuote == other.autoConvertQuote &&
        enableInclusiveTaxes == other.enableInclusiveTaxes &&
        translations == other.translations &&
        taskNumberPattern == other.taskNumberPattern &&
        taskNumberCounter == other.taskNumberCounter &&
        expenseNumberPattern == other.expenseNumberPattern &&
        expenseNumberCounter == other.expenseNumberCounter &&
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
        counterNumberApplied == other.counterNumberApplied &&
        emailSendingMethod == other.emailSendingMethod &&
        gmailSendingUserId == other.gmailSendingUserId &&
        clientPortalTerms == other.clientPortalTerms &&
        clientPortalPrivacy == other.clientPortalPrivacy &&
        lockInvoices == other.lockInvoices &&
        autoBill == other.autoBill &&
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
        hasCustomDesign1 == other.hasCustomDesign1 &&
        hasCustomDesign2 == other.hasCustomDesign2 &&
        hasCustomDesign3 == other.hasCustomDesign3;
  }

  int __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, timezoneId.hashCode), dateFormatId.hashCode), enableMilitaryTime.hashCode), languageId.hashCode), showCurrencyCode.hashCode), currencyId.hashCode), customValue1.hashCode), customValue2.hashCode), customValue3.hashCode), customValue4.hashCode), defaultPaymentTerms.hashCode), defaultValidUntil.hashCode), companyGatewayIds.hashCode), defaultTaskRate.hashCode), sendReminders.hashCode), enablePortal.hashCode), enablePortalDashboard.hashCode), enablePortalTasks.hashCode), enablePortalUploads.hashCode), emailStyle.hashCode), replyToEmail.hashCode), replyToName.hashCode), bccEmail.hashCode), pdfEmailAttachment.hashCode), ublEmailAttachment.hashCode), documentEmailAttachment.hashCode), emailStyleCustom.hashCode), customMessageDashboard.hashCode), customMessageUnpaidInvoice.hashCode), customMessagePaidInvoice.hashCode), customMessageUnapprovedQuote.hashCode), autoArchiveInvoice.hashCode), autoArchiveQuote.hashCode), autoEmailInvoice.hashCode), autoConvertQuote.hashCode), enableInclusiveTaxes.hashCode), translations.hashCode), taskNumberPattern.hashCode), taskNumberCounter.hashCode), expenseNumberPattern.hashCode), expenseNumberCounter.hashCode), vendorNumberPattern.hashCode), vendorNumberCounter.hashCode), ticketNumberPattern.hashCode), ticketNumberCounter.hashCode), paymentNumberPattern.hashCode), paymentNumberCounter.hashCode), projectNumberPattern.hashCode), projectNumberCounter.hashCode), invoiceNumberPattern.hashCode), invoiceNumberCounter.hashCode), recurringInvoiceNumberPattern.hashCode), recurringInvoiceNumberCounter.hashCode), quoteNumberPattern.hashCode), quoteNumberCounter.hashCode), clientNumberPattern.hashCode), clientNumberCounter.hashCode), creditNumberPattern.hashCode), creditNumberCounter.hashCode), recurringNumberPrefix.hashCode), resetCounterFrequencyId.hashCode), resetCounterDate.hashCode), counterPadding.hashCode), sharedInvoiceQuoteCounter.hashCode), sharedInvoiceCreditCounter.hashCode), defaultInvoiceTerms.hashCode), defaultQuoteTerms.hashCode), defaultQuoteFooter.hashCode), defaultCreditTerms.hashCode), defaultCreditFooter.hashCode), defaultInvoiceDesignId.hashCode), defaultQuoteDesignId.hashCode), defaultCreditDesignId.hashCode), defaultInvoiceFooter.hashCode), defaultTaxName1.hashCode), defaultTaxRate1.hashCode), defaultTaxName2.hashCode), defaultTaxRate2.hashCode), defaultTaxName3.hashCode), defaultTaxRate3.hashCode), defaultPaymentTypeId.hashCode), pdfVariables.hashCode), emailSignature.hashCode), emailSubjectInvoice.hashCode), emailSubjectQuote.hashCode), emailSubjectCredit.hashCode), emailSubjectPayment.hashCode), emailSubjectPaymentPartial.hashCode), emailBodyInvoice.hashCode), emailBodyQuote.hashCode), emailBodyCredit.hashCode), emailBodyPayment.hashCode), emailBodyPaymentPartial.hashCode), emailSubjectReminder1.hashCode), emailSubjectReminder2.hashCode), emailSubjectReminder3.hashCode), emailBodyReminder1.hashCode), emailBodyReminder2.hashCode), emailBodyReminder3.hashCode), emailSubjectCustom1.hashCode), emailBodyCustom1.hashCode), emailSubjectCustom2.hashCode), emailBodyCustom2.hashCode), emailSubjectCustom3.hashCode), emailBodyCustom3.hashCode), emailSubjectStatement.hashCode), emailBodyStatement.hashCode), enablePortalPassword.hashCode), signatureOnPdf.hashCode), enableEmailMarkup.hashCode), showAcceptInvoiceTerms.hashCode), showAcceptQuoteTerms.hashCode), requireInvoiceSignature.hashCode), requireQuoteSignature.hashCode), name.hashCode), companyLogo.hashCode), website.hashCode), address1.hashCode), address2.hashCode), city.hashCode), state.hashCode), postalCode.hashCode), phone.hashCode), email.hashCode), countryId.hashCode), vatNumber.hashCode), idNumber.hashCode), pageSize.hashCode), pageLayout.hashCode), fontSize.hashCode), primaryColor.hashCode), secondaryColor.hashCode), primaryFont.hashCode), secondaryFont.hashCode), hidePaidToDate.hashCode), embedDocuments.hashCode), allPagesHeader.hashCode), allPagesFooter.hashCode), enableReminder1.hashCode), enableReminder2.hashCode), enableReminder3.hashCode), enableReminderEndless.hashCode), numDaysReminder1.hashCode), numDaysReminder2.hashCode), numDaysReminder3.hashCode), scheduleReminder1.hashCode), scheduleReminder2.hashCode), scheduleReminder3.hashCode), endlessReminderFrequencyId.hashCode), lateFeeAmount1.hashCode), lateFeeAmount2.hashCode), lateFeeAmount3.hashCode), lateFeeAmountEndless.hashCode), lateFeePercent1.hashCode), lateFeePercent2.hashCode), lateFeePercent3.hashCode), lateFeePercentEndless.hashCode), emailSubjectReminderEndless.hashCode), emailBodyReminderEndless.hashCode), clientOnlinePaymentNotification.hashCode), clientManualPaymentNotification.hashCode), counterNumberApplied.hashCode), emailSendingMethod.hashCode),
                                                                                gmailSendingUserId.hashCode),
                                                                            clientPortalTerms.hashCode),
                                                                        clientPortalPrivacy.hashCode),
                                                                    lockInvoices.hashCode),
                                                                autoBill.hashCode),
                                                            clientPortalAllowUnderPayment.hashCode),
                                                        clientPortalAllowOverPayment.hashCode),
                                                    autoBillDate.hashCode),
                                                clientPortalUnderPaymentMinimum.hashCode),
                                            useCreditsPayment.hashCode),
                                        clientPortalCustomHeader.hashCode),
                                    clientPortalCustomCss.hashCode),
                                clientPortalCustomFooter.hashCode),
                            clientPortalCustomJs.hashCode),
                        hideEmptyColumnsOnPdf.hashCode),
                    entitySendTime.hashCode),
                hasCustomDesign1.hashCode),
            hasCustomDesign2.hashCode),
        hasCustomDesign3.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingsEntity')
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
          ..add('enablePortalUploads', enablePortalUploads)
          ..add('emailStyle', emailStyle)
          ..add('replyToEmail', replyToEmail)
          ..add('replyToName', replyToName)
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
          ..add('autoArchiveQuote', autoArchiveQuote)
          ..add('autoEmailInvoice', autoEmailInvoice)
          ..add('autoConvertQuote', autoConvertQuote)
          ..add('enableInclusiveTaxes', enableInclusiveTaxes)
          ..add('translations', translations)
          ..add('taskNumberPattern', taskNumberPattern)
          ..add('taskNumberCounter', taskNumberCounter)
          ..add('expenseNumberPattern', expenseNumberPattern)
          ..add('expenseNumberCounter', expenseNumberCounter)
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
          ..add('counterNumberApplied', counterNumberApplied)
          ..add('emailSendingMethod', emailSendingMethod)
          ..add('gmailSendingUserId', gmailSendingUserId)
          ..add('clientPortalTerms', clientPortalTerms)
          ..add('clientPortalPrivacy', clientPortalPrivacy)
          ..add('lockInvoices', lockInvoices)
          ..add('autoBill', autoBill)
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
          ..add('hasCustomDesign1', hasCustomDesign1)
          ..add('hasCustomDesign2', hasCustomDesign2)
          ..add('hasCustomDesign3', hasCustomDesign3))
        .toString();
  }
}

class SettingsEntityBuilder
    implements Builder<SettingsEntity, SettingsEntityBuilder> {
  _$SettingsEntity _$v;

  String _timezoneId;
  String get timezoneId => _$this._timezoneId;
  set timezoneId(String timezoneId) => _$this._timezoneId = timezoneId;

  String _dateFormatId;
  String get dateFormatId => _$this._dateFormatId;
  set dateFormatId(String dateFormatId) => _$this._dateFormatId = dateFormatId;

  bool _enableMilitaryTime;
  bool get enableMilitaryTime => _$this._enableMilitaryTime;
  set enableMilitaryTime(bool enableMilitaryTime) =>
      _$this._enableMilitaryTime = enableMilitaryTime;

  String _languageId;
  String get languageId => _$this._languageId;
  set languageId(String languageId) => _$this._languageId = languageId;

  bool _showCurrencyCode;
  bool get showCurrencyCode => _$this._showCurrencyCode;
  set showCurrencyCode(bool showCurrencyCode) =>
      _$this._showCurrencyCode = showCurrencyCode;

  String _currencyId;
  String get currencyId => _$this._currencyId;
  set currencyId(String currencyId) => _$this._currencyId = currencyId;

  String _customValue1;
  String get customValue1 => _$this._customValue1;
  set customValue1(String customValue1) => _$this._customValue1 = customValue1;

  String _customValue2;
  String get customValue2 => _$this._customValue2;
  set customValue2(String customValue2) => _$this._customValue2 = customValue2;

  String _customValue3;
  String get customValue3 => _$this._customValue3;
  set customValue3(String customValue3) => _$this._customValue3 = customValue3;

  String _customValue4;
  String get customValue4 => _$this._customValue4;
  set customValue4(String customValue4) => _$this._customValue4 = customValue4;

  String _defaultPaymentTerms;
  String get defaultPaymentTerms => _$this._defaultPaymentTerms;
  set defaultPaymentTerms(String defaultPaymentTerms) =>
      _$this._defaultPaymentTerms = defaultPaymentTerms;

  String _defaultValidUntil;
  String get defaultValidUntil => _$this._defaultValidUntil;
  set defaultValidUntil(String defaultValidUntil) =>
      _$this._defaultValidUntil = defaultValidUntil;

  String _companyGatewayIds;
  String get companyGatewayIds => _$this._companyGatewayIds;
  set companyGatewayIds(String companyGatewayIds) =>
      _$this._companyGatewayIds = companyGatewayIds;

  double _defaultTaskRate;
  double get defaultTaskRate => _$this._defaultTaskRate;
  set defaultTaskRate(double defaultTaskRate) =>
      _$this._defaultTaskRate = defaultTaskRate;

  bool _sendReminders;
  bool get sendReminders => _$this._sendReminders;
  set sendReminders(bool sendReminders) =>
      _$this._sendReminders = sendReminders;

  bool _enablePortal;
  bool get enablePortal => _$this._enablePortal;
  set enablePortal(bool enablePortal) => _$this._enablePortal = enablePortal;

  bool _enablePortalDashboard;
  bool get enablePortalDashboard => _$this._enablePortalDashboard;
  set enablePortalDashboard(bool enablePortalDashboard) =>
      _$this._enablePortalDashboard = enablePortalDashboard;

  bool _enablePortalTasks;
  bool get enablePortalTasks => _$this._enablePortalTasks;
  set enablePortalTasks(bool enablePortalTasks) =>
      _$this._enablePortalTasks = enablePortalTasks;

  bool _enablePortalUploads;
  bool get enablePortalUploads => _$this._enablePortalUploads;
  set enablePortalUploads(bool enablePortalUploads) =>
      _$this._enablePortalUploads = enablePortalUploads;

  String _emailStyle;
  String get emailStyle => _$this._emailStyle;
  set emailStyle(String emailStyle) => _$this._emailStyle = emailStyle;

  String _replyToEmail;
  String get replyToEmail => _$this._replyToEmail;
  set replyToEmail(String replyToEmail) => _$this._replyToEmail = replyToEmail;

  String _replyToName;
  String get replyToName => _$this._replyToName;
  set replyToName(String replyToName) => _$this._replyToName = replyToName;

  String _bccEmail;
  String get bccEmail => _$this._bccEmail;
  set bccEmail(String bccEmail) => _$this._bccEmail = bccEmail;

  bool _pdfEmailAttachment;
  bool get pdfEmailAttachment => _$this._pdfEmailAttachment;
  set pdfEmailAttachment(bool pdfEmailAttachment) =>
      _$this._pdfEmailAttachment = pdfEmailAttachment;

  bool _ublEmailAttachment;
  bool get ublEmailAttachment => _$this._ublEmailAttachment;
  set ublEmailAttachment(bool ublEmailAttachment) =>
      _$this._ublEmailAttachment = ublEmailAttachment;

  bool _documentEmailAttachment;
  bool get documentEmailAttachment => _$this._documentEmailAttachment;
  set documentEmailAttachment(bool documentEmailAttachment) =>
      _$this._documentEmailAttachment = documentEmailAttachment;

  String _emailStyleCustom;
  String get emailStyleCustom => _$this._emailStyleCustom;
  set emailStyleCustom(String emailStyleCustom) =>
      _$this._emailStyleCustom = emailStyleCustom;

  String _customMessageDashboard;
  String get customMessageDashboard => _$this._customMessageDashboard;
  set customMessageDashboard(String customMessageDashboard) =>
      _$this._customMessageDashboard = customMessageDashboard;

  String _customMessageUnpaidInvoice;
  String get customMessageUnpaidInvoice => _$this._customMessageUnpaidInvoice;
  set customMessageUnpaidInvoice(String customMessageUnpaidInvoice) =>
      _$this._customMessageUnpaidInvoice = customMessageUnpaidInvoice;

  String _customMessagePaidInvoice;
  String get customMessagePaidInvoice => _$this._customMessagePaidInvoice;
  set customMessagePaidInvoice(String customMessagePaidInvoice) =>
      _$this._customMessagePaidInvoice = customMessagePaidInvoice;

  String _customMessageUnapprovedQuote;
  String get customMessageUnapprovedQuote =>
      _$this._customMessageUnapprovedQuote;
  set customMessageUnapprovedQuote(String customMessageUnapprovedQuote) =>
      _$this._customMessageUnapprovedQuote = customMessageUnapprovedQuote;

  bool _autoArchiveInvoice;
  bool get autoArchiveInvoice => _$this._autoArchiveInvoice;
  set autoArchiveInvoice(bool autoArchiveInvoice) =>
      _$this._autoArchiveInvoice = autoArchiveInvoice;

  bool _autoArchiveQuote;
  bool get autoArchiveQuote => _$this._autoArchiveQuote;
  set autoArchiveQuote(bool autoArchiveQuote) =>
      _$this._autoArchiveQuote = autoArchiveQuote;

  bool _autoEmailInvoice;
  bool get autoEmailInvoice => _$this._autoEmailInvoice;
  set autoEmailInvoice(bool autoEmailInvoice) =>
      _$this._autoEmailInvoice = autoEmailInvoice;

  bool _autoConvertQuote;
  bool get autoConvertQuote => _$this._autoConvertQuote;
  set autoConvertQuote(bool autoConvertQuote) =>
      _$this._autoConvertQuote = autoConvertQuote;

  bool _enableInclusiveTaxes;
  bool get enableInclusiveTaxes => _$this._enableInclusiveTaxes;
  set enableInclusiveTaxes(bool enableInclusiveTaxes) =>
      _$this._enableInclusiveTaxes = enableInclusiveTaxes;

  MapBuilder<String, String> _translations;
  MapBuilder<String, String> get translations =>
      _$this._translations ??= new MapBuilder<String, String>();
  set translations(MapBuilder<String, String> translations) =>
      _$this._translations = translations;

  String _taskNumberPattern;
  String get taskNumberPattern => _$this._taskNumberPattern;
  set taskNumberPattern(String taskNumberPattern) =>
      _$this._taskNumberPattern = taskNumberPattern;

  int _taskNumberCounter;
  int get taskNumberCounter => _$this._taskNumberCounter;
  set taskNumberCounter(int taskNumberCounter) =>
      _$this._taskNumberCounter = taskNumberCounter;

  String _expenseNumberPattern;
  String get expenseNumberPattern => _$this._expenseNumberPattern;
  set expenseNumberPattern(String expenseNumberPattern) =>
      _$this._expenseNumberPattern = expenseNumberPattern;

  int _expenseNumberCounter;
  int get expenseNumberCounter => _$this._expenseNumberCounter;
  set expenseNumberCounter(int expenseNumberCounter) =>
      _$this._expenseNumberCounter = expenseNumberCounter;

  String _vendorNumberPattern;
  String get vendorNumberPattern => _$this._vendorNumberPattern;
  set vendorNumberPattern(String vendorNumberPattern) =>
      _$this._vendorNumberPattern = vendorNumberPattern;

  int _vendorNumberCounter;
  int get vendorNumberCounter => _$this._vendorNumberCounter;
  set vendorNumberCounter(int vendorNumberCounter) =>
      _$this._vendorNumberCounter = vendorNumberCounter;

  String _ticketNumberPattern;
  String get ticketNumberPattern => _$this._ticketNumberPattern;
  set ticketNumberPattern(String ticketNumberPattern) =>
      _$this._ticketNumberPattern = ticketNumberPattern;

  int _ticketNumberCounter;
  int get ticketNumberCounter => _$this._ticketNumberCounter;
  set ticketNumberCounter(int ticketNumberCounter) =>
      _$this._ticketNumberCounter = ticketNumberCounter;

  String _paymentNumberPattern;
  String get paymentNumberPattern => _$this._paymentNumberPattern;
  set paymentNumberPattern(String paymentNumberPattern) =>
      _$this._paymentNumberPattern = paymentNumberPattern;

  int _paymentNumberCounter;
  int get paymentNumberCounter => _$this._paymentNumberCounter;
  set paymentNumberCounter(int paymentNumberCounter) =>
      _$this._paymentNumberCounter = paymentNumberCounter;

  String _projectNumberPattern;
  String get projectNumberPattern => _$this._projectNumberPattern;
  set projectNumberPattern(String projectNumberPattern) =>
      _$this._projectNumberPattern = projectNumberPattern;

  int _projectNumberCounter;
  int get projectNumberCounter => _$this._projectNumberCounter;
  set projectNumberCounter(int projectNumberCounter) =>
      _$this._projectNumberCounter = projectNumberCounter;

  String _invoiceNumberPattern;
  String get invoiceNumberPattern => _$this._invoiceNumberPattern;
  set invoiceNumberPattern(String invoiceNumberPattern) =>
      _$this._invoiceNumberPattern = invoiceNumberPattern;

  int _invoiceNumberCounter;
  int get invoiceNumberCounter => _$this._invoiceNumberCounter;
  set invoiceNumberCounter(int invoiceNumberCounter) =>
      _$this._invoiceNumberCounter = invoiceNumberCounter;

  String _recurringInvoiceNumberPattern;
  String get recurringInvoiceNumberPattern =>
      _$this._recurringInvoiceNumberPattern;
  set recurringInvoiceNumberPattern(String recurringInvoiceNumberPattern) =>
      _$this._recurringInvoiceNumberPattern = recurringInvoiceNumberPattern;

  int _recurringInvoiceNumberCounter;
  int get recurringInvoiceNumberCounter =>
      _$this._recurringInvoiceNumberCounter;
  set recurringInvoiceNumberCounter(int recurringInvoiceNumberCounter) =>
      _$this._recurringInvoiceNumberCounter = recurringInvoiceNumberCounter;

  String _quoteNumberPattern;
  String get quoteNumberPattern => _$this._quoteNumberPattern;
  set quoteNumberPattern(String quoteNumberPattern) =>
      _$this._quoteNumberPattern = quoteNumberPattern;

  int _quoteNumberCounter;
  int get quoteNumberCounter => _$this._quoteNumberCounter;
  set quoteNumberCounter(int quoteNumberCounter) =>
      _$this._quoteNumberCounter = quoteNumberCounter;

  String _clientNumberPattern;
  String get clientNumberPattern => _$this._clientNumberPattern;
  set clientNumberPattern(String clientNumberPattern) =>
      _$this._clientNumberPattern = clientNumberPattern;

  int _clientNumberCounter;
  int get clientNumberCounter => _$this._clientNumberCounter;
  set clientNumberCounter(int clientNumberCounter) =>
      _$this._clientNumberCounter = clientNumberCounter;

  String _creditNumberPattern;
  String get creditNumberPattern => _$this._creditNumberPattern;
  set creditNumberPattern(String creditNumberPattern) =>
      _$this._creditNumberPattern = creditNumberPattern;

  int _creditNumberCounter;
  int get creditNumberCounter => _$this._creditNumberCounter;
  set creditNumberCounter(int creditNumberCounter) =>
      _$this._creditNumberCounter = creditNumberCounter;

  String _recurringNumberPrefix;
  String get recurringNumberPrefix => _$this._recurringNumberPrefix;
  set recurringNumberPrefix(String recurringNumberPrefix) =>
      _$this._recurringNumberPrefix = recurringNumberPrefix;

  String _resetCounterFrequencyId;
  String get resetCounterFrequencyId => _$this._resetCounterFrequencyId;
  set resetCounterFrequencyId(String resetCounterFrequencyId) =>
      _$this._resetCounterFrequencyId = resetCounterFrequencyId;

  String _resetCounterDate;
  String get resetCounterDate => _$this._resetCounterDate;
  set resetCounterDate(String resetCounterDate) =>
      _$this._resetCounterDate = resetCounterDate;

  int _counterPadding;
  int get counterPadding => _$this._counterPadding;
  set counterPadding(int counterPadding) =>
      _$this._counterPadding = counterPadding;

  bool _sharedInvoiceQuoteCounter;
  bool get sharedInvoiceQuoteCounter => _$this._sharedInvoiceQuoteCounter;
  set sharedInvoiceQuoteCounter(bool sharedInvoiceQuoteCounter) =>
      _$this._sharedInvoiceQuoteCounter = sharedInvoiceQuoteCounter;

  bool _sharedInvoiceCreditCounter;
  bool get sharedInvoiceCreditCounter => _$this._sharedInvoiceCreditCounter;
  set sharedInvoiceCreditCounter(bool sharedInvoiceCreditCounter) =>
      _$this._sharedInvoiceCreditCounter = sharedInvoiceCreditCounter;

  String _defaultInvoiceTerms;
  String get defaultInvoiceTerms => _$this._defaultInvoiceTerms;
  set defaultInvoiceTerms(String defaultInvoiceTerms) =>
      _$this._defaultInvoiceTerms = defaultInvoiceTerms;

  String _defaultQuoteTerms;
  String get defaultQuoteTerms => _$this._defaultQuoteTerms;
  set defaultQuoteTerms(String defaultQuoteTerms) =>
      _$this._defaultQuoteTerms = defaultQuoteTerms;

  String _defaultQuoteFooter;
  String get defaultQuoteFooter => _$this._defaultQuoteFooter;
  set defaultQuoteFooter(String defaultQuoteFooter) =>
      _$this._defaultQuoteFooter = defaultQuoteFooter;

  String _defaultCreditTerms;
  String get defaultCreditTerms => _$this._defaultCreditTerms;
  set defaultCreditTerms(String defaultCreditTerms) =>
      _$this._defaultCreditTerms = defaultCreditTerms;

  String _defaultCreditFooter;
  String get defaultCreditFooter => _$this._defaultCreditFooter;
  set defaultCreditFooter(String defaultCreditFooter) =>
      _$this._defaultCreditFooter = defaultCreditFooter;

  String _defaultInvoiceDesignId;
  String get defaultInvoiceDesignId => _$this._defaultInvoiceDesignId;
  set defaultInvoiceDesignId(String defaultInvoiceDesignId) =>
      _$this._defaultInvoiceDesignId = defaultInvoiceDesignId;

  String _defaultQuoteDesignId;
  String get defaultQuoteDesignId => _$this._defaultQuoteDesignId;
  set defaultQuoteDesignId(String defaultQuoteDesignId) =>
      _$this._defaultQuoteDesignId = defaultQuoteDesignId;

  String _defaultCreditDesignId;
  String get defaultCreditDesignId => _$this._defaultCreditDesignId;
  set defaultCreditDesignId(String defaultCreditDesignId) =>
      _$this._defaultCreditDesignId = defaultCreditDesignId;

  String _defaultInvoiceFooter;
  String get defaultInvoiceFooter => _$this._defaultInvoiceFooter;
  set defaultInvoiceFooter(String defaultInvoiceFooter) =>
      _$this._defaultInvoiceFooter = defaultInvoiceFooter;

  String _defaultTaxName1;
  String get defaultTaxName1 => _$this._defaultTaxName1;
  set defaultTaxName1(String defaultTaxName1) =>
      _$this._defaultTaxName1 = defaultTaxName1;

  double _defaultTaxRate1;
  double get defaultTaxRate1 => _$this._defaultTaxRate1;
  set defaultTaxRate1(double defaultTaxRate1) =>
      _$this._defaultTaxRate1 = defaultTaxRate1;

  String _defaultTaxName2;
  String get defaultTaxName2 => _$this._defaultTaxName2;
  set defaultTaxName2(String defaultTaxName2) =>
      _$this._defaultTaxName2 = defaultTaxName2;

  double _defaultTaxRate2;
  double get defaultTaxRate2 => _$this._defaultTaxRate2;
  set defaultTaxRate2(double defaultTaxRate2) =>
      _$this._defaultTaxRate2 = defaultTaxRate2;

  String _defaultTaxName3;
  String get defaultTaxName3 => _$this._defaultTaxName3;
  set defaultTaxName3(String defaultTaxName3) =>
      _$this._defaultTaxName3 = defaultTaxName3;

  double _defaultTaxRate3;
  double get defaultTaxRate3 => _$this._defaultTaxRate3;
  set defaultTaxRate3(double defaultTaxRate3) =>
      _$this._defaultTaxRate3 = defaultTaxRate3;

  String _defaultPaymentTypeId;
  String get defaultPaymentTypeId => _$this._defaultPaymentTypeId;
  set defaultPaymentTypeId(String defaultPaymentTypeId) =>
      _$this._defaultPaymentTypeId = defaultPaymentTypeId;

  MapBuilder<String, BuiltList<String>> _pdfVariables;
  MapBuilder<String, BuiltList<String>> get pdfVariables =>
      _$this._pdfVariables ??= new MapBuilder<String, BuiltList<String>>();
  set pdfVariables(MapBuilder<String, BuiltList<String>> pdfVariables) =>
      _$this._pdfVariables = pdfVariables;

  String _emailSignature;
  String get emailSignature => _$this._emailSignature;
  set emailSignature(String emailSignature) =>
      _$this._emailSignature = emailSignature;

  String _emailSubjectInvoice;
  String get emailSubjectInvoice => _$this._emailSubjectInvoice;
  set emailSubjectInvoice(String emailSubjectInvoice) =>
      _$this._emailSubjectInvoice = emailSubjectInvoice;

  String _emailSubjectQuote;
  String get emailSubjectQuote => _$this._emailSubjectQuote;
  set emailSubjectQuote(String emailSubjectQuote) =>
      _$this._emailSubjectQuote = emailSubjectQuote;

  String _emailSubjectCredit;
  String get emailSubjectCredit => _$this._emailSubjectCredit;
  set emailSubjectCredit(String emailSubjectCredit) =>
      _$this._emailSubjectCredit = emailSubjectCredit;

  String _emailSubjectPayment;
  String get emailSubjectPayment => _$this._emailSubjectPayment;
  set emailSubjectPayment(String emailSubjectPayment) =>
      _$this._emailSubjectPayment = emailSubjectPayment;

  String _emailSubjectPaymentPartial;
  String get emailSubjectPaymentPartial => _$this._emailSubjectPaymentPartial;
  set emailSubjectPaymentPartial(String emailSubjectPaymentPartial) =>
      _$this._emailSubjectPaymentPartial = emailSubjectPaymentPartial;

  String _emailBodyInvoice;
  String get emailBodyInvoice => _$this._emailBodyInvoice;
  set emailBodyInvoice(String emailBodyInvoice) =>
      _$this._emailBodyInvoice = emailBodyInvoice;

  String _emailBodyQuote;
  String get emailBodyQuote => _$this._emailBodyQuote;
  set emailBodyQuote(String emailBodyQuote) =>
      _$this._emailBodyQuote = emailBodyQuote;

  String _emailBodyCredit;
  String get emailBodyCredit => _$this._emailBodyCredit;
  set emailBodyCredit(String emailBodyCredit) =>
      _$this._emailBodyCredit = emailBodyCredit;

  String _emailBodyPayment;
  String get emailBodyPayment => _$this._emailBodyPayment;
  set emailBodyPayment(String emailBodyPayment) =>
      _$this._emailBodyPayment = emailBodyPayment;

  String _emailBodyPaymentPartial;
  String get emailBodyPaymentPartial => _$this._emailBodyPaymentPartial;
  set emailBodyPaymentPartial(String emailBodyPaymentPartial) =>
      _$this._emailBodyPaymentPartial = emailBodyPaymentPartial;

  String _emailSubjectReminder1;
  String get emailSubjectReminder1 => _$this._emailSubjectReminder1;
  set emailSubjectReminder1(String emailSubjectReminder1) =>
      _$this._emailSubjectReminder1 = emailSubjectReminder1;

  String _emailSubjectReminder2;
  String get emailSubjectReminder2 => _$this._emailSubjectReminder2;
  set emailSubjectReminder2(String emailSubjectReminder2) =>
      _$this._emailSubjectReminder2 = emailSubjectReminder2;

  String _emailSubjectReminder3;
  String get emailSubjectReminder3 => _$this._emailSubjectReminder3;
  set emailSubjectReminder3(String emailSubjectReminder3) =>
      _$this._emailSubjectReminder3 = emailSubjectReminder3;

  String _emailBodyReminder1;
  String get emailBodyReminder1 => _$this._emailBodyReminder1;
  set emailBodyReminder1(String emailBodyReminder1) =>
      _$this._emailBodyReminder1 = emailBodyReminder1;

  String _emailBodyReminder2;
  String get emailBodyReminder2 => _$this._emailBodyReminder2;
  set emailBodyReminder2(String emailBodyReminder2) =>
      _$this._emailBodyReminder2 = emailBodyReminder2;

  String _emailBodyReminder3;
  String get emailBodyReminder3 => _$this._emailBodyReminder3;
  set emailBodyReminder3(String emailBodyReminder3) =>
      _$this._emailBodyReminder3 = emailBodyReminder3;

  String _emailSubjectCustom1;
  String get emailSubjectCustom1 => _$this._emailSubjectCustom1;
  set emailSubjectCustom1(String emailSubjectCustom1) =>
      _$this._emailSubjectCustom1 = emailSubjectCustom1;

  String _emailBodyCustom1;
  String get emailBodyCustom1 => _$this._emailBodyCustom1;
  set emailBodyCustom1(String emailBodyCustom1) =>
      _$this._emailBodyCustom1 = emailBodyCustom1;

  String _emailSubjectCustom2;
  String get emailSubjectCustom2 => _$this._emailSubjectCustom2;
  set emailSubjectCustom2(String emailSubjectCustom2) =>
      _$this._emailSubjectCustom2 = emailSubjectCustom2;

  String _emailBodyCustom2;
  String get emailBodyCustom2 => _$this._emailBodyCustom2;
  set emailBodyCustom2(String emailBodyCustom2) =>
      _$this._emailBodyCustom2 = emailBodyCustom2;

  String _emailSubjectCustom3;
  String get emailSubjectCustom3 => _$this._emailSubjectCustom3;
  set emailSubjectCustom3(String emailSubjectCustom3) =>
      _$this._emailSubjectCustom3 = emailSubjectCustom3;

  String _emailBodyCustom3;
  String get emailBodyCustom3 => _$this._emailBodyCustom3;
  set emailBodyCustom3(String emailBodyCustom3) =>
      _$this._emailBodyCustom3 = emailBodyCustom3;

  String _emailSubjectStatement;
  String get emailSubjectStatement => _$this._emailSubjectStatement;
  set emailSubjectStatement(String emailSubjectStatement) =>
      _$this._emailSubjectStatement = emailSubjectStatement;

  String _emailBodyStatement;
  String get emailBodyStatement => _$this._emailBodyStatement;
  set emailBodyStatement(String emailBodyStatement) =>
      _$this._emailBodyStatement = emailBodyStatement;

  bool _enablePortalPassword;
  bool get enablePortalPassword => _$this._enablePortalPassword;
  set enablePortalPassword(bool enablePortalPassword) =>
      _$this._enablePortalPassword = enablePortalPassword;

  bool _signatureOnPdf;
  bool get signatureOnPdf => _$this._signatureOnPdf;
  set signatureOnPdf(bool signatureOnPdf) =>
      _$this._signatureOnPdf = signatureOnPdf;

  bool _enableEmailMarkup;
  bool get enableEmailMarkup => _$this._enableEmailMarkup;
  set enableEmailMarkup(bool enableEmailMarkup) =>
      _$this._enableEmailMarkup = enableEmailMarkup;

  bool _showAcceptInvoiceTerms;
  bool get showAcceptInvoiceTerms => _$this._showAcceptInvoiceTerms;
  set showAcceptInvoiceTerms(bool showAcceptInvoiceTerms) =>
      _$this._showAcceptInvoiceTerms = showAcceptInvoiceTerms;

  bool _showAcceptQuoteTerms;
  bool get showAcceptQuoteTerms => _$this._showAcceptQuoteTerms;
  set showAcceptQuoteTerms(bool showAcceptQuoteTerms) =>
      _$this._showAcceptQuoteTerms = showAcceptQuoteTerms;

  bool _requireInvoiceSignature;
  bool get requireInvoiceSignature => _$this._requireInvoiceSignature;
  set requireInvoiceSignature(bool requireInvoiceSignature) =>
      _$this._requireInvoiceSignature = requireInvoiceSignature;

  bool _requireQuoteSignature;
  bool get requireQuoteSignature => _$this._requireQuoteSignature;
  set requireQuoteSignature(bool requireQuoteSignature) =>
      _$this._requireQuoteSignature = requireQuoteSignature;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _companyLogo;
  String get companyLogo => _$this._companyLogo;
  set companyLogo(String companyLogo) => _$this._companyLogo = companyLogo;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  String _address1;
  String get address1 => _$this._address1;
  set address1(String address1) => _$this._address1 = address1;

  String _address2;
  String get address2 => _$this._address2;
  set address2(String address2) => _$this._address2 = address2;

  String _city;
  String get city => _$this._city;
  set city(String city) => _$this._city = city;

  String _state;
  String get state => _$this._state;
  set state(String state) => _$this._state = state;

  String _postalCode;
  String get postalCode => _$this._postalCode;
  set postalCode(String postalCode) => _$this._postalCode = postalCode;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _countryId;
  String get countryId => _$this._countryId;
  set countryId(String countryId) => _$this._countryId = countryId;

  String _vatNumber;
  String get vatNumber => _$this._vatNumber;
  set vatNumber(String vatNumber) => _$this._vatNumber = vatNumber;

  String _idNumber;
  String get idNumber => _$this._idNumber;
  set idNumber(String idNumber) => _$this._idNumber = idNumber;

  String _pageSize;
  String get pageSize => _$this._pageSize;
  set pageSize(String pageSize) => _$this._pageSize = pageSize;

  String _pageLayout;
  String get pageLayout => _$this._pageLayout;
  set pageLayout(String pageLayout) => _$this._pageLayout = pageLayout;

  int _fontSize;
  int get fontSize => _$this._fontSize;
  set fontSize(int fontSize) => _$this._fontSize = fontSize;

  String _primaryColor;
  String get primaryColor => _$this._primaryColor;
  set primaryColor(String primaryColor) => _$this._primaryColor = primaryColor;

  String _secondaryColor;
  String get secondaryColor => _$this._secondaryColor;
  set secondaryColor(String secondaryColor) =>
      _$this._secondaryColor = secondaryColor;

  String _primaryFont;
  String get primaryFont => _$this._primaryFont;
  set primaryFont(String primaryFont) => _$this._primaryFont = primaryFont;

  String _secondaryFont;
  String get secondaryFont => _$this._secondaryFont;
  set secondaryFont(String secondaryFont) =>
      _$this._secondaryFont = secondaryFont;

  bool _hidePaidToDate;
  bool get hidePaidToDate => _$this._hidePaidToDate;
  set hidePaidToDate(bool hidePaidToDate) =>
      _$this._hidePaidToDate = hidePaidToDate;

  bool _embedDocuments;
  bool get embedDocuments => _$this._embedDocuments;
  set embedDocuments(bool embedDocuments) =>
      _$this._embedDocuments = embedDocuments;

  bool _allPagesHeader;
  bool get allPagesHeader => _$this._allPagesHeader;
  set allPagesHeader(bool allPagesHeader) =>
      _$this._allPagesHeader = allPagesHeader;

  bool _allPagesFooter;
  bool get allPagesFooter => _$this._allPagesFooter;
  set allPagesFooter(bool allPagesFooter) =>
      _$this._allPagesFooter = allPagesFooter;

  bool _enableReminder1;
  bool get enableReminder1 => _$this._enableReminder1;
  set enableReminder1(bool enableReminder1) =>
      _$this._enableReminder1 = enableReminder1;

  bool _enableReminder2;
  bool get enableReminder2 => _$this._enableReminder2;
  set enableReminder2(bool enableReminder2) =>
      _$this._enableReminder2 = enableReminder2;

  bool _enableReminder3;
  bool get enableReminder3 => _$this._enableReminder3;
  set enableReminder3(bool enableReminder3) =>
      _$this._enableReminder3 = enableReminder3;

  bool _enableReminderEndless;
  bool get enableReminderEndless => _$this._enableReminderEndless;
  set enableReminderEndless(bool enableReminderEndless) =>
      _$this._enableReminderEndless = enableReminderEndless;

  int _numDaysReminder1;
  int get numDaysReminder1 => _$this._numDaysReminder1;
  set numDaysReminder1(int numDaysReminder1) =>
      _$this._numDaysReminder1 = numDaysReminder1;

  int _numDaysReminder2;
  int get numDaysReminder2 => _$this._numDaysReminder2;
  set numDaysReminder2(int numDaysReminder2) =>
      _$this._numDaysReminder2 = numDaysReminder2;

  int _numDaysReminder3;
  int get numDaysReminder3 => _$this._numDaysReminder3;
  set numDaysReminder3(int numDaysReminder3) =>
      _$this._numDaysReminder3 = numDaysReminder3;

  String _scheduleReminder1;
  String get scheduleReminder1 => _$this._scheduleReminder1;
  set scheduleReminder1(String scheduleReminder1) =>
      _$this._scheduleReminder1 = scheduleReminder1;

  String _scheduleReminder2;
  String get scheduleReminder2 => _$this._scheduleReminder2;
  set scheduleReminder2(String scheduleReminder2) =>
      _$this._scheduleReminder2 = scheduleReminder2;

  String _scheduleReminder3;
  String get scheduleReminder3 => _$this._scheduleReminder3;
  set scheduleReminder3(String scheduleReminder3) =>
      _$this._scheduleReminder3 = scheduleReminder3;

  String _endlessReminderFrequencyId;
  String get endlessReminderFrequencyId => _$this._endlessReminderFrequencyId;
  set endlessReminderFrequencyId(String endlessReminderFrequencyId) =>
      _$this._endlessReminderFrequencyId = endlessReminderFrequencyId;

  double _lateFeeAmount1;
  double get lateFeeAmount1 => _$this._lateFeeAmount1;
  set lateFeeAmount1(double lateFeeAmount1) =>
      _$this._lateFeeAmount1 = lateFeeAmount1;

  double _lateFeeAmount2;
  double get lateFeeAmount2 => _$this._lateFeeAmount2;
  set lateFeeAmount2(double lateFeeAmount2) =>
      _$this._lateFeeAmount2 = lateFeeAmount2;

  double _lateFeeAmount3;
  double get lateFeeAmount3 => _$this._lateFeeAmount3;
  set lateFeeAmount3(double lateFeeAmount3) =>
      _$this._lateFeeAmount3 = lateFeeAmount3;

  double _lateFeeAmountEndless;
  double get lateFeeAmountEndless => _$this._lateFeeAmountEndless;
  set lateFeeAmountEndless(double lateFeeAmountEndless) =>
      _$this._lateFeeAmountEndless = lateFeeAmountEndless;

  double _lateFeePercent1;
  double get lateFeePercent1 => _$this._lateFeePercent1;
  set lateFeePercent1(double lateFeePercent1) =>
      _$this._lateFeePercent1 = lateFeePercent1;

  double _lateFeePercent2;
  double get lateFeePercent2 => _$this._lateFeePercent2;
  set lateFeePercent2(double lateFeePercent2) =>
      _$this._lateFeePercent2 = lateFeePercent2;

  double _lateFeePercent3;
  double get lateFeePercent3 => _$this._lateFeePercent3;
  set lateFeePercent3(double lateFeePercent3) =>
      _$this._lateFeePercent3 = lateFeePercent3;

  double _lateFeePercentEndless;
  double get lateFeePercentEndless => _$this._lateFeePercentEndless;
  set lateFeePercentEndless(double lateFeePercentEndless) =>
      _$this._lateFeePercentEndless = lateFeePercentEndless;

  String _emailSubjectReminderEndless;
  String get emailSubjectReminderEndless => _$this._emailSubjectReminderEndless;
  set emailSubjectReminderEndless(String emailSubjectReminderEndless) =>
      _$this._emailSubjectReminderEndless = emailSubjectReminderEndless;

  String _emailBodyReminderEndless;
  String get emailBodyReminderEndless => _$this._emailBodyReminderEndless;
  set emailBodyReminderEndless(String emailBodyReminderEndless) =>
      _$this._emailBodyReminderEndless = emailBodyReminderEndless;

  bool _clientOnlinePaymentNotification;
  bool get clientOnlinePaymentNotification =>
      _$this._clientOnlinePaymentNotification;
  set clientOnlinePaymentNotification(bool clientOnlinePaymentNotification) =>
      _$this._clientOnlinePaymentNotification = clientOnlinePaymentNotification;

  bool _clientManualPaymentNotification;
  bool get clientManualPaymentNotification =>
      _$this._clientManualPaymentNotification;
  set clientManualPaymentNotification(bool clientManualPaymentNotification) =>
      _$this._clientManualPaymentNotification = clientManualPaymentNotification;

  String _counterNumberApplied;
  String get counterNumberApplied => _$this._counterNumberApplied;
  set counterNumberApplied(String counterNumberApplied) =>
      _$this._counterNumberApplied = counterNumberApplied;

  String _emailSendingMethod;
  String get emailSendingMethod => _$this._emailSendingMethod;
  set emailSendingMethod(String emailSendingMethod) =>
      _$this._emailSendingMethod = emailSendingMethod;

  String _gmailSendingUserId;
  String get gmailSendingUserId => _$this._gmailSendingUserId;
  set gmailSendingUserId(String gmailSendingUserId) =>
      _$this._gmailSendingUserId = gmailSendingUserId;

  String _clientPortalTerms;
  String get clientPortalTerms => _$this._clientPortalTerms;
  set clientPortalTerms(String clientPortalTerms) =>
      _$this._clientPortalTerms = clientPortalTerms;

  String _clientPortalPrivacy;
  String get clientPortalPrivacy => _$this._clientPortalPrivacy;
  set clientPortalPrivacy(String clientPortalPrivacy) =>
      _$this._clientPortalPrivacy = clientPortalPrivacy;

  String _lockInvoices;
  String get lockInvoices => _$this._lockInvoices;
  set lockInvoices(String lockInvoices) => _$this._lockInvoices = lockInvoices;

  String _autoBill;
  String get autoBill => _$this._autoBill;
  set autoBill(String autoBill) => _$this._autoBill = autoBill;

  bool _clientPortalAllowUnderPayment;
  bool get clientPortalAllowUnderPayment =>
      _$this._clientPortalAllowUnderPayment;
  set clientPortalAllowUnderPayment(bool clientPortalAllowUnderPayment) =>
      _$this._clientPortalAllowUnderPayment = clientPortalAllowUnderPayment;

  bool _clientPortalAllowOverPayment;
  bool get clientPortalAllowOverPayment => _$this._clientPortalAllowOverPayment;
  set clientPortalAllowOverPayment(bool clientPortalAllowOverPayment) =>
      _$this._clientPortalAllowOverPayment = clientPortalAllowOverPayment;

  String _autoBillDate;
  String get autoBillDate => _$this._autoBillDate;
  set autoBillDate(String autoBillDate) => _$this._autoBillDate = autoBillDate;

  double _clientPortalUnderPaymentMinimum;
  double get clientPortalUnderPaymentMinimum =>
      _$this._clientPortalUnderPaymentMinimum;
  set clientPortalUnderPaymentMinimum(double clientPortalUnderPaymentMinimum) =>
      _$this._clientPortalUnderPaymentMinimum = clientPortalUnderPaymentMinimum;

  String _useCreditsPayment;
  String get useCreditsPayment => _$this._useCreditsPayment;
  set useCreditsPayment(String useCreditsPayment) =>
      _$this._useCreditsPayment = useCreditsPayment;

  String _clientPortalCustomHeader;
  String get clientPortalCustomHeader => _$this._clientPortalCustomHeader;
  set clientPortalCustomHeader(String clientPortalCustomHeader) =>
      _$this._clientPortalCustomHeader = clientPortalCustomHeader;

  String _clientPortalCustomCss;
  String get clientPortalCustomCss => _$this._clientPortalCustomCss;
  set clientPortalCustomCss(String clientPortalCustomCss) =>
      _$this._clientPortalCustomCss = clientPortalCustomCss;

  String _clientPortalCustomFooter;
  String get clientPortalCustomFooter => _$this._clientPortalCustomFooter;
  set clientPortalCustomFooter(String clientPortalCustomFooter) =>
      _$this._clientPortalCustomFooter = clientPortalCustomFooter;

  String _clientPortalCustomJs;
  String get clientPortalCustomJs => _$this._clientPortalCustomJs;
  set clientPortalCustomJs(String clientPortalCustomJs) =>
      _$this._clientPortalCustomJs = clientPortalCustomJs;

  bool _hideEmptyColumnsOnPdf;
  bool get hideEmptyColumnsOnPdf => _$this._hideEmptyColumnsOnPdf;
  set hideEmptyColumnsOnPdf(bool hideEmptyColumnsOnPdf) =>
      _$this._hideEmptyColumnsOnPdf = hideEmptyColumnsOnPdf;

  bool _entitySendTime;
  bool get entitySendTime => _$this._entitySendTime;
  set entitySendTime(bool entitySendTime) =>
      _$this._entitySendTime = entitySendTime;

  bool _hasCustomDesign1;
  bool get hasCustomDesign1 => _$this._hasCustomDesign1;
  set hasCustomDesign1(bool hasCustomDesign1) =>
      _$this._hasCustomDesign1 = hasCustomDesign1;

  bool _hasCustomDesign2;
  bool get hasCustomDesign2 => _$this._hasCustomDesign2;
  set hasCustomDesign2(bool hasCustomDesign2) =>
      _$this._hasCustomDesign2 = hasCustomDesign2;

  bool _hasCustomDesign3;
  bool get hasCustomDesign3 => _$this._hasCustomDesign3;
  set hasCustomDesign3(bool hasCustomDesign3) =>
      _$this._hasCustomDesign3 = hasCustomDesign3;

  SettingsEntityBuilder();

  SettingsEntityBuilder get _$this {
    if (_$v != null) {
      _timezoneId = _$v.timezoneId;
      _dateFormatId = _$v.dateFormatId;
      _enableMilitaryTime = _$v.enableMilitaryTime;
      _languageId = _$v.languageId;
      _showCurrencyCode = _$v.showCurrencyCode;
      _currencyId = _$v.currencyId;
      _customValue1 = _$v.customValue1;
      _customValue2 = _$v.customValue2;
      _customValue3 = _$v.customValue3;
      _customValue4 = _$v.customValue4;
      _defaultPaymentTerms = _$v.defaultPaymentTerms;
      _defaultValidUntil = _$v.defaultValidUntil;
      _companyGatewayIds = _$v.companyGatewayIds;
      _defaultTaskRate = _$v.defaultTaskRate;
      _sendReminders = _$v.sendReminders;
      _enablePortal = _$v.enablePortal;
      _enablePortalDashboard = _$v.enablePortalDashboard;
      _enablePortalTasks = _$v.enablePortalTasks;
      _enablePortalUploads = _$v.enablePortalUploads;
      _emailStyle = _$v.emailStyle;
      _replyToEmail = _$v.replyToEmail;
      _replyToName = _$v.replyToName;
      _bccEmail = _$v.bccEmail;
      _pdfEmailAttachment = _$v.pdfEmailAttachment;
      _ublEmailAttachment = _$v.ublEmailAttachment;
      _documentEmailAttachment = _$v.documentEmailAttachment;
      _emailStyleCustom = _$v.emailStyleCustom;
      _customMessageDashboard = _$v.customMessageDashboard;
      _customMessageUnpaidInvoice = _$v.customMessageUnpaidInvoice;
      _customMessagePaidInvoice = _$v.customMessagePaidInvoice;
      _customMessageUnapprovedQuote = _$v.customMessageUnapprovedQuote;
      _autoArchiveInvoice = _$v.autoArchiveInvoice;
      _autoArchiveQuote = _$v.autoArchiveQuote;
      _autoEmailInvoice = _$v.autoEmailInvoice;
      _autoConvertQuote = _$v.autoConvertQuote;
      _enableInclusiveTaxes = _$v.enableInclusiveTaxes;
      _translations = _$v.translations?.toBuilder();
      _taskNumberPattern = _$v.taskNumberPattern;
      _taskNumberCounter = _$v.taskNumberCounter;
      _expenseNumberPattern = _$v.expenseNumberPattern;
      _expenseNumberCounter = _$v.expenseNumberCounter;
      _vendorNumberPattern = _$v.vendorNumberPattern;
      _vendorNumberCounter = _$v.vendorNumberCounter;
      _ticketNumberPattern = _$v.ticketNumberPattern;
      _ticketNumberCounter = _$v.ticketNumberCounter;
      _paymentNumberPattern = _$v.paymentNumberPattern;
      _paymentNumberCounter = _$v.paymentNumberCounter;
      _projectNumberPattern = _$v.projectNumberPattern;
      _projectNumberCounter = _$v.projectNumberCounter;
      _invoiceNumberPattern = _$v.invoiceNumberPattern;
      _invoiceNumberCounter = _$v.invoiceNumberCounter;
      _recurringInvoiceNumberPattern = _$v.recurringInvoiceNumberPattern;
      _recurringInvoiceNumberCounter = _$v.recurringInvoiceNumberCounter;
      _quoteNumberPattern = _$v.quoteNumberPattern;
      _quoteNumberCounter = _$v.quoteNumberCounter;
      _clientNumberPattern = _$v.clientNumberPattern;
      _clientNumberCounter = _$v.clientNumberCounter;
      _creditNumberPattern = _$v.creditNumberPattern;
      _creditNumberCounter = _$v.creditNumberCounter;
      _recurringNumberPrefix = _$v.recurringNumberPrefix;
      _resetCounterFrequencyId = _$v.resetCounterFrequencyId;
      _resetCounterDate = _$v.resetCounterDate;
      _counterPadding = _$v.counterPadding;
      _sharedInvoiceQuoteCounter = _$v.sharedInvoiceQuoteCounter;
      _sharedInvoiceCreditCounter = _$v.sharedInvoiceCreditCounter;
      _defaultInvoiceTerms = _$v.defaultInvoiceTerms;
      _defaultQuoteTerms = _$v.defaultQuoteTerms;
      _defaultQuoteFooter = _$v.defaultQuoteFooter;
      _defaultCreditTerms = _$v.defaultCreditTerms;
      _defaultCreditFooter = _$v.defaultCreditFooter;
      _defaultInvoiceDesignId = _$v.defaultInvoiceDesignId;
      _defaultQuoteDesignId = _$v.defaultQuoteDesignId;
      _defaultCreditDesignId = _$v.defaultCreditDesignId;
      _defaultInvoiceFooter = _$v.defaultInvoiceFooter;
      _defaultTaxName1 = _$v.defaultTaxName1;
      _defaultTaxRate1 = _$v.defaultTaxRate1;
      _defaultTaxName2 = _$v.defaultTaxName2;
      _defaultTaxRate2 = _$v.defaultTaxRate2;
      _defaultTaxName3 = _$v.defaultTaxName3;
      _defaultTaxRate3 = _$v.defaultTaxRate3;
      _defaultPaymentTypeId = _$v.defaultPaymentTypeId;
      _pdfVariables = _$v.pdfVariables?.toBuilder();
      _emailSignature = _$v.emailSignature;
      _emailSubjectInvoice = _$v.emailSubjectInvoice;
      _emailSubjectQuote = _$v.emailSubjectQuote;
      _emailSubjectCredit = _$v.emailSubjectCredit;
      _emailSubjectPayment = _$v.emailSubjectPayment;
      _emailSubjectPaymentPartial = _$v.emailSubjectPaymentPartial;
      _emailBodyInvoice = _$v.emailBodyInvoice;
      _emailBodyQuote = _$v.emailBodyQuote;
      _emailBodyCredit = _$v.emailBodyCredit;
      _emailBodyPayment = _$v.emailBodyPayment;
      _emailBodyPaymentPartial = _$v.emailBodyPaymentPartial;
      _emailSubjectReminder1 = _$v.emailSubjectReminder1;
      _emailSubjectReminder2 = _$v.emailSubjectReminder2;
      _emailSubjectReminder3 = _$v.emailSubjectReminder3;
      _emailBodyReminder1 = _$v.emailBodyReminder1;
      _emailBodyReminder2 = _$v.emailBodyReminder2;
      _emailBodyReminder3 = _$v.emailBodyReminder3;
      _emailSubjectCustom1 = _$v.emailSubjectCustom1;
      _emailBodyCustom1 = _$v.emailBodyCustom1;
      _emailSubjectCustom2 = _$v.emailSubjectCustom2;
      _emailBodyCustom2 = _$v.emailBodyCustom2;
      _emailSubjectCustom3 = _$v.emailSubjectCustom3;
      _emailBodyCustom3 = _$v.emailBodyCustom3;
      _emailSubjectStatement = _$v.emailSubjectStatement;
      _emailBodyStatement = _$v.emailBodyStatement;
      _enablePortalPassword = _$v.enablePortalPassword;
      _signatureOnPdf = _$v.signatureOnPdf;
      _enableEmailMarkup = _$v.enableEmailMarkup;
      _showAcceptInvoiceTerms = _$v.showAcceptInvoiceTerms;
      _showAcceptQuoteTerms = _$v.showAcceptQuoteTerms;
      _requireInvoiceSignature = _$v.requireInvoiceSignature;
      _requireQuoteSignature = _$v.requireQuoteSignature;
      _name = _$v.name;
      _companyLogo = _$v.companyLogo;
      _website = _$v.website;
      _address1 = _$v.address1;
      _address2 = _$v.address2;
      _city = _$v.city;
      _state = _$v.state;
      _postalCode = _$v.postalCode;
      _phone = _$v.phone;
      _email = _$v.email;
      _countryId = _$v.countryId;
      _vatNumber = _$v.vatNumber;
      _idNumber = _$v.idNumber;
      _pageSize = _$v.pageSize;
      _pageLayout = _$v.pageLayout;
      _fontSize = _$v.fontSize;
      _primaryColor = _$v.primaryColor;
      _secondaryColor = _$v.secondaryColor;
      _primaryFont = _$v.primaryFont;
      _secondaryFont = _$v.secondaryFont;
      _hidePaidToDate = _$v.hidePaidToDate;
      _embedDocuments = _$v.embedDocuments;
      _allPagesHeader = _$v.allPagesHeader;
      _allPagesFooter = _$v.allPagesFooter;
      _enableReminder1 = _$v.enableReminder1;
      _enableReminder2 = _$v.enableReminder2;
      _enableReminder3 = _$v.enableReminder3;
      _enableReminderEndless = _$v.enableReminderEndless;
      _numDaysReminder1 = _$v.numDaysReminder1;
      _numDaysReminder2 = _$v.numDaysReminder2;
      _numDaysReminder3 = _$v.numDaysReminder3;
      _scheduleReminder1 = _$v.scheduleReminder1;
      _scheduleReminder2 = _$v.scheduleReminder2;
      _scheduleReminder3 = _$v.scheduleReminder3;
      _endlessReminderFrequencyId = _$v.endlessReminderFrequencyId;
      _lateFeeAmount1 = _$v.lateFeeAmount1;
      _lateFeeAmount2 = _$v.lateFeeAmount2;
      _lateFeeAmount3 = _$v.lateFeeAmount3;
      _lateFeeAmountEndless = _$v.lateFeeAmountEndless;
      _lateFeePercent1 = _$v.lateFeePercent1;
      _lateFeePercent2 = _$v.lateFeePercent2;
      _lateFeePercent3 = _$v.lateFeePercent3;
      _lateFeePercentEndless = _$v.lateFeePercentEndless;
      _emailSubjectReminderEndless = _$v.emailSubjectReminderEndless;
      _emailBodyReminderEndless = _$v.emailBodyReminderEndless;
      _clientOnlinePaymentNotification = _$v.clientOnlinePaymentNotification;
      _clientManualPaymentNotification = _$v.clientManualPaymentNotification;
      _counterNumberApplied = _$v.counterNumberApplied;
      _emailSendingMethod = _$v.emailSendingMethod;
      _gmailSendingUserId = _$v.gmailSendingUserId;
      _clientPortalTerms = _$v.clientPortalTerms;
      _clientPortalPrivacy = _$v.clientPortalPrivacy;
      _lockInvoices = _$v.lockInvoices;
      _autoBill = _$v.autoBill;
      _clientPortalAllowUnderPayment = _$v.clientPortalAllowUnderPayment;
      _clientPortalAllowOverPayment = _$v.clientPortalAllowOverPayment;
      _autoBillDate = _$v.autoBillDate;
      _clientPortalUnderPaymentMinimum = _$v.clientPortalUnderPaymentMinimum;
      _useCreditsPayment = _$v.useCreditsPayment;
      _clientPortalCustomHeader = _$v.clientPortalCustomHeader;
      _clientPortalCustomCss = _$v.clientPortalCustomCss;
      _clientPortalCustomFooter = _$v.clientPortalCustomFooter;
      _clientPortalCustomJs = _$v.clientPortalCustomJs;
      _hideEmptyColumnsOnPdf = _$v.hideEmptyColumnsOnPdf;
      _entitySendTime = _$v.entitySendTime;
      _hasCustomDesign1 = _$v.hasCustomDesign1;
      _hasCustomDesign2 = _$v.hasCustomDesign2;
      _hasCustomDesign3 = _$v.hasCustomDesign3;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SettingsEntity;
  }

  @override
  void update(void Function(SettingsEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingsEntity build() {
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
              enablePortalUploads: enablePortalUploads,
              emailStyle: emailStyle,
              replyToEmail: replyToEmail,
              replyToName: replyToName,
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
              autoArchiveQuote: autoArchiveQuote,
              autoEmailInvoice: autoEmailInvoice,
              autoConvertQuote: autoConvertQuote,
              enableInclusiveTaxes: enableInclusiveTaxes,
              translations: _translations?.build(),
              taskNumberPattern: taskNumberPattern,
              taskNumberCounter: taskNumberCounter,
              expenseNumberPattern: expenseNumberPattern,
              expenseNumberCounter: expenseNumberCounter,
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
              counterNumberApplied: counterNumberApplied,
              emailSendingMethod: emailSendingMethod,
              gmailSendingUserId: gmailSendingUserId,
              clientPortalTerms: clientPortalTerms,
              clientPortalPrivacy: clientPortalPrivacy,
              lockInvoices: lockInvoices,
              autoBill: autoBill,
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
              hasCustomDesign1: hasCustomDesign1,
              hasCustomDesign2: hasCustomDesign2,
              hasCustomDesign3: hasCustomDesign3);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'translations';
        _translations?.build();

        _$failedField = 'pdfVariables';
        _pdfVariables?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SettingsEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
