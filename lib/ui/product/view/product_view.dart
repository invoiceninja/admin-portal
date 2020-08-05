import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_documents.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_overview.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final ProductViewVM viewModel;
  final bool isFilter;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final product = viewModel.product;
    final company = viewModel.company;

    String tax = '';
    if (product.taxName1.isNotEmpty) {
      tax += formatNumber(product.taxRate1, context,
              formatNumberType: FormatNumberType.percent) +
          ' ' +
          product.taxName1;
    }
    if (product.taxName2.isNotEmpty) {
      tax += ' ' +
          formatNumber(product.taxRate2, context,
              formatNumberType: FormatNumberType.percent) +
          ' ' +
          product.taxName2;
    }

    final fields = <String, String>{
      localization.tax: tax,
    };

    if (product.customValue1.isNotEmpty) {
      final label1 = company.getCustomFieldLabel(CustomFieldType.product1);
      fields[label1] = formatCustomValue(
          context: context,
          field: CustomFieldType.product1,
          value: product.customValue1);
    }

    if (product.customValue2.isNotEmpty) {
      final label2 = company.getCustomFieldLabel(CustomFieldType.product2);
      fields[label2] = formatCustomValue(
          context: context,
          field: CustomFieldType.product2,
          value: product.customValue2);
    }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: product,
      appBarBottom: TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: localization.documents,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: ProductOverview(
                      viewModel: viewModel,
                      //isFilter: widget.isFilter,
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: ProductViewDocuments(
                        //client: viewModel.client,
                        ),
                  ),
                ],
              ),
            ),
            BottomButtons(
              entity: product,
              action1: EntityAction.clone,
              action2: EntityAction.newInvoice,
            ),
          ],
        );
      }),
      /*
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                EntityHeader(
                  entity: product,
                  label: localization.price,
                  value: formatNumber(product.price, context),
                  secondLabel: localization.cost,
                  secondValue: company.enableProductCost
                      ? formatNumber(product.cost, context)
                      : null,
                ),
                ListDivider(),
                FieldGrid(fields),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    product.notes,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          BottomButtons(
            entity: product,
            action1: EntityAction.clone,
            action2: EntityAction.newInvoice,
          ),
        ],
      ),      
       */
    );
  }
}
