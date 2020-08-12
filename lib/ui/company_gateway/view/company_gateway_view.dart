import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
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
    final localization = AppLocalization.of(context);
    final processed = memoizedCalculateCompanyGatewayProcessed(
        companyGateway.id, viewModel.state.paymentState.map);

    final Map<String, String> fields = {};
    for (var gatewayTypeId in kGatewayTypes.keys)
      if (companyGateway.feesAndLimitsMap.containsKey(gatewayTypeId)) {
        final settings =
            companyGateway.getSettingsForGatewayTypeId(gatewayTypeId);
        fields[localization.feeAmount] = settings.feeAmount == 0
            ? null
            : formatNumber(settings.feeAmount, context);
        fields[localization.feePercent] = settings.feePercent == 0
            ? null
            : formatNumber(settings.feePercent, context,
                formatNumberType: FormatNumberType.percent);
        fields[localization.feeCap] = settings.feeCap == 0
            ? null
            : formatNumber(settings.feeCap, context);
        fields[localization.minLimit] = settings.minLimit == -1
            ? null
            : formatNumber(settings.minLimit, context);
        fields[localization.maxLimit] = settings.maxLimit == -1
            ? null
            : formatNumber(settings.maxLimit, context);
      }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: companyGateway,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ListView(
        children: <Widget>[
          EntityHeader(
              entity: companyGateway,
              label: localization.processed,
              value: formatNumber(processed, context)),
          ListDivider(),
          EntitiesListTile(
            isFilter: widget.isFilter,
            entityType: EntityType.client,
            title: localization.clients,
            //onTap: () => viewModel.onClientsPressed(context),
            subtitle: memoizedClientStatsForCompanyGateway(
                    companyGateway.id, state.clientState.map)
                .present(localization.active, localization.archived),
          ),
          ListDivider(),
          EntitiesListTile(
            isFilter: widget.isFilter,
            entityType: EntityType.payment,
            title: localization.payments,
            //onTap: () => viewModel.onClientsPressed(context),
            subtitle: memoizedPaymentStatsForCompanyGateway(
                    companyGateway.id, state.paymentState.map)
                .present(localization.active, localization.archived),
          ),
          ListDivider(),
          FieldGrid(fields),
        ],
      ),
    );
  }
}
