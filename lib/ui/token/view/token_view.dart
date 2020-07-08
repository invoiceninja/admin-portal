import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/token_model.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/token/view/token_view_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class TokenView extends StatefulWidget {
  const TokenView({
    Key key,
    @required this.viewModel,
    @required this.isFilter,
  }) : super(key: key);

  final TokenViewVM viewModel;
  final bool isFilter;

  @override
  _TokenViewState createState() => new _TokenViewState();
}

class _TokenViewState extends State<TokenView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final viewModel = widget.viewModel;
    final token = viewModel.token;

    return ViewScaffold(
      isFilter: widget.isFilter,
      onBackPressed: () => viewModel.onBackPressed(),
      entity: token,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 32),
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
    final localization = AppLocalization.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.all(32),
      title: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Text(
          token.token,
        ),
      ),
      trailing: Icon(FontAwesomeIcons.copy),
      onTap: () {
        Clipboard.setData(ClipboardData(text: token.token));
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalization.of(context)
                .copiedToClipboard
                .replaceFirst(':value', token.token))));
      },
    );
  }
}
