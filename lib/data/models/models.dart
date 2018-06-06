export 'package:invoiceninja/data/models/entities.dart';
export 'package:invoiceninja/data/models/product_model.dart';
export 'package:invoiceninja/data/models/client_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'models.g.dart';

class EntityAction extends EnumClass {
  static Serializer<EntityAction> get serializer => _$entityActionSerializer;

  static const EntityAction archive = _$archive;
  static const EntityAction delete = _$delete;
  static const EntityAction restore = _$restore;
  static const EntityAction clone = _$clone;
  static const EntityAction download = _$download;
  static const EntityAction invoice = _$invoice;

  const EntityAction._(String name) : super(name);

  static BuiltSet<EntityAction> get values => _$values;
  static EntityAction valueOf(String name) => _$valueOf(name);
}

