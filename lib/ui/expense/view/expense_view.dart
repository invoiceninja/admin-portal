// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/redux/recurring_expense/recurring_expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_documents.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_overview.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_schedule.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
    @required this.tabIndex,
  }) : super(key: key);

  final AbstractExpenseViewVM viewModel;
  final bool isFilter;
  final int tabIndex;

  @override
  _ExpenseViewState createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();

    final viewModel = widget.viewModel;
    final state = viewModel.state;
    _controller = TabController(
        vsync: this,
        length: viewModel.expense.isRecurring ? 3 : 2,
        initialIndex: widget.isFilter ? 0 : state.expenseUIState.tabIndex);
    _controller.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    final expense = widget.viewModel.expense;

    if (expense.isRecurring) {
      store.dispatch(UpdateRecurringExpenseTab(tabIndex: _controller.index));
    } else {
      store.dispatch(UpdateExpenseTab(tabIndex: _controller.index));
    }
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
    final expense = viewModel.expense;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: expense,
      appBarBottom: TabBar(
        controller: _controller,
        isScrollable: isMobile(context),
        tabs: [
          Tab(
            text: localization.overview,
          ),
          Tab(
            text: expense.documents.isEmpty
                ? localization.documents
                : '${localization.documents} (${expense.documents.length})',
          ),
          if (expense.isRecurring)
            Tab(
              text: localization.schedule,
            )
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
                    child: ExpenseOverview(
                      viewModel: viewModel,
                      isFilter: widget.isFilter,
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: ExpenseViewDocuments(
                        viewModel: viewModel, expense: viewModel.expense),
                  ),
                  if (expense.isRecurring)
                    RefreshIndicator(
                      onRefresh: () => viewModel.onRefreshed(context),
                      child: ExpenseViewSchedule(viewModel: viewModel),
                    ),
                ],
              ),
            ),
            BottomButtons(
              entity: expense,
              action1: expense.isRecurring
                  ? (expense.canBeStopped
                      ? EntityAction.stop
                      : EntityAction.start)
                  : EntityAction.invoiceExpense,
              action1Enabled: !expense.isInvoiced ||
                  (expense.isRecurring &&
                      (expense.canBeStarted || expense.canBeStopped)),
              action2: expense.isRecurring
                  ? EntityAction.cloneToRecurring
                  : EntityAction.cloneToExpense,
            )
          ],
        );
      }),
      floatingActionButton: viewModel.state.isEnterprisePlan
          ? Builder(builder: (BuildContext context) {
              return FloatingActionButton(
                heroTag: 'expense_fab',
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () async {
                  MultipartFile multipartFile;
                  if (kIsWeb) {
                    multipartFile = await pickFile();
                  } else {
                    final status = await Permission.camera.request();
                    if (status == PermissionStatus.granted) {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image != null && image.path != null) {
                        final croppedFile = await ImageCropper()
                            .cropImage(sourcePath: image.path);
                        final bytes = await croppedFile.readAsBytes();
                        multipartFile = MultipartFile.fromBytes('file', bytes,
                            filename: image.path.split('/').last);
                      }
                    } else {
                      openAppSettings();
                    }
                  }
                  if (multipartFile != null) {
                    viewModel.onUploadDocument(
                        navigatorKey.currentContext, multipartFile);
                  }
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                tooltip: localization.create,
              );
            })
          : null,
    );
  }
}
