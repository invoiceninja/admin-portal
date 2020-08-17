import 'package:invoiceninja_flutter/data/models/serializers.dart';

class SerializationUtils {
  static dynamic computeDecode(dynamic list) {
    return serializers.deserializeWith<dynamic>(list[0], list[1]);
  }

  static dynamic computeEncode(dynamic list) {
    return serializers.serializeWith<dynamic>(list[0], list[1]);
  }
}
