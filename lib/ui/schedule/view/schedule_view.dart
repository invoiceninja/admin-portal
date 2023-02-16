import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/schedule/view/schedule_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final ScheduleViewVM viewModel;
  final bool isFilter;

  @override
  _ScheduleViewState createState() => new _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final schedule = viewModel.schedule;
    final parameters = schedule.parameters;
    final localization = AppLocalization.of(context);

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: schedule,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ScrollableListView(
        children: <Widget>[
          FieldGrid({
            localization.template: localization.lookup(schedule.template),
            localization.nextRun: formatDate(schedule.nextRun, context),
            localization.frequency:
                localization.lookup(kFrequencies[schedule.frequencyId]),
            if (schedule.template ==
                ScheduleEntity.TEMPLATE_EMAIL_STATEMENT) ...{
              localization.clients: parameters.clients.isEmpty
                  ? localization.allClients
                  : parameters.clients.length == 1
                      ? state.clientState
                          .get(parameters.clients.first)
                          .displayName
                      : '${parameters.clients.length} ${localization.clients}',
              localization.dateRange: localization.lookup(parameters.dateRange),
              localization.status: localization.lookup(parameters.status),
              localization.showAgingTable: parameters.showAgingTable
                  ? localization.yes
                  : localization.no,
              localization.showPaymentsTable: parameters.showPaymentsTable
                  ? localization.yes
                  : localization.no,
            }
          })
        ],
      ),
    );
  }
}
