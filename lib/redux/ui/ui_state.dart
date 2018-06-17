import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:invoiceninja/data/models/invoice_model.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/redux/ui/entity_ui_state.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {

  String get currentRoute;
  EntityUIState get productUIState;
  EntityUIState get clientUIState;
  EntityUIState get invoiceUIState;

  factory UIState() {
    return _$UIState._(
      currentRoute: '/',
      productUIState: EntityUIState(ProductFields.productKey),
      clientUIState: EntityUIState(ClientFields.name),
      invoiceUIState: EntityUIState(InvoiceFields.invoiceNumber),
    );
  }

  UIState._();
  //factory UIState([updates(UIStateBuilder b)]) = _$UIState;
  static Serializer<UIState> get serializer => _$uIStateSerializer;
}

