import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_details.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_documents.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_vm.dart';
import 'package:invoiceninja_flutter/ui/expense/view/expense_view_overview.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final ExpenseViewVM viewModel;
  final bool isFilter;

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
    final expense = viewModel.expense;

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: expense,
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
            text: expense.documents.isEmpty
                ? localization.documents
                : '${localization.documents} (${expense.documents.length})',
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return TabBarView(
          controller: _controller,
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
      }),
      floatingActionButton: viewModel.state.isEnterprisePlan
          ? Builder(builder: (BuildContext context) {
              return FloatingActionButton(
                heroTag: 'expense_fab',
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () async {
                  String path;
                  if (kIsWeb) {
                    path = await WebUtils.filePicker();
                  } else {
                    final image = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    if (image != null) {
                      path = image.path;
                    }
                  }
                  if (path != null) {
                    viewModel.onUploadDocument(context, path);
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
