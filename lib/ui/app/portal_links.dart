import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/models/client_model.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class PortalLinks extends StatelessWidget {
  const PortalLinks({
    Key key,
    @required this.viewLink,
    @required this.copyLink,
    @required this.client,
  }) : super(key: key);

  final String viewLink;
  final String copyLink;
  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
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

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: () => launch(viewLinkWithHash),
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
              onPressed: () {
                Clipboard.setData(ClipboardData(text: copyLinkWithHash));
                showToast(
                    localization.copiedToClipboard.replaceFirst(':value ', ''));
              },
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
