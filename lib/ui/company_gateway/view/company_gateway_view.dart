import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';
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
    final companyGateway = viewModel.companyGateway;
    final localization = AppLocalization.of(context);

    final Map<String, String> fields = {};
    for (var gatewayTypeId in kGatewayTypes.keys)
      if (companyGateway.feesAndLimitsMap.containsKey(gatewayTypeId)) {
        final settings =
            companyGateway.getSettingsForGatewayTypeId(gatewayTypeId);
        fields[localization.feeAmount] = settings.feeAmount == null
            ? null
            : formatNumber(settings.feeAmount, context);
        fields[localization.feePercent] = settings.feePercent == null
            ? null
            : formatNumber(settings.feePercent, context,
                formatNumberType: FormatNumberType.percent);
        fields[localization.feeCap] = settings.feeCap == null
            ? null
            : formatNumber(settings.feeCap, context);
        fields[localization.minLimit] = settings.minLimit == null
            ? null
            : formatNumber(settings.minLimit, context);
        fields[localization.maxLimit] = settings.maxLimit == null
            ? null
            : formatNumber(settings.maxLimit, context);
      }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: companyGateway,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ListView(
        children: <Widget>[
          /*
          EntityHeader(
            label: localization.processed,
            value: '', // TODO calculate value
          ),
          EntityListTile(
            icon: getEntityIcon(EntityType.client),
            title: localization.clients,
            //onTap: () => viewModel.onEntityPressed(context, EntityType.invoice),
            subtitle: memoizedInvoiceStatsForClient(
                client.id,
                state.invoiceState.map,
                localization.active,
                localization.archived),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
          FieldGrid({}),
           */
        ],
      ),
    );
  }
}
