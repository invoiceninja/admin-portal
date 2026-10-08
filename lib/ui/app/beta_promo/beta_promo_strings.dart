/// Copy for the beta invitation.
///
/// Kept apart from i18n.dart: these translations are not in Transifex so a
/// sync would drop them, and the whole feature is removed once the new app
/// replaces this one.
enum BetaStr {
  pillNew,
  headline,
  sub,
  subKeep,
  offlineTitle,
  offlineBody,
  dashboardTitle,
  dashboardBody,
  designerTitle,
  designerBody,
  tasksTitle,
  tasksBody,
  tabsTitle,
  tabsBody,
  receiptTitle,
  receiptBody,
  callsTitle,
  callsBody,
  bigTitle,
  bigBody,
  getBeta,
  captionApple,
  captionAndroid,
  captionWindows,
  captionLinux,
  chipsLabel,
  winIntro,
  winField,
  winRequest,
  winSent,
  winOpenStore,
  winFailed,
  winOpenEmail,
  winChange,
  winSelfHosted,
  winInvalid,
  snapIntro,
  snapNote,
  keepBoth,
  appImage,
  appImageCaption,
  orSnap,
  thenSignIn,
  qrCaption,
  qrCaptionApple,
  demo,
  remindLater,
  dontShow,
  stepTitle,
  stepSub,
  serverUrl,
  apiSecret,
  appName,
  passwordHint,
  openAgain,
  entryTitle,
  cardBody,
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

  static const Map<String, Map<BetaStr, String>> _values = {
    'en': {
      BetaStr.pillNew: 'New',
      BetaStr.headline: 'Meet the new Invoice Ninja',
      BetaStr.sub:
          "It's the same account and the same data, so there's nothing to move.",
      BetaStr.subKeep: 'Keep this app while you try it.',
      BetaStr.offlineTitle: 'Works offline',
      BetaStr.offlineBody:
          "Create and edit without a connection. Changes sync when you're back online.",
      BetaStr.dashboardTitle: 'A dashboard that shows what to chase',
      BetaStr.dashboardBody:
          'Past due, due soon and expiring quotes come first, each with one-tap actions.',
      BetaStr.designerTitle: 'Design invoices visually',
      BetaStr.designerBody:
          'Drag blocks onto the page and watch your invoice take shape. No code.',
      BetaStr.tasksTitle: 'Tasks by day, week or month',
      BetaStr.tasksBody:
          'Daily, weekly and calendar views alongside the list and board.',
      BetaStr.tabsTitle: 'One-click status tabs',
      BetaStr.tabsBody:
          'Draft, Unpaid and Past Due above your lists, with counts in the menu.',
      BetaStr.receiptTitle: 'Receipt to expense in one share',
      BetaStr.receiptBody:
          'Share a photo or PDF from any app and a new expense opens with it attached.',
      BetaStr.callsTitle: 'Log every call',
      BetaStr.callsBody:
          "After a call, save who you spoke to and what was said on the client's record.",
      BetaStr.bigTitle: 'Built for big accounts',
      BetaStr.bigBody:
          "Records load as you go, so you're working right away instead of waiting for a full download.",
      BetaStr.getBeta: 'Get the beta',
      BetaStr.captionApple:
          "Opens TestFlight, Apple's free app for trying beta versions.",
      BetaStr.captionAndroid:
          'Tap "Become a tester", then install it from Google Play.',
      BetaStr.captionWindows:
          'Invite-only on the Microsoft Store for now. Requesting access takes a few seconds.',
      BetaStr.captionLinux: 'Available as a snap or an AppImage.',
      BetaStr.chipsLabel: 'Get it for',
      BetaStr.winIntro:
          "The Windows beta is invite-only on the Microsoft Store for now. Send us your Microsoft account email and we'll add you.",
      BetaStr.winField: 'Microsoft account email',
      BetaStr.winRequest: 'Request access',
      BetaStr.winSent:
          "Request sent. We'll email you at :email once you're added. Then install it from the Store.",
      BetaStr.winOpenStore: 'Open Microsoft Store',
      BetaStr.winFailed:
          "We couldn't send that from here. Email :contact with your Microsoft account address instead.",
      BetaStr.winOpenEmail: 'Open email app',
      BetaStr.winChange: 'Use a different address',
      BetaStr.winSelfHosted:
          "Sent through your server's own email. If you don't hear back, write to :contact.",
      BetaStr.winInvalid: 'Enter a valid email address',
      BetaStr.snapIntro:
          'Copy this command, quit Invoice Ninja, then paste it into a terminal.',
      BetaStr.snapNote:
          'This replaces this app with the beta. To go back, run:',
      BetaStr.keepBoth: 'Want to keep both? Download the AppImage instead.',
      BetaStr.appImage: 'Download the AppImage',
      BetaStr.appImageCaption: 'Runs beside this app, no installer.',
      BetaStr.orSnap: 'Or install the snap:',
      BetaStr.thenSignIn: 'Then sign in with :email.',
      BetaStr.qrCaption: 'Scan to get it on your phone',
      BetaStr.qrCaptionApple: 'Scan to get it on iPhone or iPad',
      BetaStr.demo: 'Try the live demo',
      BetaStr.remindLater: 'Remind me later',
      BetaStr.dontShow: "Don't show again",
      BetaStr.stepTitle: 'One more step',
      BetaStr.stepSub:
          'Sign in to the beta with the account you use here. Your data will be waiting.',
      BetaStr.serverUrl: 'Server URL',
      BetaStr.apiSecret: 'Add your API secret too, if your server uses one.',
      BetaStr.appName: 'On your device it\'s called ":name".',
      BetaStr.passwordHint:
          "You sign in here without a password. If the beta doesn't offer the same sign-in on your device, use your email and a password.",
      BetaStr.openAgain: 'Open the store again',
      BetaStr.entryTitle: 'Try the new app',
      BetaStr.cardBody:
          'The new Invoice Ninja is in beta. Same account, same data.',
      BetaStr.launchFailed: "Couldn't open that link. Copy it instead:",
      BetaStr.close: 'Close',
      BetaStr.copy: 'Copy',
      BetaStr.done: 'Done',
      BetaStr.back: 'Back',
    },
    'de': {
      BetaStr.pillNew: 'Neu',
      BetaStr.headline: 'Lernen Sie das neue Invoice Ninja kennen',
      BetaStr.sub:
          'Gleiches Konto, gleiche Daten – es muss nichts übertragen werden.',
      BetaStr.subKeep: 'Diese App können Sie währenddessen weiter nutzen.',
      BetaStr.offlineTitle: 'Funktioniert offline',
      BetaStr.offlineBody:
          'Ohne Verbindung erstellen und bearbeiten. Änderungen werden synchronisiert, sobald Sie wieder online sind.',
      BetaStr.dashboardTitle: 'Eine Übersicht, die zeigt, was ansteht',
      BetaStr.dashboardBody:
          'Überfälliges, bald Fälliges und ablaufende Angebote stehen ganz oben, jeweils mit direkten Aktionen.',
      BetaStr.designerTitle: 'Rechnungen visuell gestalten',
      BetaStr.designerBody:
          'Ziehen Sie Bausteine auf die Seite und sehen Sie, wie Ihre Rechnung entsteht. Ganz ohne Code.',
      BetaStr.tasksTitle: 'Zeiterfassung nach Tag, Woche oder Monat',
      BetaStr.tasksBody:
          'Tages-, Wochen- und Kalenderansicht zusätzlich zu Liste und Kanban.',
      BetaStr.tabsTitle: 'Status-Tabs mit einem Klick',
      BetaStr.tabsBody:
          'Entwurf, Unbezahlt und Überfällig über Ihren Listen, mit Zählern im Menü.',
      BetaStr.receiptTitle: 'Vom Beleg zur Ausgabe in einem Schritt',
      BetaStr.receiptBody:
          'Teilen Sie ein Foto oder PDF aus einer beliebigen App, und eine neue Ausgabe öffnet sich mit dem Anhang.',
      BetaStr.callsTitle: 'Jeden Anruf festhalten',
      BetaStr.callsBody:
          'Halten Sie nach einem Anruf im Kundendatensatz fest, mit wem Sie gesprochen haben und worum es ging.',
      BetaStr.bigTitle: 'Für große Konten gemacht',
      BetaStr.bigBody:
          'Datensätze werden nach und nach geladen. Sie können sofort arbeiten, statt auf einen vollständigen Download zu warten.',
      BetaStr.getBeta: 'Beta installieren',
      BetaStr.captionApple:
          'Öffnet TestFlight, Apples kostenlose App zum Testen von Beta-Versionen.',
      BetaStr.captionAndroid:
          'Treten Sie dem Testprogramm bei und installieren Sie die App dann über Google Play.',
      BetaStr.captionWindows:
          'Im Microsoft Store derzeit nur auf Einladung. Die Anfrage dauert nur wenige Sekunden.',
      BetaStr.captionLinux: 'Als Snap oder AppImage verfügbar.',
      BetaStr.chipsLabel: 'Verfügbar für',
      BetaStr.winIntro:
          'Die Windows-Beta ist im Microsoft Store derzeit nur auf Einladung verfügbar. Senden Sie uns die E-Mail-Adresse Ihres Microsoft-Kontos, und wir schalten Sie frei.',
      BetaStr.winField: 'E-Mail-Adresse des Microsoft-Kontos',
      BetaStr.winRequest: 'Zugang anfordern',
      BetaStr.winSent:
          'Anfrage gesendet. Wir schreiben Ihnen an :email, sobald Sie freigeschaltet sind. Danach installieren Sie die App über den Store.',
      BetaStr.winOpenStore: 'Microsoft Store öffnen',
      BetaStr.winFailed:
          'Das Senden von hier aus hat nicht geklappt. Schreiben Sie stattdessen eine E-Mail mit der Adresse Ihres Microsoft-Kontos an :contact.',
      BetaStr.winOpenEmail: 'E-Mail-App öffnen',
      BetaStr.winChange: 'Andere Adresse verwenden',
      BetaStr.winSelfHosted:
          'Über den E-Mail-Versand Ihres eigenen Servers gesendet. Falls Sie nichts hören, schreiben Sie an :contact.',
      BetaStr.winInvalid: 'Bitte eine gültige E-Mail-Adresse eingeben',
      BetaStr.snapIntro:
          'Kopieren Sie diesen Befehl, beenden Sie Invoice Ninja und fügen Sie ihn dann in ein Terminal ein.',
      BetaStr.snapNote:
          'Dadurch wird diese App durch die Beta ersetzt. Zurück geht es mit:',
      BetaStr.keepBoth:
          'Beide behalten? Laden Sie stattdessen das AppImage herunter.',
      BetaStr.appImage: 'AppImage herunterladen',
      BetaStr.appImageCaption:
          'Läuft neben dieser App. Keine Installation nötig.',
      BetaStr.orSnap: 'Oder das Snap installieren:',
      BetaStr.thenSignIn: 'Melden Sie sich danach mit :email an.',
      BetaStr.qrCaption: 'Scannen und aufs Smartphone holen',
      BetaStr.qrCaptionApple: 'Scannen und auf iPhone oder iPad holen',
      BetaStr.demo: 'Live-Demo ausprobieren',
      BetaStr.remindLater: 'Später erinnern',
      BetaStr.dontShow: 'Nicht mehr anzeigen',
      BetaStr.stepTitle: 'Nur noch ein Schritt',
      BetaStr.stepSub:
          'Melden Sie sich in der Beta mit dem Konto an, das Sie hier nutzen. Ihre Daten sind schon da.',
      BetaStr.serverUrl: 'Server-URL',
      BetaStr.apiSecret:
          'Falls Ihr Server ein API-Secret verwendet, geben Sie es ebenfalls ein.',
      BetaStr.appName: 'Auf Ihrem Gerät heißt die App „:name“.',
      BetaStr.passwordHint:
          'Sie melden sich hier ohne Passwort an. Falls die Beta diese Anmeldung auf Ihrem Gerät nicht anbietet, verwenden Sie Ihre E-Mail-Adresse und ein Passwort.',
      BetaStr.openAgain: 'Store erneut öffnen',
      BetaStr.entryTitle: 'Neue App ausprobieren',
      BetaStr.cardBody:
          'Das neue Invoice Ninja ist als Beta verfügbar. Gleiches Konto, gleiche Daten.',
      BetaStr.launchFailed:
          'Der Link konnte nicht geöffnet werden. Kopieren Sie ihn stattdessen:',
      BetaStr.close: 'Schließen',
      BetaStr.copy: 'Kopieren',
      BetaStr.done: 'Fertig',
      BetaStr.back: 'Zurück',
    },
    'fr': {
      BetaStr.pillNew: 'Nouveau',
      BetaStr.headline: 'Découvrez le nouvel Invoice Ninja',
      BetaStr.sub: 'Même compte, mêmes données : rien à transférer.',
      BetaStr.subKeep: "Gardez cette application pendant que vous l'essayez.",
      BetaStr.offlineTitle: 'Fonctionne hors ligne',
      BetaStr.offlineBody:
          'Créez et modifiez sans connexion. Les modifications se synchronisent dès que vous êtes de nouveau en ligne.',
      BetaStr.dashboardTitle:
          "Un tableau de bord qui montre ce qu'il faut relancer",
      BetaStr.dashboardBody:
          'Factures en retard, échéances proches et devis qui expirent apparaissent en premier, avec des actions en un geste.',
      BetaStr.designerTitle: 'Concevez vos factures visuellement',
      BetaStr.designerBody:
          'Faites glisser des blocs sur la page et regardez votre facture prendre forme. Sans code.',
      BetaStr.tasksTitle: 'Tâches par jour, semaine ou mois',
      BetaStr.tasksBody:
          'Vues quotidienne, hebdomadaire et calendrier, en plus de la liste et du tableau.',
      BetaStr.tabsTitle: 'Onglets de statut en un clic',
      BetaStr.tabsBody:
          'Brouillon, Non payé et En retard au-dessus de vos listes, avec des compteurs dans le menu.',
      BetaStr.receiptTitle: 'Du reçu à la dépense en un partage',
      BetaStr.receiptBody:
          "Partagez une photo ou un PDF depuis n'importe quelle application : une nouvelle dépense s'ouvre avec la pièce jointe.",
      BetaStr.callsTitle: 'Consignez chaque appel',
      BetaStr.callsBody:
          'Après un appel, notez dans la fiche du client à qui vous avez parlé et ce qui a été dit.',
      BetaStr.bigTitle: 'Conçu pour les gros comptes',
      BetaStr.bigBody:
          'Les données se chargent au fur et à mesure : vous travaillez tout de suite, sans attendre un téléchargement complet.',
      BetaStr.getBeta: 'Obtenir la bêta',
      BetaStr.captionApple:
          "Ouvre TestFlight, l'application gratuite d'Apple pour essayer les versions bêta.",
      BetaStr.captionAndroid:
          "Rejoignez le programme de test, puis installez l'application depuis Google Play.",
      BetaStr.captionWindows:
          "Sur invitation dans le Microsoft Store pour l'instant. La demande ne prend que quelques secondes.",
      BetaStr.captionLinux: 'Disponible en snap ou en AppImage.',
      BetaStr.chipsLabel: 'Disponible pour',
      BetaStr.winIntro:
          "La bêta Windows est pour l'instant sur invitation dans le Microsoft Store. Envoyez-nous l'adresse e-mail de votre compte Microsoft et nous vous ajouterons.",
      BetaStr.winField: 'E-mail du compte Microsoft',
      BetaStr.winRequest: "Demander l'accès",
      BetaStr.winSent:
          'Demande envoyée. Nous vous écrirons à :email dès que vous serez ajouté. Installez-la ensuite depuis le Store.',
      BetaStr.winOpenStore: 'Ouvrir le Microsoft Store',
      BetaStr.winFailed:
          "L'envoi depuis l'application a échoué. Écrivez plutôt à :contact en indiquant l'adresse de votre compte Microsoft.",
      BetaStr.winOpenEmail: 'Ouvrir la messagerie',
      BetaStr.winChange: 'Utiliser une autre adresse',
      BetaStr.winSelfHosted:
          'Envoyé par la messagerie de votre propre serveur. Sans réponse de notre part, écrivez à :contact.',
      BetaStr.winInvalid: 'Saisissez une adresse e-mail valide',
      BetaStr.snapIntro:
          'Copiez cette commande, quittez Invoice Ninja, puis collez-la dans un terminal.',
      BetaStr.snapNote:
          'Cela remplace cette application par la bêta. Pour revenir en arrière, exécutez :',
      BetaStr.keepBoth:
          "Vous préférez garder les deux ? Téléchargez plutôt l'AppImage.",
      BetaStr.appImage: "Télécharger l'AppImage",
      BetaStr.appImageCaption:
          'Fonctionne à côté de cette application. Rien à installer.',
      BetaStr.orSnap: 'Ou installez le snap :',
      BetaStr.thenSignIn: 'Connectez-vous ensuite avec :email.',
      BetaStr.qrCaption: "Scannez pour l'avoir sur votre téléphone",
      BetaStr.qrCaptionApple: "Scannez pour l'avoir sur iPhone ou iPad",
      BetaStr.demo: 'Essayer la démo en ligne',
      BetaStr.remindLater: 'Me le rappeler plus tard',
      BetaStr.dontShow: 'Ne plus afficher',
      BetaStr.stepTitle: 'Encore une étape',
      BetaStr.stepSub:
          'Connectez-vous à la bêta avec le compte que vous utilisez ici. Vos données vous y attendent.',
      BetaStr.serverUrl: 'URL du serveur',
      BetaStr.apiSecret:
          'Ajoutez aussi votre secret API si votre serveur en utilise un.',
      BetaStr.appName: "Sur votre appareil, elle s'appelle « :name ».",
      BetaStr.passwordHint:
          'Vous vous connectez ici sans mot de passe. Si la bêta ne propose pas la même connexion sur votre appareil, utilisez votre e-mail et un mot de passe.',
      BetaStr.openAgain: 'Rouvrir le Store',
      BetaStr.entryTitle: 'Essayer la nouvelle application',
      BetaStr.cardBody:
          'Le nouvel Invoice Ninja est en bêta. Même compte, mêmes données.',
      BetaStr.launchFailed: "Impossible d'ouvrir ce lien. Copiez-le plutôt :",
      BetaStr.close: 'Fermer',
      BetaStr.copy: 'Copier',
      BetaStr.done: 'Terminé',
      BetaStr.back: 'Retour',
    },
    'fr_CA': {
      BetaStr.dashboardBody:
          'Factures en souffrance, échéances proches et soumissions qui expirent apparaissent en premier, avec des actions en un geste.',
      BetaStr.tabsBody:
          'Brouillon, Impayé et En souffrance au-dessus de vos listes, avec des compteurs dans le menu.',
      BetaStr.winIntro:
          "La bêta Windows est pour l'instant sur invitation dans le Microsoft Store. Envoyez-nous l'adresse courriel de votre compte Microsoft et nous vous ajouterons.",
      BetaStr.winField: 'Courriel du compte Microsoft',
      BetaStr.winInvalid: 'Saisissez une adresse courriel valide',
      BetaStr.passwordHint:
          'Vous vous connectez ici sans mot de passe. Si la bêta ne propose pas la même connexion sur votre appareil, utilisez votre courriel et un mot de passe.',
    },
    'es': {
      BetaStr.pillNew: 'Nuevo',
      BetaStr.headline: 'Conoce el nuevo Invoice Ninja',
      BetaStr.sub:
          'Es la misma cuenta y los mismos datos, así que no hay nada que migrar.',
      BetaStr.subKeep: 'Conserva esta aplicación mientras lo pruebas.',
      BetaStr.offlineTitle: 'Funciona sin conexión',
      BetaStr.offlineBody:
          'Crea y edita sin conexión. Los cambios se sincronizan cuando vuelves a estar en línea.',
      BetaStr.dashboardTitle:
          'Una pantalla de inicio que muestra qué requiere tu atención',
      BetaStr.dashboardBody:
          'Lo vencido, lo que vence pronto y las cotizaciones por expirar aparecen primero, con acciones de un toque.',
      BetaStr.designerTitle: 'Diseña facturas visualmente',
      BetaStr.designerBody:
          'Arrastra bloques a la página y mira cómo toma forma tu factura. Sin código.',
      BetaStr.tasksTitle: 'Tareas por día, semana o mes',
      BetaStr.tasksBody:
          'Vistas diaria, semanal y de calendario, además de la lista y el tablero.',
      BetaStr.tabsTitle: 'Pestañas de estado con un clic',
      BetaStr.tabsBody:
          'Borrador, Sin Pagar y Vencido encima de tus listas, con contadores en el menú.',
      BetaStr.receiptTitle: 'Del recibo al gasto con solo compartir',
      BetaStr.receiptBody:
          'Comparte una foto o un PDF desde cualquier aplicación y se abre un gasto nuevo con el archivo adjunto.',
      BetaStr.callsTitle: 'Registra cada llamada',
      BetaStr.callsBody:
          'Después de una llamada, guarda en la ficha del cliente con quién hablaste y qué se dijo.',
      BetaStr.bigTitle: 'Pensado para cuentas grandes',
      BetaStr.bigBody:
          'Los registros se cargan sobre la marcha, así que empiezas a trabajar de inmediato en lugar de esperar una descarga completa.',
      BetaStr.getBeta: 'Obtener la beta',
      BetaStr.captionApple:
          'Abre TestFlight, la aplicación gratuita de Apple para probar versiones beta.',
      BetaStr.captionAndroid:
          'Únete al programa de pruebas y luego instálala desde Google Play.',
      BetaStr.captionWindows:
          'Por ahora, solo por invitación en Microsoft Store. Solicitar acceso lleva unos segundos.',
      BetaStr.captionLinux: 'Disponible como snap o AppImage.',
      BetaStr.chipsLabel: 'Disponible para',
      BetaStr.winIntro:
          'Por ahora, la beta de Windows está disponible solo por invitación en Microsoft Store. Envíanos el correo de tu cuenta de Microsoft y te daremos acceso.',
      BetaStr.winField: 'Correo de la cuenta de Microsoft',
      BetaStr.winRequest: 'Solicitar acceso',
      BetaStr.winSent:
          'Solicitud enviada. Te escribiremos a :email cuando tengas acceso. Después, instálala desde la Store.',
      BetaStr.winOpenStore: 'Abrir Microsoft Store',
      BetaStr.winFailed:
          'No pudimos enviarla desde aquí. Escribe a :contact con la dirección de tu cuenta de Microsoft.',
      BetaStr.winOpenEmail: 'Abrir aplicación de correo',
      BetaStr.winChange: 'Usar otra dirección',
      BetaStr.winSelfHosted:
          'Enviado mediante el correo de tu propio servidor. Si no recibes respuesta, escribe a :contact.',
      BetaStr.winInvalid: 'Introduce un correo electrónico válido',
      BetaStr.snapIntro:
          'Copia este comando, cierra Invoice Ninja y pégalo en una terminal.',
      BetaStr.snapNote:
          'Esto reemplaza esta aplicación por la beta. Para volver, ejecuta:',
      BetaStr.keepBoth: '¿Prefieres conservar las dos? Descarga la AppImage.',
      BetaStr.appImage: 'Descargar la AppImage',
      BetaStr.appImageCaption:
          'Funciona junto a esta aplicación. No hay nada que instalar.',
      BetaStr.orSnap: 'O instala el snap:',
      BetaStr.thenSignIn: 'Después, inicia sesión con :email.',
      BetaStr.qrCaption: 'Escanea para tenerla en tu teléfono',
      BetaStr.qrCaptionApple: 'Escanea para tenerla en tu iPhone o iPad',
      BetaStr.demo: 'Probar la demo en vivo',
      BetaStr.remindLater: 'Recordármelo más tarde',
      BetaStr.dontShow: 'No volver a mostrar',
      BetaStr.stepTitle: 'Un paso más',
      BetaStr.stepSub:
          'Inicia sesión en la beta con la cuenta que usas aquí. Tus datos te estarán esperando.',
      BetaStr.serverUrl: 'URL del servidor',
      BetaStr.apiSecret:
          'Añade también tu secreto de API si tu servidor usa uno.',
      BetaStr.appName: 'En tu dispositivo se llama «:name».',
      BetaStr.passwordHint:
          'Aquí inicias sesión sin contraseña. Si la beta no ofrece el mismo inicio de sesión en tu dispositivo, usa tu correo y una contraseña.',
      BetaStr.openAgain: 'Abrir la tienda de nuevo',
      BetaStr.entryTitle: 'Probar la nueva aplicación',
      BetaStr.cardBody:
          'El nuevo Invoice Ninja está en beta. La misma cuenta, los mismos datos.',
      BetaStr.launchFailed: 'No se pudo abrir el enlace. Cópialo:',
      BetaStr.close: 'Cerrar',
      BetaStr.copy: 'Copiar',
      BetaStr.done: 'Listo',
      BetaStr.back: 'Atrás',
    },
    'es_ES': {
      BetaStr.dashboardBody:
          'Lo vencido, lo que vence pronto y los presupuestos a punto de caducar aparecen primero, con acciones de un toque.',
      BetaStr.tabsBody:
          'Borrador, Impagado y Vencido encima de tus listas, con contadores en el menú.',
    },
    'it': {
      BetaStr.pillNew: 'Novità',
      BetaStr.headline: 'Ecco il nuovo Invoice Ninja',
      BetaStr.sub: "Stesso account, stessi dati: non c'è niente da trasferire.",
      BetaStr.subKeep: 'Tieni questa app mentre lo provi.',
      BetaStr.offlineTitle: 'Funziona offline',
      BetaStr.offlineBody:
          'Crea e modifica senza connessione. Le modifiche si sincronizzano quando torni online.',
      BetaStr.dashboardTitle: 'Un pannello che mostra cosa sollecitare',
      BetaStr.dashboardBody:
          'Fatture scadute o in scadenza e preventivi che stanno per scadere compaiono per primi, con azioni a portata di tocco.',
      BetaStr.designerTitle: 'Progetta le fatture visivamente',
      BetaStr.designerBody:
          'Trascina i blocchi sulla pagina e guarda la fattura prendere forma. Senza codice.',
      BetaStr.tasksTitle: 'Attività per giorno, settimana o mese',
      BetaStr.tasksBody:
          'Viste giornaliera, settimanale e calendario, oltre a elenco e bacheca.',
      BetaStr.tabsTitle: 'Schede di stato con un clic',
      BetaStr.tabsBody:
          'Bozza, Non pagata e Scaduta sopra i tuoi elenchi, con i conteggi nel menu.',
      BetaStr.receiptTitle: 'Dalla ricevuta alla spesa con una condivisione',
      BetaStr.receiptBody:
          "Condividi una foto o un PDF da qualsiasi app e si apre una nuova spesa con l'allegato.",
      BetaStr.callsTitle: 'Annota ogni chiamata',
      BetaStr.callsBody:
          'Dopo una chiamata, salva nella scheda del cliente con chi hai parlato e cosa vi siete detti.',
      BetaStr.bigTitle: 'Pensato per gli account grandi',
      BetaStr.bigBody:
          'I dati si caricano man mano, così inizi subito a lavorare invece di attendere un download completo.',
      BetaStr.getBeta: 'Scarica la beta',
      BetaStr.captionApple:
          "Apre TestFlight, l'app gratuita di Apple per provare le versioni beta.",
      BetaStr.captionAndroid:
          'Partecipa al programma di test, poi installala da Google Play.',
      BetaStr.captionWindows:
          "Per ora solo su invito nel Microsoft Store. Per richiedere l'accesso bastano pochi secondi.",
      BetaStr.captionLinux: 'Disponibile come snap o AppImage.',
      BetaStr.chipsLabel: 'Disponibile per',
      BetaStr.winIntro:
          "Per ora la beta per Windows è disponibile solo su invito nel Microsoft Store. Inviaci l'email del tuo account Microsoft e ti aggiungeremo.",
      BetaStr.winField: "Email dell'account Microsoft",
      BetaStr.winRequest: "Richiedi l'accesso",
      BetaStr.winSent:
          'Richiesta inviata. Ti scriveremo a :email non appena sarai stato aggiunto. Poi installala dallo Store.',
      BetaStr.winOpenStore: 'Apri Microsoft Store',
      BetaStr.winFailed:
          "Non siamo riusciti a inviarla da qui. Scrivi a :contact indicando l'indirizzo del tuo account Microsoft.",
      BetaStr.winOpenEmail: "Apri l'app di posta",
      BetaStr.winChange: 'Usa un altro indirizzo',
      BetaStr.winSelfHosted:
          'Inviata tramite la posta del tuo server. Se non ricevi risposta, scrivi a :contact.',
      BetaStr.winInvalid: 'Inserisci un indirizzo email valido',
      BetaStr.snapIntro:
          'Copia questo comando, chiudi Invoice Ninja e incollalo in un terminale.',
      BetaStr.snapNote:
          'In questo modo la beta sostituisce questa app. Per tornare indietro, esegui:',
      BetaStr.keepBoth: "Vuoi tenerle entrambe? Scarica invece l'AppImage.",
      BetaStr.appImage: "Scarica l'AppImage",
      BetaStr.appImageCaption:
          'Funziona accanto a questa app. Niente da installare.',
      BetaStr.orSnap: 'Oppure installa lo snap:',
      BetaStr.thenSignIn: 'Poi accedi con :email.',
      BetaStr.qrCaption: 'Inquadra per averla sul telefono',
      BetaStr.qrCaptionApple: 'Inquadra per averla su iPhone o iPad',
      BetaStr.demo: 'Prova la demo online',
      BetaStr.remindLater: 'Ricordamelo più tardi',
      BetaStr.dontShow: 'Non mostrare più',
      BetaStr.stepTitle: 'Ancora un passaggio',
      BetaStr.stepSub:
          "Accedi alla beta con l'account che usi qui. I tuoi dati ti aspettano.",
      BetaStr.serverUrl: 'URL del server',
      BetaStr.apiSecret:
          'Aggiungi anche il secret API, se il tuo server ne usa uno.',
      BetaStr.appName: 'Sul tuo dispositivo si chiama «:name».',
      BetaStr.passwordHint:
          'Qui accedi senza password. Se la beta non offre lo stesso accesso sul tuo dispositivo, usa la tua email e una password.',
      BetaStr.openAgain: 'Riapri lo store',
      BetaStr.entryTitle: 'Prova la nuova app',
      BetaStr.cardBody:
          'Il nuovo Invoice Ninja è in beta. Stesso account, stessi dati.',
      BetaStr.launchFailed: 'Impossibile aprire il link. Copialo:',
      BetaStr.close: 'Chiudi',
      BetaStr.copy: 'Copia',
      BetaStr.done: 'Fatto',
      BetaStr.back: 'Indietro',
    },
    'nl': {
      BetaStr.pillNew: 'Nieuw',
      BetaStr.headline: 'Maak kennis met het nieuwe Invoice Ninja',
      BetaStr.sub:
          'Hetzelfde account en dezelfde gegevens, dus er hoeft niets te worden overgezet.',
      BetaStr.subKeep:
          'Je kunt deze app gewoon blijven gebruiken terwijl je de nieuwe uitprobeert.',
      BetaStr.offlineTitle: 'Werkt offline',
      BetaStr.offlineBody:
          'Aanmaken en bewerken zonder verbinding. Wijzigingen worden gesynchroniseerd zodra je weer online bent.',
      BetaStr.dashboardTitle: 'Een dashboard dat laat zien wat aandacht vraagt',
      BetaStr.dashboardBody:
          'Verlopen facturen, facturen die bijna vervallen en aflopende offertes staan bovenaan, elk met acties in één tik.',
      BetaStr.designerTitle: 'Ontwerp facturen visueel',
      BetaStr.designerBody:
          'Sleep blokken op de pagina en zie je factuur ontstaan. Zonder code.',
      BetaStr.tasksTitle: 'Taken per dag, week of maand',
      BetaStr.tasksBody:
          'Dag-, week- en kalenderweergave naast de lijst en het bord.',
      BetaStr.tabsTitle: 'Statustabs met één klik',
      BetaStr.tabsBody:
          'Concept, Onbetaald en Verlopen boven je lijsten, met tellers in het menu.',
      BetaStr.receiptTitle: 'Van bon naar uitgave door één keer te delen',
      BetaStr.receiptBody:
          'Deel een foto of pdf vanuit elke app en er opent een nieuwe uitgave met de bijlage.',
      BetaStr.callsTitle: 'Leg elk gesprek vast',
      BetaStr.callsBody:
          'Sla na een telefoongesprek bij de klant op met wie je sprak en wat er is gezegd.',
      BetaStr.bigTitle: 'Gemaakt voor grote accounts',
      BetaStr.bigBody:
          'Gegevens worden geladen terwijl je werkt, zodat je meteen aan de slag kunt in plaats van te wachten op een volledige download.',
      BetaStr.getBeta: 'Download de bèta',
      BetaStr.captionApple:
          'Opent TestFlight, de gratis app van Apple om bètaversies te proberen.',
      BetaStr.captionAndroid:
          'Meld je aan als tester en installeer de app daarna via Google Play.',
      BetaStr.captionWindows:
          'Voorlopig alleen op uitnodiging in de Microsoft Store. Toegang aanvragen duurt een paar seconden.',
      BetaStr.captionLinux: 'Beschikbaar als snap of AppImage.',
      BetaStr.chipsLabel: 'Beschikbaar voor',
      BetaStr.winIntro:
          'De Windows-bèta is voorlopig alleen op uitnodiging beschikbaar in de Microsoft Store. Stuur ons het e-mailadres van je Microsoft-account en we voegen je toe.',
      BetaStr.winField: 'E-mailadres van Microsoft-account',
      BetaStr.winRequest: 'Toegang aanvragen',
      BetaStr.winSent:
          'Aanvraag verzonden. We mailen je op :email zodra je bent toegevoegd. Installeer de app daarna via de Store.',
      BetaStr.winOpenStore: 'Microsoft Store openen',
      BetaStr.winFailed:
          'Verzenden vanaf hier is niet gelukt. Mail in plaats daarvan naar :contact met het adres van je Microsoft-account.',
      BetaStr.winOpenEmail: 'E-mailapp openen',
      BetaStr.winChange: 'Ander adres gebruiken',
      BetaStr.winSelfHosted:
          'Verzonden via de e-mail van je eigen server. Hoor je niets, mail dan naar :contact.',
      BetaStr.winInvalid: 'Voer een geldig e-mailadres in',
      BetaStr.snapIntro:
          'Kopieer deze opdracht, sluit Invoice Ninja af en plak hem in een terminal.',
      BetaStr.snapNote:
          'Hiermee wordt deze app vervangen door de bèta. Om terug te gaan, voer je dit uit:',
      BetaStr.keepBoth: 'Liever beide houden? Download dan de AppImage.',
      BetaStr.appImage: 'AppImage downloaden',
      BetaStr.appImageCaption: 'Draait naast deze app. Niets te installeren.',
      BetaStr.orSnap: 'Of installeer de snap:',
      BetaStr.thenSignIn: 'Log daarna in met :email.',
      BetaStr.qrCaption: 'Scan om de app op je telefoon te zetten',
      BetaStr.qrCaptionApple: 'Scan om de app op je iPhone of iPad te zetten',
      BetaStr.demo: 'Probeer de live demo',
      BetaStr.remindLater: 'Herinner me later',
      BetaStr.dontShow: 'Niet meer tonen',
      BetaStr.stepTitle: 'Nog één stap',
      BetaStr.stepSub:
          'Log in bij de bèta met het account dat je hier gebruikt. Je gegevens staan al klaar.',
      BetaStr.serverUrl: 'Server-URL',
      BetaStr.apiSecret:
          'Vul ook je API-secret in als je server er een gebruikt.',
      BetaStr.appName: 'Op je apparaat heet de app ":name".',
      BetaStr.passwordHint:
          'Je logt hier in zonder wachtwoord. Biedt de bèta dezelfde inlogmethode niet aan op je apparaat, gebruik dan je e-mailadres en een wachtwoord.',
      BetaStr.openAgain: 'Store opnieuw openen',
      BetaStr.entryTitle: 'Probeer de nieuwe app',
      BetaStr.cardBody:
          'Het nieuwe Invoice Ninja is er als bèta. Hetzelfde account, dezelfde gegevens.',
      BetaStr.launchFailed: 'De link kon niet worden geopend. Kopieer hem:',
      BetaStr.close: 'Sluiten',
      BetaStr.copy: 'Kopiëren',
      BetaStr.done: 'Klaar',
      BetaStr.back: 'Terug',
    },
    'pt_BR': {
      BetaStr.pillNew: 'Novo',
      BetaStr.headline: 'Conheça o novo Invoice Ninja',
      BetaStr.sub:
          'É a mesma conta e os mesmos dados, então não há nada para migrar.',
      BetaStr.subKeep: 'Mantenha este aplicativo enquanto experimenta.',
      BetaStr.offlineTitle: 'Funciona offline',
      BetaStr.offlineBody:
          'Crie e edite sem conexão. As alterações são sincronizadas quando você voltar a ficar online.',
      BetaStr.dashboardTitle: 'Um painel que mostra o que cobrar',
      BetaStr.dashboardBody:
          'Vencidos, a vencer em breve e orçamentos prestes a expirar aparecem primeiro, com ações em um toque.',
      BetaStr.designerTitle: 'Crie faturas visualmente',
      BetaStr.designerBody:
          'Arraste blocos para a página e veja sua fatura tomar forma. Sem código.',
      BetaStr.tasksTitle: 'Tarefas por dia, semana ou mês',
      BetaStr.tasksBody:
          'Visualizações diária, semanal e de calendário, além da lista e do quadro.',
      BetaStr.tabsTitle: 'Abas de status em um clique',
      BetaStr.tabsBody:
          'Rascunho, Não Pago e Vencido acima das suas listas, com contadores no menu.',
      BetaStr.receiptTitle: 'Do recibo à despesa em um compartilhamento',
      BetaStr.receiptBody:
          'Compartilhe uma foto ou PDF de qualquer aplicativo e uma nova despesa abre com o anexo.',
      BetaStr.callsTitle: 'Registre cada ligação',
      BetaStr.callsBody:
          'Depois de uma ligação, salve no cadastro do cliente com quem você falou e o que foi dito.',
      BetaStr.bigTitle: 'Feito para contas grandes',
      BetaStr.bigBody:
          'Os registros carregam conforme você usa, então você começa a trabalhar na hora em vez de esperar um download completo.',
      BetaStr.getBeta: 'Obter a versão beta',
      BetaStr.captionApple:
          'Abre o TestFlight, o aplicativo gratuito da Apple para testar versões beta.',
      BetaStr.captionAndroid:
          'Participe do programa de testes e depois instale pelo Google Play.',
      BetaStr.captionWindows:
          'Por enquanto, apenas por convite na Microsoft Store. Solicitar acesso leva alguns segundos.',
      BetaStr.captionLinux: 'Disponível como snap ou AppImage.',
      BetaStr.chipsLabel: 'Disponível para',
      BetaStr.winIntro:
          'Por enquanto, a versão beta para Windows está disponível apenas por convite na Microsoft Store. Envie o e-mail da sua conta Microsoft e nós adicionaremos você.',
      BetaStr.winField: 'E-mail da conta Microsoft',
      BetaStr.winRequest: 'Solicitar acesso',
      BetaStr.winSent:
          'Solicitação enviada. Escreveremos para :email assim que você for adicionado. Depois, instale pela Store.',
      BetaStr.winOpenStore: 'Abrir a Microsoft Store',
      BetaStr.winFailed:
          'Não foi possível enviar daqui. Escreva para :contact com o endereço da sua conta Microsoft.',
      BetaStr.winOpenEmail: 'Abrir aplicativo de e-mail',
      BetaStr.winChange: 'Usar outro endereço',
      BetaStr.winSelfHosted:
          'Enviado pelo e-mail do seu próprio servidor. Se não tiver resposta, escreva para :contact.',
      BetaStr.winInvalid: 'Digite um endereço de e-mail válido',
      BetaStr.snapIntro:
          'Copie este comando, feche o Invoice Ninja e cole-o em um terminal.',
      BetaStr.snapNote:
          'Isso substitui este aplicativo pela versão beta. Para voltar, execute:',
      BetaStr.keepBoth: 'Prefere manter os dois? Baixe a AppImage.',
      BetaStr.appImage: 'Baixar a AppImage',
      BetaStr.appImageCaption:
          'Funciona ao lado deste aplicativo. Nada para instalar.',
      BetaStr.orSnap: 'Ou instale o snap:',
      BetaStr.thenSignIn: 'Depois, entre com :email.',
      BetaStr.qrCaption: 'Escaneie para ter no seu celular',
      BetaStr.qrCaptionApple: 'Escaneie para ter no iPhone ou iPad',
      BetaStr.demo: 'Experimentar a demonstração',
      BetaStr.remindLater: 'Lembrar mais tarde',
      BetaStr.dontShow: 'Não mostrar novamente',
      BetaStr.stepTitle: 'Só mais um passo',
      BetaStr.stepSub:
          'Entre na versão beta com a conta que você usa aqui. Seus dados já estarão lá.',
      BetaStr.serverUrl: 'URL do servidor',
      BetaStr.apiSecret:
          'Informe também o segredo da API, se o seu servidor usar um.',
      BetaStr.appName: 'No seu dispositivo, ele se chama ":name".',
      BetaStr.passwordHint:
          'Você entra aqui sem senha. Se a versão beta não oferecer o mesmo acesso no seu dispositivo, use seu e-mail e uma senha.',
      BetaStr.openAgain: 'Abrir a loja novamente',
      BetaStr.entryTitle: 'Experimente o novo aplicativo',
      BetaStr.cardBody:
          'O novo Invoice Ninja está em beta. Mesma conta, mesmos dados.',
      BetaStr.launchFailed: 'Não foi possível abrir o link. Copie-o:',
      BetaStr.close: 'Fechar',
      BetaStr.copy: 'Copiar',
      BetaStr.done: 'Concluir',
      BetaStr.back: 'Voltar',
    },
  };
}
