import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/buttons/action_icon_button.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class SettingsScaffold extends StatelessWidget {
  const SettingsScaffold({
    @required this.title,
    @required this.onSavePressed,
    @required this.onCancelPressed,
    @required this.body,
    this.appBarBottom,
  });

  final String title;
  final Function(BuildContext) onSavePressed;
  final Function(BuildContext) onCancelPressed;
  final Widget appBarBottom;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final state = StoreProvider.of<AppState>(context).state;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: body,
        appBar: AppBar(
          automaticallyImplyLeading: isMobile(context),
          title: Text(title),
          actions: <Widget>[
            if (!isMobile(context))
              Builder(builder: (BuildContext context) {
                return FlatButton(
                  child: Text(
                    localization.cancel,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    onCancelPressed(context);
                  },
                );
              }),
            Builder(builder: (BuildContext context) {
              return ActionIconButton(
                icon: Icons.cloud_upload,
                tooltip: localization.save,
                isVisible: true,
                isDirty: true,
                isSaving: state.isSaving,
                onPressed: () => onSavePressed(context),
              );
            }),
          ],
          bottom: appBarBottom,
        ),
      ),
    );
  }
}
