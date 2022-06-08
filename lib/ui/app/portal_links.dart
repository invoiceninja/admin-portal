import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class PortalLinks extends StatelessWidget {
  const PortalLinks({
    Key key,
    @required this.viewLink,
    @required this.copyLink,
    @required this.client,
    this.useIcons = false,
  }) : super(key: key);

  final String viewLink;
  final String copyLink;
  final ClientEntity client;
  final bool useIcons;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final prefState = state.prefState;
    final localization = AppLocalization.of(context);

    var viewLinkWithHash = viewLink;
    if (!viewLink.contains('?')) {
      viewLinkWithHash += '?';
    }
    viewLinkWithHash += '&client_hash=${client.clientHash}';

    var copyLinkWithHash = copyLink;
    if (!copyLink.contains('?')) {
      copyLinkWithHash += '?';
    }
    copyLinkWithHash += '&client_hash=${client.clientHash}';

    final viewLinkPressed = () => launch(viewLinkWithHash);
    final copyLinkPressed = () {
      Clipboard.setData(ClipboardData(text: copyLinkWithHash));
      showToast(localization.copiedToClipboard.replaceFirst(':value ', ''));
    };

    if (useIcons) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: viewLinkPressed,
            icon: Icon(Icons.open_in_new),
            tooltip: prefState.enableTooltips ? localization.viewPortal : '',
          ),
          IconButton(
            onPressed: copyLinkPressed,
            icon: Icon(Icons.copy),
            tooltip: prefState.enableTooltips ? localization.copy : '',
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: viewLinkPressed,
              child: Text(
                localization.viewPortal,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              )),
        ),
        SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
              onPressed: copyLinkPressed,
              child: Text(
                localization.copyLink,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              )),
        ),
      ],
    );
  }
}
