import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatelessWidget {
  const AppWebView({this.html});
  final String html;

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? _WebWebView(html: html) : _MobileWebView(html: html);
  }
}

class _WebWebView extends StatelessWidget {
  const _WebWebView({this.html});
  final String html;

  @override
  Widget build(BuildContext context) {
    final encodedHtml =
        'data:text/html;charset=utf-8,' + Uri.encodeComponent(html);
    WebUtils.registerWebView(encodedHtml);
    return AbsorbPointer(
      child: HtmlElementView(viewType: encodedHtml),
    );
  }
}

class _MobileWebView extends StatefulWidget {
  const _MobileWebView({Key key, this.html}) : super(key: key);

  final String html;

  @override
  _MobileWebViewState createState() => _MobileWebViewState();
}

class _MobileWebViewState extends State<_MobileWebView>
    with AutomaticKeepAliveClientMixin<_MobileWebView> {
  WebViewController _webViewController;

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.html != oldWidget.html) {
      _webViewController.loadUrl(
          Uri.dataFromString(widget.html, mimeType: 'text/html').toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WebView(
      initialUrl:
          Uri.dataFromString(widget.html, mimeType: 'text/html').toString(),
      onWebViewCreated: (WebViewController webViewController) {
        _webViewController = webViewController;
      },
      javascriptMode: JavascriptMode.disabled,
    );
  }
}
