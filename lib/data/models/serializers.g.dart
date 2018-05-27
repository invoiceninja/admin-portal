// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(CompanyEntity.serializer)
      ..add(DashboardEntity.serializer)
      ..add(DashboardResponse.serializer)
      ..add(ErrorMessage.serializer)
      ..add(LoginResponse.serializer)
      ..add(ProductEntity.serializer)
      ..add(ProductResponse.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CompanyEntity)]),
          () => new ListBuilder<CompanyEntity>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ProductEntity)]),
          () => new ListBuilder<ProductEntity>()))
    .build();
