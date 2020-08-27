import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:invoiceninja_flutter/data/models/system_log_model.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientViewSystemLogs extends StatefulWidget {
  const ClientViewSystemLogs({Key key, this.viewModel}) : super(key: key);

  final ClientViewVM viewModel;

  @override
  _ClientViewSystemLogsState createState() => _ClientViewSystemLogsState();
}

class _ClientViewSystemLogsState extends State<ClientViewSystemLogs> {
  final Map<String, bool> _isExpanded = {};

  @override
  void didChangeDependencies() {
    if (widget.viewModel.client.isStale) {
      widget.viewModel.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final client = widget.viewModel.client;

    if (client.isStale) {
      return LoadingIndicator();
    }

    return ListView(
      shrinkWrap: true,
      children: [
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              final systemLog = client.systemLogs[index];
              _isExpanded[systemLog.id] = !isExpanded;
            });
          },
          children: client.systemLogs
              .where((systemLog) => systemLog.isVisible)
              .map((systemLog) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
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
                  child: JsonViewerWidget(
                      jsonDecode(systemLog.log)['server_response']),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
