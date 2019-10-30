import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:invoiceninja_flutter/ui/app/responsive_padding.dart';

class StateInspector extends StatefulWidget {
  @override
  _StateInspectorState createState() => _StateInspectorState();
}

class _StateInspectorState extends State<StateInspector> {
  String _filter = '';

  dynamic filterJson(dynamic data, String filter) {
    if (filter.contains('.')) {
      final parts = filter.split('.')
        ..removeLast()
        ..where((part) => part.isNotEmpty);

      if (parts.isNotEmpty) {
        parts.forEach((part) {
          String pattern = '';
          part.split('').forEach((ch) => pattern += ch.toLowerCase() + '.*');
          final regExp = RegExp(pattern, caseSensitive: false);

          try {
            final dynamic index = (data as Map)
                .keys
                .firstWhere((dynamic key) => regExp.hasMatch(key));

            if (index != null) {
              data = data[index];
            }
          } catch (e) {
            // do nothing
          }
        });
      }
    }

    if (data.runtimeType.toString() ==
        '_InternalLinkedHashMap<String, Object>') {
      return data;
    } else {
      return <String, dynamic>{'value': data};
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final data = serializers.serializeWith(AppState.serializer, state);

    return Padding(
      padding: const EdgeInsets.only(left: 100, top: 20, right: 100),
      child: Material(
        child: ResponsivePadding(
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    _filter = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Container(
                //color: Colors.white,
                child: SingleChildScrollView(
                    child: JsonViewerWidget(filterJson(data, _filter))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
