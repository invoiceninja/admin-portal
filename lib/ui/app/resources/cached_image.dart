// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    this.url,
    this.width,
    this.height,
    this.showNinjaOnError = true,
    this.sendApiToken = false,
  });

  final String url;
  final bool showNinjaOnError;
  final double width;
  final double height;
  final bool sendApiToken;

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
        headers: sendApiToken ? {'X-API-TOKEN': state.credentials.token} : null,
      );
    }

    return CachedNetworkImage(
      width: width,
      height: height,
      key: ValueKey(url),
      imageUrl: url,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, Object error) =>
          Image.asset('assets/images/icon.png', width: 32, height: 30),
      httpHeaders:
          sendApiToken ? {'X-API-TOKEN': state.credentials.token} : null,
    );
  }
}
