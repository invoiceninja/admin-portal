import 'package:invoiceninja_flutter/data/models/import_model.dart';

class Constants {
  //static String get hostedApiUrl => kReleaseMode ? kAppProductionUrl : kAppStagingUrl;
  static String get hostedApiUrl => kAppProductionUrl;
}

// TODO remove version once #46609 is fixed
const String kClientVersion = '5.0.156';
const String kMinServerVersion = '5.0.4';

const String kAppName = 'Invoice Ninja';
const String kSiteUrl = 'https://invoiceninja.com';
const String kAppProductionUrl = 'https://invoicing.co';
const String kAppReactUrl = 'https://app.invoicing.co';
const String kAppStagingUrl = 'https://staging.invoicing.co';
const String kAppStagingNetUrl = 'https://invoiceninja.net';
const String kAppLargeTestUrl = 'https://testv5.invoicing.co';
const String kFlutterDemoUrl = 'https://demo.invoiceninja.com';
const String kReactDemoUrl = 'https://react.invoicing.co/demo';
const String kWhiteLabelUrl =
    'https://app.invoiceninja.com/buy_now/?account_key=AsFmBAeLXF0IKf7tmi0eiyZfmWW9hxMT&product_id=3';
const String kPrivacyPolicyURL = 'https://www.invoiceninja.com/privacy-policy';
const String kTermsOfServiceURL = 'https://www.invoiceninja.com/terms';
const String kBankingURL = 'https://invoiceninja.com/banking';
const String kTransifexURL =
    'https://www.transifex.com/invoice-ninja/invoice-ninja';
const String kWebhookSiteURL = 'https://requestcatcher.com';
const String kZipTaxURL = 'https://zip-tax.com';
const String kSourceCodeBackend =
    'https://github.com/invoiceninja/invoiceninja/tree/v5-stable';
const String kSourceCodeFrontend =
    'https://github.com/invoiceninja/admin-portal';
const String kSourceCodeFrontendSDK = 'https://pub.dev/packages/invoiceninja';

const String kPlayStoreAppId = 'com.invoiceninja.app';
const String kAppStoreAppId = 'id1503970375';

const String kMicrosoftAppStoreId = '9N3F2BBCFDR6';
const String kAppleStoreUrl =
    'https://apps.apple.com/us/app/invoice-ninja-v5/$kAppStoreAppId';
const String kGoogleStoreUrl =
    'https://play.google.com/store/apps/details?id=$kPlayStoreAppId';
const String kGoogleFDroidUrl =
    'https://f-droid.org/packages/com.invoiceninja.app';
const String kMacOSUrl = 'https://apps.apple.com/app/$kAppStoreAppId';
const String kLinuxUrl = 'https://snapcraft.io/invoiceninja';
const String kWindowsUrl =
    'https://apps.microsoft.com/store/detail/invoice-ninja/$kMicrosoftAppStoreId';

const String kSlackUrl = 'http://slack.invoiceninja.com';
const String kGitHubUrl = 'https://github.com/invoiceninja';
const String kTwitterUrl = 'https://twitter.com/invoiceninja';
const String kFacebookUrl = 'https://www.facebook.com/invoiceninja';
const String kYouTubeUrl =
    'https://www.youtube.com/channel/UCXAHcBvhW05PDtWYIq7WDFA/videos';

const String kYodleeCoverageUrl =
    'https://www.yodlee.com/open-banking/data-connections';
const String kNordigenCoverageUrl =
    'https://gocardless.com/bank-account-data/coverage';
const String kNordigenOverviewUrl = 'https://gocardless.com/bank-account-data';

const String kTaskExtensionUrl =
    'https://chromewebstore.google.com/detail/invoice-ninja-tasks/dlfcbfdpemfnjbjlladogijcchfmmaaf';
const String kTaskExtensionYouTubeUrl =
    'https://www.youtube.com/watch?v=UL0OklMJTEA&ab_channel=InvoiceNinja';

const String kAppleOAuthClientId = 'com.invoiceninja.client';
const String kAppleOAuthRedirectUrl = 'https://invoicing.co/auth/apple';

const String kReleaseNotesUrl =
    'https://github.com/invoiceninja/invoiceninja/releases';
const String kDocsUrl = 'https://invoiceninja.github.io/en';
const String kDocsCustomDomainUrl = '$kDocsUrl/hosted-custom-domain';
const String kDocsCustomDesignUrl = '$kDocsUrl/custom-fields';
const String kDocsCustomFieldsUrl = '$kDocsUrl/custom-fields/#custom-fields';
const String kDocsEmailVariablesUrl =
    '$kDocsUrl/email-customization/#payment-email-customization';
const String kDocsStripeConnectUrl = '$kDocsUrl/hosted-stripe';

const String kPHPDateFormatsUrl =
    'https://www.php.net/manual/en/datetime.format.php#refsect1-datetime.format-parameters';
const String kForumUrl = 'https://forum.invoiceninja.com';
const String kApiDocsUrl = 'https://api-docs.invoicing.co';
const String kZapierUrl = 'https://zapier.com/apps/invoice-ninja';
const String kGatewayFeeHelpURL =
    'https://support.stripe.com/questions/passing-the-stripe-fee-on-to-customers';

const String kDebugModeUrl = '$kDocsUrl/self-host-debug-mode';
const String kCapterralUrl = 'https://www.capterra.com/p/145215/Invoice-Ninja';
const String kCronsHelpUrl =
    '$kDocsUrl/self-host-troubleshooting/#cron-not-running-queue-not-running';
const String kGitHubDiffUrl =
    'https://github.com/invoiceninja/invoiceninja/compare/vVERSION...v5-stable';
const String kGitHubLangUrl =
    'https://github.com/invoiceninja/invoiceninja/blob/master/resources/lang/en/texts.php';
const String kStatusCheckUrl = 'https://status.invoiceninja.com';
const String kGoogleAnalyticsUrl =
    'https://support.google.com/analytics/answer/1037249?hl=en';

enum AppEnvironment {
  hosted,
  selfhosted,
  testing,
  demo,
  staging,
  develop,
}

const String kSharedPrefs = 'shared_prefs';
const String kSharedPrefUrl = 'url';
const String kSharedPrefToken = 'checksum';
const String kSharedPrefWidth = 'width';
const String kSharedPrefHeight = 'height';

const String kProductProPlanMonth = 'pro_plan';
const String kProductEnterprisePlanMonth_2 = 'enterprise_plan';
const String kProductEnterprisePlanMonth_5 = 'enterprise_plan_5';
const String kProductEnterprisePlanMonth_10 = 'enterprise_plan_10';
const String kProductEnterprisePlanMonth_20 = 'enterprise_plan_20';
const String kProductProPlanYear = 'pro_plan_annual';
const String kProductEnterprisePlanYear_2 = 'enterprise_plan_annual';
const String kProductEnterprisePlanYear_5 = 'enterprise_plan_annual_5';
const String kProductEnterprisePlanYear_10 = 'enterprise_plan_annual_10';
const String kProductEnterprisePlanYear_20 = 'enterprise_plan_annual_20';

const kProductPlans = [
  kProductProPlanMonth,
  kProductEnterprisePlanMonth_2,
  kProductEnterprisePlanMonth_5,
  kProductEnterprisePlanMonth_10,
  kProductEnterprisePlanMonth_20,
  kProductProPlanYear,
  kProductEnterprisePlanYear_2,
  kProductEnterprisePlanYear_5,
  kProductEnterprisePlanYear_10,
  kProductEnterprisePlanYear_20,
];

const double kMobileLayoutWidth = 700;
const double kMobileDialogPadding = 12;
const double kDrawerWidthMobile = 272;
const double kDrawerWidthDesktop = 210;
const double kTableColumnGap = 16;
const double kTopBottomBarHeight = 50;
const double kDialogWidth = 400;
const double kDashboardPanelHeight = 543; // TODO remove this
const double kDashboardPanelHeightWeb = 539; // TODO remove this
const double kListNumberWidth = 100;
const double kBorderRadius = 2;

const double kTabletLayoutWidth = 1100;
const double kTabletDialogPadding = 250;

const double kTableColumnWidthMin = 80;
const double kTableColumnWidthMax = 200;

const int kTableListWidthCutoff = 550;
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
const String kPaymentTypeCredit = '32';

const String kPlanFree = '';
const String kPlanPro = 'pro';
const String kPlanEnterprise = 'enterprise';
const String kPlanWhiteLabel = 'white_label';

const String kBrightnessLight = 'light';
const String kBrightnessDark = 'dark';
const String kBrightnessSytem = 'system';

const String kColorThemeLight = 'light';
const String kColorThemeDark = 'dark';

const double kGutterWidth = 16;
const double kLighterOpacity = .6;

const String kStatementIncludePayments = 'payments';
const String kStatementIncludeCredits = 'credits';
const String kStatementIncludeAging = 'aging';

const int kMaxNumberOfCompanies = 10;
const int kMaxNumberOfHistory = 50;
const int kMaxPostSeconds = 120;
const int kMaxRawPostSeconds = 600;
const int kMaxEntitiesPerBulkAction = 100;
const int kMaxRecordsPerPage = 5000;
const int kMillisecondsToTimerRefreshData = 1000 * 60 * 5; // 5 minutes
const int kMillisecondsToRefreshData = 1000 * 60 * 15; // 15 minutes
const int kUpdatedAtBufferSeconds = 600;
const int kMillisecondsToRefreshActivities = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToRefreshStaticData = 1000 * 60 * 60 * 24; // 1 day
const int kMillisecondsToDebounceUpdate = 500; // .5 second
const int kMillisecondsToDebounceSave = 1500; // 1.5 seconds
const int kMillisecondsToDebounceWrite = 3000; // 3 seconds

const String kLanguageEnglish = '1';

const String kCurrencyAll = '-1';
const String kCurrencyUSDollar = '1';
const String kCurrencyEuro = '3';

const String kTaxCategoryPhysical = '1';
const String kTaxCategoryServices = '2';
const String kTaxCategoryDigital = '3';
const String kTaxCategoryShipping = '4';
const String kTaxCategoryExempt = '5';
const String kTaxCategoryReducedTax = '6';
const String kTaxCategoryOverrideTax = '7';
const String kTaxCategoryZeroRated = '8';
const String kTaxCategoryReverseTax = '9';

const kTaxCategories = {
  kTaxCategoryPhysical: 'physical_goods',
  kTaxCategoryDigital: 'digital_products',
  kTaxCategoryServices: 'services',
  kTaxCategoryShipping: 'shipping',
  kTaxCategoryExempt: 'tax_exempt',
  kTaxCategoryReducedTax: 'reduced_tax',
  kTaxCategoryOverrideTax: 'override_tax',
  kTaxCategoryZeroRated: 'zero_rated',
  kTaxCategoryReverseTax: 'reverse_tax',
};

const String kTaxClassificationIndividual = 'individual';
const String kTaxClassificationCompany = 'company';
const String kTaxClassificationPartnership = 'partnership';
const String kTaxClassificationTrust = 'trust';
const String kTaxClassificationCharity = 'charity';
const String kTaxClassificationGovernment = 'government';
const String kTaxClassificationOther = 'other';

const kTaxClassifications = [
  kTaxClassificationIndividual,
  kTaxClassificationCompany,
  kTaxClassificationPartnership,
  kTaxClassificationTrust,
  kTaxClassificationCharity,
  kTaxClassificationGovernment,
  kTaxClassificationOther,
];

const String kEInvoiceTypeEN16931 = 'EN16931';
const String kEInvoiceTypeXInvoice_3_0 = 'XInvoice_3_0';
const String kEInvoiceTypeXInvoice_2_3 = 'XInvoice_2_3';
const String kEInvoiceTypeXInvoice_2_2 = 'XInvoice_2_2';
const String kEInvoiceTypeXInvoice_2_1 = 'XInvoice_2_1';
const String kEInvoiceTypeXInvoice_2_0 = 'XInvoice_2_0';
const String kEInvoiceTypeXInvoice_1_0 = 'XInvoice_1_0';
const String kEInvoiceTypeXInvoice_Extended = 'XInvoice-Extended';
const String kEInvoiceTypeXInvoice_BasicWL = 'XInvoice-BasicWL';
const String kEInvoiceTypeXInvoice_Basic = 'XInvoice-Basic';
const String kEInvoiceTypeFacturae_3_2 = 'Facturae_3.2';
const String kEInvoiceTypeFacturae_3_2_1 = 'Facturae_3.2.1';
const String kEInvoiceTypeFacturae_3_2_2 = 'Facturae_3.2.2';

const kEInvoiceTypes = [
  kEInvoiceTypeEN16931,
  kEInvoiceTypeXInvoice_3_0,
  kEInvoiceTypeXInvoice_2_3,
  kEInvoiceTypeXInvoice_2_2,
  kEInvoiceTypeXInvoice_2_1,
  kEInvoiceTypeXInvoice_2_0,
  kEInvoiceTypeXInvoice_1_0,
  kEInvoiceTypeXInvoice_Extended,
  kEInvoiceTypeXInvoice_BasicWL,
  kEInvoiceTypeXInvoice_Basic,
  kEInvoiceTypeFacturae_3_2_2,
  kEInvoiceTypeFacturae_3_2_1,
  kEInvoiceTypeFacturae_3_2,
];

const String kCountryUnitedStates = '840';
const String kCountryAustralia = '36';
const String kCountryCanada = '124';
const String kCountrySwitzerland = '756';

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
  kInvoiceStatusViewed: 'viewed',
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

const String kRecurringExpenseStatusDraft = '1';
const String kRecurringExpenseStatusActive = '2';
const String kRecurringExpenseStatusPaused = '3';
const String kRecurringExpenseStatusCompleted = '4';
const String kRecurringExpenseStatusPending = '-1';

const kRecurringExpenseStatuses = {
  kRecurringExpenseStatusDraft: 'draft',
  kRecurringExpenseStatusActive: 'active',
  kRecurringExpenseStatusPaused: 'paused',
  kRecurringExpenseStatusCompleted: 'completed',
  kRecurringExpenseStatusPending: 'pending',
};

const String kQuoteStatusViewed = '-2';
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
  kQuoteStatusViewed: 'viewed',
};

const String kCreditStatusViewed = '-1';
const String kCreditStatusDraft = '1';
const String kCreditStatusSent = '2';
const String kCreditStatusPartial = '3';
const String kCreditStatusApplied = '4';

const kCreditStatuses = {
  kCreditStatusDraft: 'draft',
  kCreditStatusSent: 'sent',
  kCreditStatusPartial: 'partial',
  kCreditStatusApplied: 'applied',
  kCreditStatusViewed: 'viewed',
};

const String kPurchaseOrderStatusViewed = '-1';
const String kPurchaseOrderStatusDraft = '1';
const String kPurchaseOrderStatusSent = '2';
const String kPurchaseOrderStatusAccepted = '3';
const String kPurchaseOrderStatusReceived = '4';
const String kPurchaseOrderStatusCancelled = '5';

const kPurchaseOrderStatuses = {
  kPurchaseOrderStatusDraft: 'draft',
  kPurchaseOrderStatusSent: 'sent',
  kPurchaseOrderStatusAccepted: 'accepted',
  kPurchaseOrderStatusReceived: 'received',
  kPurchaseOrderStatusCancelled: 'cancelled',
  kPurchaseOrderStatusViewed: 'viewed',
};

const String kDocumentStatusPublic = '-1';
const String kDocumentStatusPrivate = '-2';
const String kDocumentStatusImage = '-3';
const String kDocumentStatusPDF = '-4';
const String kDocumentStatusOther = '-5';

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
const String kGatewayTypeKBC = '11';
const String kGatewayTypeBancontact = '12';
const String kGatewayTypeIDeal = '13';
const String kGatewayTypeHosted = '14';
const String kGatewayTypeGiropay = '15';
const String kGatewayTypePrzelewy24 = '16';
const String kGatewayTypeEPS = '17';
const String kGatewayTypeDirectDebit = '18';
const String kGatewayTypeACSS = '19';
const String kGatewayTypeBECS = '20';
const String kGatewayTypeInstantBankPay = '21';
const String kGatewayTypeFPX = '22';
const String kGatewayTypeKlarna = '23';
const String kGatewayTypeBacs = '24';
const String kGatewayTypeVenmo = '25';
const String kGatewayTypeMercadoPago = '26';
const String kGatewayTypeMyBank = '27';
const String kGatewayTypePayLater = '28';

const kGatewayTypes = {
  kGatewayTypeCreditCard: 'credit_card',
  kGatewayTypeBankTransfer: 'bank_transfer',
  kGatewayTypePayPal: 'paypal',
  kGatewayTypeCrypto: 'crypto',
  kGatewayTypeCustom: 'custom',
  kGatewayTypeAlipay: 'alipay',
  kGatewayTypeSofort: 'sofort',
  kGatewayTypeApplePay: 'apple_pay',
  kGatewayTypeSEPA: 'sepa',
  kGatewayTypeCredit: 'credit',
  kGatewayTypeKBC: 'kbc',
  kGatewayTypeBancontact: 'bancontact',
  kGatewayTypeIDeal: 'ideal',
  kGatewayTypeHosted: 'hosted',
  kGatewayTypeGiropay: 'giropay',
  kGatewayTypePrzelewy24: 'przelewy24',
  kGatewayTypeDirectDebit: 'direct_debit',
  kGatewayTypeEPS: 'eps',
  kGatewayTypeACSS: 'acss',
  kGatewayTypeBECS: 'becs',
  kGatewayTypeInstantBankPay: 'instant_bank_pay',
  kGatewayTypeFPX: 'fpx',
  kGatewayTypeKlarna: 'klarna',
  kGatewayTypeBacs: 'bacs',
  kGatewayTypeVenmo: 'venmo',
  kGatewayTypeMercadoPago: 'mercado_pago',
  kGatewayTypeMyBank: 'my_bank',
  kGatewayTypePayLater: 'pay_later',
};

const String kNotificationChannelEmail = 'email';
const String kNotificationChannelSlack = 'slack';

const String kPlatformWindows = 'Windows';
const String kPlatformLinux = 'Linux';
const String kPlatformMacOS = 'macOS';
const String kPlatformAndroid = 'Android';
const String kPlatformiPhone = 'iPhone';

const String kNotificationsAll = 'all_notifications';
const String kNotificationsAllUser = 'all_user_notifications';
const String kNotificationsPaymentSuccess = 'payment_success';
const String kNotificationsPaymentFailure = 'payment_failure';
const String kNotificationsPaymentManual = 'payment_manual';
const String kNotificationsInvoiceCreated = 'invoice_created';
const String kNotificationsInvoiceSent = 'invoice_sent';
const String kNotificationsInvoiceLate = 'invoice_late';
const String kNotificationsInvoiceViewed = 'invoice_viewed';
const String kNotificationsQuoteCreated = 'quote_created';
const String kNotificationsQuoteSent = 'quote_sent';
const String kNotificationsQuoteViewed = 'quote_viewed';
const String kNotificationsQuoteExpired = 'quote_expired';
const String kNotificationsQuoteApproved = 'quote_approved';
const String kNotificationsCreditCreated = 'credit_created';
const String kNotificationsCreditSent = 'credit_sent';
const String kNotificationsCreditViewed = 'credit_viewed';
const String kNotificationsPurchaseOrderCreated = 'purchase_order_created';
const String kNotificationsPurchaseOrderSent = 'purchase_order_sent';
const String kNotificationsPurchaseOrderViewed = 'purchase_order_viewed';
const String kNotificationsPurchaseOrderAccepted = 'purchase_order_accepted';
const String kNotificationsInventoryThreshold = 'inventory_threshold';

const kNotificationEvents = [
  kNotificationsInvoiceCreated,
  kNotificationsInvoiceSent,
  kNotificationsInvoiceViewed,
  kNotificationsInvoiceLate,
  kNotificationsPaymentSuccess,
  kNotificationsPaymentFailure,
  kNotificationsPaymentManual,
  kNotificationsQuoteCreated,
  kNotificationsQuoteSent,
  kNotificationsQuoteViewed,
  kNotificationsQuoteApproved,
  kNotificationsQuoteExpired,
  kNotificationsCreditCreated,
  kNotificationsCreditSent,
  kNotificationsCreditViewed,
  kNotificationsPurchaseOrderCreated,
  kNotificationsPurchaseOrderSent,
  kNotificationsPurchaseOrderViewed,
  kNotificationsPurchaseOrderAccepted,
  kNotificationsInventoryThreshold,
];

const String kGatewayStripe = 'd14dd26a37cecc30fdd65700bfb55b23';
const String kGatewayStripeConnect = 'd14dd26a47cecc30fdd65700bfb67b34';
const String kGatewayAuthorizeNet = '3b6621f970ab18887c4f6dca78d3f8bb';
const String kGatewayCheckoutCom = '3758e7f7c6f4cecf0f4f348b9a00f456';
const String kGatewayPayPalREST = '80af24a6a691230bbec33e930ab40665';
const String kGatewayPayPalExpress = '38f2c48af60c7dd69e04248cbb24c36e';
const String kGatewayPayPalPlatform = '80af24a6a691230bbec33e930ab40666';
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

const kTaskStatuses = {
  kTaskStatusLogged: 'logged',
  kTaskStatusRunning: 'running',
  kTaskStatusInvoiced: 'invoiced',
};

const String kMain = 'main';
const String kSettings = 'settings';
const String kDashboard = 'dashboard';
const String kReports = 'reports';
const String kKanban = 'kanban';

const String kAgeGroupPaid = 'age_group_paid';
const String kAgeGroup0 = 'age_group_0';
const String kAgeGroup30 = 'age_group_30';
const String kAgeGroup60 = 'age_group_60';
const String kAgeGroup90 = 'age_group_90';
const String kAgeGroup120 = 'age_group_120';

const kAgeGroups = {
  kAgeGroupPaid: -1,
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
const String kSettingsPaymentTermView = 'payment_term/view';
const String kSettingsPaymentTermEdit = 'payment_term/edit';
const String kSettingsUserDetails = 'user_details';
const String kSettingsLocalization = 'localization';
const String kSettingsPaymentSettings = 'payment_settings';
const String kSettingsCompanyGateways = 'company_gateways';
const String kSettingsCompanyGatewaysView = 'company_gateways/view';
const String kSettingsCompanyGatewaysEdit = 'company_gateways/edit';
const String kSettingsTaxSettings = 'tax_settings';
const String kSettingsTaxRates = 'tax_settings_rates';
const String kSettingsTaxRatesView = 'tax_settings_rates/view';
const String kSettingsTaxRatesEdit = 'tax_settings_rates/edit';
const String kSettingsProducts = 'product_settings';
const String kSettingsTasks = 'task_settings';
const String kSettingsExpenses = 'expense_settings';
const String kSettingsImportExport = 'import_export';
const String kSettingsDeviceSettings = 'device_settings';
const String kSettingsGroupSettings = 'group_settings';
const String kSettingsGroupSettingsView = 'group_settings/view';
const String kSettingsGroupSettingsEdit = 'group_settings/edit';
const String kSettingsPaymentLinks = 'payment_links';
const String kSettingsPaymentLinksView = 'payment_links/view';
const String kSettingsPaymentLinksEdit = 'payment_links/edit';
const String kSettingsCustomFields = 'custom_fields';
const String kSettingsCustomDesigns = 'custom_designs';
const String kSettingsCustomDesignsView = 'custom_designs/view';
const String kSettingsCustomDesignsEdit = 'custom_designs/edit';
const String kSettingsGeneratedNumbers = 'generated_numbers';
const String kSettingsWorkflowSettings = 'workflow_settings';
const String kSettingsInvoiceDesign = 'invoice_design';
const String kSettingsClientPortal = 'client_portal';
const String kSettingsEmailSettings = 'email_settings';
const String kSettingsTemplatesAndReminders = 'templates_and_reminders';
const String kSettingsCreditCardsAndBanks = 'credit_cards_and_banks';
const String kSettingsDataVisualizations = 'data_visualizations';
const String kSettingsApiTokens = 'api_tokens';
const String kSettingsUserManagement = 'user_management';
const String kSettingsUserManagementView = 'user_management/view';
const String kSettingsUserManagementEdit = 'user_management/edit';
const String kSettingsAccountManagement = 'account_management';
const String kSettingsTokens = 'tokens';
const String kSettingsTokenView = 'token/view';
const String kSettingsTokenEdit = 'token/edit';
const String kSettingsWebhooks = 'webhook';
const String kSettingsWebhookView = 'webhook/view';
const String kSettingsWebhookEdit = 'webhook/edit';
const String kSettingsExpenseCategories = 'expense_category';
const String kSettingsExpenseCategoryView = 'expense_category/view';
const String kSettingsExpenseCategoryEdit = 'expense_category/edit';
const String kSettingsTaskStatuses = 'task_status';
const String kSettingsTaskStatusView = 'task_status/view';
const String kSettingsTaskStatusEdit = 'task_status/edit';
const String kSettingsBankAccounts = 'bank_accounts';
const String kSettingsBankAccountsView = 'bank_accounts/view';
const String kSettingsBankAccountsEdit = 'bank_accounts/edit';
const String kSettingsTransactionRules = 'transaction_rules';
const String kSettingsTransactionRulesView = 'transaction_rules/view';
const String kSettingsTransactionRulesEdit = 'transaction_rules/edit';
const String kSettingsSchedules = 'schedules';
const String kSettingsSchedulesView = 'schedules/view';
const String kSettingsSchedulesEdit = 'schedules/edit';

const List<String> kAdvancedSettings = [
  kSettingsCustomDesigns,
  kSettingsGroupSettings,
  kSettingsClientPortal,
  kSettingsCustomFields,
  kSettingsEmailSettings,
  kSettingsGeneratedNumbers,
  kSettingsInvoiceDesign,
  kSettingsTemplatesAndReminders,
  kSettingsPaymentLinks,
  kSettingsUserManagement,
  kSettingsTransactionRules,
];

const String kReportClient = 'client';
const String kReportClientContact = 'client_contact';
const String kReportCredit = 'credit';
const String kReportCreditItem = 'credit_item';
const String kReportDocument = 'document';
const String kReportExpense = 'expense';
const String kReportInvoice = 'invoice';
const String kReportPayment = 'payment';
const String kReportProduct = 'product';
const String kReportProfitAndLoss = 'profit_and_loss';
const String kReportTask = 'task';
const String kReportTaskItem = 'task_item';
const String kReportInvoiceTax = 'invoice_tax';
const String kReportPaymentTax = 'payment_tax';
const String kReportQuote = 'quote';
const String kReportInvoiceItem = 'invoice_item';
const String kReportQuoteItem = 'quote_item';
const String kReportRecurringExpense = 'recurring_expense';
const String kReportRecurringInvoice = 'recurring_invoice';
const String kReportPurchaseOrder = 'purchase_order';
const String kReportPurchaseOrderItem = 'purchase_order_item';
const String kReportVendor = 'vendor';
const String kReportTransaction = 'transaction';

final kReportMap = {
  kReportClient: ExportType.clients,
  kReportClientContact: ExportType.client_contacts,
  kReportCredit: ExportType.credits,
  kReportCreditItem: null,
  kReportDocument: ExportType.documents,
  kReportExpense: ExportType.expenses,
  kReportInvoice: ExportType.invoices,
  kReportPayment: ExportType.payments,
  kReportProduct: ExportType.products,
  kReportProfitAndLoss: ExportType.profitloss,
  kReportTask: ExportType.tasks,
  kReportTaskItem: null,
  kReportInvoiceTax: ExportType.tax_summary,
  kReportPaymentTax: null,
  kReportQuote: ExportType.quotes,
  kReportInvoiceItem: ExportType.invoice_items,
  kReportQuoteItem: ExportType.quote_items,
  kReportRecurringExpense: null,
  kReportRecurringInvoice: ExportType.recurring_invoices,
  kReportPurchaseOrder: ExportType.purchase_order,
  kReportPurchaseOrderItem: ExportType.purchase_order_item,
  kReportVendor: ExportType.vendor,
  kReportTransaction: null,
};

const String kPdfFieldsClientDetails = 'client_details';
const String kPdfFieldsCompanyDetails = 'company_details';
const String kPdfFieldsCompanyAddress = 'company_address';
const String kPdfFieldsInvoiceDetails = 'invoice_details';
const String kPdfFieldsQuoteDetails = 'quote_details';
const String kPdfFieldsCreditDetails = 'credit_details';
const String kPdfFieldsProductColumns = 'product_columns';
const String kPdfFieldsProductQuoteColumns = 'product_quote_columns';
const String kPdfFieldsVendorDetails = 'vendor_details';
const String kPdfFieldsPurchaseOrderDetails = 'purchase_order_details';
const String kPdfFieldsTaskColumns = 'task_columns';
const String kPdfFieldsTotalFields = 'total_columns';

const String kPdfFields = '';
const String kPermissionCreateAll = 'create_all';
const String kPermissionViewAll = 'view_all';
const String kPermissionEditAll = 'edit_all';
const String kPermissionViewReports = 'view_reports';
const String kPermissionViewDashboard = 'view_dashboard';

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
const String kExpenseStatusUnpaid = '4';
const String kExpenseStatusPaid = '5';

const kExpenseStatuses = {
  kExpenseStatusLogged: 'logged',
  kExpenseStatusPending: 'pending',
  kExpenseStatusInvoiced: 'invoiced',
  kExpenseStatusUnpaid: 'unpaid',
  kExpenseStatusPaid: 'paid',
};

const String kTransactionStatusUnmatched = '1';
const String kTransactionStatusMatched = '2';
const String kTransactionStatusConverted = '3';
const String kTransactionStatusDeposit = '-1';
const String kTransactionStatusWithdrawal = '-2';

const kTransactionStatuses = {
  kTransactionStatusUnmatched: 'unmatched',
  kTransactionStatusMatched: 'matched',
  kTransactionStatusConverted: 'converted',
  kTransactionStatusDeposit: 'deposit',
  kTransactionStatusWithdrawal: 'withdrawal',
};

const String kDefaultCurrencyId = '1';
const String kDefaultLanguageId = '1';
const String kDefaultDateFormat = '5';
const String kDefaultAccentColor = '#2F7DC3';
const String kDefaultDarkSelectedColorMenu = '#1E252F';
const String kDefaultDarkSelectedColor = '#253750';
const String kDefaultDarkBorderColor = '#393A3C';
const String kDefaultLightSelectedColorMenu = '#f2faff';
const String kDefaultLightSelectedColor = '#e5f5ff';
const String kDefaultLightBorderColor = '#dfdfdf';

const String kTaxRegionUnitedStates = 'US';
const String kTaxRegionEurope = 'EU';
const String kTaxRegionAustralia = 'AU';

const String kReportGroupDay = 'day';
const String kReportGroupWeek = 'week';
const String kReportGroupMonth = 'month';
const String kReportGroupQuarter = 'quarter';
const String kReportGroupYear = 'year';

const int kModuleRecurringInvoices = 1;
const int kModuleCredits = 2;
const int kModuleQuotes = 4;
const int kModuleTasks = 8;
const int kModuleExpenses = 16;
const int kModuleProjects = 32;
const int kModuleVendors = 64;
const int kModuleDocuments = 128;
const int kModuleTransactions = 256;
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
  kModulePurchaseOrders: 'purchase_orders',
  kModuleExpenses: 'expenses',
  kModuleRecurringExpenses: 'recurring_expenses',
  kModuleTransactions: 'transactions',
  kModuleDocuments: 'documents',
  //kModuleRecurringTasks: 'recurring_tasks',
  //kModuleRecurringQuotes: 'recurring_quotes',
};

const List<int> kPaymentTerms = [0, -1, 7, 10, 14, 15, 30, 60, 90];

const List<String> kLanguages = [
  'ar',
  'bg',
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
  'et',
  'fa',
  'fi',
  'fr',
  'fr_CA',
  'fr_CH',
  'hu',
  'hr',
  'it',
  'ja',
  'lo_LA',
  'lt',
  'lv_LV',
  'mk_MK',
  'nb_NO',
  'nl',
  'pl',
  'pt_BR',
  'pt_PT',
  'ro',
  'ru_RU',
  'sk',
  'sl',
  'sq',
  'sr',
  'sv',
  'th',
  'tr_TR',
  'zh_TW',
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
  'invoice_terms',
  'quote_terms',
  'credit_terms',
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

//const kFrequencyOnce = '0';
const kFrequencyMonthly = '5';

const kStatementStatusAll = 'all';
const kStatementStatusPaid = 'paid';
const kStatementStatusUnpaid = 'unpaid';

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

// https://github.com/invoiceninja/invoiceninja/blob/v5-develop/app/Models/Activity.php
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
const String kActivityCreateRecurringQuote = '110';
const String kActivityUpdateRecurringQuote = '111';
const String kActivityArchiveRecurringQuote = '112';
const String kActivityDeleteRecurringQuote = '113';
const String kActivityRestoreRecurringQuote = '114';
const String kActivityCreateRecurringExpense = '120';
const String kActivityUpdateRecurringExpense = '121';
const String kActivityArchiveRecurringExpense = '122';
const String kActivityDeleteRecurringExpense = '123';
const String kActivityRestoreRecurringExpense = '124';
const String kActivityCreatePurchaseOrder = '130';
const String kActivityUpdatePurchaseOrder = '131';
const String kActivityArchivePurchaseOrder = '132';
const String kActivityDeletePurchaseOrder = '133';
const String kActivityRestorePurchaseOrder = '134';
const String kActivityEmailPurchaseOrder = '135';
const String kActivityViewPurchaseOrder = '136';
const String kActivityAcceptPurchaseOrder = '137';
const String kActivityEmailPayment = '138';
