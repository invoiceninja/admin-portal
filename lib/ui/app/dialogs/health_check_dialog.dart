import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/health_check_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
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

  void runCheck() {
    setState(() {
      _response = null;
    });

    final webClient = WebClient();
    final state = StoreProvider.of<AppState>(context).state;
    final credentials = state.credentials;
    final url = '${credentials.url}/health_check';

    webClient.get(url, credentials.token).then((dynamic response) {
      setState(() {
        _response = serializers.deserializeWith(
            HealthCheckResponse.serializer, response);
      });
    }).catchError((dynamic error) {
      showDialog<ErrorDialog>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(error);
          });
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
      showDialog<ErrorDialog>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(error);
          });
    });
  }

  String _parseVersion(String version) =>
      RegExp(r'(\d+\.\d+.\d+)').stringMatch(version);

  @override
  Widget build(BuildContext context) {
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
                      : 'Web: v$webPhpVersion\nCLI: v$cliPhpVersion}',
                ),
                if (!_response.execEnabled)
                  _HealthListTile(
                    title: 'PHP Exec',
                    isValid: false,
                    subtitle: 'Not enabled',
                  ),
                if (!_response.openBasedir)
                  _HealthListTile(
                    title: 'Open Basedir',
                    isValid: false,
                    subtitle: 'Not enabled',
                  ),
                if (!_response.envWritable)
                  _HealthListTile(
                    title: '.env Writable',
                    isValid: false,
                  ),
                if (!_response.cacheEnabled)
                  _HealthListTile(
                    title: 'Config not cached',
                    subtitle: 'Run php artisan optimize to improve performance',
                  ),
                if (_response.phantomEnabled)
                  _HealthListTile(
                    title: 'Using PhantomJS',
                    subtitle: 'Use headless Chrome to generate PDFs locally',
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
    this.isValid,
    this.subtitle,
  });

  final String title;
  final bool isValid;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle != null
          ? subtitle
          : (isValid == null ? 'Warning' : (isValid ? 'Passed' : 'Failed'))),
      trailing: Icon(
        isValid == null
            ? Icons.warning
            : (isValid ? Icons.check_circle_outline : Icons.error_outline),
        color: isValid == null
            ? Colors.orange
            : (isValid ? Colors.green : Colors.red),
      ),
    );
  }
}
