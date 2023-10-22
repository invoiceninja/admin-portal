// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/system_log_viewer.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';

class ClientViewSystemLogs extends StatefulWidget {
  const ClientViewSystemLogs({Key? key, this.viewModel}) : super(key: key);

  final ClientViewVM? viewModel;

  @override
  _ClientViewSystemLogsState createState() => _ClientViewSystemLogsState();
}

class _ClientViewSystemLogsState extends State<ClientViewSystemLogs> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel!.client.isStale) {
      widget.viewModel!.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final client = widget.viewModel!.client;

    if (client.isStale) {
      return LoadingIndicator();
    }

    return SystemLogViewer(
      systemLogs: client.systemLogs,
    );
  }
}
