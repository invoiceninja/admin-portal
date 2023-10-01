// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/edit_scaffold.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_desktop.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_details.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_notes.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_settings.dart';
import 'package:invoiceninja_flutter/ui/expense/edit/expense_edit_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ExpenseEdit extends StatefulWidget {
  const ExpenseEdit({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AbstractExpenseEditVM viewModel;

  @override
  _ExpenseEditState createState() => _ExpenseEditState();
}

class _ExpenseEditState extends State<ExpenseEdit>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: '_expenseEdit');

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _onSavePressed(BuildContext context, [EntityAction? action]) {
    // Gives the exchange rate conversion a change to calculate
    // after the field loses focus
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      final bool isValid = _formKey.currentState!.validate();

      /*
        setState(() {
          autoValidate = !isValid ?? false;
        });
         */

      if (!isValid) {
        return;
      }

      widget.viewModel.onSavePressed!(context, action);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final expense = viewModel.expense!;
    final state = viewModel.state!;
    final store = StoreProvider.of<AppState>(context);
    final client = state.clientState.get(expense.clientId ?? '');
    final prefState = state.prefState;
    final isFullscreen = prefState.isEditorFullScreen(EntityType.expense);
    final footer = localization.expenseTotal +
        ': ' +
        formatNumber(expense.grossAmount, context,
            currencyId: expense.currencyId)!;

    return EditScaffold(
      isFullscreen: isFullscreen,
      entity: expense,
      title: expense.isRecurring
          ? (expense.isNew
              ? localization.newRecurringExpense
              : localization.editRecurringExpense)
          : (expense.isNew
              ? localization.newExpense
              : localization.editExpense),
      onCancelPressed: (context) => viewModel.onCancelPressed!(context),
      onSavePressed: (context) => _onSavePressed(context),
      actions: expense.getActions(
        userCompany: state.userCompany,
        client: client,
      ),
      onActionPressed: (context, action) => _onSavePressed(context, action),
      appBarBottom: TabBar(
        controller: _controller,
        //isScrollable: true,
        tabs: [
          Tab(
            text: localization.details,
          ),
          Tab(
            text: localization.notes,
          ),
          Tab(
            text: localization.settings,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: isFullscreen
            ? ExpenseEditDesktop(
                viewModel: viewModel,
                key: ValueKey('__expense_${expense.id}_${expense.updatedAt}__'),
              )
            : TabBarView(
                key: ValueKey('__expense_${expense.id}_${expense.updatedAt}__'),
                controller: _controller,
                children: <Widget>[
                  ExpenseEditDetails(
                    viewModel: widget.viewModel,
                  ),
                  ExpenseEditNotes(
                    viewModel: widget.viewModel,
                  ),
                  ExpenseEditSettings(
                    viewModel: widget.viewModel,
                  ),
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).cardColor,
        shape: CircularNotchedRectangle(),
        child: SizedBox(
          height: kTopBottomBarHeight,
          child: AppBorder(
            isTop: true,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isDesktop(context))
                  Tooltip(
                    message: isFullscreen
                        ? localization.sidebarEditor
                        : localization.fullscreenEditor,
                    child: InkWell(
                      onTap: () => store
                          .dispatch(ToggleEditorLayout(EntityType.expense)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(isFullscreen
                            ? Icons.chevron_right
                            : Icons.chevron_left),
                      ),
                    ),
                  ),
                AppBorder(
                  isLeft: isDesktop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          expense.number.isEmpty
                              ? footer
                              : '${expense.number} • $footer',
                          style: TextStyle(
                            color: viewModel.state!.prefState.enableDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20.0,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
