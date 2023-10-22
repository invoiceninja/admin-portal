import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/utils/colors.dart';

class SearchText extends StatelessWidget {
  const SearchText({
    Key? key,
    this.filterController,
    this.focusNode,
    this.placeholder,
    this.onChanged,
    this.onCleared,
  }) : super(key: key);

  final Function(String)? onChanged;
  final Function? onCleared;
  final TextEditingController? filterController;
  final FocusNode? focusNode;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final enableDarkMode = state.prefState.enableDarkMode;
    final isFilterSet = filterController!.text.isNotEmpty;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    Color? color;
    if (enableDarkMode) {
      color = convertHexStringToColor(
          isFilterSet ? kDefaultDarkBorderColor : kDefaultDarkBorderColor);
    } else {
      color = convertHexStringToColor(
          isFilterSet ? kDefaultLightBorderColor : kDefaultLightBorderColor);
    }

    return Container(
      padding: const EdgeInsets.only(left: 8.0),
      height: 40,
      margin: EdgeInsets.only(bottom: 2.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      ),
      child: TextField(
        focusNode: focusNode,
        textAlign: filterController!.text.isNotEmpty || focusNode!.hasFocus
            ? TextAlign.start
            : TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 8, right: 8, bottom: 6),
          suffixIcon: filterController!.text.isNotEmpty || focusNode!.hasFocus
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: textColor,
                  ),
                  onPressed: () {
                    filterController!.text = '';
                    focusNode!.unfocus(
                        disposition: UnfocusDisposition.previouslyFocusedChild);
                    onCleared!();
                  },
                )
              : Icon(Icons.search, color: textColor),
          border: InputBorder.none,
          hintText: focusNode!.hasFocus ? '' : placeholder,
        ),
        autocorrect: false,
        onChanged: (value) => onChanged!(value),
        controller: filterController,
      ),
    );
  }
}
