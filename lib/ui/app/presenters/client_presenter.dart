import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class ClientPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      ClientFields.name,
      ClientFields.address1,
      EntityFields.state,
    ];
  }

  @override
  String getField({String field, BuildContext context}) {
    final client = entity as ClientEntity;

    switch (field) {
      case ClientFields.name:
        return client.name;
      case ClientFields.address1:
        return client.address1;
    }

    return super.getField(field: field, context: context);
  }
}
