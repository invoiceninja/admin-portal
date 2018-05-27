import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:invoiceninja/data/models/models.dart';
import 'package:invoiceninja/data/models/entities.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  LoginResponse,
  DashboardResponse,
  ProductListResponse,
  ProductItemResponse,
])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();