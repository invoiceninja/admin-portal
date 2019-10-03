import 'package:flutter/material.dart';
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
              FlatButton(
                child: Text(
                  localization.cancel,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => onCancelPressed(context),
              ),
            ActionIconButton(
              icon: Icons.cloud_upload,
              tooltip: localization.save,
              isVisible: true,
              isDirty: true,
              isSaving: false,
              //isVisible: !client.isDeleted,
              //isDirty: client.isNew || client != viewModel.origClient,
              //isSaving: viewModel.isSaving,
              onPressed: () => onSavePressed(context),
            ),
          ],
          bottom: appBarBottom,
        ),
      ),
    );
  }
}
