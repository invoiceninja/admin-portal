/// Copy for the move to the new app: the prompt, the sidebar row and the
/// dashboard card, the restore-only purchase dialog, and the screen shown once
/// the server retires this app.
///
/// In English and in the languages the old beta invite was translated into
/// (German, French, Spanish, Italian, Dutch and Brazilian Portuguese, with
/// their regional variants), each one complete, and every other locale reads
/// English. All of them read left to right, so every surface built from it is
/// laid out left to right and takes nothing from AppLocalization: it is never
/// half one language. Kept apart from i18n.dart, these strings are not in
/// Transifex and the whole feature is removed with this app.
library;

import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';

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
  const BetaPromoStrings(this.localeCode);

  /// The copy for the language [state] shows the app in.
  BetaPromoStrings.of(AppState state) : this(localeSelector(state));

  final String localeCode;

  // Regional locales read their base language
  static const Map<String, String> _baseLocales = {
    'fr_CA': 'fr',
    'fr_CH': 'fr',
    'es_ES': 'es',
    'pt_PT': 'pt_BR',
  };

  /// The locale this copy is read in: the user's, or its base language, only
  /// when that one carries every string, else English, so a surface is never
  /// half one language and half another. A string added without its
  /// translations turns those languages back to English until they have it.
  String get sourceLocale {
    for (final code in [localeCode, _baseLocales[localeCode]]) {
      final values = _values[code];
      if (code != null &&
          values != null &&
          values.length == BetaStr.values.length) {
        return code;
      }
    }

    return 'en';
  }

  String get(BetaStr key) => _values[sourceLocale]![key]!;

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
      BetaStr.upgradeNote: 'New plans are bought in the new Invoice Ninja app.',
      BetaStr.playRefund:
          "If you buy a plan in the new app, we'll cancel your Legacy subscription and refund its unused time.",
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
      BetaStr.retiredTitle: 'This app has been retired',
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
    },
    'de': {
      BetaStr.pillNew: 'Neu',
      BetaStr.moveTitle: 'Invoice Ninja hat eine neue App',
      BetaStr.dataTitle: 'Ihre Daten sind sicher und bleiben, wo sie sind',
      BetaStr.dataBody:
          'Alles ist in Ihrem Invoice Ninja-Konto in der Cloud gespeichert, nicht in dieser App. Die Installation der neuen App ändert nichts an Ihren Kunden, Rechnungen, Zahlungen oder Einstellungen.',
      BetaStr.dataBodySelfHosted:
          'Alles ist auf Ihrem Server gespeichert, nicht in dieser App. Die Installation der neuen App ändert nichts an Ihren Kunden, Rechnungen, Zahlungen oder Einstellungen.',
      BetaStr.newAppTitle: 'Sie brauchen nur die neue App',
      BetaStr.newAppBody:
          'Installieren Sie sie auf Ihrem Smartphone oder Computer und melden Sie sich mit demselben Konto an. Alles ist da.',
      BetaStr.newAppSelfHosted:
          'Geben Sie Ihre Server-URL (und das Secret) erneut ein.',
      BetaStr.bothTitle:
          'Nutzen Sie beide parallel, während Sie sich umstellen',
      BetaStr.bothBody:
          'Beide Apps funktionieren bis zum :date gleichzeitig mit demselben Konto, sodass Sie in Ihrem eigenen Tempo wechseln können.',
      BetaStr.bothBodyAfter:
          'Der Support für diese App endete am :date und sie kann jederzeit aufhören zu funktionieren. Wechseln Sie deshalb so bald wie möglich.',
      BetaStr.planBody:
          'Ihr Tarif und Ihr Abonnement werden übernommen; Sie müssen nichts erneut kaufen.',
      BetaStr.upgradeNote:
          'Neue Tarife werden in der neuen Invoice Ninja-App gekauft.',
      BetaStr.playRefund:
          'Wenn Sie in der neuen App einen Tarif kaufen, kündigen wir Ihr Legacy-Abonnement und erstatten die nicht genutzte Zeit.',
      BetaStr.feedbackTitle: 'Sagen Sie uns, was Sie ändern würden',
      BetaStr.feedbackBody:
          'Wenn etwas anders funktioniert, als Sie es möchten, oder Ihnen etwas aus der alten App fehlt, kontaktieren Sie uns und wir sehen es uns an.',
      BetaStr.contactUs: 'Kontaktieren Sie uns',
      BetaStr.getNewApp: 'Neue App holen',
      BetaStr.belowFloor:
          'Die neue App läuft nicht auf Ihrem Gerät; nutzen Sie sie im Browser.',
      BetaStr.openInBrowser: 'Im Browser öffnen',
      BetaStr.openWebApp: 'Neue App öffnen',
      BetaStr.signInSub:
          'Melden Sie sich in der neuen App mit dem Konto an, das Sie hier verwenden. Ihre Daten warten dort auf Sie.',
      BetaStr.passwordHint:
          'Hier melden Sie sich ohne Passwort an. Falls die neue App auf Ihrem Gerät nicht dieselbe Anmeldung anbietet, verwenden Sie Ihre E-Mail-Adresse und ein Passwort.',
      BetaStr.email: 'E-Mail',
      BetaStr.setPassword: 'Passwort festlegen',
      BetaStr.copiedToClipboard: ':value in die Zwischenablage kopiert',
      BetaStr.cardBody:
          'Invoice Ninja hat eine neue App. Dasselbe Konto, dieselben Daten.',
      BetaStr.managePlan: 'Ihr Tarif wird im Web verwaltet.',
      BetaStr.subscriptionInStore:
          'Ihr Tarif ist ein Abonnement aus dem Store, in dem Sie ihn gekauft haben. Verwalten Sie ihn dort.',
      BetaStr.retiredTitle: 'Diese App wurde eingestellt',
      BetaStr.retiredBody:
          'Ihre Daten sind sicher in Ihrem Konto. Installieren Sie die neue Invoice Ninja-App und melden Sie sich mit demselben Konto an.',
      BetaStr.retiredBodySelfHosted:
          'Ihre Daten sind sicher auf Ihrem Server. Installieren Sie die neue Invoice Ninja-App und melden Sie sich erneut bei Ihrem Server an.',
      BetaStr.retiredPlan:
          'Ihr Tarif wird übernommen, behalten Sie also Ihr Abonnement.',
      BetaStr.manageSubscription: 'Abonnement verwalten',
      BetaStr.signOut: 'Abmelden',
      BetaStr.changeServer: 'Server wechseln',
      BetaStr.restorePurchases: 'Käufe wiederherstellen',
      BetaStr.restoreBody:
          'Stellen Sie ein in dieser App gekauftes Abonnement wieder her, damit es für Ihr Konto gilt. Neue Tarife werden in der neuen Invoice Ninja-App gekauft.',
      BetaStr.restoreChecking: 'Store wird abgefragt...',
      BetaStr.restoreNoneFound:
          'Es wurde kein Abonnement zum Wiederherstellen gefunden.',
      BetaStr.storeUnavailable:
          'Der Store ist auf diesem Gerät nicht verfügbar.',
      BetaStr.purchaseLinked: 'Ihr Abonnement ist mit diesem Konto verknüpft.',
      BetaStr.purchaseNotApplied:
          'Der Kauf konnte nicht auf Ihr Konto angewendet werden.',
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
      BetaStr.moveTitle: 'Invoice Ninja a une nouvelle application',
      BetaStr.dataTitle:
          'Vos données sont en sécurité et restent où elles sont',
      BetaStr.dataBody:
          'Tout est stocké dans votre compte Invoice Ninja dans le cloud, pas dans cette application. Installer la nouvelle application ne change rien à vos clients, factures, paiements ou paramètres.',
      BetaStr.dataBodySelfHosted:
          'Tout est stocké sur votre serveur, pas dans cette application. Installer la nouvelle application ne change rien à vos clients, factures, paiements ou paramètres.',
      BetaStr.newAppTitle: "Vous n'avez besoin que de la nouvelle application",
      BetaStr.newAppBody:
          'Installez-la sur votre téléphone ou votre ordinateur et connectez-vous avec le même compte. Tout y est.',
      BetaStr.newAppSelfHosted:
          "Saisissez à nouveau l'URL de votre serveur (et le secret).",
      BetaStr.bothTitle:
          'Utilisez les deux en parallèle le temps de vous adapter',
      BetaStr.bothBody:
          "Les deux applications fonctionnent avec le même compte en même temps jusqu'au :date, vous pouvez donc changer à votre rythme.",
      BetaStr.bothBodyAfter:
          'Le support de cette application a pris fin le :date et elle peut cesser de fonctionner à tout moment, alors changez dès que possible.',
      BetaStr.planBody:
          'Votre plan et votre abonnement sont conservés ; rien à racheter.',
      BetaStr.upgradeNote:
          "Les nouveaux plans s'achètent dans la nouvelle application Invoice Ninja.",
      BetaStr.playRefund:
          'Si vous achetez un plan dans la nouvelle application, nous résilierons votre abonnement Legacy et rembourserons la période non utilisée.',
      BetaStr.feedbackTitle: 'Dites-nous ce que vous changeriez',
      BetaStr.feedbackBody:
          "Si quelque chose ne fonctionne pas comme vous le souhaitez, ou s'il vous manque quelque chose de l'ancienne application, contactez-nous et nous l'examinerons.",
      BetaStr.contactUs: 'Nous contacter',
      BetaStr.getNewApp: 'Obtenir la nouvelle application',
      BetaStr.belowFloor:
          'Votre appareil ne peut pas exécuter la nouvelle application ; utilisez-la dans votre navigateur.',
      BetaStr.openInBrowser: 'Ouvrir dans votre navigateur',
      BetaStr.openWebApp: 'Ouvrir la nouvelle application',
      BetaStr.signInSub:
          'Connectez-vous à la nouvelle application avec le compte que vous utilisez ici. Vos données vous y attendent.',
      BetaStr.passwordHint:
          'Ici, vous vous connectez sans mot de passe. Si la nouvelle application ne propose pas la même connexion sur votre appareil, utilisez votre adresse e-mail et un mot de passe.',
      BetaStr.email: 'E-mail',
      BetaStr.setPassword: 'Définir le mot de passe',
      BetaStr.copiedToClipboard: ':value copié dans le presse-papiers',
      BetaStr.cardBody:
          'Invoice Ninja a une nouvelle application. Même compte, mêmes données.',
      BetaStr.managePlan: 'Votre plan est géré sur le Web.',
      BetaStr.subscriptionInStore:
          "Votre plan est un abonnement du Store où vous l'avez acheté. Gérez-le depuis ce Store.",
      BetaStr.retiredTitle: 'Cette application a été retirée',
      BetaStr.retiredBody:
          'Vos données sont en sécurité dans votre compte. Installez la nouvelle application Invoice Ninja et connectez-vous avec le même compte.',
      BetaStr.retiredBodySelfHosted:
          'Vos données sont en sécurité sur votre serveur. Installez la nouvelle application Invoice Ninja et reconnectez-vous à votre serveur.',
      BetaStr.retiredPlan:
          'Votre plan est conservé, gardez donc votre abonnement.',
      BetaStr.manageSubscription: "Gérer l'abonnement",
      BetaStr.signOut: 'Se déconnecter',
      BetaStr.changeServer: 'Changer de serveur',
      BetaStr.restorePurchases: 'Restaurer les achats',
      BetaStr.restoreBody:
          "Restaurez un abonnement acheté dans cette application pour qu'il s'applique à votre compte. Les nouveaux plans s'achètent dans la nouvelle application Invoice Ninja.",
      BetaStr.restoreChecking: 'Vérification auprès du Store...',
      BetaStr.restoreNoneFound: "Aucun abonnement à restaurer n'a été trouvé.",
      BetaStr.storeUnavailable:
          "Le Store n'est pas disponible sur cet appareil.",
      BetaStr.purchaseLinked: 'Votre abonnement est lié à ce compte.',
      BetaStr.purchaseNotApplied:
          "L'achat n'a pas pu être appliqué à votre compte.",
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
      BetaStr.moveTitle: 'Invoice Ninja tiene una nueva aplicación',
      BetaStr.dataTitle: 'Tus datos están seguros y no se mueven',
      BetaStr.dataBody:
          'Todo se guarda en tu cuenta de Invoice Ninja en la nube, no en esta aplicación. Instalar la nueva aplicación no cambia nada de tus clientes, facturas, pagos ni configuración.',
      BetaStr.dataBodySelfHosted:
          'Todo se guarda en tu servidor, no en esta aplicación. Instalar la nueva aplicación no cambia nada de tus clientes, facturas, pagos ni configuración.',
      BetaStr.newAppTitle: 'Solo necesitas la nueva aplicación',
      BetaStr.newAppBody:
          'Instálala en tu teléfono o en tu equipo e inicia sesión con la misma cuenta. Todo estará ahí.',
      BetaStr.newAppSelfHosted:
          'Vuelve a escribir la URL de tu servidor (y el secreto).',
      BetaStr.bothTitle: 'Usa ambas a la vez mientras te adaptas',
      BetaStr.bothBody:
          'Las dos aplicaciones funcionan con la misma cuenta al mismo tiempo hasta el :date, así que puedes cambiar a tu ritmo.',
      BetaStr.bothBodyAfter:
          'El soporte de esta aplicación terminó el :date y puede dejar de funcionar en cualquier momento, así que cámbiate lo antes posible.',
      BetaStr.planBody:
          'Tu plan y tu suscripción se mantienen; no tienes que volver a comprar nada.',
      BetaStr.upgradeNote:
          'Los planes nuevos se compran en la nueva aplicación de Invoice Ninja.',
      BetaStr.playRefund:
          'Si compras un plan en la nueva aplicación, cancelaremos tu suscripción de Legacy y te reembolsaremos el tiempo no utilizado.',
      BetaStr.feedbackTitle: 'Cuéntanos qué cambiarías',
      BetaStr.feedbackBody:
          'Si algo funciona de forma distinta a como te gustaría, o te falta algo de la aplicación anterior, contáctanos y lo revisaremos.',
      BetaStr.contactUs: 'Contáctanos',
      BetaStr.getNewApp: 'Obtener la nueva aplicación',
      BetaStr.belowFloor:
          'Tu dispositivo no puede ejecutar la nueva aplicación; úsala en tu navegador.',
      BetaStr.openInBrowser: 'Abrir en tu navegador',
      BetaStr.openWebApp: 'Abrir la nueva aplicación',
      BetaStr.signInSub:
          'Inicia sesión en la nueva aplicación con la cuenta que usas aquí. Tus datos te estarán esperando.',
      BetaStr.passwordHint:
          'Aquí inicias sesión sin contraseña. Si la nueva aplicación no ofrece el mismo inicio de sesión en tu dispositivo, usa tu correo electrónico y una contraseña.',
      BetaStr.email: 'Correo electrónico',
      BetaStr.setPassword: 'Establecer contraseña',
      BetaStr.copiedToClipboard: 'Se copió :value al portapapeles',
      BetaStr.cardBody:
          'Invoice Ninja tiene una nueva aplicación. La misma cuenta, los mismos datos.',
      BetaStr.managePlan: 'Tu plan se gestiona en la web.',
      BetaStr.subscriptionInStore:
          'Tu plan es una suscripción de la tienda donde lo compraste. Gestiónalo allí.',
      BetaStr.retiredTitle: 'Esta aplicación se ha retirado',
      BetaStr.retiredBody:
          'Tus datos están seguros en tu cuenta. Instala la nueva aplicación de Invoice Ninja e inicia sesión con la misma cuenta.',
      BetaStr.retiredBodySelfHosted:
          'Tus datos están seguros en tu servidor. Instala la nueva aplicación de Invoice Ninja y vuelve a iniciar sesión en tu servidor.',
      BetaStr.retiredPlan:
          'Tu plan se mantiene, así que conserva tu suscripción.',
      BetaStr.manageSubscription: 'Gestionar suscripción',
      BetaStr.signOut: 'Cerrar sesión',
      BetaStr.changeServer: 'Cambiar de servidor',
      BetaStr.restorePurchases: 'Restaurar compras',
      BetaStr.restoreBody:
          'Restaura una suscripción que compraste en esta aplicación para que se aplique a tu cuenta. Los planes nuevos se compran en la nueva aplicación de Invoice Ninja.',
      BetaStr.restoreChecking: 'Consultando con la tienda...',
      BetaStr.restoreNoneFound:
          'No se encontró ninguna suscripción para restaurar.',
      BetaStr.storeUnavailable:
          'La tienda no está disponible en este dispositivo.',
      BetaStr.purchaseLinked: 'Tu suscripción está vinculada a esta cuenta.',
      BetaStr.purchaseNotApplied: 'No se pudo aplicar la compra a tu cuenta.',
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
      BetaStr.moveTitle: 'Invoice Ninja ha una nuova app',
      BetaStr.dataTitle: 'I tuoi dati sono al sicuro e non si spostano',
      BetaStr.dataBody:
          'Tutto è salvato nel tuo account Invoice Ninja nel cloud, non in questa app. Installare la nuova app non cambia nulla di clienti, fatture, pagamenti o impostazioni.',
      BetaStr.dataBodySelfHosted:
          'Tutto è salvato sul tuo server, non in questa app. Installare la nuova app non cambia nulla di clienti, fatture, pagamenti o impostazioni.',
      BetaStr.newAppTitle: 'Ti basta la nuova app',
      BetaStr.newAppBody:
          'Installala sul telefono o sul computer e accedi con lo stesso account. Troverai tutto.',
      BetaStr.newAppSelfHosted:
          "Inserisci di nuovo l'URL del server (e il secret).",
      BetaStr.bothTitle: 'Usale entrambe mentre ti abitui',
      BetaStr.bothBody:
          'Entrambe le app funzionano con lo stesso account contemporaneamente fino al :date, così puoi passare alla nuova con i tuoi tempi.',
      BetaStr.bothBodyAfter:
          'Il supporto per questa app è terminato il :date e potrebbe smettere di funzionare in qualsiasi momento, quindi passa alla nuova il prima possibile.',
      BetaStr.planBody:
          'Il tuo piano e il tuo abbonamento restano validi; non devi acquistare nulla di nuovo.',
      BetaStr.upgradeNote:
          'I nuovi piani si acquistano nella nuova app Invoice Ninja.',
      BetaStr.playRefund:
          'Se acquisti un piano nella nuova app, annulleremo il tuo abbonamento Legacy e ti rimborseremo il periodo non utilizzato.',
      BetaStr.feedbackTitle: 'Dicci cosa cambieresti',
      BetaStr.feedbackBody:
          "Se qualcosa funziona in modo diverso da come vorresti, o ti manca qualcosa della vecchia app, contattaci e ci daremo un'occhiata.",
      BetaStr.contactUs: 'Contattaci',
      BetaStr.getNewApp: 'Scarica la nuova app',
      BetaStr.belowFloor:
          'Il tuo dispositivo non può eseguire la nuova app; usala nel browser.',
      BetaStr.openInBrowser: 'Apri nel browser',
      BetaStr.openWebApp: 'Apri la nuova app',
      BetaStr.signInSub:
          "Accedi alla nuova app con l'account che usi qui. I tuoi dati ti aspettano.",
      BetaStr.passwordHint:
          'Qui accedi senza password. Se la nuova app non offre lo stesso accesso sul tuo dispositivo, usa la tua e-mail e una password.',
      BetaStr.email: 'E-mail',
      BetaStr.setPassword: 'Imposta password',
      BetaStr.copiedToClipboard: ':value copiato negli appunti',
      BetaStr.cardBody:
          'Invoice Ninja ha una nuova app. Stesso account, stessi dati.',
      BetaStr.managePlan: 'Il tuo piano è gestito sul web.',
      BetaStr.subscriptionInStore:
          "Il tuo piano è un abbonamento dello store in cui l'hai acquistato. Gestiscilo lì.",
      BetaStr.retiredTitle: 'Questa app è stata dismessa',
      BetaStr.retiredBody:
          'I tuoi dati sono al sicuro nel tuo account. Installa la nuova app Invoice Ninja e accedi con lo stesso account.',
      BetaStr.retiredBodySelfHosted:
          'I tuoi dati sono al sicuro sul tuo server. Installa la nuova app Invoice Ninja e accedi di nuovo al tuo server.',
      BetaStr.retiredPlan:
          'Il tuo piano resta valido, quindi mantieni il tuo abbonamento.',
      BetaStr.manageSubscription: 'Gestisci abbonamento',
      BetaStr.signOut: 'Esci',
      BetaStr.changeServer: 'Cambia server',
      BetaStr.restorePurchases: 'Ripristina acquisti',
      BetaStr.restoreBody:
          'Ripristina un abbonamento acquistato in questa app perché si applichi al tuo account. I nuovi piani si acquistano nella nuova app Invoice Ninja.',
      BetaStr.restoreChecking: 'Verifica con lo store in corso...',
      BetaStr.restoreNoneFound:
          'Non è stato trovato nessun abbonamento da ripristinare.',
      BetaStr.storeUnavailable:
          'Lo store non è disponibile su questo dispositivo.',
      BetaStr.purchaseLinked:
          'Il tuo abbonamento è collegato a questo account.',
      BetaStr.purchaseNotApplied:
          "Non è stato possibile applicare l'acquisto al tuo account.",
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
      BetaStr.moveTitle: 'Invoice Ninja heeft een nieuwe app',
      BetaStr.dataTitle: 'Je gegevens zijn veilig en blijven waar ze zijn',
      BetaStr.dataBody:
          'Alles staat in je Invoice Ninja-account in de cloud, niet in deze app. De nieuwe app installeren verandert niets aan je klanten, facturen, betalingen of instellingen.',
      BetaStr.dataBodySelfHosted:
          'Alles staat op je server, niet in deze app. De nieuwe app installeren verandert niets aan je klanten, facturen, betalingen of instellingen.',
      BetaStr.newAppTitle: 'Je hebt alleen de nieuwe app nodig',
      BetaStr.newAppBody:
          'Installeer hem op je telefoon of computer en log in met hetzelfde account. Alles staat klaar.',
      BetaStr.newAppSelfHosted: 'Vul je server-URL (en secret) opnieuw in.',
      BetaStr.bothTitle: 'Gebruik ze naast elkaar terwijl je went',
      BetaStr.bothBody:
          'Beide apps werken tot :date tegelijk met hetzelfde account, dus je kunt in je eigen tempo overstappen.',
      BetaStr.bothBodyAfter:
          'De ondersteuning voor deze app is op :date gestopt en hij kan op elk moment ophouden met werken, dus stap zo snel mogelijk over.',
      BetaStr.planBody:
          'Je abonnement gaat mee; je hoeft niets opnieuw te kopen.',
      BetaStr.upgradeNote:
          'Nieuwe abonnementen koop je in de nieuwe Invoice Ninja-app.',
      BetaStr.playRefund:
          'Als je in de nieuwe app een abonnement koopt, zeggen we je Legacy-abonnement op en betalen we de ongebruikte tijd terug.',
      BetaStr.feedbackTitle: 'Vertel ons wat je zou veranderen',
      BetaStr.feedbackBody:
          'Werkt iets anders dan je zou willen, of mis je iets uit de oude app? Neem contact met ons op, dan kijken we ernaar.',
      BetaStr.contactUs: 'Neem contact op',
      BetaStr.getNewApp: 'Download de nieuwe app',
      BetaStr.belowFloor:
          'De nieuwe app werkt niet op je apparaat; gebruik hem in je browser.',
      BetaStr.openInBrowser: 'Openen in je browser',
      BetaStr.openWebApp: 'Open de nieuwe app',
      BetaStr.signInSub:
          'Log in op de nieuwe app met het account dat je hier gebruikt. Je gegevens staan klaar.',
      BetaStr.passwordHint:
          'Hier log je in zonder wachtwoord. Biedt de nieuwe app op je apparaat niet dezelfde manier van inloggen, gebruik dan je e-mailadres en een wachtwoord.',
      BetaStr.email: 'E-mail',
      BetaStr.setPassword: 'Wachtwoord instellen',
      BetaStr.copiedToClipboard: ':value naar het klembord gekopieerd',
      BetaStr.cardBody:
          'Invoice Ninja heeft een nieuwe app. Hetzelfde account, dezelfde gegevens.',
      BetaStr.managePlan: 'Je abonnement wordt via het web beheerd.',
      BetaStr.subscriptionInStore:
          'Je abonnement komt uit de store waarin je het hebt gekocht. Beheer het daar.',
      BetaStr.retiredTitle: 'Deze app is buiten gebruik gesteld',
      BetaStr.retiredBody:
          'Je gegevens zijn veilig in je account. Installeer de nieuwe Invoice Ninja-app en log in met hetzelfde account.',
      BetaStr.retiredBodySelfHosted:
          'Je gegevens zijn veilig op je server. Installeer de nieuwe Invoice Ninja-app en log opnieuw in op je server.',
      BetaStr.retiredPlan: 'Je abonnement gaat mee, dus zeg het niet op.',
      BetaStr.manageSubscription: 'Abonnement beheren',
      BetaStr.signOut: 'Uitloggen',
      BetaStr.changeServer: 'Server wijzigen',
      BetaStr.restorePurchases: 'Aankopen herstellen',
      BetaStr.restoreBody:
          'Herstel een abonnement dat je in deze app hebt gekocht, zodat het voor je account geldt. Nieuwe abonnementen koop je in de nieuwe Invoice Ninja-app.',
      BetaStr.restoreChecking: 'Controleren bij de store...',
      BetaStr.restoreNoneFound:
          'Er is geen abonnement gevonden om te herstellen.',
      BetaStr.storeUnavailable: 'De store is niet beschikbaar op dit apparaat.',
      BetaStr.purchaseLinked: 'Je abonnement is gekoppeld aan dit account.',
      BetaStr.purchaseNotApplied:
          'De aankoop kon niet op je account worden toegepast.',
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
      BetaStr.moveTitle: 'O Invoice Ninja tem um novo app',
      BetaStr.dataTitle: 'Seus dados estão seguros e não saem do lugar',
      BetaStr.dataBody:
          'Tudo fica armazenado na sua conta do Invoice Ninja na nuvem, não neste app. Instalar o novo app não muda nada nos seus clientes, faturas, pagamentos ou configurações.',
      BetaStr.dataBodySelfHosted:
          'Tudo fica armazenado no seu servidor, não neste app. Instalar o novo app não muda nada nos seus clientes, faturas, pagamentos ou configurações.',
      BetaStr.newAppTitle: 'Você só precisa do novo app',
      BetaStr.newAppBody:
          'Instale-o no seu celular ou computador e entre com a mesma conta. Está tudo lá.',
      BetaStr.newAppSelfHosted:
          'Informe novamente a URL do seu servidor (e o segredo).',
      BetaStr.bothTitle: 'Use os dois lado a lado enquanto se adapta',
      BetaStr.bothBody:
          'Os dois apps funcionam na mesma conta ao mesmo tempo até :date, então você pode mudar no seu ritmo.',
      BetaStr.bothBodyAfter:
          'O suporte a este app terminou em :date e ele pode parar de funcionar a qualquer momento, então mude assim que puder.',
      BetaStr.planBody:
          'Seu plano e sua assinatura continuam valendo; não é preciso comprar nada de novo.',
      BetaStr.upgradeNote:
          'Novos planos são comprados no novo app do Invoice Ninja.',
      BetaStr.playRefund:
          'Se você comprar um plano no novo app, cancelaremos sua assinatura do Legacy e reembolsaremos o tempo não utilizado.',
      BetaStr.feedbackTitle: 'Conte o que você mudaria',
      BetaStr.feedbackBody:
          'Se algo funcionar de um jeito diferente do que você gostaria, ou se sentir falta de algo do app antigo, fale com a gente e vamos analisar.',
      BetaStr.contactUs: 'Fale conosco',
      BetaStr.getNewApp: 'Baixar o novo app',
      BetaStr.belowFloor:
          'Seu dispositivo não consegue executar o novo app; use-o no navegador.',
      BetaStr.openInBrowser: 'Abrir no navegador',
      BetaStr.openWebApp: 'Abrir o novo app',
      BetaStr.signInSub:
          'Entre no novo app com a conta que você usa aqui. Seus dados estarão esperando.',
      BetaStr.passwordHint:
          'Aqui você entra sem senha. Se o novo app não oferecer o mesmo login no seu dispositivo, use seu e-mail e uma senha.',
      BetaStr.email: 'E-mail',
      BetaStr.setPassword: 'Definir senha',
      BetaStr.copiedToClipboard: ':value copiado para a área de transferência',
      BetaStr.cardBody:
          'O Invoice Ninja tem um novo app. Mesma conta, mesmos dados.',
      BetaStr.managePlan: 'Seu plano é gerenciado na web.',
      BetaStr.subscriptionInStore:
          'Seu plano é uma assinatura da loja em que você o comprou. Gerencie-o lá.',
      BetaStr.retiredTitle: 'Este app foi descontinuado',
      BetaStr.retiredBody:
          'Seus dados estão seguros na sua conta. Instale o novo app do Invoice Ninja e entre com a mesma conta.',
      BetaStr.retiredBodySelfHosted:
          'Seus dados estão seguros no seu servidor. Instale o novo app do Invoice Ninja e entre no seu servidor novamente.',
      BetaStr.retiredPlan:
          'Seu plano continua valendo, então mantenha sua assinatura.',
      BetaStr.manageSubscription: 'Gerenciar assinatura',
      BetaStr.signOut: 'Sair',
      BetaStr.changeServer: 'Trocar de servidor',
      BetaStr.restorePurchases: 'Restaurar compras',
      BetaStr.restoreBody:
          'Restaure uma assinatura comprada neste app para que ela valha para a sua conta. Novos planos são comprados no novo app do Invoice Ninja.',
      BetaStr.restoreChecking: 'Verificando com a loja...',
      BetaStr.restoreNoneFound:
          'Nenhuma assinatura para restaurar foi encontrada.',
      BetaStr.storeUnavailable: 'A loja não está disponível neste dispositivo.',
      BetaStr.purchaseLinked: 'Sua assinatura está vinculada a esta conta.',
      BetaStr.purchaseNotApplied:
          'Não foi possível aplicar a compra à sua conta.',
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
