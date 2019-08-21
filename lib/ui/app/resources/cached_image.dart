import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CachedImage extends StatelessWidget {

  const CachedImage({this.url, this.width, this.height, this.showNinjaOnError = true});
  final String url;
  final bool showNinjaOnError;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;

    // TODO remove this workaround
    if (uiState.isTesting) {
      return SizedBox(
        width: width,
        height: height,
      );
    }

    return CachedNetworkImage(
      width: 32,
      height: 30,
      key: ValueKey(url),
      imageUrl: url,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Image.asset(
          'assets/images/logo.png',
          width: 32,
          height: 30),
    );
  }
}
