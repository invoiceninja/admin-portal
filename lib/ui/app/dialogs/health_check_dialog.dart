import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/health_check_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
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
          ? LoadingIndicator(
              height: 100,
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
                  title: '.env Writable',
                  isValid: _response.envWritable,
                ),
                _HealthListTile(
                  title: 'PHP Version',
                  isValid: _response.phpVersion.isOkay,
                  subtitle: webPhpVersion == cliPhpVersion
                      ? 'v$webPhpVersion'
                      : 'Web: v$webPhpVersion\nCLI: v$cliPhpVersion}',
                ),
                _HealthListTile(
                  title: 'Node Version',
                  isValid: _response.nodeStatus.isNotEmpty,
                  subtitle: _response.nodeStatus,
                ),
                _HealthListTile(
                  title: 'NPM Version',
                  isValid: _response.npmStatus.isNotEmpty,
                  subtitle: 'v' + _response.npmStatus,
                ),
              ],
            ),
      actions: _response == null
          ? []
          : [
              FlatButton(
                child: Text(localization.refresh.toUpperCase()),
                onPressed: () => runCheck(),
              ),
              FlatButton(
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
    @required this.isValid,
    this.subtitle,
  });

  final String title;
  final bool isValid;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(isValid ? (subtitle ?? 'Passed') : 'Failed'),
      trailing: Icon(
        isValid ? Icons.check_circle_outline : Icons.error_outline,
        color: isValid ? Colors.green : Colors.red,
      ),
    );
  }
}
