class Constants {
  //static String get hostedApiUrl => kReleaseMode ? kAppProductionUrl : kAppStagingUrl;
  static String get hostedApiUrl => kAppProductionUrl;
}

// TODO remove version once #46609 is fixed
const String kClientVersion = '5.0.48';
const String kMinServerVersion = '5.0.4';

const String kAppName = 'Invoice Ninja';
const String kSiteUrl = 'https://invoiceninja.com';
const String kAppProductionUrl = 'https://invoicing.co';
const String kAppStagingUrl = 'https://staging.invoicing.co';
const String kAppDemoUrl = 'https://demo.invoiceninja.com';
const String kWhiteLabelUrl =
    'https://app.invoiceninja.com/buy_now/?account_key=AsFmBAeLXF0IKf7tmi0eiyZfmWW9hxMT&product_id=3';
const String kAppPlansURL =
    'https://www.invoiceninja.com/invoicing-pricing-plans/';
const String kPrivacyPolicyURL = 'https://www.invoiceninja.com/privacy-policy';
const String kTermsOfServiceURL = 'https://www.invoiceninja.com/terms';
const String kTransifexURL =
    'https://www.transifex.com/invoice-ninja/invoice-ninja/';

//const String kAppleStoreUrl = 'https://itunes.apple.com/us/app/invoice-ninja/id1435514417?ls=1&mt=8';
//const String kGoogleStoreUrl = 'https://play.google.com/store/apps/details?id=com.invoiceninja.flutter';

//const String kSourceCodeBackend = 'https://github.com/invoiceninja/invoiceninja';
const String kSourceCodeBackend =
    'https://github.com/invoiceninja/invoiceninja/tree/v5-stable';
const String kSourceCodeFrontend =
    'https://github.com/invoiceninja/flutter-client';
const String kSourceCodeFrontendSDK = 'https://pub.dev/packages/invoiceninja';

const String kAppleStoreUrl = 'https://testflight.apple.com/join/MJ6WpaXh';
const String kGoogleStoreUrl =
    'https://play.google.com/apps/testing/com.invoiceninja.app';
const String kGoogleFDroidUrl =
    'https://f-droid.org/packages/com.invoiceninja.app/';
const String kMacOSUrl = 'http://download.invoiceninja.com/macos';
const String kLinuxUrl = 'http://download.invoiceninja.com/linux';

const String kDocsUrl = 'https://invoiceninja.github.io/docs/getting-started/';
const String kForumUrl = 'https://forum.invoiceninja.com';
const String kApiDocsURL =
    'https://app.swaggerhub.com/apis/invoiceninja/invoiceninja';
const String kZapierURL =
    'https://zapier.com/developer/public-invite/95884/5e4368b9efb9d377dc0a0b0465b7c1a7';

const String kDebugModeUrl =
    'https://www.mailgun.com/blog/a-word-of-caution-for-laravel-developers/';
const String kCapterralUrl = 'https://www.capterra.com/p/145215/Invoice-Ninja/';
const String kCronsHelpUrl =
    'https://invoiceninja.github.io/docs/self-host-troubleshooting/#cron-not-running-queue-not-running';
const String kGitHubDiffUrl =
    'https://github.com/invoiceninja/invoiceninja/compare/vVERSION...v5-stable';
const String kGitHubLangUrl =
    'https://github.com/invoiceninja/invoiceninja/blob/master/resources/lang/en/texts.php';

enum AppEnvironment {
  hosted,
  selfhosted,
  testing,
  demo,
  staging,
  develop,
}

const String kSharedPrefs = 'shared_prefs';
const String kSharedPrefAppVersion = 'app_version';
const String kSharedPrefUrl = 'url';
const String kSharedPrefToken = 'checksum';

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
const double kDialogWidth = 400;
const double kDashboardPanelHeight = 548; // TODO remove this
const double kListNumberWidth = 100;

const double kTabletLayoutWidth = 1100;
const double kTabletDialogPadding = 250;

const double kTableColumnWidthMin = 40;
const double kTableColumnWidthMax = 120;

const int kTableListWidthCutoff = 450;
const int kDefaultAnimationDuration = 500;

const int kCardTypeVisa = 1;
const int kCardTypeMasterCard = 2;
const int kCardTypeAmEx = 4;
const int kCardTypeDiners = 8;
const int kCardTypeDiscover = 16;

const String kPaymentTypeVisa = '5';
const String kPaymentTypeMasterCard = '6';
const String kPaymentTypeAmEx = '7';
const String kPaymentTypeDiners = '9';
const String kPaymentTypeDiscover = '8';

const String kPlanFree = '';
const String kPlanPro = 'pro';
const String kPlanEnterprise = 'enterprise';
const String kPlanWhiteLabel = 'white_label';

const String kColorThemeLight = 'light';
const String kColorThemeDark = 'dark';

const double kGutterWidth = 16;
const double kLighterOpacity = .6;

const int kMaxNumberOfCompanies = 10;
const int kMaxNumberOfHistory = 50;
const int kMaxRecordsPerApiPage = 5000;
const int kMaxPostSeconds = 30;
const int kMaxRawPostSeconds = 180;
const int kMillisecondsToRefreshData = 1000 * 60 * 15; // 15 minutes
const int kUpdatedAtBufferSeconds = 600;
const int kMillisecondsToRefreshActivities = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToRefreshStaticData = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToReenterPassword = 1000 * 60 * 30; // 30 minutes
const int kMillisecondsToDebounceUpdate = 500; // .5 second
const int kMillisecondsToDebounceSave = 1000 * 2; // 2 seconds

const String kLanguageEnglish = '1';

const String kCurrencyAll = '-1';
const String kCurrencyUSDollar = '1';
const String kCurrencyEuro = '3';

const String kCountryUnitedStates = '840';
const String kCountryCanada = '124';

const String kInvoiceStatusViewed = '-3';
const String kInvoiceStatusUnpaid = '-2';
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

const String kRecurringInvoiceStatusDraft = '1';
const String kRecurringInvoiceStatusActive = '2';
const String kRecurringInvoiceStatusPaused = '3';
const String kRecurringInvoiceStatusCompleted = '4';
const String kRecurringInvoiceStatusPending = '-1';

const kRecurringInvoiceStatuses = {
  kRecurringInvoiceStatusDraft: 'draft',
  kRecurringInvoiceStatusActive: 'active',
  kRecurringInvoiceStatusPaused: 'paused',
  kRecurringInvoiceStatusCompleted: 'completed',
  kRecurringInvoiceStatusPending: 'pending',
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
const String kGatewayTypeCrypto = '4';
const String kGatewayTypeCustom = '5';
const String kGatewayTypeAlipay = '6';
const String kGatewayTypeSofort = '7';
const String kGatewayTypeApplePay = '8';
const String kGatewayTypeSEPA = '9';
const String kGatewayTypeCredit = '10';

const kGatewayTypes = {
  kGatewayTypeCreditCard: 'credit_card',
  kGatewayTypeBankTransfer: 'bank_transfer',
  kGatewayTypePayPal: 'paypal',
  kGatewayTypeCrypto: 'crypto',
  kGatewayTypeCustom: 'custom',
  kGatewayTypeAlipay: 'alipay',
  kGatewayTypeSofort: 'sofort',
  kGatewayTypeApplePay: 'apple_pay',
};

const String kNotificationChannelEmail = 'email';
const String kNotificationChannelSlack = 'slack';

const String kNotificationsAll = 'all_notifications';
const String kNotificationsAllUser = 'all_user_notifications';
const String kNotificationsPaymentSuccess = 'payment_success';
const String kNotificationsPaymentFailure = 'payment_failure';
const String kNotificationsInvoiceCreated = 'invoice_created';
const String kNotificationsInvoiceSent = 'invoice_sent';
const String kNotificationsInvoiceLate = 'invoice_late';
const String kNotificationsQuoteCreated = 'quote_created';
const String kNotificationsQuoteSent = 'quote_sent';
const String kNotificationsCreditCreated = 'credit_created';
const String kNotificationsCreditSent = 'credit_sent';
const String kNotificationsQuoteViewed = 'quote_viewed';
const String kNotificationsQuoteExpired = 'quote_expired';
const String kNotificationsInvoiceViewed = 'invoice_viewed';
const String kNotificationsCreditViewed = 'credit_viewed';
const String kNotificationsQuoteApproved = 'quote_approved';

const kNotificationEvents = [
  kNotificationsInvoiceCreated,
  kNotificationsInvoiceSent,
  kNotificationsInvoiceViewed,
  kNotificationsInvoiceLate,
  kNotificationsPaymentSuccess,
  kNotificationsPaymentFailure,
  kNotificationsQuoteCreated,
  kNotificationsQuoteSent,
  kNotificationsQuoteViewed,
  kNotificationsQuoteApproved,
  kNotificationsQuoteExpired,
  kNotificationsCreditCreated,
  kNotificationsCreditSent,
  kNotificationsCreditViewed,
];

const String kGatewayStripe = 'd14dd26a37cecc30fdd65700bfb55b23';
const String kGatewayStripeConnect = 'd14dd26a47cecc30fdd65700bfb67b34';
const String kGatewayAuthorizeNet = '3b6621f970ab18887c4f6dca78d3f8bb';
const String kGatewayCheckoutCom = '3758e7f7c6f4cecf0f4f348b9a00f456';
const String kGatewayPayPalExpress = '38f2c48af60c7dd69e04248cbb24c36e';
const String kGatewayWePay = '8fdeed552015b3c7b44ed6c8ebd9e992';
const String kGatewayCustom = '54faab2ab6e3223dbe848b1686490baa';

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
const String kKanban = 'kanban';

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
const String kSettingsCompanyGateways = 'company_gateways';
const String kSettingsCompanyGatewaysView = 'company_gateways_view';
const String kSettingsCompanyGatewaysEdit = 'company_gateways_edit';
const String kSettingsTaxSettings = 'tax_settings';
const String kSettingsTaxRates = 'tax_settings_rates';
const String kSettingsTaxRatesView = 'tax_settings_rates_view';
const String kSettingsTaxRatesEdit = 'tax_settings_rates_edit';
const String kSettingsIntegrations = 'integrations';
const String kSettingsProducts = 'product_settings';
const String kSettingsTasks = 'task_settings';
const String kSettingsExpenses = 'expense_settings';
const String kSettingsImportExport = 'import_export';
const String kSettingsDeviceSettings = 'device_settings';
const String kSettingsGroupSettings = 'group_settings';
const String kSettingsGroupSettingsView = 'group_settings_view';
const String kSettingsGroupSettingsEdit = 'group_settings_edit';
const String kSettingsSubscriptions = 'subscriptions';
const String kSettingsSubscriptionsView = 'subscriptions_view';
const String kSettingsSubscriptionsEdit = 'subscriptions_edit';
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
const String kSettingsExpenseCategories = 'expense_category';
const String kSettingsExpenseCategoryView = 'expense_category_view';
const String kSettingsExpenseCategoryEdit = 'expense_category_edit';
const String kSettingsTaskStatuses = 'task_status';
const String kSettingsTaskStatusView = 'task_status_view';
const String kSettingsTaskStatusEdit = 'task_status_edit';

const String kReportClient = 'client';
const String kReportCredit = 'credit';
const String kReportDocument = 'document';
const String kReportExpense = 'expense';
const String kReportInvoice = 'invoice';
const String kReportPayment = 'payment';
const String kReportProduct = 'product';
const String kReportProfitAndLoss = 'profit_and_loss';
const String kReportTask = 'task';
const String kReportTax = 'tax';
const String kReportPaymentTax = 'payment_tax';
const String kReportQuote = 'quote';
const String kReportInvoiceItem = 'invoice_item';
const String kReportQuoteItem = 'quote_item';

const String kPdfFieldsClientDetails = 'client_details';
const String kPdfFieldsCompanyDetails = 'company_details';
const String kPdfFieldsCompanyAddress = 'company_address';
const String kPdfFieldsInvoiceDetails = 'invoice_details';
const String kPdfFieldsQuoteDetails = 'quote_details';
const String kPdfFieldsCreditDetails = 'credit_details';
const String kPdfFieldsProductColumns = 'product_columns';
const String kPdfFieldsTaskColumns = 'task_columns';
const String kPdfFieldsTotalFields = 'total_columns';

const String kPdfFields = '';
const String kPermissionCreateAll = 'create_all';
const String kPermissionViewAll = 'view_all';
const String kPermissionEditAll = 'edit_all';

const String kPaymentStatusPartiallyUnapplied = '-2';
const String kPaymentStatusUnapplied = '-1';
const String kPaymentStatusPending = '1';
const String kPaymentStatusCancelled = '2';
const String kPaymentStatusFailed = '3';
const String kPaymentStatusCompleted = '4';
const String kPaymentStatusPartiallyRefunded = '5';
const String kPaymentStatusRefunded = '6';

const kPaymentStatuses = {
  kPaymentStatusPartiallyUnapplied: 'partially_unapplied',
  kPaymentStatusUnapplied: 'unapplied',
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

const kExpenseStatuses = {
  kExpenseStatusLogged: 'logged',
  kExpenseStatusPending: 'pending',
  kExpenseStatusInvoiced: 'invoiced',
};

const String kDefaultCurrencyId = '1';
const String kDefaultDateFormat = '5';
const String kDefaultAccentColor = '#0091EA';
const String kDefaultDarkSelectedColorMenu = '#1E252F';
const String kDefaultDarkSelectedColor = '#253750';
const String kDefaultDarkBorderColor = '#393A3C';
const String kDefaultLightSelectedColorMenu = '#f2faff';
const String kDefaultLightSelectedColor = '#e5f5ff';
const String kDefaultLightBorderColor = '#dfdfdf';

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

const Map<int, String> kModules = {
  kModuleInvoices: 'invoices',
  kModuleRecurringInvoices: 'recurring_invoices',
  kModuleQuotes: 'quotes',
  kModuleCredits: 'credits',
  kModuleProjects: 'projects',
  kModuleTasks: 'tasks',
  kModuleVendors: 'vendors',
  kModuleExpenses: 'expenses',
  //kModuleProposals: 'proposals',
  //kModuleTickets: 'tickets',
  //kModuleRecurringTasks: 'recurring_tasks',
  //kModuleRecurringExpenses: 'recurring_expenses',
  //kModuleRecurringQuotes: 'recurring_quotes',
};

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
  'ru_RU',
  'sl',
  'sq',
  'sr_RS',
  'sv',
  'th',
  'tr_TR',
  'bg',
];

List<String> kCustomLabels = [
  'address1',
  'address2',
  'amount',
  'balance',
  'country',
  'credit',
  'credit_card',
  'date',
  'description',
  'details',
  'discount',
  'due_date',
  'email',
  'from',
  'hours',
  'id_number',
  'invoice',
  'item',
  'line_total',
  'paid_to_date',
  'partial_due',
  'payment_date',
  'phone',
  'po_number',
  'quantity',
  'quote',
  'rate',
  'service',
  'statement',
  'subtotal',
  'surcharge',
  'tax',
  'taxes',
  'terms',
  'to',
  'total',
  'unit_cost',
  'valid_until',
  'vat_number',
  'website',
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

const kFrequencyMonthly = '5';

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

const kPageLayouts = ['portrait', 'landscape'];

const kPageSizes = [
  'A5',
  'A4',
  'A3',
  'B5',
  'B4',
  'JIS-B5',
  'JIS-B4',
  'letter',
  'legal',
  'ledger',
];

const String kDrawerKey = 'drawer_key';
const String kSelectCompanyDropdownKey = 'select_company_dropdown_key';

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
const String kActivityViewCredit = '60';
const String kActivityUpdateClient = '61';
const String kActivityUpdateVendor = '62';
const String kActivityEmailReminder1 = '63';
const String kActivityEmailReminder2 = '64';
const String kActivityEmailReminder3 = '65';
const String kActivityEmailReminderEndless = '66';
const String kActivityCreateSubscription = '80';
const String kActivityUpdateSubscription = '81';
const String kActivityArchiveSubscription = '82';
const String kActivityDeleteSubscription = '83';
const String kActivityRestoreSubscription = '84';
const String kActivityCreateRecurringInvoice = '100';
const String kActivityUpdateRecurringInvoice = '101';
const String kActivityArchiveRecurringInvoice = '102';
const String kActivityDeleteRecurringInvoice = '103';
const String kActivityRestoreRecurringInvoice = '104';
