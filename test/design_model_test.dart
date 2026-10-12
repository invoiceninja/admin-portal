import 'package:flutter_test/flutter_test.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/design_model.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';

void main() {
  group('DesignEntity deserialization', () {
    test('drops non-string design values (blocks array) instead of crashing',
        () {
      final raw = <Object?, Object?>{
        'id': 'x1',
        'name': 'Visual Design',
        'is_custom': true,
        'is_free': false,
        'is_template': false,
        'entities': 'invoice,quote',
        'created_at': 0,
        'updated_at': 0,
        'archived_at': 0,
        'design': <String, Object?>{
          'blocks': [
            {'type': 'text', 'properties': {'content': '\$company.name'}},
          ],
          'header': '<div>header</div>',
          'body': '<div>body</div>',
          'footer': '<div>footer</div>',
          'product': '',
          'task': '',
          'includes': '<style></style>',
        },
      };

      final entity = serializers.deserializeWith(DesignEntity.serializer, raw);

      expect(entity, isNotNull);
      expect(entity!.name, 'Visual Design');
      expect(entity.design[kDesignHeader], '<div>header</div>');
      expect(entity.design[kDesignBody], '<div>body</div>');
      expect(entity.design.containsKey('blocks'), isFalse);
    });

    test('design values that are strings still deserialize unchanged', () {
      final raw = <Object?, Object?>{
        'id': 'x2',
        'name': 'Plain',
        'is_custom': true,
        'is_free': true,
        'is_template': false,
        'entities': '',
        'created_at': 0,
        'updated_at': 0,
        'archived_at': 0,
        'design': <String, Object?>{
          'header': 'h',
          'body': 'b',
          'footer': 'f',
        },
      };

      final entity = serializers.deserializeWith(DesignEntity.serializer, raw);

      expect(entity, isNotNull);
      expect(entity!.design[kDesignHeader], 'h');
      expect(entity.design[kDesignBody], 'b');
      expect(entity.design[kDesignFooter], 'f');
    });
  });
}
