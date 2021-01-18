import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:invoiceninja_flutter/data/models/system_log_model.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class SystemLogViewer extends StatefulWidget {
  const SystemLogViewer({this.systemLogs});
  final BuiltList<SystemLogEntity> systemLogs;

  @override
  _SystemLogViewerState createState() => _SystemLogViewerState();
}

class _SystemLogViewerState extends State<SystemLogViewer> {
  final Map<String, bool> _isExpanded = {};

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return ListView(
      shrinkWrap: true,
      children: [
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              final systemLog = widget.systemLogs[index];
              _isExpanded[systemLog.id] = !isExpanded;
            });
          },
          children: widget.systemLogs
              .where((systemLog) => systemLog.isVisible)
              .map((systemLog) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                //return Text(systemLog.log);
                return ListTile(
                  leading: Icon(
                      systemLog.categoryId == SystemLogEntity.CATEGORY_EMAIL
                          ? Icons.email
                          : Icons.credit_card),
                  title: Text(localization.lookup(systemLog.category) +
                      '  ›  ' +
                      localization.lookup(systemLog.type)),
                  isThreeLine: true,
                  subtitle: Text(localization.lookup(systemLog.event) +
                      '\n' +
                      formatDate(
                          convertTimestampToDateString(systemLog.createdAt),
                          context,
                          showTime: true)),
                  onTap: () {
                    setState(() {
                      _isExpanded[systemLog.id] =
                          _isExpanded.containsKey(systemLog.id)
                              ? !_isExpanded[systemLog.id]
                              : true;
                    });
                  },
                );
              },
              isExpanded: _isExpanded[systemLog.id] == true,
              body: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child:
                      JsonViewerWidget(jsonDecode(systemLog.log)['response']),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
