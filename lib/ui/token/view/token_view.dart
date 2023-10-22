// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/token/token_actions.dart';
import 'package:invoiceninja_flutter/ui/app/entity_header.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/token/view/token_view_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TokenView extends StatefulWidget {
  const TokenView({
    Key? key,
    required this.viewModel,
    required this.isFilter,
  }) : super(key: key);

  final TokenViewVM viewModel;
  final bool isFilter;

  @override
  _TokenViewState createState() => new _TokenViewState();
}

class _TokenViewState extends State<TokenView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final viewModel = widget.viewModel;
    final token = viewModel.token;
    final user = viewModel.state.userState.get(token.createdUserId!);

    return ViewScaffold(
      isFilter: widget.isFilter,
      onBackPressed: () => viewModel.onBackPressed(),
      entity: token,
      body: ScrollableListView(
        children: <Widget>[
          EntityHeader(
            entity: token,
            label: localization.user,
            value: user.listDisplayName,
            secondLabel: localization.createdOn,
            secondValue: formatDate(
                convertTimestampToDateString(token.createdAt), context),
          ),
          ListDivider(),
          _TokenListTile(token),
          ListDivider(),
        ],
      ),
    );
  }
}

class _TokenListTile extends StatelessWidget {
  const _TokenListTile(this.token);

  final TokenEntity token;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(22),
      title: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Text(token.token),
      ),
      trailing: token.isMasked ? null : Icon(Icons.content_copy),
      onTap: token.isMasked
          ? null
          : () {
              handleTokenAction(context, [token], EntityAction.copy);
            },
    );
  }
}
