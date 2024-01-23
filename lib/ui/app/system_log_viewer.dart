// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/system_log_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SystemLogViewer extends StatefulWidget {
  const SystemLogViewer({this.systemLogs});

  final BuiltList<SystemLogEntity>? systemLogs;

  @override
  _SystemLogViewerState createState() => _SystemLogViewerState();
}

class _SystemLogViewerState extends State<SystemLogViewer> {
  final Map<String, bool> _isExpanded = {};

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;

    var systemLogs = widget.systemLogs!.where((log) {
      return log.typeId != 800;
    }).toList();
    if (systemLogs.length > 25) {
      systemLogs = systemLogs.sublist(0, 25);
    }

    return ScrollableListView(
      children: [
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              final systemLog = systemLogs[index];
              _isExpanded[systemLog.id] = !isExpanded;
            });
          },
          children: systemLogs
              .where((systemLog) => systemLog.isVisible)
              .map((systemLog) {
            final client = state.clientState.get(systemLog.clientId);
            Map<String, dynamic>? logs;
            if (_isExpanded[systemLog.id] == true && systemLog.log.isNotEmpty) {
              try {
                logs = json.decode(systemLog.log);
              } catch (e) {
                // do nothing
              }
            }

            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  leading: Icon(getActivityIcon(systemLog.categoryId)),
                  title: Text(localization!.lookup(systemLog.category) +
                      '  ›  ' +
                      localization.lookup(systemLog.type)),
                  isThreeLine: true,
                  subtitle: Text(localization.lookup(systemLog.event) +
                      (client.isOld ? ' • ${client.displayName}' : '') +
                      '\n' +
                      formatDate(
                          convertTimestampToDateString(systemLog.createdAt),
                          context,
                          showTime: true)),
                  onTap: () {
                    setState(() {
                      _isExpanded[systemLog.id] =
                          _isExpanded.containsKey(systemLog.id)
                              ? !_isExpanded[systemLog.id]!
                              : true;
                    });
                  },
                );
              },
              isExpanded: _isExpanded[systemLog.id] == true,
              body: _isExpanded[systemLog.id] == true
                  ? logs == null
                      ? Padding(
                          child: Text(systemLog.log),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10))
                      : Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: JsonViewer(logs),
                          ),
                        )
                  : SizedBox(),
            );
          }).toList(),
        ),
      ],
    );
  }
}
