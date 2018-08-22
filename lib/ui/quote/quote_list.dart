import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_list_item.dart';
import 'package:invoiceninja_flutter/ui/quote/quote_list_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class QuoteList extends StatelessWidget {
  final QuoteListVM viewModel;

  const QuoteList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isLoaded) {
      return LoadingIndicator();
    } else if (viewModel.quoteList.isEmpty) {
      return Opacity(
        opacity: 0.5,
        child: Center(
          child: Text(
            AppLocalization.of(context).noRecordsFound,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }

    return _buildListView(context);
  }

  void _showMenu(BuildContext context, QuoteEntity quote) async {
    final user = viewModel.user;
    final message = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(children: <Widget>[
              user.canCreate(EntityType.quote)
                  ? ListTile(
                      leading: Icon(Icons.control_point_duplicate),
                      title: Text(AppLocalization.of(context).clone),
                      onTap: () => viewModel.onEntityAction(
                          context, quote, EntityAction.clone),
                    )
                  : Container(),
              Divider(),
              user.canEditEntity(quote) && !quote.isActive
                  ? ListTile(
                      leading: Icon(Icons.restore),
                      title: Text(AppLocalization.of(context).restore),
                      onTap: () => viewModel.onEntityAction(
                          context, quote, EntityAction.restore),
                    )
                  : Container(),
              user.canEditEntity(quote) && quote.isActive
                  ? ListTile(
                      leading: Icon(Icons.archive),
                      title: Text(AppLocalization.of(context).archive),
                      onTap: () => viewModel.onEntityAction(
                          context, quote, EntityAction.archive),
                    )
                  : Container(),
              user.canEditEntity(quote) && !quote.isDeleted
                  ? ListTile(
                      leading: Icon(Icons.delete),
                      title: Text(AppLocalization.of(context).delete),
                      onTap: () => viewModel.onEntityAction(
                          context, quote, EntityAction.delete),
                    )
                  : Container(),
            ]));
    if (message != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: SnackBarRow(
        message: message,
      )));
    }
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.builder(
          itemCount: viewModel.quoteList.length,
          itemBuilder: (BuildContext context, index) {
            final quoteId = viewModel.quoteList[index];
            final quote = viewModel.quoteMap[quoteId];
            return Column(children: <Widget>[
              QuoteListItem(
                user: viewModel.user,
                filter: viewModel.filter,
                quote: quote,
                client: viewModel.clientMap[quote.clientId],
                onDismissed: (DismissDirection direction) =>
                    viewModel.onDismissed(context, quote, direction),
                onTap: () => viewModel.onQuoteTap(context, quote),
                onLongPress: () => _showMenu(context, quote),
              ),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}
