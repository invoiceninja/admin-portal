import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/group/view/group_view_vm.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class GroupView extends StatefulWidget {
  const GroupView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final GroupViewVM viewModel;

  @override
  _GroupViewState createState() => new _GroupViewState();
}

class _GroupViewState extends State<GroupView>
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
    final userCompany = viewModel.state.userCompany;
    final group = viewModel.group;

    return Scaffold(
      appBar: AppBar(
        leading: !isMobile(context)
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: viewModel.onBackPressed,
              )
            : null,
        title: EntityStateTitle(entity: group),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              text: localization.settings,
            ),
            Tab(
              text: localization.clients,
            ),
          ],
        ),
        actions: [
          userCompany.canEditEntity(group)
              ? EditIconButton(
                  isVisible: !(group.isDeleted ?? false), // TODO remove this
                  onPressed: () => viewModel.onEditPressed(context),
                )
              : Container(),
          ActionMenuButton(
            entityActions: group.getActions(userCompany: userCompany),
            isSaving: viewModel.isSaving,
            entity: group,
            onSelected: viewModel.onEntityAction,
          )
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          ListView(),
          ListView(),
        ],
      ),
    );
  }
}
