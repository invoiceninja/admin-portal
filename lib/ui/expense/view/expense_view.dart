import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
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
    final company = viewModel.state.company;
    final expense = viewModel.expense;
    final documentState = viewModel.state.documentState;
    final documents =
        memoizedExpenseDocumentsSelector(documentState.map, viewModel.expense);

    return ViewScaffold(
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
            text: documents.isEmpty
                ? localization.documents
                : '${localization.documents} (${documents.length})',
          ),
        ],
      ),
      body: TabBarView(
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
      ),
      floatingActionButton: company.isEnterprisePlan
          ? Builder(builder: (BuildContext context) {
              return FloatingActionButton(
                heroTag: 'expense_fab',
                backgroundColor: Theme.of(context).primaryColorDark,
                onPressed: () async {
                  final image =
                      await ImagePicker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    viewModel.onUploadDocument(context, image.path);
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
