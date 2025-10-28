// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/health_check_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

enum _HealthCheckLevel {
  Info,
  Warning,
}

class HealthCheckDialog extends StatefulWidget {
  @override
  _HealthCheckDialogState createState() => _HealthCheckDialogState();
}

class _HealthCheckDialogState extends State<HealthCheckDialog> {
  HealthCheckResponse? _response;

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
      if (!kReleaseMode) {
        print('## response: $response');
      }
      setState(() {
        _response = serializers.deserializeWith(
            HealthCheckResponse.serializer, response);
      });
    }).catchError((dynamic error) {
      Navigator.of(navigatorKey.currentContext!).pop();
      showErrorDialog(message: error);
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
            ..future.then<Null>((_) {
              runCheck();
            })));
    }).catchError((dynamic error) {
      showErrorDialog(message: error);
    });
  }

  String _parseVersion(String version) {
    final parsed = RegExp(r'(\d+\.\d+.\d+)').stringMatch(version);

    if (parsed == null) {
      return version;
    }

    return 'v$parsed';
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final account = state.account;
    final localization = AppLocalization.of(context);
    final webPhpVersion =
        _parseVersion(_response?.phpVersion.currentPHPVersion ?? '');
    final cliPhpVersion =
        _parseVersion(_response?.phpVersion.currentPHPCLIVersion ?? '');
    final phpMemoryLimit = _response?.phpVersion.memoryLimit ?? '';
    final phpMemoryLimitDouble = parseDouble(phpMemoryLimit);

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
                Text('${localization!.loading}...'),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HealthListTile(
                    title: 'System Health',
                    subtitle:
                        'Email: ${_response!.emailDriver}\nQueue: ${_response!.queue}\nPDF: ${_response!.pdfEngine.replaceFirst(' Generator', '')}',
                    isValid: _response!.systemHealth,
                    buttonLabel: 'View Last Error',
                    buttonCallback: () async {
                      showDialog(
                          context: context,
                          builder: (context) => _LastError(state: state));
                    },
                  ),
                  _HealthListTile(
                    title: 'Database Check',
                    isValid: _response!.dbCheck && !_response!.pendingMigration,
                    subtitle: _response!.pendingMigration
                        ? 'There are pending migrations, run \'php artisan migrate\''
                        : null,
                  ),
                  _HealthListTile(
                    title: 'PHP Info',
                    // TODO move this logic to the backend
                    isValid: _response!.phpVersion.isOkay &&
                        webPhpVersion.startsWith('v8') &&
                        (cliPhpVersion.startsWith('v8') ||
                            !cliPhpVersion.startsWith('v')),
                    subtitle: 'Web: $webPhpVersion\nCLI: $cliPhpVersion' +
                        (phpMemoryLimit.isNotEmpty
                            ? '\nMemory Limit: $phpMemoryLimit'
                            : ''),
                  ),
                  if (_response!.queue == 'database') ...[
                    _HealthListTile(
                      title: 'Queue',
                      isValid: _response!.queueData.failed == 0,
                      subtitle:
                          'Pending Jobs: ${_response!.queueData.pending}\nFailed Jobs: ${_response!.queueData.failed}',
                      level: _response!.queueData.failed == 0 &&
                              _response!.queueData.pending > 0
                          ? _HealthCheckLevel.Warning
                          : null,
                      buttonLabel: _response!.queueData.lastError.isNotEmpty
                          ? 'View Last Queue Error'
                          : null,
                      buttonCallback: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: Text('Last Queue Error'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      showToast(localization.copiedToClipboard
                                          .replaceFirst(':value', ''));
                                      Clipboard.setData(ClipboardData(
                                          text:
                                              _response!.queueData.lastError));
                                    },
                                    child: Text(
                                      localization!.copy.toUpperCase(),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      localization.close.toUpperCase(),
                                    ),
                                  ),
                                ],
                                content: SelectableText(
                                  _response!.queueData.lastError,
                                )));
                      },
                    ),
                  ],
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
                  if (_response!.filePermissions != 'Ok' &&
                      !account.disableAutoUpdate &&
                      !account.isDocker)
                    _HealthListTile(
                      title: 'Invalid File Permissions',
                      isValid: false,
                      subtitle: _response!.filePermissions,
                      url: '$kDocsUrl/self-host-installation/#file-permissions',
                    ),
                  /*
                  if (!account.isDocker) ...[
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
                  if (!account.isDocker &&
                      phpMemoryLimitDouble! > 100 &&
                      phpMemoryLimitDouble < 1024)
                    _HealthListTile(
                      title: 'PHP memory limit is too low',
                      subtitle:
                          'Increase the limit to 1024M to support the in-app update',
                      level: _HealthCheckLevel.Warning,
                    ),
                  if (_response!.queue == 'sync')
                    _HealthListTile(
                      title: 'Queue not enabled',
                      subtitle: 'Enable the queue for improved performance',
                      level: _HealthCheckLevel.Info,
                      url:
                          '$kDocsUrl/self-host-installation/#final-setup-steps',
                    ),
                  if (!_response!.pdfEngine.toLowerCase().startsWith('snappdf'))
                    _HealthListTile(
                      title: 'SnapPDF not enabled',
                      subtitle: 'Use SnapPDF to generate PDF files locally',
                      level: _HealthCheckLevel.Info,
                      url:
                          '$kDocsUrl/self-host-troubleshooting/#pdf-conversion-issues',
                    ),
                  if (_response!.trailingSlash)
                    _HealthListTile(
                      title: 'APP_URL has trailing slash',
                      subtitle: 'Remove the slash in the .env file',
                      level: _HealthCheckLevel.Warning,
                    ),
                  if (_response!.exchangeRateApiNotConfigured)
                    _HealthListTile(
                      title: 'Exchange Rate API Not Enabled',
                      subtitle: 'Add an Open Exchange key to the .env file',
                      level: _HealthCheckLevel.Info,
                      url:
                          '$kDocsUrl/self-host-installation/#currency-conversion',
                    ),
                ],
              ),
            ),
      actions: _response == null
          ? []
          : [
              TextButton(
                child: Text(localization!.clearCache.toUpperCase()),
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
    required this.title,
    this.isValid = true,
    this.level,
    this.subtitle,
    this.url,
    this.buttonLabel,
    this.buttonCallback,
  });

  final String title;
  final bool isValid;
  final _HealthCheckLevel? level;
  final String? subtitle;
  final String? url;
  final String? buttonLabel;
  final Function? buttonCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle != null
                ? subtitle!
                : (level != null
                    ? level.toString()
                    : (isValid ? 'Passed' : 'Failed')),
          ),
          if (buttonLabel != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 12),
              child: OutlinedButton(
                onPressed: () {
                  buttonCallback!();
                },
                child: Text(buttonLabel!),
              ),
            ),
        ],
      ),
      trailing: Icon(
        level == _HealthCheckLevel.Warning
            ? Icons.warning
            : level == _HealthCheckLevel.Info
                ? Icons.info_outline
                : (isValid ? Icons.check_circle_outline : Icons.warning),
        color: level == _HealthCheckLevel.Warning
            ? Colors.orange
            : level == _HealthCheckLevel.Info
                ? Colors.blue
                : (isValid ? Colors.green : Colors.red),
      ),
      onTap: url != null ? () => launchUrl(Uri.parse(url!)) : null,
    );
  }
}

class _LastError extends StatefulWidget {
  const _LastError({
    required this.state,
  });

  final AppState state;

  @override
  State<_LastError> createState() => __LastErrorState();
}

class __LastErrorState extends State<_LastError> {
  HealthCheckLastErrorResponse? _response;

  @override
  void initState() {
    super.initState();

    final webClient = WebClient();
    final credentials = widget.state.credentials;
    final url = '${credentials.url}/last_error';

    webClient.get(url, credentials.token).then((dynamic response) {
      setState(() {
        _response = serializers.deserializeWith(
            HealthCheckLastErrorResponse.serializer, response);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AlertDialog(
        title: Text('Last Error'),
        actions: [
          if (_response != null && _response!.lastError.isNotEmpty)
            TextButton(
              onPressed: () {
                showToast(
                    localization.copiedToClipboard.replaceFirst(':value', ''));
                Clipboard.setData(ClipboardData(text: _response!.lastError));
              },
              child: Text(
                localization!.copy.toUpperCase(),
              ),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              localization!.close.toUpperCase(),
            ),
          ),
        ],
        content: _response == null
            ? LinearProgressIndicator()
            : SelectableText(
                _response!.lastError.isEmpty
                    ? 'No errors found'
                    : '${_response!.lastError}',
              ));
  }
}
