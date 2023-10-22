// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/expense/expense_actions.dart';
import 'package:invoiceninja_flutter/ui/app/document_grid.dart';
import 'package:invoiceninja_flutter/ui/app/form_card.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ExpenseEditNotes extends StatefulWidget {
  const ExpenseEditNotes({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AbstractExpenseEditVM viewModel;

  @override
  ExpenseEditNotesState createState() => new ExpenseEditNotesState();
}

class ExpenseEditNotesState extends State<ExpenseEditNotes> {
  final _publicNotesController = TextEditingController();
  final _privateNotesController = TextEditingController();

  late List<TextEditingController> _controllers;
  final _debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    _controllers = [
      _publicNotesController,
      _privateNotesController,
    ];

    _controllers
        .forEach((dynamic controller) => controller.removeListener(_onChanged));

    final expense = widget.viewModel.expense!;
    _publicNotesController.text = expense.publicNotes;
    _privateNotesController.text = expense.privateNotes;

    _controllers
        .forEach((dynamic controller) => controller.addListener(_onChanged));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllers.forEach((dynamic controller) {
      controller.removeListener(_onChanged);
      controller.dispose();
    });

    super.dispose();
  }

  void _onChanged() {
    final viewModel = widget.viewModel;
    final expense = viewModel.expense!.rebuild((b) => b
      ..publicNotes = _publicNotesController.text.trim()
      ..privateNotes = _privateNotesController.text.trim());
    if (expense != viewModel.expense) {
      _debouncer.run(() {
        viewModel.onChanged!(expense);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final state = viewModel.state!;
    final expense = viewModel.expense;
    final isFullscreen = state.prefState.isEditorFullScreen(EntityType.expense);
    final company = state.company;

    final showDocuments = isDesktop(context) &&
        state.isEnterprisePlan &&
        company.isModuleEnabled(EntityType.document);

    return ScrollableListView(
      children: <Widget>[
        FormCard(
          padding: isFullscreen
              ? const EdgeInsets.only(
                  left: kMobileDialogPadding / 2,
                  top: kMobileDialogPadding,
                  right: kMobileDialogPadding / 2,
                )
              : null,
          children: <Widget>[
            DecoratedFormField(
              maxLines: showDocuments ? 6 : 10,
              controller: _publicNotesController,
              keyboardType: TextInputType.multiline,
              label: localization.publicNotes,
            ),
            DecoratedFormField(
              maxLines: showDocuments ? 6 : 10,
              controller: _privateNotesController,
              keyboardType: TextInputType.multiline,
              label: localization.privateNotes,
            ),
            if (showDocuments)
              if (expense!.isNew || state.hasChanges())
                SizedBox(
                  child: HelpText(localization.saveToUploadDocuments),
                  height: 200,
                )
              else ...[
                SizedBox(height: 8),
                DocumentGrid(
                  documents: expense.documents.toList(),
                  onUploadDocument: (path, isPrivate) => widget
                      .viewModel.onUploadDocument!(context, path, isPrivate),
                  onRenamedDocument: () =>
                      store.dispatch(LoadExpense(expenseId: expense.id)),
                )
              ]
          ],
        ),
      ],
    );
  }
}
