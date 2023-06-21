import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/company_model.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_kit_plugin/user_defaults/user_defaults.dart';
import 'package:widget_kit_plugin/widget_kit/widget_kit.dart';
import 'package:window_manager/window_manager.dart';

class WindowManager extends StatefulWidget {
  const WindowManager({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  State<WindowManager> createState() => _WindowManagerState();
}

class _WindowManagerState extends State<WindowManager> with WindowListener {
  @override
  void initState() {
    if (isDesktopOS()) {
      windowManager.addListener(this);
      _initManager();
    }

    if (isApple()) {
      _initWidgets();
    }

    super.initState();
  }

  void _initManager() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  void _initWidgets() async {
    //print("## SET DATA");
    //await UserDefaults.setString('widgetData', 'hello', 'group.com.invoiceninja.app');
    //await WidgetKit.reloadAllTimelines();
  }

  @override
  void onWindowResize() async {
    if (!isDesktopOS()) {
      return;
    }

    final size = await windowManager.getSize();
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(kSharedPrefWidth, size.width);
    prefs.setDouble(kSharedPrefHeight, size.height);
  }

  @override
  void onWindowClose() async {
    if (!isDesktopOS()) {
      return;
    }

    final store = StoreProvider.of<AppState>(navigatorKey.currentContext);

    if (await windowManager.isPreventClose()) {
      checkForChanges(
        store: store,
        callback: () async {
          await windowManager.destroy();
        },
      );
    }
  }

  @override
  void dispose() {
    if (isDesktopOS()) {
      windowManager.removeListener(this);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class WidgetData {
  WidgetData({
    this.url,
    this.companies,
    this.companyId,
  });

  WidgetData.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        companyId = json['company_id'],
        companies = json['companies'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'companies': companies,
        'company_id': companyId,
        'url': url,
      };

  final String url;
  final String companyId;
  final Map<String, WidgetCompany> companies;
}

class WidgetCompany {
  WidgetCompany(
      {this.id,
      this.name,
      this.token,
      this.accentColor,
      this.currencyId,
      this.currencies});

  WidgetCompany.fromUserCompany(
      {UserCompanyState userCompanyState, StaticState staticState})
      : id = userCompanyState.userCompany.company.id,
        name = userCompanyState.userCompany.company.displayName,
        token = userCompanyState.userCompany.token.token,
        accentColor = userCompanyState.userCompany.settings.accentColor,
        currencyId = userCompanyState.userCompany.company.currencyId,
        currencies = {
          for (var currencyId in getCurrencyIds(
            userCompanyState.userCompany.company,
            userCompanyState.clientState.map,
            userCompanyState.groupState.map,
          ).where((currencyId) => currencyId != kCurrencyAll))
            currencyId: WidgetCurrency(
              id: currencyId,
              name: staticState.currencyMap[currencyId].name,
              exchangeRate: staticState.currencyMap[currencyId].exchangeRate,
            )
        };

  WidgetCompany.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        token = json['token'],
        accentColor = json['accent_color'],
        currencies = json['currencies'],
        currencyId = json['currency_id'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'token': token,
        'accent_color': accentColor,
        'currencies': currencies,
        'currency_id': currencyId,
      };

  final String id;
  final String name;
  final String token;
  final String accentColor;
  final String currencyId;
  final Map<String, WidgetCurrency> currencies;
}

class WidgetCurrency {
  WidgetCurrency({this.id, this.name, this.exchangeRate});

  WidgetCurrency.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        exchangeRate = json['exchange_rate'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'exchange_rate': exchangeRate,
      };

  final String id;
  final String name;
  final double exchangeRate;
}
