// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/elevated_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/system_log_viewer.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class CompanyGatewayView extends StatefulWidget {
  const CompanyGatewayView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final CompanyGatewayViewVM viewModel;
  final bool isFilter;

  @override
  _CompanyGatewayViewState createState() => _CompanyGatewayViewState();
}

class _CompanyGatewayViewState extends State<CompanyGatewayView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final companyGateway = viewModel.companyGateway;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: companyGateway,
      onBackPressed: () => widget.viewModel.onBackPressed(),
      appBarBottom: TabBar(
        controller: _controller,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: localization.systemLogs,
          ),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          RefreshIndicator(
            onRefresh: () => viewModel.onRefreshed(context),
            child: _CompanyGatewayOverview(
                viewModel: widget.viewModel, isFilter: widget.isFilter),
          ),
          RefreshIndicator(
              onRefresh: () => viewModel.onRefreshed(context),
              child: _CompanyGatewaySystemLog(viewModel: widget.viewModel)),
        ],
      ),
    );
  }
}

class _CompanyGatewayOverview extends StatelessWidget {
  const _CompanyGatewayOverview({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final bool isFilter;
  final CompanyGatewayViewVM viewModel;

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
    final companyGateway = viewModel.companyGateway;
    final gateway = state.staticState.gatewayMap[companyGateway.gatewayId]!;
    final localization = AppLocalization.of(context)!;
    final processed = memoizedCalculateCompanyGatewayProcessed(
        companyGateway.id, viewModel.state.paymentState.map);
    final webhookUrl =
        '${state.account.defaultUrl}/payment_webhook/${state.company.companyKey}/${companyGateway.id}';

    final allFields = <String, Map<String, String>>{};
    for (var gatewayTypeId in kGatewayTypes.keys) {
      final Map<String, String> fields = {};
      if (companyGateway.feesAndLimitsMap.containsKey(gatewayTypeId)) {
        final settings =
            companyGateway.getSettingsForGatewayTypeId(gatewayTypeId);
        if (settings.feeAmount != 0) {
          fields[localization.feeAmount] =
              formatNumber(settings.feeAmount, context) ?? '';
        }
        if (settings.feePercent != 0) {
          fields[localization.feePercent] = formatNumber(
                  settings.feePercent, context,
                  formatNumberType: FormatNumberType.percent) ??
              '';
        }
        if (settings.feeCap != 0) {
          fields[localization.feeCap] =
              formatNumber(settings.feeCap, context) ?? '';
        }
        if (settings.minLimit != -1) {
          fields[localization.minLimit] =
              formatNumber(settings.minLimit, context) ?? '';
        }
        if (settings.maxLimit != -1) {
          fields[localization.maxLimit] =
              formatNumber(settings.maxLimit, context) ?? '';
        }
        if (fields.isNotEmpty) {
          allFields[gatewayTypeId] = fields;
        }
      }
    }

    return ScrollableListView(children: <Widget>[
      EntityHeader(
          entity: companyGateway,
          label: localization.processed,
          value: formatNumber(processed, context)),
      ListDivider(),
      if ([kGatewayStripe, kGatewayStripeConnect].contains(gateway.id)) ...[
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 20, right: 16),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  iconData:
                      isDesktop(context) ? MdiIcons.checkCircleOutline : null,
                  label: localization.verifyCustomers.toUpperCase(),
                  onPressed: () => viewModel.onStripeVerifyPressed(context),
                ),
              ),
              SizedBox(width: kTableColumnGap),
              Expanded(
                child: AppButton(
                  iconData: isDesktop(context) ? MdiIcons.import : null,
                  label: localization.importCustomers.toUpperCase(),
                  onPressed: () => viewModel.onStripeImportPressed(context),
                ),
              ),
            ],
          ),
        ),
        ListDivider(),
      ],
      if (gateway.supportedEvents().isNotEmpty) ...[
        ListTile(
          contentPadding: const EdgeInsets.all(22),
          title: Text(localization.webhookUrl),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                webhookUrl,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '\n${localization.supportedEvents}:\n${gateway.supportedEvents().map((e) => ' - $e').join('\n')}',
              ),
            ],
          ),
          trailing: Icon(Icons.content_copy),
          onTap: () {
            Clipboard.setData(ClipboardData(text: webhookUrl));
            showToast(localization.copiedToClipboard
                .replaceFirst(':value ', webhookUrl));
          },
        ),
        ListDivider(),
      ],
      if (gateway.supportsTokenBilling == true) ...[
        EntitiesListTile(
          hideNew: true,
          entity: companyGateway,
          isFilter: isFilter,
          entityType: EntityType.client,
          title: localization.clients,
          subtitle: memoizedClientStatsForCompanyGateway(
                  companyGateway.id, state.clientState.map)
              .present(localization.active, localization.archived),
        ),
      ],
      EntitiesListTile(
        hideNew: true,
        entity: companyGateway,
        isFilter: isFilter,
        entityType: EntityType.payment,
        title: localization.payments,
        subtitle: memoizedPaymentStatsForCompanyGateway(
                companyGateway.id, state.paymentState.map)
            .present(localization.active, localization.archived),
      ),
      for (var entry in allFields.entries) ...[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            localization.lookup(kGatewayTypes[entry.key]),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        FieldGrid(entry.value),
      ]
    ]);
  }
}

class _CompanyGatewaySystemLog extends StatefulWidget {
  const _CompanyGatewaySystemLog({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayViewVM viewModel;

  @override
  __CompanyGatewaySystemLogState createState() =>
      __CompanyGatewaySystemLogState();
}

class __CompanyGatewaySystemLogState extends State<_CompanyGatewaySystemLog> {
  @override
  void didChangeDependencies() {
    if (widget.viewModel.companyGateway.isStale) {
      widget.viewModel.onRefreshed(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final companyGateway = widget.viewModel.companyGateway;

    if (companyGateway.isStale) {
      return LoadingIndicator();
    }

    return SystemLogViewer(
      systemLogs: companyGateway.systemLogs,
    );
  }
}
