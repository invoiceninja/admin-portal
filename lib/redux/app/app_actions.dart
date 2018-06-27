import 'package:invoiceninja/data/models/entities.dart';

class PersistData {}
class PersistUI {}

class StartLoading {}
class StopLoading {}

class LoadStaticSuccess {
  final StaticData data;

  LoadStaticSuccess(this.data);
}