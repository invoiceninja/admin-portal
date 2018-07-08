import 'package:invoiceninja_flutter/data/models/entities.dart';

class PersistUI {}
class PersistData {}

class StartLoading {}
class StopLoading {}

class StartSaving {}
class StopSaving {}

class LoadStaticSuccess {
  final StaticData data;

  LoadStaticSuccess(this.data);
}