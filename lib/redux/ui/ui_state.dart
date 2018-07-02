import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/redux/client/client_state.dart';
import 'package:invoiceninja/redux/invoice/invoice_state.dart';
import 'package:invoiceninja/redux/product/product_state.dart';
import 'package:invoiceninja/ui/auth/login_vm.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {

  factory UIState() {
    return _$UIState._(
      selectedCompanyIndex: 0,
      currentRoute: LoginScreen.route,
      productUIState: ProductUIState(),
      clientUIState: ClientUIState(),
      invoiceUIState: InvoiceUIState(),
    );
  }
  UIState._();

  int get selectedCompanyIndex;
  String get currentRoute;
  ProductUIState get productUIState;
  ClientUIState get clientUIState;
  InvoiceUIState get invoiceUIState;

  //factory UIState([void updates(UIStateBuilder b)]) = _$UIState;
  static Serializer<UIState> get serializer => _$uIStateSerializer;
}

