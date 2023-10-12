// Dart imports:

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:webview_flutter/webview_flutter.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class AppWebView extends StatelessWidget {
  const AppWebView({this.html});

  final String? html;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? _WebWebView(html: html)
        : _MobileWebView(
            html: html,
            width: MediaQuery.of(context).size.width - 20,
          );
  }
}

class _WebWebView extends StatelessWidget {
  const _WebWebView({this.html});

  final String? html;

  @override
  Widget build(BuildContext context) {
    final encodedHtml =
        'data:text/html;charset=utf-8,' + Uri.encodeComponent(html!);
    WebUtils.registerWebView(encodedHtml);
    return AbsorbPointer(
      child: HtmlElementView(viewType: encodedHtml),
    );
  }
}

class _MobileWebView extends StatefulWidget {
  const _MobileWebView({
    Key? key,
    required this.html,
    required this.width,
  }) : super(key: key);

  final String? html;
  final double width;

  @override
  _MobileWebViewState createState() => _MobileWebViewState();
}

class _MobileWebViewState extends State<_MobileWebView>
    with AutomaticKeepAliveClientMixin<_MobileWebView> {
  late WebViewController _webViewController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setBackgroundColor(const Color(0x00000000));

    if ((widget.html ?? '').isNotEmpty) {
      _webViewController.loadHtmlString(
          widget.html!.replaceFirst('width="570"', 'width="${widget.width}"'));
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.html != oldWidget.html) {
      _webViewController.loadHtmlString(
          widget.html!.replaceFirst('width="570"', 'width="${widget.width}"'));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WebViewWidget(
      controller: _webViewController,
    );
  }
}
