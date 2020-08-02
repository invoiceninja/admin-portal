import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/health_check.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class HealthCheckDialog extends StatefulWidget {
  @override
  _HealthCheckDialogState createState() => _HealthCheckDialogState();
}

class _HealthCheckDialogState extends State<HealthCheckDialog> {
  HealthCheckResponse _response;

  @override
  void initState() {
    super.initState();

    print('## INIT STATE');
  }

  @override
  void didChangeDependencies() {
    print('## didChangeDependencies');

    if (_response == null) {
      runCheck();
    }
    super.didChangeDependencies();
  }

  void runCheck() {
    print('## RUN CHECK');

    setState(() {
      _response = null;
    });

    final webClient = WebClient();
    final state = StoreProvider.of<AppState>(context).state;
    final credentials = state.credentials;
    final url = '${credentials.url}/health_check';

    webClient.get(url, credentials.token).then((dynamic response) {
      print('## response: $response');
      setState(() {
        //_response = json.decode(response);
        _response = serializers.deserializeWith(
            HealthCheckResponse.serializer, response);
      });
    }).catchError((dynamic error) {
      print('## error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AlertDialog(
      content: _response == null
          ? LoadingIndicator()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('System Health'),
                  subtitle: Text(_response.systemHealth ? 'Passed' : 'Failed'),
                  trailing: Icon(_response.systemHealth
                      ? Icons.check_circle_outline
                      : Icons.error_outline),
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
