// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/entity_top_filter.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_activity.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_details.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_documents.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_fullwidth.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_overview.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorView extends StatefulWidget {
  const VendorView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
    required this.isTopFilter,
    required this.tabIndex,
  }) : super(key: key);

  final VendorViewVM viewModel;
  final bool isFilter;
  final bool isTopFilter;
  final int tabIndex;

  @override
  _VendorViewState createState() => _VendorViewState();
}

class _VendorViewState extends State<VendorView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    _controller = TabController(
        vsync: this,
        length: state.company.isModuleEnabled(EntityType.document) ? 4 : 3,
        initialIndex: widget.isFilter ? 0 : state.vendorUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateVendorTab(tabIndex: _controller!.index));
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
    final company = viewModel.state.company;
    final vendor = viewModel.vendor;
    final documents = vendor.documents;

    if (widget.isTopFilter) {
      return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EntityTopFilterHeader(),
            Expanded(
                child: AppBorder(
              isTop: true,
              isBottom: true,
              child: VendorViewFullwidth(
                viewModel: viewModel,
              ),
            )),
          ],
        ),
      );
    }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: vendor,
      appBarBottom: TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization!.overview,
          ),
          Tab(
            text: localization.details,
          ),
          if (company.isModuleEnabled(EntityType.document))
            Tab(
              text: documents.isEmpty
                  ? localization.documents
                  : '${localization.documents} (${documents.length})',
            ),
          Tab(
            text: localization.activity,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: VendorOverview(
                      viewModel: viewModel,
                      isFilter: widget.isFilter,
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: VendorViewDetails(vendor: viewModel.vendor),
                  ),
                  if (company.isModuleEnabled(EntityType.document))
                    RefreshIndicator(
                      onRefresh: () => viewModel.onRefreshed(context),
                      child: VendorViewDocuments(
                        viewModel: viewModel,
                      ),
                    ),
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: VendorViewActivity(
                      viewModel: viewModel,
                      key: ValueKey(viewModel.vendor.id),
                    ),
                  ),
                ],
              ),
            ),
            BottomButtons(
              entity: vendor,
              action1: EntityAction.newExpense,
              action2: EntityAction.archive,
            ),
          ],
        );
      }),
    );
  }
}
