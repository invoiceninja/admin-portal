import 'package:flutter/material.dart';

// This version must be updated in tandem with the pubspec version.
const String kAppVersion = '2.0.2';
const String kSiteUrl = 'https://invoiceninja.com';
//const String kAppUrl = 'https://admin.invoiceninja.com';
const String kAppUrl = 'https://staging.invoicing.co';
//const String kAppUrl = '';

const String kAppPlansURL =
    'https://www.invoiceninja.com/invoicing-pricing-plans/';
const String kPrivacyPolicyURL = 'https://www.invoiceninja.com/privacy-policy';
const String kTermsOfServiceURL = 'https://www.invoiceninja.com/terms';

const String kAppleStoreUrl =
    'https://itunes.apple.com/us/app/invoice-ninja/id1435514417?ls=1&mt=8';
const String kGoogleStoreUrl =
    'https://play.google.com/store/apps/details?id=com.invoiceninja.flutter';

const String kSharedPrefs = 'shared_prefs';
const String kSharedPrefAppVersion = 'app_version';
const String kSharedPrefEmail = 'email';
const String kSharedPrefUrl = 'url';
const String kSharedPrefSecret = 'secret';
const String kSharedPrefToken = 'api_token';

// TODO remove these
const String kSharedPrefAddDocumentsToInvoice = 'add_documents_to_invoice';
const String kSharedPrefEmailPayment = 'email_payment';
const String kSharedPrefAutoStartTasks = 'auto_start_tasks';

const String kProductPlanPro = 'v1_pro_yearly';
const String kProductPlanEnterprise2 = 'v1_enterprise_2_yearly';
const String kProductPlanEnterprise5 = 'v1_enterprise_5_yearly';
const String kProductPlanEnterprise10 = 'v1_enterprise_10_yearly';
const String kProductPlanEnterprise20 = 'v1_enterprise_20_yearly';

const kProductPlans = [
  kProductPlanPro,
  kProductPlanEnterprise2,
  kProductPlanEnterprise5,
  kProductPlanEnterprise10,
  kProductPlanEnterprise20,
];

const double kMobileLayoutWidth = 700;
const double kMobileDialogPadding = 12;
const double kDrawerWidth = 300;
const double kTableColumnGap = 20;

const double kTabletLayoutWidth = 1000;
const double kTabletDialogPadding = 250;

const int kCardTypeVisa = 1;
const int kCardTypeMasterCard = 2;
const int kCardTypeAmEx = 4;
const int kCardTypeDiners = 8;
const int kCardTypeDiscover = 16;

const String kPaymentTypeVisa = '6';
const String kPaymentTypeMasterCard = '7';
const String kPaymentTypeAmEx = '8';
const String kPaymentTypeDiners = '9';
const String kPaymentTypeDiscover = '10';

const String kPlanFree = '';
const String kPlanPro = 'pro';
const String kPlanEnterprise = 'enterprise';

const double kGutterWidth = 20;

const int kMinMajorAppVersion = 0;
const int kMinMinorAppVersion = 0;
const int kMinPatchAppVersion = 0;
const int kDebounceDelay = 300;
const int kMaxNumberOfCompanies = 10;
const int kMaxNumberOfHistory = 50;
const int kMaxRecordsPerApiPage = 5000;
const int kMaxPostSeconds = 120;
const int kMillisecondsToRefreshData = 1000 * 60 * 15; // 15 minutes
const int kMillisecondsToRefreshActivities = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToRefreshStaticData = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToReenterPassword = 1000 * 60 * 10; // 10 minutes
const int kMillisecondsToDebounceStateSave = 1000 * 1; // 3 seconds
const int kUpdatedAtBufferSeconds = 600;

const String kLanguageEnglish = '1';

const String kCurrencyAll = '-1';
const String kCurrencyUSDollar = '1';
const String kCurrencyEuro = '3';

const String kCountryUnitedStates = '840';

const String kInvoiceStatusPastDue = '-1';
const String kInvoiceStatusDraft = '1';
const String kInvoiceStatusSent = '2';
const String kInvoiceStatusPartial = '3';
const String kInvoiceStatusPaid = '4';

const String kQuoteStatusExpired = '-1';
const String kQuoteStatusDraft = '1';
const String kQuoteStatusSent = '2';
const String kQuoteStatusApproved = '4';

const String kGatewayTypeCreditCard = '1';
const String kGatewayTypeBankTransfer = '2';
const String kGatewayTypePayPal = '3';
const String kGatewayTypeBitcoin = '4';
//const String kGatewayTypeDwolla = '5';
const String kGatewayTypeCustom = '6';
const String kGatewayTypeAlipay = '7';
const String kGatewayTypeSofort = '8';
const String kGatewayTypeGoCardless = '9';
const String kGatewayTypeApplePay = '10';

const kGatewayTypes = {
  kGatewayTypeCreditCard: 'credit_card',
  kGatewayTypeBankTransfer: 'bank_transfer',
  kGatewayTypePayPal: 'paypal',
  kGatewayTypeBitcoin: 'bitcoin',
  kGatewayTypeCustom: 'custom',
  kGatewayTypeAlipay: 'alipay',
  kGatewayTypeSofort: 'sofort',
  kGatewayTypeGoCardless: 'gocardless',
  kGatewayTypeApplePay: 'apple_pay',
};

const String kGatewayStripe = 'd14dd26a37cecc30fdd65700bfb55b23';

const String kClientPortalModeSubdomain = 'subdomain';
const String kClientPortalModeDomain = 'domain';
const String kClientPortalModeIFrame = 'iframe';

const String kGenerateNumberWhenSaved = 'when_saved';
const String kGenerateNumberWhenSent = 'when_sent';
//const String kNumberGeneratedWhenPaid = 'paid';

const String kEmailDesignPlain = 'plain';
const String kEmailDesignLight = 'light';
const String kEmailDesignDark = 'dark';
const String kEmailDesignCustom = 'custom';

const String kEntityStateActive = 'active';
const String kEntityStateArchived = 'archived';
const String kEntityStateDeleted = 'deleted';

const String kFieldTypeSingleLineText = 'single_line_text';
const String kFieldTypeMultiLineText = 'multi_line_text';
const String kFieldTypeDropdown = 'dropdown';
const String kFieldTypeDate = 'date';
const String kFieldTypeSwitch = 'switch';

const String kSwitchValueYes = 'yes';
const String kSwitchValueNo = 'no';

const String kTaskStatusLogged = '-1';
const String kTaskStatusRunning = '-2';
const String kTaskStatusInvoiced = '-3';

const String kMain = 'main';
const String kSettings = 'settings';
const String kDashboard = 'dashboard';
const String kReports = 'reports';

/*
const String kEmailTemplateInvoice = 'invoice_email';
const String kEmailTemplateQuote = 'quote_email';
const String kEmailTemplatePayment = 'payment_email';
const String kEmailTemplateReminder1 = 'first_reminder';
const String kEmailTemplateReminder2 = 'second_reminder';
const String kEmailTemplateReminder3 = 'third_reminder';
const String kEmailTemplateReminder4 = 'endless_reminder';
const String kEmailTemplateCustom1 = 'first_custom';
const String kEmailTemplateCustom2 = 'second_custom';
const String kEmailTemplateCustom3 = 'third_custom';
*/

const String kReminderScheduleAfterInvoiceDate = 'after_invoice_date';
const String kReminderScheduleBeforeDueDate = 'before_due_date';
const String kReminderScheduleAfterDueDate = 'after_due_date';

const String kSettingsCompanyDetails = 'company_details';
const String kSettingsUserDetails = 'user_details';
const String kSettingsLocalization = 'localization';
const String kSettingsOnlinePayments = 'online_payments';
const String kSettingsOnlinePaymentsView = 'online_payments_view';
const String kSettingsOnlinePaymentsEdit = 'online_payments_edit';
const String kSettingsTaxSettings = 'tax_settings';
const String kSettingsTaxRates = 'tax_settings_rates';
const String kSettingsTaxRatesView = 'tax_settings_rates_view';
const String kSettingsTaxRatesEdit = 'tax_settings_rates_edit';
const String kSettingsIntegrations = 'integrations';
const String kSettingsProducts = 'products';
const String kSettingsImportExport = 'import_export';
const String kSettingsDeviceSettings = 'device_settings';
const String kSettingsGroupSettings = 'group_settings';
const String kSettingsGroupSettingsView = 'group_settings_view';
const String kSettingsGroupSettingsEdit = 'group_settings_edit';
const String kSettingsCustomFields = 'custom_fields';
const String kSettingsGeneratedNumbers = 'generated_numbers';
const String kSettingsWorkflowSettings = 'workflow_settings';
const String kSettingsInvoiceDesign = 'invoice_design';
const String kSettingsClientPortal = 'client_portal';
const String kSettingsBuyNowButtons = 'buy_now_buttons';
const String kSettingsEmailSettings = 'email_settings';
const String kSettingsTemplatesAndReminders = 'templates_and_reminders';
const String kSettingsCreditCardsAndBanks = 'credit_cards_and_banks';
const String kSettingsDataVisualizations = 'data_visualizations';
const String kSettingsApiTokens = 'api_tokens';
const String kSettingsUserManagement = 'user_management';
const String kSettingsUserManagementView = 'user_management_view';
const String kSettingsUserManagementEdit = 'user_management_edit';

const String kReportAging = 'aging';
const String kReportClient = 'client';
const String kReportCredit = 'credit';
const String kReportDocument = 'document';
const String kReportExpense = 'expense';
const String kReportInvoice = 'invoice';
const String kReportPayment = 'payment';
const String kReportProduct = 'product';
const String kReportProfitAndLoss = 'profitAndLoss';
const String kReportTask = 'task';
const String kReportTaxRate = 'taxRate';
const String kReportQuote = 'quote';

const String kPermissionCreateAll = 'create_all';
const String kPermissionViewAll = 'view_all';
const String kPermissionEditAll = 'edit_all';

const String kPaymentStatusPending = '1';
const String kPaymentStatusVoided = '2';
const String kPaymentStatusFailed = '3';
const String kPaymentStatusCompleted = '4';
const String kPaymentStatusPartiallyRefunded = '5';
const String kPaymentStatusRefunded = '6';

const String kExpenseStatusLogged = '1';
const String kExpenseStatusPending = '2';
const String kExpenseStatusInvoiced = '3';

const String kDefaultCurrencyId = '1';
const String kDefaultDateFormat = '5';
const String kDefaultAccentColor = '#0091EA';

const String kReportGroupDay = 'day';
const String kReportGroupMonth = 'month';
const String kReportGroupYear = 'year';

const String kActivityEmailInvoice = '6';

const int kModuleRecurringInvoice = 1;
const int kModuleCredit = 2;
const int kModuleQuote = 4;
const int kModuleTask = 8;
const int kModuleExpense = 16;

class InvoiceStatusColors {
  static const colors = {
    kInvoiceStatusDraft: Colors.grey,
    kInvoiceStatusSent: Colors.blue,
    //kInvoiceStatusViewed: Colors.orange,
    //kInvoiceStatusApproved: Colors.green,
    kInvoiceStatusPartial: Colors.deepPurple,
    kInvoiceStatusPaid: Colors.green,
  };
}

class QuoteStatusColors {
  static const colors = {
    kQuoteStatusDraft: Colors.grey,
    kQuoteStatusSent: Colors.blue,
    //kQuoteStatusViewed: Colors.orange,
    kQuoteStatusApproved: Colors.green,
  };
}

class PaymentStatusColors {
  static const colors = {
    kPaymentStatusPending: Colors.grey,
    kPaymentStatusVoided: Colors.red,
    kPaymentStatusFailed: Colors.red,
    kPaymentStatusCompleted: Colors.green,
    kPaymentStatusPartiallyRefunded: Colors.purple,
    kPaymentStatusRefunded: Colors.red,
  };
}

class ExpenseStatusColors {
  static const colors = {
    kExpenseStatusLogged: Colors.grey,
    kExpenseStatusPending: Colors.orange,
    kExpenseStatusInvoiced: Colors.green,
  };
}

const List<int> kPaymentTerms = [0, -1, 7, 10, 14, 15, 30, 60, 90];

const String kDesignCustom1 = 'Custom 1';
const String kDesignCustom2 = 'Custom 2';
const String kDesignCustom3 = 'Custom 3';

const Map<String, String> kInvoiceDesigns = {
  '1': 'Clean',
  '2': 'Bold',
  '3': 'Modern',
  '4': 'Plain',
  '5': 'Business',
  '6': 'Creative',
  '7': 'Elegant',
  '8': 'Hipster',
  '9': 'Playful',
  '10': 'Photo',
  '11': kDesignCustom1,
  '12': kDesignCustom2,
  '13': kDesignCustom3,
};

const List<String> kLanguages = [
  'ca',
  'cs',
  'da',
  'de',
  'el',
  'en',
  'en_GB',
  'en_AU',
  'es',
  'es_ES',
  'fi',
  'fr',
  'fr_CA',
  'hr',
  'it',
  'ja',
  'lt',
  'mk_MK',
  'nb_NO',
  'nl',
  'pl',
  'pt_BR',
  'pt_PT',
  'ro',
  'sl',
  'sq',
  'sr_RS',
  'sv',
  'th',
  'tr_TR',
  'bg',
];

const kDaysOfTheWeek = {
  '0': 'sunday',
  '1': 'monday',
  '2': 'tuesday',
  '3': 'wednesday',
  '4': 'thursday',
  '5': 'friday',
  '6': 'saturday',
};

const kMonthsOfTheYear = {
  '0': 'january',
  '1': 'february',
  '2': 'march',
  '3': 'april',
  '4': 'may',
  '5': 'june',
  '6': 'july',
  '7': 'august',
  '8': 'september',
  '9': 'october',
  '10': 'november',
  '11': 'december',
};

const kFrequencies = {
  '1': 'freq_daily',
  '2': 'freq_weekly',
  '3': 'freq_two_weeks',
  '4': 'freq_four_weeks',
  '5': 'freq_monthly',
  '6': 'freq_two_months',
  '7': 'freq_three_months',
  '8': 'freq_four_months',
  '9': 'freq_six_months',
  '10': 'freq_annually',
  '11': 'freq_two_years',
  '12': 'freq_three_years',
};

const kPageSizes = [
  'A0',
  'A1',
  'A2',
  'A3',
  'A4',
  'A5',
  'A6',
  'A7',
  'A8',
  'A9',
  'A10',
  'B0',
  'B1',
  'B2',
  'B3',
  'B4',
  'B5',
  'B6',
  'B7',
  'B8',
  'B9',
  'B10',
  'C0',
  'C1',
  'C2',
  'C3',
  'C4',
  'C5',
  'C6',
  'C7',
  'C8',
  'C9',
  'C10',
  'RA0',
  'RA1',
  'RA2',
  'RA3',
  'RA4',
  'SRA0',
  'SRA1',
  'SRA2',
  'SRA3',
  'SRA4',
  'Executive',
  'Folio',
  'Legal',
  'Letter',
  'Tabloid',
];
