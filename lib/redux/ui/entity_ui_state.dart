import 'package:invoiceninja/redux/ui/list_ui_state.dart';

abstract class EntityUIState {

  bool get isSelectedNew;
  ListUIState get listUIState;
  String get dropdownFilter;
}