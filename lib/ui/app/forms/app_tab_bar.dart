import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    this.isScrollable,
    this.tabs,
    this.controller,
  });

  final List<Widget> tabs;
  final TabController controller;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final tabBar = TabBar(
      tabs: tabs,
      controller: controller,
      isScrollable: isScrollable,
      indicatorColor: Theme.of(context).accentColor,
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
