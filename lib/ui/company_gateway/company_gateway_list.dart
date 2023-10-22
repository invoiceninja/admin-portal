// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_item.dart';
import 'package:invoiceninja_flutter/ui/company_gateway/company_gateway_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class CompanyGatewayList extends StatefulWidget {
  const CompanyGatewayList({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final CompanyGatewayListVM viewModel;

  @override
  _CompanyGatewayListState createState() => _CompanyGatewayListState();
}

class _CompanyGatewayListState extends State<CompanyGatewayList> {
  // TODO remove this https://github.com/flutter/flutter/issues/71946
  ScrollController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final listUIState = state.uiState.companyGatewayUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();
    final viewModel = widget.viewModel;

    if (!viewModel.state.isLoaded) {
      return LoadingIndicator();
    }

    if (viewModel.companyGatewayList.isEmpty) {
      return Center(
          child: HelpText(AppLocalization.of(context)!.noRecordsFound));
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        if (state.isSaving) LinearProgressIndicator(),
        RefreshIndicator(
          onRefresh: () => widget.viewModel.onRefreshed(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ReorderableListView(
              scrollController: _controller,
              onReorder: (oldIndex, newIndex) {
                // https://stackoverflow.com/a/54164333/497368
                // These two lines are workarounds for ReorderableListView problems
                if (newIndex > widget.viewModel.companyGatewayList.length) {
                  newIndex = widget.viewModel.companyGatewayList.length;
                }
                if (oldIndex < newIndex) {
                  newIndex--;
                }

                widget.viewModel.onSortChanged(oldIndex, newIndex);
              },
              children:
                  widget.viewModel.companyGatewayList.map((companyGatewayId) {
                final companyGateway =
                    widget.viewModel.companyGatewayMap[companyGatewayId];
                return CompanyGatewayListItem(
                    key: ValueKey('__company_gateway_$companyGatewayId'),
                    user: state.userCompany.user,
                    filter: widget.viewModel.filter,
                    companyGateway: companyGateway,
                    onRemovePressed: widget
                            .viewModel.state.settingsUIState.isFiltered
                        ? () =>
                            widget.viewModel.onRemovePressed(companyGatewayId)
                        : null,
                    isChecked: isInMultiselect &&
                        listUIState.isSelected(companyGateway!.id));
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
