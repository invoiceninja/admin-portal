// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    this.tabs,
    this.controller,
    this.isScrollable = false,
    this.onTap,
  });

  final List<Widget>? tabs;
  final TabController? controller;
  final bool isScrollable;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final tabBar = TabBar(
      tabs: tabs!,
      controller: controller,
      isScrollable: isScrollable,
      indicatorColor: Theme.of(context).colorScheme.secondary,
      onTap: onTap,
    );

    if (state.prefState.enableDarkMode || !state.hasAccentColor) {
      return tabBar;
    }

    return Theme(
      data: ThemeData(
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black.withOpacity(.65),
        ),
      ),
      child: tabBar,
    );
  }
}
