// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';

class AppForm extends StatelessWidget {
  const AppForm({
    this.children,
    this.child,
    required this.formKey,
    required this.focusNode,
  });

  final GlobalKey<FormState> formKey;
  final List<Widget>? children;
  final Widget? child;
  final FocusScopeNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: focusNode,
      child: Form(
        key: formKey,
        child: child ??
            ScrollableListView(
              primary: true,
              children: children,
            ),
      ),
    );
  }
}

class AppTabForm extends StatelessWidget {
  const AppTabForm({
    required this.children,
    required this.formKey,
    required this.focusNode,
    required this.tabController,
    this.tabBarKey,
  });

  final FocusScopeNode? focusNode;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final TabController? tabController;
  final Key? tabBarKey;

  @override
  Widget build(BuildContext context) {
    final state = StoreProvider.of<AppState>(context).state;

    return FocusScope(
      node: focusNode,
      child: Form(
        key: formKey,
        child: TabBarView(
          key: tabBarKey ?? ValueKey(state.settingsUIState.updatedAt),
          children: children,
          controller: tabController,
        ),
      ),
    );
  }
}
