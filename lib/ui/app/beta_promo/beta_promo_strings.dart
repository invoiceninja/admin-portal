/// Copy for the move to the new app: the prompt, the sidebar row and the
/// dashboard card, and the screen shown once the server retires this app.
///
/// Kept apart from i18n.dart: these translations are not in Transifex so a
/// sync would drop them, and the whole feature is removed with this app. A
/// key a locale doesn't have reads English.
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
  playRefund,
  feedbackTitle,
  feedbackBody,
  contactUs,
  getNewApp,
  belowFloor,
  openInBrowser,
  signInSub,
  passwordHint,
  cardBody,
  managePlan,
  retiredTitle,
  retiredBody,
  manageSubscription,
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
  const BetaPromoStrings(this.localeCode);

  final String localeCode;

  // Regional locales read their base language before falling back to English
  static const Map<String, String> _baseLocales = {
    'en_GB': 'en',
    'fr_CA': 'fr',
    'fr_CH': 'fr',
    'es_ES': 'es',
    'pt_PT': 'pt_BR',
  };

  bool get isTranslated =>
      _values.containsKey(localeCode) || _baseLocales.containsKey(localeCode);

  String get(BetaStr key) =>
      _values[localeCode]?[key] ??
      _values[_baseLocales[localeCode]]?[key] ??
      _values['en']![key]!;

  /// The locale [get] reads [key] from, so a date put into it matches the
  /// language of the sentence around it
  String localeOf(BetaStr key) {
    if (_values[localeCode]?[key] != null) {
      return localeCode;
    }

    final base = _baseLocales[localeCode];

    return base != null && _values[base]?[key] != null ? base : 'en';
  }

  static const Map<String, Map<BetaStr, String>> _values = {
    'en': {
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
      BetaStr.signInSub:
          'Sign in to the new app with the account you use here. Your data will be waiting.',
      BetaStr.passwordHint:
          "You sign in here without a password. If the new app doesn't offer the same sign-in on your device, use your email and a password.",
      BetaStr.cardBody: 'Invoice Ninja has a new app. Same account, same data.',
      BetaStr.managePlan: 'Manage your plan in the new Invoice Ninja app.',
      BetaStr.retiredTitle: 'This app has been retired.',
      BetaStr.retiredBody:
          'Your data is safe in your account. Install the new Invoice Ninja app and sign in with the same account.',
      BetaStr.manageSubscription: 'Manage subscription',
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
    },
    'de': {
      BetaStr.pillNew: 'Neu',
      BetaStr.chipsLabel: 'Verfügbar für',
      BetaStr.qrCaption: 'Scannen und aufs Smartphone holen',
      BetaStr.qrCaptionApple: 'Scannen und auf iPhone oder iPad holen',
      BetaStr.demo: 'Live-Demo ausprobieren',
      BetaStr.remindLater: 'Später erinnern',
      BetaStr.stepTitle: 'Nur noch ein Schritt',
      BetaStr.serverUrl: 'Server-URL',
      BetaStr.apiSecret:
          'Falls Ihr Server ein API-Secret verwendet, geben Sie es ebenfalls ein.',
      BetaStr.appName: 'Auf Ihrem Gerät heißt die App „:name“.',
      BetaStr.openAgain: 'Store erneut öffnen',
      BetaStr.launchFailed:
          'Der Link konnte nicht geöffnet werden. Kopieren Sie ihn stattdessen:',
      BetaStr.close: 'Schließen',
      BetaStr.copy: 'Kopieren',
      BetaStr.done: 'Fertig',
      BetaStr.back: 'Zurück',
    },
    'fr': {
      BetaStr.pillNew: 'Nouveau',
      BetaStr.chipsLabel: 'Disponible pour',
      BetaStr.qrCaption: "Scannez pour l'avoir sur votre téléphone",
      BetaStr.qrCaptionApple: "Scannez pour l'avoir sur iPhone ou iPad",
      BetaStr.demo: 'Essayer la démo en ligne',
      BetaStr.remindLater: 'Me le rappeler plus tard',
      BetaStr.stepTitle: 'Encore une étape',
      BetaStr.serverUrl: 'URL du serveur',
      BetaStr.apiSecret:
          'Ajoutez aussi votre secret API si votre serveur en utilise un.',
      BetaStr.appName: "Sur votre appareil, elle s'appelle « :name ».",
      BetaStr.openAgain: 'Rouvrir le Store',
      BetaStr.launchFailed: "Impossible d'ouvrir ce lien. Copiez-le plutôt :",
      BetaStr.close: 'Fermer',
      BetaStr.copy: 'Copier',
      BetaStr.done: 'Terminé',
      BetaStr.back: 'Retour',
    },
    'es': {
      BetaStr.pillNew: 'Nuevo',
      BetaStr.chipsLabel: 'Disponible para',
      BetaStr.qrCaption: 'Escanea para tenerla en tu teléfono',
      BetaStr.qrCaptionApple: 'Escanea para tenerla en tu iPhone o iPad',
      BetaStr.demo: 'Probar la demo en vivo',
      BetaStr.remindLater: 'Recordármelo más tarde',
      BetaStr.stepTitle: 'Un paso más',
      BetaStr.serverUrl: 'URL del servidor',
      BetaStr.apiSecret:
          'Añade también tu secreto de API si tu servidor usa uno.',
      BetaStr.appName: 'En tu dispositivo se llama «:name».',
      BetaStr.openAgain: 'Abrir la tienda de nuevo',
      BetaStr.launchFailed: 'No se pudo abrir el enlace. Cópialo:',
      BetaStr.close: 'Cerrar',
      BetaStr.copy: 'Copiar',
      BetaStr.done: 'Listo',
      BetaStr.back: 'Atrás',
    },
    'it': {
      BetaStr.pillNew: 'Novità',
      BetaStr.chipsLabel: 'Disponibile per',
      BetaStr.qrCaption: 'Inquadra per averla sul telefono',
      BetaStr.qrCaptionApple: 'Inquadra per averla su iPhone o iPad',
      BetaStr.demo: 'Prova la demo online',
      BetaStr.remindLater: 'Ricordamelo più tardi',
      BetaStr.stepTitle: 'Ancora un passaggio',
      BetaStr.serverUrl: 'URL del server',
      BetaStr.apiSecret:
          'Aggiungi anche il secret API, se il tuo server ne usa uno.',
      BetaStr.appName: 'Sul tuo dispositivo si chiama «:name».',
      BetaStr.openAgain: 'Riapri lo store',
      BetaStr.launchFailed: 'Impossibile aprire il link. Copialo:',
      BetaStr.close: 'Chiudi',
      BetaStr.copy: 'Copia',
      BetaStr.done: 'Fatto',
      BetaStr.back: 'Indietro',
    },
    'nl': {
      BetaStr.pillNew: 'Nieuw',
      BetaStr.chipsLabel: 'Beschikbaar voor',
      BetaStr.qrCaption: 'Scan om de app op je telefoon te zetten',
      BetaStr.qrCaptionApple: 'Scan om de app op je iPhone of iPad te zetten',
      BetaStr.demo: 'Probeer de live demo',
      BetaStr.remindLater: 'Herinner me later',
      BetaStr.stepTitle: 'Nog één stap',
      BetaStr.serverUrl: 'Server-URL',
      BetaStr.apiSecret:
          'Vul ook je API-secret in als je server er een gebruikt.',
      BetaStr.appName: 'Op je apparaat heet de app ":name".',
      BetaStr.openAgain: 'Store opnieuw openen',
      BetaStr.launchFailed: 'De link kon niet worden geopend. Kopieer hem:',
      BetaStr.close: 'Sluiten',
      BetaStr.copy: 'Kopiëren',
      BetaStr.done: 'Klaar',
      BetaStr.back: 'Terug',
    },
    'pt_BR': {
      BetaStr.pillNew: 'Novo',
      BetaStr.chipsLabel: 'Disponível para',
      BetaStr.qrCaption: 'Escaneie para ter no seu celular',
      BetaStr.qrCaptionApple: 'Escaneie para ter no iPhone ou iPad',
      BetaStr.demo: 'Experimentar a demonstração',
      BetaStr.remindLater: 'Lembrar mais tarde',
      BetaStr.stepTitle: 'Só mais um passo',
      BetaStr.serverUrl: 'URL do servidor',
      BetaStr.apiSecret:
          'Informe também o segredo da API, se o seu servidor usar um.',
      BetaStr.appName: 'No seu dispositivo, ele se chama ":name".',
      BetaStr.openAgain: 'Abrir a loja novamente',
      BetaStr.launchFailed: 'Não foi possível abrir o link. Copie-o:',
      BetaStr.close: 'Fechar',
      BetaStr.copy: 'Copiar',
      BetaStr.done: 'Concluir',
      BetaStr.back: 'Voltar',
    },
  };
}
