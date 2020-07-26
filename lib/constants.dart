import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:flutter/foundation.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';

class Constants {
  static String get hostedApiUrl =>
      kReleaseMode ? kAppProductionUrl : kAppStagingUrl;
}

// TODO remove version once #46609 is fixed
const String kClientVersion = '5.0.15';
const String kMinServerVersion = '5.0.4';

const String kSiteUrl = 'https://invoiceninja.com';
//const String kAppProductionUrl = 'https://invoicing.co';
const String kAppProductionUrl =
    'https://staging.invoicing.co'; // TODO remove staging
const String kAppStagingUrl = 'https://staging.invoicing.co';
const String kAppDemoUrl = 'https://demo.invoiceninja.com';
const String kWhiteLabelUrl =
    'https://app.invoiceninja.com/buy_now/?account_key=AsFmBAeLXF0IKf7tmi0eiyZfmWW9hxMT&product_id=3';
const String kAppPlansURL =
    'https://www.invoiceninja.com/invoicing-pricing-plans/';
const String kPrivacyPolicyURL = 'https://www.invoiceninja.com/privacy-policy';
const String kTermsOfServiceURL = 'https://www.invoiceninja.com/terms';
const String kAppleStoreUrl =
    'https://itunes.apple.com/us/app/invoice-ninja/id1435514417?ls=1&mt=8';
const String kGoogleStoreUrl =
    'https://play.google.com/store/apps/details?id=com.invoiceninja.flutter';
const String kCapterralUrl = 'https://www.capterra.com/p/145215/Invoice-Ninja/';
const String kCronsHelpUrl =
    'https://invoiceninja.github.io/selfhost.html#cron-configuration';

enum AppEnvironment {
  hosted,
  selfhosted,
  demo,
  staging,
  develop,
}

const String kSharedPrefs = 'shared_prefs';
const String kSharedPrefAppVersion = 'app_version';
const String kSharedPrefEmail = 'email';
const String kSharedPrefUrl = 'url';
const String kSharedPrefToken = 'checksum';

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
const double kTopBottomBarHeight = 50;
const double kDashboardPanelHeight = 501; // TODO remove this

const double kTabletLayoutWidth = 1100;
const double kTabletDialogPadding = 250;

const double kTableColumnWidthMin = 50;
const double kTableColumnWidthMax = 120;

const int kTableListWidthCutoff = 500;
const int kDefaultAnimationDuration = 500;

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
const String kPlanWhiteLabel = 'white_label';

const double kGutterWidth = 16;

const int kMaxNumberOfCompanies = 10;
const int kMaxNumberOfHistory = 50;
const int kMaxRecordsPerApiPage = 5000;
const int kMaxPostSeconds = 120;
const int kMillisecondsToRefreshData = 1000 * 60 * 15; // 15 minutes
const int kUpdatedAtBufferSeconds = 600;
const int kMillisecondsToRefreshActivities = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToRefreshStaticData = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToReenterPassword = 1000 * 60 * 30; // 30 minutes
const int kMillisecondsToDebounceStateSave = 1000 * 2; // 2 seconds

const String kLanguageEnglish = '1';

const String kCurrencyAll = '-1';
const String kCurrencyUSDollar = '1';
const String kCurrencyEuro = '3';

const String kCountryUnitedStates = '840';

/*
const EVENT_CREATE_CLIENT = 1;
const EVENT_CREATE_INVOICE = 2;
const EVENT_CREATE_QUOTE = 3;
const EVENT_CREATE_PAYMENT = 4;
const EVENT_CREATE_VENDOR = 5;
const EVENT_UPDATE_QUOTE = 6;
const EVENT_DELETE_QUOTE = 7;
const EVENT_UPDATE_INVOICE = 8;
const EVENT_DELETE_INVOICE = 9;
const EVENT_UPDATE_CLIENT = 10;
const EVENT_DELETE_CLIENT = 11;
const EVENT_DELETE_PAYMENT = 12;
const EVENT_UPDATE_VENDOR = 13;
const EVENT_DELETE_VENDOR = 14;
const EVENT_CREATE_EXPENSE = 15;
const EVENT_UPDATE_EXPENSE = 16;
const EVENT_DELETE_EXPENSE = 17;
const EVENT_CREATE_TASK = 18;
const EVENT_UPDATE_TASK = 19;
const EVENT_DELETE_TASK = 20;
const EVENT_APPROVE_QUOTE = 21;
*/

const String kInvoiceStatusPastDue = '-1';
const String kInvoiceStatusDraft = '1';
const String kInvoiceStatusSent = '2';
const String kInvoiceStatusPartial = '3';
const String kInvoiceStatusPaid = '4';
const String kInvoiceStatusCancelled = '5';
const String kInvoiceStatusReversed = '6';

const kInvoiceStatuses = {
  kInvoiceStatusPastDue: 'past_due',
  kInvoiceStatusDraft: 'draft',
  kInvoiceStatusSent: 'sent',
  kInvoiceStatusPartial: 'partial',
  kInvoiceStatusPaid: 'paid',
  kInvoiceStatusCancelled: 'cancelled',
  kInvoiceStatusReversed: 'reversed',
};

const String kQuoteStatusExpired = '-1';
const String kQuoteStatusDraft = '1';
const String kQuoteStatusSent = '2';
const String kQuoteStatusApproved = '3';
const String kQuoteStatusConverted = '4';

const kQuoteStatuses = {
  kQuoteStatusExpired: 'expired',
  kQuoteStatusDraft: 'draft',
  kQuoteStatusSent: 'sent',
  kQuoteStatusApproved: 'approved',
  kQuoteStatusConverted: 'converted',
};

const String kCreditStatusDraft = '1';
const String kCreditStatusSent = '2';
const String kCreditStatusPartial = '3';
const String kCreditStatusApplied = '4';

const kCreditStatuses = {
  kCreditStatusDraft: 'draft',
  kCreditStatusSent: 'sent',
  kCreditStatusPartial: 'partial',
  kCreditStatusApplied: 'applied',
};

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

const String kNotificationChannelEmail = 'email';
const String kNotificationChannelSlack = 'slack';

const String kNotificationsAll = 'all_notifications';
const String kNotificationsAllUser = 'all_user_notifications';
const String kNotificationsPaymentSuccess = 'payment_success';
const String kNotificationsPaymentFailure = 'payment_failure';
const String kNotificationsInvoiceSent = 'invoice_sent';
const String kNotificationsQuoteSent = 'quote_sent';
const String kNotificationsCreditSent = 'credit_sent';
const String kNotificationsQuoteViewed = 'quote_viewed';
const String kNotificationsInvoiceViewed = 'invoice_viewed';
const String kNotificationsCreditViewed = 'credit_viewed';
const String kNotificationsQuoteApproved = 'quote_approved';

const kNotificationEvents = [
  kNotificationsInvoiceSent,
  kNotificationsInvoiceViewed,
  kNotificationsPaymentSuccess,
  kNotificationsPaymentFailure,
  kNotificationsQuoteSent,
  kNotificationsQuoteViewed,
  kNotificationsQuoteApproved,
  kNotificationsCreditSent,
  kNotificationsCreditViewed,
];

const String kGatewayStripe = 'd14dd26a37cecc30fdd65700bfb55b23';

const String kClientPortalModeSubdomain = 'subdomain';
const String kClientPortalModeDomain = 'domain';
const String kClientPortalModeIFrame = 'iframe';

const String kGenerateNumberWhenSaved = 'when_saved';
const String kGenerateNumberWhenSent = 'when_sent';
//const String kNumberGeneratedWhenPaid = 'paid';

const String kDesignHeader = 'header';
const String kDesignBody = 'body';
const String kDesignFooter = 'footer';
const String kDesignProducts = 'product';
const String kDesignTasks = 'task';
const String kDesignIncludes = 'includes';

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

const String kAgeGroup0 = 'age_group_0';
const String kAgeGroup30 = 'age_group_30';
const String kAgeGroup60 = 'age_group_60';
const String kAgeGroup90 = 'age_group_90';
const String kAgeGroup120 = 'age_group_120';

const kAgeGroups = {
  kAgeGroup0: 0,
  kAgeGroup30: 30,
  kAgeGroup60: 60,
  kAgeGroup90: 90,
  kAgeGroup120: 120,
};

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
const String kSettingsPaymentTerms = 'payment_terms';
const String kSettingsPaymentTermView = 'payment_term_view';
const String kSettingsPaymentTermEdit = 'payment_term_edit';
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
const String kSettingsProducts = 'product_settings';
const String kSettingsImportExport = 'import_export';
const String kSettingsDeviceSettings = 'device_settings';
const String kSettingsGroupSettings = 'group_settings';
const String kSettingsGroupSettingsView = 'group_settings_view';
const String kSettingsGroupSettingsEdit = 'group_settings_edit';
const String kSettingsCustomFields = 'custom_fields';
const String kSettingsCustomDesigns = 'custom_designs';
const String kSettingsCustomDesignsView = 'custom_designs_view';
const String kSettingsCustomDesignsEdit = 'custom_designs_edit';
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
const String kSettingsAccountManagement = 'account_management';
const String kSettingsTokens = 'tokens';
const String kSettingsTokenView = 'token_view';
const String kSettingsTokenEdit = 'token_edit';
const String kSettingsWebhooks = 'webhook';
const String kSettingsWebhookView = 'webhook_view';
const String kSettingsWebhookEdit = 'webhook_edit';

const kEntitySettings = [
  EntityType.group,
  EntityType.companyGateway,
  EntityType.taxRate,
  EntityType.design,
  EntityType.user,
];

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

const String kPdfFieldsClientDetails = 'client_details';
const String kPdfFieldsCompanyDetails = 'company_details';
const String kPdfFieldsCompanyAddress = 'company_address';
const String kPdfFieldsInvoiceDetails = 'invoice_details';
const String kPdfFieldsQuoteDetails = 'quote_details';
const String kPdfFieldsCreditDetails = 'credit_details';
const String kPdfFieldsProductColumns = 'product_columns';
const String kPdfFieldsTaskColumns = 'task_columns';

const String kPdfFields = '';
const String kPermissionCreateAll = 'create_all';
const String kPermissionViewAll = 'view_all';
const String kPermissionEditAll = 'edit_all';

const String kPaymentStatusPending = '1';
const String kPaymentStatusCancelled = '2';
const String kPaymentStatusFailed = '3';
const String kPaymentStatusCompleted = '4';
const String kPaymentStatusPartiallyRefunded = '5';
const String kPaymentStatusRefunded = '6';

const kPaymentStatuses = {
  kPaymentStatusPending: 'pending',
  kPaymentStatusCancelled: 'cancelled',
  kPaymentStatusFailed: 'failed',
  kPaymentStatusCompleted: 'completed',
  kPaymentStatusPartiallyRefunded: 'partially_refunded',
  kPaymentStatusRefunded: 'refunded',
};

const String kExpenseStatusLogged = '1';
const String kExpenseStatusPending = '2';
const String kExpenseStatusInvoiced = '3';

const String kDefaultCurrencyId = '1';
const String kDefaultDateFormat = '5';
const String kDefaultAccentColor = '#0091EA';
const String kDefaultDarkSelectedColorMenu = '#1E252F';
const String kDefaultDarkSelectedColor = '#253750';
const String kDefaultDarkBorderColor = '#393A3C';
const String kDefaultLightSelectedColorMenu = '#f2faff';
const String kDefaultLightSelectedColor = '#e5f5ff';
const String kDefaultLightBorderColor = '#E7EBEE';

const String kReportGroupDay = 'day';
const String kReportGroupMonth = 'month';
const String kReportGroupYear = 'year';

const int kModuleRecurringInvoices = 1;
const int kModuleCredits = 2;
const int kModuleQuotes = 4;
const int kModuleTasks = 8;
const int kModuleExpenses = 16;
const int kModuleProjects = 32;
const int kModuleVendors = 64;
const int kModuleTickets = 128;
const int kModuleProposals = 256;
const int kModuleRecurringExpenses = 512;
const int kModuleRecurringTasks = 1024;
const int kModuleRecurringQuotes = 2048;
const int kModuleInvoices = 4096;
const int kModuleProformaInvoices = 8192;
const int kModulePurchaseOrders = 16384;

Color kColorRed = convertHexStringToColor('#8D3E3F');
Color kColorGreen = convertHexStringToColor('#407535');

const Map<int, String> kModules = {
  kModuleQuotes: 'quotes',
  kModuleCredits: 'credits',
  kModuleProjects: 'projects',
  kModuleTasks: 'tasks',
  kModuleVendors: 'vendors',
  kModuleExpenses: 'expenses',
  kModuleProposals: 'proposals',
  kModuleTickets: 'tickets',
  kModuleRecurringInvoices: 'recurring_invoices',
  kModuleRecurringTasks: 'recurring_tasks',
  kModuleRecurringExpenses: 'recurring_expenses',
  kModuleRecurringQuotes: 'recurring_quotes',
  kModuleInvoices: 'invoices',
};

class InvoiceStatusColors {
  static var colors = {
    kInvoiceStatusDraft: convertHexStringToColor('#444444'),
    kInvoiceStatusSent: convertHexStringToColor('#505F73'),
    //kInvoiceStatusViewed: Colors.orange,
    //kInvoiceStatusApproved: Colors.green,
    kInvoiceStatusPartial: Colors.deepPurple,
    kInvoiceStatusPaid: kColorGreen,
    kInvoiceStatusPastDue: kColorRed,
    kInvoiceStatusCancelled: Colors.black,
    kInvoiceStatusReversed: Colors.black,
  };
}

class CreditStatusColors {
  static var colors = {
    kCreditStatusDraft: convertHexStringToColor('#444444'),
    kCreditStatusSent: convertHexStringToColor('#505F73'),
    //kInvoiceStatusViewed: Colors.orange,
    //kInvoiceStatusApproved: Colors.green,
    kCreditStatusPartial: Colors.deepPurple,
    kCreditStatusApplied: kColorGreen,
  };
}

class QuoteStatusColors {
  static var colors = {
    kQuoteStatusDraft: convertHexStringToColor('#444444'),
    kQuoteStatusSent: convertHexStringToColor('#505F73'),
    kQuoteStatusApproved: Colors.deepPurple,
    kQuoteStatusConverted: kColorGreen,
    kQuoteStatusExpired: kColorRed,
  };
}

class PaymentStatusColors {
  static var colors = {
    kPaymentStatusPending: convertHexStringToColor('#505F73'),
    kPaymentStatusCancelled: kColorRed,
    kPaymentStatusFailed: kColorRed,
    kPaymentStatusCompleted: kColorGreen,
    kPaymentStatusPartiallyRefunded: Colors.purple,
    kPaymentStatusRefunded: convertHexStringToColor('#8D3E3F'),
  };
}

class ExpenseStatusColors {
  static var colors = {
    kExpenseStatusLogged: convertHexStringToColor('#505F73'),
    kExpenseStatusPending: Colors.orange,
    kExpenseStatusInvoiced: kColorGreen,
  };
}

const List<int> kPaymentTerms = [0, -1, 7, 10, 14, 15, 30, 60, 90];

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
  '1': 'january',
  '2': 'february',
  '3': 'march',
  '4': 'april',
  '5': 'may',
  '6': 'june',
  '7': 'july',
  '8': 'august',
  '9': 'september',
  '10': 'october',
  '11': 'november',
  '12': 'december',
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

const String kDrawerKey = 'drawer_key';

const String kActivityCreateClient = '1';
const String kActivityArchiveClient = '2';
const String kActivityDeleteClient = '3';
const String kActivityCreateInvoice = '4';
const String kActivityUpdateInvoice = '5';
const String kActivityEmailInvoice = '6';
const String kActivityViewInvoice = '7';
const String kActivityArchiveInvoice = '8';
const String kActivityDeleteInvoice = '9';
const String kActivityCreatePayment = '10';
const String kActivityUpdatePayment = '11';
const String kActivityArchivePayment = '12';
const String kActivityDeletePayment = '13';
const String kActivityCreateCredit = '14';
const String kActivityUpdateCredit = '15';
const String kActivityArchiveCredit = '16';
const String kActivityDeleteCredit = '17';
const String kActivityCreateQuote = '18';
const String kActivityUpdateQuote = '19';
const String kActivityEmailQuote = '20';
const String kActivityViewQuote = '21';
const String kActivityArchiveQuote = '22';
const String kActivityDeleteQuote = '23';
const String kActivityRestoreQuote = '24';
const String kActivityRestoreInvoice = '25';
const String kActivityRestoreClient = '26';
const String kActivityRestorePayment = '27';
const String kActivityRestoreCredit = '28';
const String kActivityApproveQuote = '29';
const String kActivityCreateVendor = '30';
const String kActivityArchiveVendor = '31';
const String kActivityDeleteVendor = '32';
const String kActivityRestoreVendor = '33';
const String kActivityCreateExpense = '34';
const String kActivityArchiveExpense = '35';
const String kActivityDeleteExpense = '36';
const String kActivityRestoreExpense = '37';
const String kActivityVoidedPayment = '39';
const String kActivityRefundedPayment = '40';
const String kActivityFailedPayment = '41';
const String kActivityCreateTask = '42';
const String kActivityUpdateTask = '43';
const String kActivityArchiveTask = '44';
const String kActivityDeleteTask = '45';
const String kActivityRestoreTask = '46';
const String kActivityUpdateExpense = '47';
const String kActivityCreateUser = '48';
const String kActivityUpdateUser = '49';
const String kActivityArchiveUser = '50';
const String kActivityDeleteUser = '51';
const String kActivityRestoreUser = '52';
const String kActivityMarkSentInvoice = '53';
const String kActivityPaidInvoice = '54';
const String kActivityEmailInvoiceFailed = '57';
const String kActivityReversedInvoice = '58';
const String kActivityCancelledInvoice = '59';
