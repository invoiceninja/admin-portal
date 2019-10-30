import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class StateInspector extends StatefulWidget {
  @override
  _StateInspectorState createState() => _StateInspectorState();
}

class _StateInspectorState extends State<StateInspector> {
  String _text;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    final data = serializers.serializeWith(AppState.serializer, state);
    final map = data as Map;
    final json = jsonEncode(data);

    final JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(data);

    final keys = map.keys.where((dynamic key) {
      if (map[key].runtimeType.toString() !=
          '_InternalLinkedHashMap<String, Object>') {
        return false;
      }

      if ((_text ?? '').isEmpty) {
        return true;
      }

      return '$key'.toLowerCase().contains(_text.toLowerCase());
    });

    return Padding(
      padding: const EdgeInsets.only(left: 100, top: 20, right: 100),
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                onChanged: (value) {
                  print('TEXT: $value');
                  if (value.endsWith('\t')) {
                    print('ends with tab');
                  }
                  setState(() {
                    _text = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  for (var key in keys)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text('$key'),
                    )
                ],
              ),
              SizedBox(height: 20),
              Flexible(child: Text(prettyJson)),
            ],
          ),
        ),
      ),
    );
  }
}
