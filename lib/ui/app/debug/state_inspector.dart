import 'dart:convert';

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
    print('FILTER...');
    if (filter.contains('.')) {
      filter.split('.')
        ..removeLast()
        ..where((part) => part.isNotEmpty).forEach((part) {
          print('part: $part');

          String pattern = '.*';
          part.split('').forEach((ch) => pattern += ch + '.*');
          final regExp = RegExp(pattern, caseSensitive: true);
          dynamic index;
          try {
            index = (data as Map)
                .keys
                .firstWhere((dynamic key) => regExp.hasMatch(key));
          } catch (e) {
            // do nothing
          }

          print('index: $index');

          if (index != null) {
            data = data[index];
          }
        });
    }

    return data;
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
                  print('changed: $value');
                  setState(() {
                    _filter = value;
                  });
                },
              ),
              Container(
                color: Colors.white,
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
