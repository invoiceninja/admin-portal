import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/view_scaffold.dart';
import 'package:invoiceninja_flutter/ui/token/view/token_view_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
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
    //final userCompany = viewModel.state.userCompany;
    final token = viewModel.token;

    return ViewScaffold(
      isFilter: widget.isFilter,
      onBackPressed: () => viewModel.onBackPressed(),
      entity: token,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 16),
          ListDivider(),
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              token.token,
            ),
            trailing: Icon(FontAwesomeIcons.copy),
            onTap: () {

            },
          ),
          ListDivider(),
        ],
      ),
    );
  }
}
