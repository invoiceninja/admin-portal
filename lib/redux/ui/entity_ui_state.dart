import 'package:invoiceninja_flutter/redux/ui/list_ui_state.dart';

abstract class EntityUIState {

  bool get isCreatingNew;
  int get selectedId;
  ListUIState get listUIState;
}