/// Copy for the move to the new app: the prompt, the sidebar row and the
/// dashboard card, the restore-only purchase dialog, and the screen shown once
/// the server retires this app.
///
/// English only, in every locale: the copy was written once for the move and
/// never translated. Every surface built from it is laid out left to right
/// and takes nothing from AppLocalization, so it is never half one language.
/// Kept apart from i18n.dart, these strings are not in Transifex and the
/// whole feature is removed with this app.
enum BetaStr {
  pillNew,
  moveTitle,
  dataTitle,
  dataBody,
  dataBodySelfHosted,
  newAppTitle,
  newAppBody,
  newAppSelfHosted,
  bothTitle,
  bothBody,
  bothBodyAfter,
  planBody,
  upgradeNote,
  playRefund,
  feedbackTitle,
  feedbackBody,
  contactUs,
  getNewApp,
  belowFloor,
  openInBrowser,
  openWebApp,
  signInSub,
  passwordHint,
  email,
  setPassword,
  copiedToClipboard,
  cardBody,
  managePlan,
  subscriptionInStore,
  retiredTitle,
  retiredBody,
  retiredBodySelfHosted,
  retiredPlan,
  manageSubscription,
  signOut,
  changeServer,
  restorePurchases,
  restoreBody,
  restoreChecking,
  restoreNoneFound,
  storeUnavailable,
  purchaseLinked,
  purchaseNotApplied,
  chipsLabel,
  qrCaption,
  qrCaptionApple,
  demo,
  remindLater,
  stepTitle,
  serverUrl,
  apiSecret,
  appName,
  openAgain,
  launchFailed,
  close,
  copy,
  done,
  back,
}

class BetaPromoStrings {
  const BetaPromoStrings();

  String get(BetaStr key) => _values[key]!;

  static const Map<BetaStr, String> _values = {
    BetaStr.pillNew: 'New',
    BetaStr.moveTitle: 'Invoice Ninja has a new app',
    BetaStr.dataTitle: "Your data is safe and doesn't move",
    BetaStr.dataBody:
        'Everything is stored in your Invoice Ninja account in the cloud, not in this app. Installing the new app changes nothing about your clients, invoices, payments or settings.',
    BetaStr.dataBodySelfHosted:
        'Everything is stored on your server, not in this app. Installing the new app changes nothing about your clients, invoices, payments or settings.',
    BetaStr.newAppTitle: 'You only need the new app',
    BetaStr.newAppBody:
        'Install it on your phone or computer and sign in with the same account. Everything is there.',
    BetaStr.newAppSelfHosted: 'Enter your server URL (and secret) again.',
    BetaStr.bothTitle: 'Use both side by side while you adjust',
    BetaStr.bothBody:
        'Both apps work on the same account at the same time until :date, so you can switch at your own pace.',
    BetaStr.bothBodyAfter:
        'Support for this app ended on :date and it can stop working at any time, so switch as soon as you can.',
    BetaStr.planBody:
        'Your plan and subscription carry over; nothing to buy again.',
    BetaStr.upgradeNote: 'New plans are bought in the new Invoice Ninja app.',
    BetaStr.playRefund:
        "If you change plans in the new app, we'll cancel your Legacy subscription and refund its unused time.",
    BetaStr.feedbackTitle: "Tell us what you'd change",
    BetaStr.feedbackBody:
        "If something works differently than you'd like, or you miss something from the old app, contact us and we'll look at it.",
    BetaStr.contactUs: 'Contact us',
    BetaStr.getNewApp: 'Get the new app',
    BetaStr.belowFloor:
        "Your device can't run the new app; use it in your browser.",
    BetaStr.openInBrowser: 'Open in your browser',
    BetaStr.openWebApp: 'Open the new app',
    BetaStr.signInSub:
        'Sign in to the new app with the account you use here. Your data will be waiting.',
    BetaStr.passwordHint:
        "You sign in here without a password. If the new app doesn't offer the same sign-in on your device, use your email and a password.",
    BetaStr.email: 'Email',
    BetaStr.setPassword: 'Set password',
    BetaStr.copiedToClipboard: 'Copied :value to the clipboard',
    BetaStr.cardBody: 'Invoice Ninja has a new app. Same account, same data.',
    // Shown on a store build for a plan billed on the web, which neither app
    // can change in-app; same words as the new app's Plan screen
    BetaStr.managePlan: 'Your plan is managed on the web.',
    BetaStr.subscriptionInStore:
        'Your plan is a subscription from the store you bought it in. Manage it there.',
    BetaStr.retiredTitle: 'This app has been retired.',
    BetaStr.retiredBody:
        'Your data is safe in your account. Install the new Invoice Ninja app and sign in with the same account.',
    BetaStr.retiredBodySelfHosted:
        'Your data is safe on your server. Install the new Invoice Ninja app and sign in to your server again.',
    BetaStr.retiredPlan: 'Your plan carries over, so keep your subscription.',
    BetaStr.manageSubscription: 'Manage subscription',
    BetaStr.signOut: 'Sign out',
    BetaStr.changeServer: 'Change server',
    BetaStr.restorePurchases: 'Restore purchases',
    BetaStr.restoreBody:
        'Restore a subscription you bought in this app so it applies to your account. New plans are bought in the new Invoice Ninja app.',
    BetaStr.restoreChecking: 'Checking with the store...',
    BetaStr.restoreNoneFound: 'No subscription to restore was found.',
    BetaStr.storeUnavailable: "The store isn't available on this device.",
    BetaStr.purchaseLinked: 'Your subscription is linked to this account.',
    BetaStr.purchaseNotApplied:
        "The purchase couldn't be applied to your account.",
    BetaStr.chipsLabel: 'Get it for',
    BetaStr.qrCaption: 'Scan to get it on your phone',
    BetaStr.qrCaptionApple: 'Scan to get it on iPhone or iPad',
    BetaStr.demo: 'Try the live demo',
    BetaStr.remindLater: 'Remind me later',
    BetaStr.stepTitle: 'One more step',
    BetaStr.serverUrl: 'Server URL',
    BetaStr.apiSecret: 'Add your API secret too, if your server uses one.',
    BetaStr.appName: 'On your device it\'s called ":name".',
    BetaStr.openAgain: 'Open the store again',
    BetaStr.launchFailed: "Couldn't open that link. Copy it instead:",
    BetaStr.close: 'Close',
    BetaStr.copy: 'Copy',
    BetaStr.done: 'Done',
    BetaStr.back: 'Back',
  };
}
