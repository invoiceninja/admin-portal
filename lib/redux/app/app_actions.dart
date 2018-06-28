import 'package:invoiceninja/data/models/entities.dart';

class PersistUI {}
class PersistData {}

class StartLoading {}
class StopLoading {}

class LoadStaticSuccess {
  final StaticData data;

  LoadStaticSuccess(this.data);
}