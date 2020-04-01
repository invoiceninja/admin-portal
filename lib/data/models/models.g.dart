// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EntityAction _$edit = const EntityAction._('edit');
const EntityAction _$archive = const EntityAction._('archive');
const EntityAction _$delete = const EntityAction._('delete');
const EntityAction _$restore = const EntityAction._('restore');
const EntityAction _$remove = const EntityAction._('remove');
const EntityAction _$clone = const EntityAction._('clone');
const EntityAction _$cloneToCredit = const EntityAction._('cloneToCredit');
const EntityAction _$cloneToInvoice = const EntityAction._('cloneToInvoice');
const EntityAction _$cloneToQuote = const EntityAction._('cloneToQuote');
const EntityAction _$convert = const EntityAction._('convert');
const EntityAction _$approve = const EntityAction._('approve');
const EntityAction _$download = const EntityAction._('download');
const EntityAction _$sendEmail = const EntityAction._('sendEmail');
const EntityAction _$markSent = const EntityAction._('markSent');
const EntityAction _$markPaid = const EntityAction._('markPaid');
const EntityAction _$newClient = const EntityAction._('newClient');
const EntityAction _$newInvoice = const EntityAction._('newInvoice');
const EntityAction _$newQuote = const EntityAction._('newQuote');
const EntityAction _$newCredit = const EntityAction._('newCredit');
const EntityAction _$newExpense = const EntityAction._('newExpense');
const EntityAction _$newProject = const EntityAction._('newProject');
const EntityAction _$newTask = const EntityAction._('newTask');
const EntityAction _$viewInvoice = const EntityAction._('viewInvoice');
const EntityAction _$viewQuote = const EntityAction._('viewQuote');
const EntityAction _$clientPortal = const EntityAction._('clientPortal');
const EntityAction _$newPayment = const EntityAction._('newPayment');
const EntityAction _$settings = const EntityAction._('settings');
const EntityAction _$refund = const EntityAction._('refund');
const EntityAction _$pdf = const EntityAction._('pdf');
const EntityAction _$more = const EntityAction._('more');
const EntityAction _$start = const EntityAction._('start');
const EntityAction _$resume = const EntityAction._('resume');
const EntityAction _$stop = const EntityAction._('stop');
const EntityAction _$toggleMultiselect =
    const EntityAction._('toggleMultiselect');

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
    case 'remove':
      return _$remove;
    case 'clone':
      return _$clone;
    case 'cloneToCredit':
      return _$cloneToCredit;
    case 'cloneToInvoice':
      return _$cloneToInvoice;
    case 'cloneToQuote':
      return _$cloneToQuote;
    case 'convert':
      return _$convert;
    case 'approve':
      return _$approve;
    case 'download':
      return _$download;
    case 'sendEmail':
      return _$sendEmail;
    case 'markSent':
      return _$markSent;
    case 'markPaid':
      return _$markPaid;
    case 'newClient':
      return _$newClient;
    case 'newInvoice':
      return _$newInvoice;
    case 'newQuote':
      return _$newQuote;
    case 'newCredit':
      return _$newCredit;
    case 'newExpense':
      return _$newExpense;
    case 'newProject':
      return _$newProject;
    case 'newTask':
      return _$newTask;
    case 'viewInvoice':
      return _$viewInvoice;
    case 'viewQuote':
      return _$viewQuote;
    case 'clientPortal':
      return _$clientPortal;
    case 'newPayment':
      return _$newPayment;
    case 'settings':
      return _$settings;
    case 'refund':
      return _$refund;
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
    case 'toggleMultiselect':
      return _$toggleMultiselect;
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
  _$remove,
  _$clone,
  _$cloneToCredit,
  _$cloneToInvoice,
  _$cloneToQuote,
  _$convert,
  _$approve,
  _$download,
  _$sendEmail,
  _$markSent,
  _$markPaid,
  _$newClient,
  _$newInvoice,
  _$newQuote,
  _$newCredit,
  _$newExpense,
  _$newProject,
  _$newTask,
  _$viewInvoice,
  _$viewQuote,
  _$clientPortal,
  _$newPayment,
  _$settings,
  _$refund,
  _$pdf,
  _$more,
  _$start,
  _$resume,
  _$stop,
  _$toggleMultiselect,
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
