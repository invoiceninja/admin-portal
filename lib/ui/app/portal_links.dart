import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

enum PortalLinkStyle {
  icons,
  buttons,
  dropdown,
}

class PortalLinks extends StatelessWidget {
  const PortalLinks({
    Key? key,
    required this.viewLink,
    required this.copyLink,
    required this.client,
    this.style,
  }) : super(key: key);

  final String viewLink;
  final String copyLink;
  final ClientEntity? client;
  final PortalLinkStyle? style;

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
    if (client != null) {
      viewLinkWithHash += '&client_hash=${client!.clientHash}';
    }

    var copyLinkWithHash = copyLink;
    if (!copyLink.contains('?')) {
      copyLinkWithHash += '?';
    }
    if (client != null) {
      copyLinkWithHash += '&client_hash=${client!.clientHash}';
    }

    final viewLinkPressed = () => launchUrl(Uri.parse(viewLinkWithHash));
    final copyLinkPressed = () {
      Clipboard.setData(ClipboardData(text: copyLinkWithHash));
      showToast(localization!.copiedToClipboard.replaceFirst(':value ', ''));
    };

    if (style == PortalLinkStyle.icons) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: viewLinkPressed,
            icon: Icon(Icons.open_in_new),
            tooltip: prefState.enableTooltips ? localization!.viewPortal : '',
          ),
          IconButton(
            onPressed: copyLinkPressed,
            icon: Icon(Icons.copy),
            tooltip: prefState.enableTooltips ? localization!.copyLink : '',
          ),
        ],
      );
    } else if (style == PortalLinkStyle.dropdown) {
      return PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            child: IconText(
                text: localization!.viewPortal, icon: Icons.open_in_new),
            value: localization.viewPortal,
          ),
          PopupMenuItem(
            child: IconText(text: localization.copyLink, icon: Icons.copy),
            value: localization.copyLink,
          ),
        ],
        onSelected: (value) {
          if (value == localization!.viewPortal) {
            viewLinkPressed();
          } else {
            copyLinkPressed();
          }
        },
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
                onPressed: viewLinkPressed,
                child: Text(
                  localization!.viewPortal,
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
}
