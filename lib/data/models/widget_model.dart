import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/dashboard_model.dart';
import 'package:invoiceninja_flutter/data/models/static/currency_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/company/company_selectors.dart';
import 'package:invoiceninja_flutter/redux/company/company_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_state.dart';
import 'package:invoiceninja_flutter/redux/static/static_state.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/strings.dart';

class WidgetData {
  WidgetData({
    this.url,
    this.companies,
    this.companyId,
    this.dateRanges,
    this.dashboardFields,
  });

  WidgetData.fromState(AppState state, AppLocalization? localization)
      : url = formatApiUrl(state.authState.url),
        companyId = state.account.defaultCompanyId,
        companies = {
          for (var userCompany in state.userCompanyStates
              .where((state) => state.company.hasName))
            userCompany.company.id: WidgetCompany.fromUserCompany(
              userCompanyState: userCompany,
              staticState: state.staticState,
            )
        },
        dashboardFields = Map.fromIterable(<String>[
          DashboardUISettings.FIELD_ACTIVE_INVOICES,
          DashboardUISettings.FIELD_OUTSTANDING_INVOICES,
          DashboardUISettings.FIELD_COMPLETED_PAYMENTS,
        ],
            key: (dynamic item) => item,
            value: (dynamic item) => localization!.lookup('$item')),
        dateRanges = Map.fromIterable(
            DateRange.values.where((value) => value != DateRange.custom),
            key: (dynamic item) => toSnakeCase('$item'),
            value: (dynamic item) =>
                localization!.lookup(toSnakeCase('$item')));

  WidgetData.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        companyId = json['company_id'],
        companies = json['companies'],
        dateRanges = json['date_ranges'],
        dashboardFields = json['dashboard_fields'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'companies': companies,
        'company_id': companyId,
        'url': url,
        'date_ranges': dateRanges,
        'dashboard_fields': dashboardFields,
      };

  final String? url;
  final String? companyId;
  final Map<String, WidgetCompany>? companies;
  final Map<String, String?>? dateRanges;
  final Map<String?, String?>? dashboardFields;
}

class WidgetCompany {
  WidgetCompany(
      {this.id,
      this.name,
      this.token,
      this.accentColor,
      this.firstMonthOfYear,
      this.currencyId,
      this.currencies});

  WidgetCompany.fromUserCompany(
      {required UserCompanyState userCompanyState, StaticState? staticState})
      : id = userCompanyState.userCompany.company.id,
        name = userCompanyState.userCompany.company.displayName,
        token = userCompanyState.userCompany.token.token,
        accentColor =
            userCompanyState.userCompany.settings.validatedAccentColor,
        firstMonthOfYear =
            parseInt(userCompanyState.userCompany.company.firstMonthOfYear),
        currencyId = userCompanyState.userCompany.company.currencyId,
        currencies = {
          for (var currencyId in getCurrencyIds(
            userCompanyState.userCompany.company,
            userCompanyState.clientState.map,
            userCompanyState.groupState.map,
          ).where((currencyId) => currencyId != kCurrencyAll))
            currencyId: WidgetCurrency.fromCurrency(
              staticState!.currencyMap[currencyId]!,
            )
        };

  WidgetCompany.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        token = json['token'],
        accentColor = json['accent_color'],
        currencies = json['currencies'],
        currencyId = json['currency_id'],
        firstMonthOfYear = json['first_month_of_year'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'token': token,
        'accent_color': accentColor,
        'currencies': currencies,
        'currency_id': currencyId,
        'first_month_of_year': firstMonthOfYear,
      };

  final String? id;
  final String? name;
  final String? token;
  final String? accentColor;
  final String? currencyId;
  final int? firstMonthOfYear;
  final Map<String, WidgetCurrency>? currencies;
}

class WidgetCurrency {
  WidgetCurrency({
    this.id,
    this.name,
    this.code,
    this.exchangeRate,
  });

  WidgetCurrency.fromCurrency(CurrencyEntity currency)
      : id = currency.id,
        name = currency.name,
        code = currency.code,
        exchangeRate = currency.exchangeRate;

  WidgetCurrency.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        code = json['code'],
        exchangeRate = json['exchange_rate'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'code': code,
        'exchange_rate': exchangeRate,
      };

  final String? id;
  final String? name;
  final String? code;
  final double? exchangeRate;
}
