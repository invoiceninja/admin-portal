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
    final json = jsonEncode(data);

    final JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(data);

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
                },
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  for (var key in (data as Map).keys) Text('$key')
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
