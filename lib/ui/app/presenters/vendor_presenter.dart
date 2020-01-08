import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';

class VendorPresenter extends EntityPresenter {
  static List<String> getTableFields(UserCompanyEntity userCompany) {
    return [
      VendorFields.name,
      EntityFields.state,
    ];
  }

  @override
  String getField({String field, BuildContext context}) {
    final vendor = entity as VendorEntity;

    switch (field) {
      case VendorFields.name:
        return vendor.name;
    }

    return super.getField(field: field, context: context);
  }
}
