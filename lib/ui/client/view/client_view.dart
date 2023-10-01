// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/bottom_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/entity_top_filter.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_activity.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_details.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_documents.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_fullwidth.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_ledger.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_overview.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_system_logs.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ClientView extends StatefulWidget {
  const ClientView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
    required this.isTopFilter,
    required this.tabIndex,
  }) : super(key: key);

  final ClientViewVM viewModel;
  final bool isFilter;
  final bool isTopFilter;
  final int tabIndex;

  @override
  _ClientViewState createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    _controller = TabController(
        vsync: this,
        length: state.company.isModuleEnabled(EntityType.document) ? 6 : 5,
        initialIndex: widget.isFilter ? 0 : state.clientUIState.tabIndex);
    _controller!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (widget.isFilter) {
      return;
    }

    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateClientTab(tabIndex: _controller!.index));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex) {
      _controller!.index = widget.tabIndex;
    }
  }

  @override
  void dispose() {
    _controller!.removeListener(_onTabChanged);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final company = viewModel.state.company;
    final client = viewModel.client;
    final documents = client.documents;

    if (widget.isTopFilter) {
      return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EntityTopFilterHeader(),
            Expanded(
                child: AppBorder(
              isTop: true,
              isBottom: true,
              child: ClientViewFullwidth(
                viewModel: viewModel,
              ),
            )),
          ],
        ),
      );
    }

    return ViewScaffold(
      isFilter: widget.isFilter,
      entity: client,
      appBarBottom: TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: localization!.overview,
          ),
          Tab(
            text: localization.details,
          ),
          if (company.isModuleEnabled(EntityType.document))
            Tab(
              text: documents.isEmpty
                  ? localization.documents
                  : '${localization.documents} (${documents.length})',
            ),
          Tab(
            text: localization.ledger,
          ),
          Tab(
            text: localization.activity,
          ),
          Tab(
            text: localization.systemLogs,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: ClientOverview(
                      viewModel: viewModel,
                      isFilter: widget.isFilter,
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: ClientViewDetails(client: viewModel.client),
                  ),
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: ClientViewDocuments(
                      viewModel: viewModel,
                      key: ValueKey(viewModel.client.id),
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: ClientViewLedger(
                      viewModel: viewModel,
                      key: ValueKey(viewModel.client.id),
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: ClientViewActivity(
                      viewModel: viewModel,
                      key: ValueKey(viewModel.client.id),
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () => viewModel.onRefreshed(context),
                    child: ClientViewSystemLogs(
                      viewModel: viewModel,
                      key: ValueKey(viewModel.client.id),
                    ),
                  ),
                ],
              ),
            ),
            BottomButtons(
              entity: client,
              action1: EntityAction.viewStatement,
              action2: EntityAction.clientPortal,
            ),
          ],
        );
      }),
    );
  }
}
