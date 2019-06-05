import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpenseViewDetails extends StatefulWidget {
  const ExpenseViewDetails({this.expense});

  final ExpenseEntity expense;

  @override
  _ExpenseViewDetailsState createState() => _ExpenseViewDetailsState();
}

class _ExpenseViewDetailsState extends State<ExpenseViewDetails> {
  Future<Null> _launched;

  Future<Null> _launchURL(BuildContext context, String url) async {
    final localization = AppLocalization.of(context);
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw '${localization.couldNotLaunch}';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<Null> snapshot) {
    final localization = AppLocalization.of(context);
    if (snapshot.hasError) {
      return Text('${localization.error}: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final expense = widget.expense;

    List<Widget> _buildDetailsList() {
      final listTiles = <Widget>[];

      /*
      if (listTiles.isNotEmpty) {
        listTiles.add(
          Container(
            color: Theme.of(context).backgroundColor,
            height: 12.0,
          ),
        );
      }
      */

      listTiles.add(Padding(
        padding: const EdgeInsets.all(14.0),
        child: FutureBuilder<Null>(future: _launched, builder: _launchStatus),
      ));

      return listTiles;
    }

    return ListView(
      children: _buildDetailsList(),
    );
  }
}

class AppListTile extends StatelessWidget {
  const AppListTile({
    this.icon,
    this.title,
    this.subtitle,
    this.dense = false,
    this.onTap,
    this.copyValue,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool dense;
  final Function onTap;
  final String copyValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).canvasColor,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
        leading: Icon(icon),
        title: Text(title),
        subtitle: subtitle == null ? Container() : Text(subtitle),
        dense: dense,
        onTap: onTap,
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: copyValue ?? title));
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalization.of(context)
                  .copiedToClipboard
                  .replaceFirst(':value', copyValue ?? title))));
        },
      ),
    );
  }
}
