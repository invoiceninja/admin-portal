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
    this.apiToken,
  });

  final String? url;
  final bool showNinjaOnError;
  final double? width;
  final double? height;
  final String? apiToken;

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
        url!,
        width: width,
        height: height,
        key: ValueKey(url! + (apiToken != null ? apiToken!.substring(0, 8) : '')),
        fit: BoxFit.contain,
        headers: apiToken != null ? {'X-API-TOKEN': apiToken!} : null,
      );
    }

    return CachedNetworkImage(
      width: width,
      height: height,
      key: ValueKey(url! + (apiToken != null ? apiToken!.substring(0, 8) : '')),
      imageUrl: url!,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, Object? error) =>
          Image.asset('assets/images/icon.png', width: 32, height: 30),
      httpHeaders: apiToken != null ? {'X-API-TOKEN': apiToken!} : null,
    );
  }
}
