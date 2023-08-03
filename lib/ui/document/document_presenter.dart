// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/presenters/entity_presenter.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DocumentPresenter extends EntityPresenter {
  static List<String> getDefaultTableFields(UserCompanyEntity userCompany) {
    return [
      DocumentFields.name,
      DocumentFields.type,
      DocumentFields.size,
      DocumentFields.width,
      DocumentFields.height,
    ];
  }

  static List<String> getAllTableFields(UserCompanyEntity userCompany) {
    return [
      ...getDefaultTableFields(userCompany),
      ...EntityPresenter.getBaseFields(),
      DocumentFields.id,
      DocumentFields.updatedAt,
      DocumentFields.archivedAt,
      DocumentFields.isDeleted,
      DocumentFields.hash,
    ];
  }

  @override
  Widget getField({String field, BuildContext context}) {
    final document = entity as DocumentEntity;
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);
    final state = store.state;

    switch (field) {
      case DocumentFields.name:
        return Text(document.name);
    }

    return super.getField(field: field, context: context);
  }
}
