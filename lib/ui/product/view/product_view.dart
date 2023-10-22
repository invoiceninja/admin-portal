// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_documents.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_overview.dart';
import 'package:invoiceninja_flutter/ui/product/view/product_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
    required this.tabIndex,
  }) : super(key: key);

  final ProductViewVM viewModel;
  final bool isFilter;
  final int tabIndex;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    _controller = TabController(
        vsync: this,
        length: 2,
        initialIndex: widget.isFilter ? 0 : state.productUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateProductTab(tabIndex: _controller!.index));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex) {
      _controller!.index = widget.tabIndex;
    }
  }

  @override
  void dispose() {
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final company = state.company;
    final product = viewModel.product;
    final documents = product.documents;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: product,
      appBarBottom: company.isModuleEnabled(EntityType.document)
          ? TabBar(
              controller: _controller,
              isScrollable: false,
              tabs: [
                Tab(
                  text: localization!.overview,
                ),
                Tab(
                  text: documents.isEmpty
                      ? localization.documents
                      : '${localization.documents} (${documents.length})',
                ),
              ],
            )
          : null,
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: company.isModuleEnabled(EntityType.document)
                  ? TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed(context),
                          child: ProductOverview(
                            viewModel: viewModel,
                            key: ValueKey(viewModel.product.id),
                            //isFilter: widget.isFilter,
                          ),
                        ),
                        RefreshIndicator(
                          onRefresh: () => viewModel.onRefreshed(context),
                          child: ProductViewDocuments(
                            viewModel: viewModel,
                            key: ValueKey(viewModel.product.id),
                            //client: viewModel.client,
                          ),
                        ),
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: () => viewModel.onRefreshed(context),
                      child: ProductOverview(
                        viewModel: viewModel,
                        key: ValueKey(viewModel.product.id),
                        //isFilter: widget.isFilter,
                      ),
                    ),
            ),
            BottomButtons(
              entity: product,
              action1: EntityAction.newInvoice,
              action2: EntityAction.clone,
            ),
          ],
        );
      }),
    );
  }
}
