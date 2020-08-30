import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/company_gateway/company_gateway_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyGatewayView extends StatefulWidget {
  const CompanyGatewayView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final CompanyGatewayViewVM viewModel;
  final bool isFilter;

  @override
  _CompanyGatewayViewState createState() => new _CompanyGatewayViewState();
}

class _CompanyGatewayViewState extends State<CompanyGatewayView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final companyGateway = viewModel.companyGateway;
    final gateway = state.staticState.gatewayMap[companyGateway.gatewayId];
    final localization = AppLocalization.of(context);
    final processed = memoizedCalculateCompanyGatewayProcessed(
        companyGateway.id, viewModel.state.paymentState.map);

    final allFields = <String, Map<String, String>>{};
    for (var gatewayTypeId in kGatewayTypes.keys) {
      final Map<String, String> fields = {};
      if (companyGateway.feesAndLimitsMap.containsKey(gatewayTypeId)) {
        final settings =
            companyGateway.getSettingsForGatewayTypeId(gatewayTypeId);
        if (settings.feeAmount != 0) {
          fields[localization.feeAmount] =
              formatNumber(settings.feeAmount, context);
        }
        if (settings.feePercent != 0) {
          fields[localization.feePercent] = formatNumber(
              settings.feePercent, context,
              formatNumberType: FormatNumberType.percent);
        }
        if (settings.feeCap != 0) {
          fields[localization.feeCap] = formatNumber(settings.feeCap, context);
        }
        if (settings.minLimit != -1) {
          fields[localization.minLimit] =
              formatNumber(settings.minLimit, context);
        }
        if (settings.maxLimit != -1) {
          fields[localization.maxLimit] =
              formatNumber(settings.maxLimit, context);
        }
        if (fields.isNotEmpty) {
          allFields[gatewayTypeId] = fields;
        }
      }
    }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: companyGateway,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ListView(children: <Widget>[
        EntityHeader(
            entity: companyGateway,
            label: localization.processed,
            value: formatNumber(processed, context)),
        ListDivider(),
        if (gateway?.supportsTokenBilling == true) ...[
          EntitiesListTile(
            isFilter: widget.isFilter,
            entityType: EntityType.client,
            title: localization.clients,
            onTap: () => viewEntitiesByType(
                context: context,
                entityType: EntityType.client,
                filterEntity: companyGateway),
            subtitle: memoizedClientStatsForCompanyGateway(
                    companyGateway.id, state.clientState.map)
                .present(localization.active, localization.archived),
          ),
        ],
        ListDivider(),
        EntitiesListTile(
          isFilter: widget.isFilter,
          entityType: EntityType.payment,
          title: localization.payments,
          onTap: () => viewEntitiesByType(
              context: context,
              entityType: EntityType.payment,
              filterEntity: companyGateway),
          subtitle: memoizedPaymentStatsForCompanyGateway(
                  companyGateway.id, state.paymentState.map)
              .present(localization.active, localization.archived),
        ),
        ListDivider(),
        for (var entry in allFields.entries) ...[
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              localization.lookup(kGatewayTypes[entry.key]),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          FieldGrid(entry.value),
        ]
      ]),
    );
  }
}
