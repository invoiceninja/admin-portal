import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class EditScaffold extends StatelessWidget {
  const EditScaffold({
    Key key,
    @required this.title,
    @required this.onSavePressed,
    @required this.body,
    this.entity,
    this.onCancelPressed,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBarBottom,
    this.saveLabel,
  }) : super(key: key);

  final BaseEntity entity;
  final String title;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Widget appBarBottom;
  final Widget floatingActionButton;
  final Widget body;
  final Widget bottomNavigationBar;
  final String saveLabel;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: body,
        appBar: AppBar(
          leading: isNotMobile(context) && entity != null
              ? Icon(getEntityIcon(entity.entityType))
              : null,
          automaticallyImplyLeading: isMobile(context),
          title: Text(title),
          actions: <Widget>[
            SaveCancelButtons(
              saveLabel: saveLabel,
              isSaving: state.isSaving,
              onSavePressed: (context) => onSavePressed(context),
              onCancelPressed: isMobile(context)
                  ? null
                  : (context) {
                      if (onCancelPressed != null) {
                        onCancelPressed(context);
                      } else {
                        store.dispatch(ResetSettings());
                      }
                    },
            ),
          ],
          bottom: appBarBottom,
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
