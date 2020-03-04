import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/design/design_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entities/entity_actions_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/design/design_list_item.dart';
import 'package:invoiceninja_flutter/ui/design/design_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class DesignList extends StatefulWidget {
  const DesignList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DesignListVM viewModel;

  @override
  _DesignListState createState() => _DesignListState();
}

class _DesignListState extends State<DesignList> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final state = viewModel.state;
    final listUIState = state.uiState.designUIState.listUIState;
    final isInMultiselect = listUIState.isInMultiselect();

    if (!viewModel.isLoaded) {
      return viewModel.isLoading ? LoadingIndicator() : SizedBox();
    } else if (viewModel.designMap.isEmpty) {
      return HelpText(AppLocalization.of(context).noRecordsFound);
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.separated(
          separatorBuilder: (context, index) => ListDivider(),
          itemCount: viewModel.designList.length,
          itemBuilder: (BuildContext context, index) {
            final designId = viewModel.designList[index];
            final design = viewModel.designMap[designId];

            return DesignListItem(
              user: viewModel.state.user,
              filter: viewModel.filter,
              design: design,
              onEntityAction: (EntityAction action) {
                if (action == EntityAction.more) {
                  showEntityActionsDialog(
                    entities: [design],
                    context: context,
                  );
                } else {
                  handleDesignAction(context, [design], action);
                }
              },
              onTap: () => viewModel.onDesignTap(context, design),
              onLongPress: () async {
                final longPressIsSelection =
                    state.prefState.longPressSelectionIsDefault ?? true;
                if (longPressIsSelection && !isInMultiselect) {
                  handleDesignAction(
                      context, [design], EntityAction.toggleMultiselect);
                } else {
                  showEntityActionsDialog(
                    entities: [design],
                    context: context,
                  );
                }
              },
              isChecked: isInMultiselect && listUIState.isSelected(design.id),
            );
          }),
    );
  }
}
