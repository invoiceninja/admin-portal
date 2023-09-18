// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/tax_rate/view/tax_rate_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TaxRateView extends StatefulWidget {
  const TaxRateView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final TaxRateViewVM viewModel;
  final bool isFilter;

  @override
  _TaxRateViewState createState() => new _TaxRateViewState();
}

class _TaxRateViewState extends State<TaxRateView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final taxRate = viewModel.taxRate;
    final localization = AppLocalization.of(context)!;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: taxRate,
      onBackPressed: () => viewModel.onBackPressed(),
      body: ScrollableListView(children: [
        EntityHeader(
          entity: taxRate,
          label: localization.name,
          value: taxRate.name,
          secondLabel: localization.rate,
          secondValue: formatNumber(taxRate.rate, context,
              formatNumberType: FormatNumberType.percent),
        ),
      ]),
    );
  }
}
