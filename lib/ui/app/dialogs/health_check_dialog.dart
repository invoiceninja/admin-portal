// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/health_check_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class HealthCheckDialog extends StatefulWidget {
  @override
  _HealthCheckDialogState createState() => _HealthCheckDialogState();
}

class _HealthCheckDialogState extends State<HealthCheckDialog> {
  HealthCheckResponse _response;

  @override
  void didChangeDependencies() {
    if (_response == null) {
      runCheck();
    }

    super.didChangeDependencies();
  }

  void runCheck() async {
    setState(() {
      _response = null;
    });

    final webClient = WebClient();
    final state = StoreProvider.of<AppState>(context).state;

    try {
      await webClient.get('${state.account.defaultUrl}/update?secret=', '',
          rawResponse: true);
    } catch (e) {
      // do nothing
    }

    final credentials = state.credentials;
    final url = '${credentials.url}/health_check';

    webClient.get(url, credentials.token).then((dynamic response) {
      setState(() {
        _response = serializers.deserializeWith(
            HealthCheckResponse.serializer, response);
      });
    }).catchError((dynamic error) {
      Navigator.of(context).pop();
      showErrorDialog(context: context, message: error);
    });
  }

  void clearCache() {
    setState(() {
      _response = null;
    });

    final webClient = WebClient();
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final credentials = state.credentials;
    final url = '${credentials.url}/ping?clear_cache=true';

    webClient.get(url, credentials.token).then((dynamic response) {
      store.dispatch(RefreshData(
          completer: Completer<Null>()
            ..future.then((value) {
              runCheck();
            })));
    }).catchError((dynamic error) {
      showErrorDialog(context: context, message: error);
    });
  }

  String _parseVersion(String version) =>
      RegExp(r'(\d+\.\d+.\d+)').stringMatch(version);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);
    final webPhpVersion =
        _parseVersion(_response?.phpVersion?.currentPHPVersion ?? '');
    final cliPhpVersion =
        _parseVersion(_response?.phpVersion?.currentPHPCLIVersion ?? '');

    return AlertDialog(
      content: _response == null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: LinearProgressIndicator(),
                ),
                Text('${localization.loading}...'),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _HealthListTile(
                  title: 'System Health',
                  subtitle:
                      'Email: ${_response.emailDriver}\nQueue: ${_response.queue}\nPDF: ${_response.pdfEngine.replaceFirst(' Generator', '')}',
                  isValid: _response.systemHealth,
                ),
                _HealthListTile(
                  title: 'Database Check',
                  isValid: _response.dbCheck,
                ),
                _HealthListTile(
                  title: 'PHP Version',
                  isValid: _response.phpVersion.isOkay,
                  subtitle: webPhpVersion == cliPhpVersion
                      ? 'v$webPhpVersion'
                      : 'Web: v$webPhpVersion\nCLI: v$cliPhpVersion',
                ),
                /*
                if (!_response.execEnabled)
                  _HealthListTile(
                    title: 'PHP Exec',
                    isValid: false,
                    subtitle: 'Not enabled',
                  ),
                  */
                /*
                if (_response.pendingJobs > 0)
                  _HealthListTile(
                    title: 'Pending Jobs',
                    subtitle: 'Count: ${_response.pendingJobs}',
                    isWarning: true,
                  ),
                  */
                if (_response.filePermissions != 'Ok' &&
                    !state.account.disableAutoUpdate)
                  _HealthListTile(
                    title: 'Invalid File Permissions',
                    isValid: false,
                    subtitle: _response.filePermissions,
                    url:
                        'https://invoiceninja.github.io/docs/self-host-installation/#file-permissions',
                  ),
                /*
                if (!state.account.isDocker) ...[
                  if (!_response.openBasedir)
                    _HealthListTile(
                      title: 'Open Basedir',
                      isWarning: true,
                      subtitle: 'Not enabled',
                    ),
                    if (!_response.cacheEnabled)
                      _HealthListTile(
                        title: 'Config not cached',
                        subtitle:
                            'Run php artisan optimize to improve performance',
                        isWarning: true,
                      ),
                ],
                */
                if (_response.queue == 'sync')
                  _HealthListTile(
                    title: 'Queue not enabled',
                    subtitle: 'Enable the queue for improved performance',
                    isWarning: true,
                    url:
                        'https://invoiceninja.github.io/docs/self-host-installation/#final-setup-steps',
                  ),
                if (_response.phantomEnabled)
                  _HealthListTile(
                    title: 'SnapPDF not enabled',
                    subtitle: 'Use SnapPDF for faster PDF generation',
                    isWarning: true,
                    url:
                        'https://invoiceninja.github.io/docs/self-host-troubleshooting/#pdf-conversion-issues',
                  ),
                if (_response.trailingSlash)
                  _HealthListTile(
                    title: 'APP_URL has trailing slash',
                    subtitle: 'Remove the slash in the .env file',
                    isWarning: true,
                  )
              ],
            ),
      actions: _response == null
          ? []
          : [
              TextButton(
                child: Text(localization.clearCache.toUpperCase()),
                onPressed: () => clearCache(),
              ),
              TextButton(
                child: Text(localization.refresh.toUpperCase()),
                onPressed: () => runCheck(),
              ),
              TextButton(
                child: Text(localization.close.toUpperCase()),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
    );
  }
}

class _HealthListTile extends StatelessWidget {
  const _HealthListTile({
    @required this.title,
    this.isValid = true,
    this.isWarning = false,
    this.subtitle,
    this.url,
  });

  final String title;
  final bool isValid;
  final bool isWarning;
  final String subtitle;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle != null
            ? subtitle
            : (isWarning ? 'Warning' : (isValid ? 'Passed' : 'Failed')),
      ),
      trailing: Icon(
        isWarning
            ? Icons.warning
            : (isValid ? Icons.check_circle_outline : Icons.error_outline),
        color:
            isWarning ? Colors.orange : (isValid ? Colors.green : Colors.red),
      ),
      onTap: url != null ? () => launchUrl(Uri.parse(url)) : null,
    );
  }
}
