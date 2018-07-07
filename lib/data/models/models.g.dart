// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

const EntityAction _$archive = const EntityAction._('archive');
const EntityAction _$delete = const EntityAction._('delete');
const EntityAction _$restore = const EntityAction._('restore');
const EntityAction _$clone = const EntityAction._('clone');
const EntityAction _$download = const EntityAction._('download');
const EntityAction _$email = const EntityAction._('emailInvoice');
const EntityAction _$markSent = const EntityAction._('markSent');
const EntityAction _$invoice = const EntityAction._('invoice');
const EntityAction _$pdf = const EntityAction._('pdf');

EntityAction _$valueOf(String name) {
  switch (name) {
    case 'archive':
      return _$archive;
    case 'delete':
      return _$delete;
    case 'restore':
      return _$restore;
    case 'clone':
      return _$clone;
    case 'download':
      return _$download;
    case 'emailInvoice':
      return _$email;
    case 'markSent':
      return _$markSent;
    case 'invoice':
      return _$invoice;
    case 'pdf':
      return _$pdf;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EntityAction> _$values =
    new BuiltSet<EntityAction>(const <EntityAction>[
  _$archive,
  _$delete,
  _$restore,
  _$clone,
  _$download,
  _$email,
  _$markSent,
  _$invoice,
  _$pdf,
]);

Serializer<EntityAction> _$entityActionSerializer =
    new _$EntityActionSerializer();

class _$EntityActionSerializer implements PrimitiveSerializer<EntityAction> {
  @override
  final Iterable<Type> types = const <Type>[EntityAction];
  @override
  final String wireName = 'EntityAction';

  @override
  Object serialize(Serializers serializers, EntityAction object,
          {FullType specifiedType: FullType.unspecified}) =>
      object.name;

  @override
  EntityAction deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      EntityAction.valueOf(serialized as String);
}
