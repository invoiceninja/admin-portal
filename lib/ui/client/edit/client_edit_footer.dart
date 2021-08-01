import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class ClientEditFooter extends StatelessWidget {
  const ClientEditFooter({@required this.client});

  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final useSidebarEditor =
        state.prefState.useSidebarEditor[EntityType.client] ?? false;

    return BottomAppBar(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: CircularNotchedRectangle(),
      child: SizedBox(
        height: kTopBottomBarHeight,
        child: AppBorder(
          isTop: true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isDesktop(context))
                Tooltip(
                  message: useSidebarEditor
                      ? localization.fullscreenEditor
                      : localization.sidebarEditor,
                  child: InkWell(
                    onTap: () =>
                        store.dispatch(ToggleEditorLayout(EntityType.client)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(useSidebarEditor
                          ? Icons.chevron_left
                          : Icons.chevron_right),
                    ),
                  ),
                ),
              AppBorder(
                isLeft: isDesktop(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    client.calculateDisplayName,
                    style: TextStyle(
                      color: state.prefState.enableDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
