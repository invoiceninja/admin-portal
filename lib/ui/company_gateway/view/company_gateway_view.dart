import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/FieldGrid.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_list_tile.dart';
import 'package:invoiceninja_flutter/ui/app/two_value_header.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/view/company_gateway_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class CompanyGatewayView extends StatefulWidget {
  const CompanyGatewayView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayViewVM viewModel;

  @override
  _CompanyGatewayViewState createState() => new _CompanyGatewayViewState();
}

class _CompanyGatewayViewState extends State<CompanyGatewayView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final userCompany = viewModel.state.userCompany;
    final companyGateway = viewModel.companyGateway;
    final localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: !isMobile(context)
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: viewModel.onBackPressed,
              )
            : null,
        title: EntityStateTitle(entity: companyGateway),
        actions: [
          userCompany.canEditEntity(companyGateway)
              ? EditIconButton(
                  isVisible: !(companyGateway.isDeleted ?? false),
                  onPressed: () => viewModel.onEditPressed(context),
                )
              : Container(),
          ActionMenuButton(
            entityActions: companyGateway.getActions(userCompany: userCompany),
            isSaving: viewModel.isSaving,
            entity: companyGateway,
            onSelected: viewModel.onEntityAction,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          TwoValueHeader(
            label1: localization.clients,
            value1: '', // TODO calculate value
            label2: localization.processed,
            value2: '', // TODO calculate value
          ),
          EntityListTile(
            icon: getEntityIcon(EntityType.client),
            title: localization.clients,
            //onTap: () => viewModel.onEntityPressed(context, EntityType.invoice),
            /*
            subtitle: memoizedInvoiceStatsForClient(
                client.id,
                state.invoiceState.map,
                localization.active,
                localization.archived),
             */
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
          FieldGrid({
            localization.feeAmount: companyGateway.feeAmount == null
                ? null
                : formatNumber(companyGateway.feeAmount, context),
            localization.feePercent: companyGateway.feePercent == null
                ? null
                : formatNumber(companyGateway.feePercent, context,
                    formatNumberType: FormatNumberType.percent),
            localization.feeAmount: companyGateway.feeCap == null
                ? null
                : formatNumber(companyGateway.feeCap, context),
            localization.minLimit: companyGateway.minLimit == null
                ? null
                : formatNumber(companyGateway.minLimit, context),
            companyGateway.maxLimit == null ? null : localization.maxLimit:
                formatNumber(companyGateway.maxLimit, context),
          }),
        ],
      ),
    );
  }
}
