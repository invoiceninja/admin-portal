import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/ui/app/actions_menu_button.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/edit_icon_button.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_state_title.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_details.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_documents.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_overview.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final ExpenseViewVM viewModel;

  @override
  _ExpenseViewState createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
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
        floatingActionButton: Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColorDark,
            onPressed: () async {
              final image =
                  await ImagePicker.pickImage(source: ImageSource.camera);
              viewModel.onFileUpload(context, image.path);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            tooltip: localization.create,
          );
        }),
      ),
    );
  }
}

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({
    @required this.viewModel,
    @required this.controller,
  });

  final ExpenseViewVM viewModel;
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
          child: ExpenseOverview(viewModel: viewModel),
        ),
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: ExpenseViewDetails(expense: viewModel.expense),
        ),
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: ExpenseViewDocuments(
              viewModel: viewModel, expense: viewModel.expense),
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

  final ExpenseViewVM viewModel;
  final TabController controller;

  @override
  final Size preferredSize = const Size(double.infinity, kToolbarHeight * 2);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final expense = viewModel.expense;
    final user = viewModel.company.user;

    return AppBar(
      title: EntityStateTitle(
        entity: expense,
        title: expense.publicNotes.isNotEmpty
            ? expense.publicNotes
            : localization.expense,
      ),
      // Text(localizations.expenseDetails),
      bottom: TabBar(
        controller: controller,
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
      actions: expense.isNew
          ? []
          : [
              user.canEditEntity(expense)
                  ? EditIconButton(
                      isVisible: !expense.isDeleted,
                      onPressed: () => viewModel.onEditPressed(context),
                    )
                  : Container(),
              ActionMenuButton(
                user: viewModel.company.user,
                isSaving: viewModel.isSaving,
                entity: expense,
                onSelected: viewModel.onEntityAction,
                entityActions: viewModel.expense.getActions(user: user),
              )
            ],
    );
  }
}
