// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

const EntityAction _$edit = const EntityAction._('edit');
const EntityAction _$archive = const EntityAction._('archive');
const EntityAction _$delete = const EntityAction._('delete');
const EntityAction _$restore = const EntityAction._('restore');
const EntityAction _$clone = const EntityAction._('clone');
const EntityAction _$cloneToInvoice = const EntityAction._('cloneToInvoice');
const EntityAction _$cloneToQuote = const EntityAction._('cloneToQuote');
const EntityAction _$convert = const EntityAction._('convert');
const EntityAction _$download = const EntityAction._('download');
const EntityAction _$sendEmail = const EntityAction._('sendEmail');
const EntityAction _$markSent = const EntityAction._('markSent');
const EntityAction _$newInvoice = const EntityAction._('newInvoice');
const EntityAction _$viewInvoice = const EntityAction._('viewInvoice');
const EntityAction _$clientPortal = const EntityAction._('clientPortal');
const EntityAction _$enterPayment = const EntityAction._('enterPayment');
const EntityAction _$pdf = const EntityAction._('pdf');
const EntityAction _$more = const EntityAction._('more');
const EntityAction _$start = const EntityAction._('start');
const EntityAction _$resume = const EntityAction._('resume');
const EntityAction _$stop = const EntityAction._('stop');

EntityAction _$valueOf(String name) {
  switch (name) {
    case 'edit':
      return _$edit;
    case 'archive':
      return _$archive;
    case 'delete':
      return _$delete;
    case 'restore':
      return _$restore;
    case 'clone':
      return _$clone;
    case 'cloneToInvoice':
      return _$cloneToInvoice;
    case 'cloneToQuote':
      return _$cloneToQuote;
    case 'convert':
      return _$convert;
    case 'download':
      return _$download;
    case 'sendEmail':
      return _$sendEmail;
    case 'markSent':
      return _$markSent;
    case 'newInvoice':
      return _$newInvoice;
    case 'viewInvoice':
      return _$viewInvoice;
    case 'clientPortal':
      return _$clientPortal;
    case 'enterPayment':
      return _$enterPayment;
    case 'pdf':
      return _$pdf;
    case 'more':
      return _$more;
    case 'start':
      return _$start;
    case 'resume':
      return _$resume;
    case 'stop':
      return _$stop;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EntityAction> _$values =
    new BuiltSet<EntityAction>(const <EntityAction>[
  _$edit,
  _$archive,
  _$delete,
  _$restore,
  _$clone,
  _$cloneToInvoice,
  _$cloneToQuote,
  _$convert,
  _$download,
  _$sendEmail,
  _$markSent,
  _$newInvoice,
  _$viewInvoice,
  _$clientPortal,
  _$enterPayment,
  _$pdf,
  _$more,
  _$start,
  _$resume,
  _$stop,
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
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  EntityAction deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EntityAction.valueOf(serialized as String);
}
