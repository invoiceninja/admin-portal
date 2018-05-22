import 'package:flutter/widgets.dart';

class NinjaKeys {

  static final snackbar = const Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  static final dashboard = const Key('__dashboard__');
  static final loginScreen = const Key('__login_screen__');
  static final clientList = const Key('__client_list__');
  static final productHome = const Key('__product_home__');

  static final productList = const Key('__product_list__');
  static final productItem = (int id) => Key('ProductItem__${id}');
  static final productItemCheckbox = (int id) => Key('ProductItem__${id}__Checkbox');
  static final productItemProductKey = (int id) => Key('ProductItem__${id}__ProductKey');

  static final detailsProductItemNote = Key('DetailsProduct__Note');
}