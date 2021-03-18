import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/vendor/vendor_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_details.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_documents.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_overview.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class VendorView extends StatefulWidget {
  const VendorView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
    @required this.tabIndex,
  }) : super(key: key);

  final VendorViewVM viewModel;
  final bool isFilter;
  final int tabIndex;

  @override
  _VendorViewState createState() => _VendorViewState();
}

class _VendorViewState extends State<VendorView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    _controller = TabController(
        vsync: this,
        length: 3,
        initialIndex: widget.isFilter ? 0 : state.vendorUIState.tabIndex);
    _controller.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateVendorTab(tabIndex: _controller.index));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex) {
      _controller.index = widget.tabIndex;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTabChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final vendor = viewModel.vendor;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: vendor,
      appBarBottom: TabBar(
        controller: _controller,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: localization.details,
          ),
          Tab(
            text: localization.documents,
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
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: VendorViewDocuments(
                      viewModel: viewModel,
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
      floatingActionButton: FloatingActionButton(
        heroTag: 'vendor_view_fab',
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () => viewModel.onAddExpensePressed(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: localization.create,
      ),
    );
  }
}
