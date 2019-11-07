import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/two_value_header.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/view/tax_rate_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class TaxRateView extends StatefulWidget {
  const TaxRateView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final TaxRateViewVM viewModel;

  @override
  _TaxRateViewState createState() => new _TaxRateViewState();
}

class _TaxRateViewState extends State<TaxRateView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final userCompany = viewModel.state.userCompany;
    final taxRate = viewModel.taxRate;
    final localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: !isMobile(context)
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: viewModel.onBackPressed,
              )
            : null,
        title: EntityStateTitle(entity: taxRate),
        actions: [
          userCompany.canEditEntity(taxRate)
              ? EditIconButton(
                  isVisible: !(taxRate.isDeleted ?? false),
                  onPressed: () => viewModel.onEditPressed(context),
                )
              : Container(),
          ActionMenuButton(
            entityActions: taxRate.getActions(userCompany: userCompany),
            isSaving: viewModel.isSaving,
            entity: taxRate,
            onSelected: viewModel.onEntityAction,
          )
        ],
      ),
      body: ListView(children: [
        TwoValueHeader(
          label1: localization.name,
          value1: taxRate.name,
          label2: localization.rate,
          value2: formatNumber(taxRate.rate, context,
              formatNumberType: FormatNumberType.percent),
        ),
      ]),
    );
  }
}
