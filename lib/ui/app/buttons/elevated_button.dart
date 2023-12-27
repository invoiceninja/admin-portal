// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.iconData,
    this.color,
    this.width,
  });

  final Color? color;
  final IconData? iconData;
  final String? label;
  final Function? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? state.accentColor,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius)),
        elevation: 4,
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: iconData != null && isDesktop(context)
          ? IconText(
              icon: iconData,
              text: label,
              alignment: MainAxisAlignment.center,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          : SizedBox(
              child: Text(
                label!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              height: 24,
            ),
      onPressed: onPressed as void Function()?,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: width == null
          ? button
          : SizedBox(
              width: width,
              child: button,
            ),
    );
  }
}
