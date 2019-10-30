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
  final _filterController = TextEditingController();

  List<TextEditingController> _controllers = [];
  String _text;
  List<String> _keys = [];

  @override
  void didChangeDependencies() {

    _controllers = [_filterController];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  List<String> getKeys() {
    final state = StoreProvider.of<AppState>(context).state;
    dynamic data = serializers.serializeWith(AppState.serializer, state);

    _keys.forEach((key) => data = data[key]);

    final map = data as Map;

    return map.keys.where((dynamic key) {
      if (map[key].runtimeType.toString() !=
          '_InternalLinkedHashMap<String, Object>') {
        return false;
      }

      if ((_text ?? '').isEmpty) {
        return true;
      }

      String pattern = '.*';
      _text.split('').forEach((ch) => pattern += ch + '.*');
      final regExp = RegExp(pattern, caseSensitive: true);

      return regExp.hasMatch('$key'.toLowerCase());
    }).toList();
  }

  void _onChanged() {
    String value = _filterController.text.toLowerCase();
    print('TEXT: $value');
    if (value.endsWith('\t') || value.endsWith('.')) {
      print('ends with tab');
      value = getKeys().first;
      //_filterController.text = value;
      _text = value;
      _keys.add(value);
    }
    setState(() {
      _text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;
    dynamic data = serializers.serializeWith(AppState.serializer, state);

    _keys.forEach((key) => data = data[key]);

    final JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(data);

    final keys = getKeys();

    return Padding(
      padding: const EdgeInsets.only(left: 100, top: 20, right: 100),
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Text('Text: $_text, Keys: $_keys'),
              TextFormField(
                autofocus: true,
                controller: _filterController,
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
