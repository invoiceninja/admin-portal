import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

import 'entities/entity_state_title.dart';

class ViewScaffold extends StatelessWidget {
  const ViewScaffold({
    @required this.body,
    @required this.entity,
    this.floatingActionButton,
    this.appBarBottom,
  });

  final BaseEntity entity;
  final Widget body;
  final Widget floatingActionButton;
  final Widget appBarBottom;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: isMobile(context),
          title: EntityStateTitle(entity: entity),
          bottom: appBarBottom,
        ),
        body: body,
      ),
    );
  }
}
