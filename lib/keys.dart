import 'package:flutter/widgets.dart';

class NinjaKeys {

  static final dashboard = const Key('__dashboard__');
  static final loginScreen = const Key('__login_screen__');
  static final clientList = const Key('__client_list__');

  static final productHome = const Key('__product_home__');
  static final productList = const Key('__product_list__');
  static final productItem = (int id) => Key('__product_item_${id}__');
}