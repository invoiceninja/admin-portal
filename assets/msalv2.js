// Needs to be a var at the top level to get hoisted to global scope.
// https://stackoverflow.com/questions/28776079/do-let-statements-create-properties-on-the-global-object/28776236#28776236
var aadOauth = (function () {
  let myMSALObj = null;
  let authResult = null;

  const tokenRequest = {
    scopes: null,
    // Hardcoded?
    prompt: null,
  };

  // Initialise the myMSALObj for the given client, authority and scope
  function init(config) {
    // TODO: Add support for other MSAL / B2C configuration
    var msalConfig = {
      auth: {
        clientId: config.clientId,
        authority: "https://login.microsoftonline.com/" + config.tenant,
        redirectUri: config.redirectUri,
      },
      cache: {
        cacheLocation: "localStorage",
        storeAuthStateInCookie: false,
      },
    };

    if (typeof config.scope === "string") {
      tokenRequest.scopes = config.scope.split(" ");
    } else {
      tokenRequest.scopes = config.scope;
    }

    tokenRequest.prompt = config.prompt;

    myMSALObj = new msal.PublicClientApplication(msalConfig);
  }

  /// Authorize user via refresh token or web gui if necessary.
  ///
  /// Setting [refreshIfAvailable] to [true] should attempt to re-authenticate
  /// with the existing refresh token, if any, even though the access token may
  /// still be valid; however MSAL doesn't support this. Therefore it will have
  /// the same impact as when it is set to [false]. 
  /// The token is requested using acquireTokenSilent, which will refresh the token
  /// if it has nearly expired. If this fails for any reason, it will then move on
  /// to attempt to refresh the token using an interactive login.

  async function login(refreshIfAvailable, onSuccess, onError) {
    // Try to sign in silently
    const account = getAccount();
    if (account !== null) {
      try {
        // Silent acquisition only works if we the access token is either
        // within its lifetime, or the refresh token can successfully be
        // used to refresh it. This will throw if the access token can't
        // be acquired.
        const silentAuthResult = await myMSALObj.acquireTokenSilent({
          scopes: tokenRequest.scopes,
          prompt: "none",
          account: account
        });

        authResult = silentAuthResult;

        // Skip interactive login
        onSuccess();

        return;
      } catch (error) {
        console.log(error.message)
      }
    }

    // Sign in with popup
    try {
      const interactiveAuthResult = await myMSALObj.loginPopup({
        scopes: tokenRequest.scopes,
        prompt: tokenRequest.prompt,
        account: account
      });

      authResult = interactiveAuthResult;

      onSuccess();
    } catch (error) {
      // rethrow
      console.warn(error.message);
      onError(error);
    }
  }

  function getAccount() {
    // If we have recently authenticated, we use the auth'd account;
    // otherwise we fallback to using MSAL APIs to find cached auth
    // accounts in browser storage.
    if (authResult !== null && authResult.account !== null) {
      return authResult.account
    }

    const currentAccounts = myMSALObj.getAllAccounts();

    if (currentAccounts === null || currentAccounts.length === 0) {
      return null;
    } else if (currentAccounts.length > 1) {
      // Multiple users - pick the first one, but this shouldn't happen
      console.warn("Multiple accounts detected, selecting first.");

      return currentAccounts[0];
    } else if (currentAccounts.length === 1) {
      return currentAccounts[0];
    }
  }

  function logout(onSuccess, onError) {
    const account = getAccount();

    if (!account) {
      onSuccess();
      return;
    }

    authResult = null;
    tokenRequest.scopes = null;
    myMSALObj
      .logout({ account: account })
      .then((_) => onSuccess())
      .catch(onError);
  }

  function getAccessToken() {
    return authResult ? authResult.accessToken : null;
  }

  function getIdToken() {
    return authResult ? authResult.idToken : null;
  }

  return {
    init: init,
    login: login,
    logout: logout,
    getIdToken: getIdToken,
    getAccessToken: getAccessToken,
  };
})();
