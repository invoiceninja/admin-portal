// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/document/document_selectors.dart';
import 'document_screen.dart';

class DocumentScreenBuilder extends StatelessWidget {
  const DocumentScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DocumentScreenVM>(
      converter: DocumentScreenVM.fromStore,
      builder: (context, vm) {
        return DocumentScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class DocumentScreenVM {
  DocumentScreenVM({
    required this.isInMultiselect,
    required this.documentList,
    required this.userCompany,
    required this.documentMap,
  });

  final bool isInMultiselect;
  final UserCompanyEntity? userCompany;
  final List<String> documentList;
  final BuiltMap<String, DocumentEntity> documentMap;

  static DocumentScreenVM fromStore(Store<AppState> store) {
    final state = store.state;

    return DocumentScreenVM(
      documentMap: state.documentState.map,
      documentList: memoizedFilteredDocumentList(
        state.getUISelection(EntityType.document),
        state.documentState.map,
        state.documentState.list,
        state.documentListState,
      ),
      userCompany: state.userCompany,
      isInMultiselect: state.documentListState.isInMultiselect(),
    );
  }
}
