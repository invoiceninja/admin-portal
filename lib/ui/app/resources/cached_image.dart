import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CachedImage extends StatelessWidget {
  const CachedImage(
      {this.url, this.width, this.height, this.showNinjaOnError = true});

  final String url;
  final bool showNinjaOnError;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    // TODO remove this workaround
    if (state.isTesting || (url ?? '').isEmpty) {
      return SizedBox(
        width: width,
        height: height,
      );
    }

    // TODO remove this
    if (kIsWeb) {
      return Image.network(
        url,
        width: width,
        height: height,
        key: ValueKey(url),
        fit: BoxFit.contain,
      );
    }

    return CachedNetworkImage(
      width: width,
      height: height,
      key: ValueKey(url),
      imageUrl: url,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, Object error) =>
          Image.asset('assets/images/logo.png', width: 32, height: 30),
    );
  }
}
