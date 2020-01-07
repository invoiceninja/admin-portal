import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';

class ClientPresenter extends EntityPresenter {
  @override
  String getField(String field) {
    final client = entity as ClientEntity;

    switch (field) {
      case ClientFields.name:
        return client.name;
    }

    return super.getField(field);
  }
}
