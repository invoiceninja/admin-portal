// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer.dart';

class HistoryDrawerBuilder extends StatelessWidget {
  const HistoryDrawerBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppDrawerVM>(
      converter: AppDrawerVM.fromStore,
      builder: (context, viewModel) {
        return HistoryDrawer(viewModel: viewModel);
      },
    );
  }
}

class AppDrawerVM {
  AppDrawerVM({
    required this.companies,
    required this.selectedCompany,
    required this.user,
    required this.isLoading,
  });

  final List<CompanyEntity?> companies;
  final CompanyEntity? selectedCompany;
  final UserEntity? user;
  final bool isLoading;

  static AppDrawerVM fromStore(Store<AppState> store) {
    final AppState state = store.state;

    return AppDrawerVM(
      isLoading: state.isLoading,
      companies: state.companies,
      user: state.user,
      selectedCompany: state.company,
    );
  }
}
