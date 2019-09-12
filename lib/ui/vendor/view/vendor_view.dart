import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_details.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_vm.dart';
import 'package:invoiceninja_flutter/ui/vendor/view/vendor_view_overview.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class VendorView extends StatefulWidget {
  const VendorView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final VendorViewVM viewModel;

  @override
  _VendorViewState createState() => _VendorViewState();
}

class _VendorViewState extends State<VendorView>
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

    return WillPopScope(
      onWillPop: () async {
        viewModel.onBackPressed();
        return true;
      },
      child: Scaffold(
        appBar: _CustomAppBar(
          viewModel: viewModel,
          controller: _controller,
        ),
        body: CustomTabBarView(
          viewModel: viewModel,
          controller: _controller,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () => viewModel.onAddExpensePressed(context),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          tooltip: localization.create,
        ),
      ),
    );
  }
}

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({
    @required this.viewModel,
    @required this.controller,
  });

  final VendorViewVM viewModel;
  final TabController controller;

  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return TabBarView(
      controller: widget.controller,
      children: <Widget>[
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: VendorOverview(viewModel: viewModel),
        ),
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: VendorViewDetails(vendor: viewModel.vendor),
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    @required this.viewModel,
    @required this.controller,
  });

  final VendorViewVM viewModel;
  final TabController controller;

  @override
  final Size preferredSize = const Size(double.infinity, kToolbarHeight * 2);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final vendor = viewModel.vendor;
    final user = viewModel.state.user;

    return AppBar(
      automaticallyImplyLeading: isMobile(context),
      title: EntityStateTitle(entity: vendor),
      bottom: TabBar(
        controller: controller,
        //isScrollable: true,
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: localization.details,
          ),
        ],
      ),
      actions: vendor.isNew
          ? []
          : [
              user.canEditEntity(vendor)
                  ? EditIconButton(
                      isVisible: !vendor.isDeleted,
                      onPressed: () => viewModel.onEditPressed(context),
                    )
                  : Container(),
              ActionMenuButton(
                user: viewModel.state.user,
                isSaving: viewModel.isSaving,
                entity: vendor,
                onSelected: viewModel.onEntityAction,
                entityActions: viewModel.vendor.getActions(user: user),
              )
            ],
    );
  }
}
