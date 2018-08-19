import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja_flutter/redux/client/client_state.dart';
import 'package:invoiceninja_flutter/redux/invoice/invoice_state.dart';
import 'package:invoiceninja_flutter/redux/product/product_state.dart';
import 'package:invoiceninja_flutter/ui/auth/login_vm.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {

  factory UIState({bool enableDarkMode}) {
    return _$UIState._(
      selectedCompanyIndex: 0,
      currentRoute: LoginScreen.route,
      enableDarkMode: enableDarkMode ?? false,
      productUIState: ProductUIState(),
      clientUIState: ClientUIState(),
      invoiceUIState: InvoiceUIState(),
    );
  }
  UIState._();

  int get selectedCompanyIndex;
  String get currentRoute;
  bool get enableDarkMode;
  ProductUIState get productUIState;
  ClientUIState get clientUIState;
  InvoiceUIState get invoiceUIState;

  @nullable
  String get filter;

  //factory UIState([void updates(UIStateBuilder b)]) = _$UIState;
  static Serializer<UIState> get serializer => _$uIStateSerializer;
}

