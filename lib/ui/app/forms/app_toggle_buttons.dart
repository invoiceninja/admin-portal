// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class AppToggleButtons extends StatelessWidget {
  const AppToggleButtons({
    required this.selectedIndex,
    required this.onTabChanged,
    required this.tabLabels,
    this.padding = 36,
  });

  final List<String?>? tabLabels;
  final int selectedIndex;
  final Function(int) onTabChanged;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isDesktop = calculateLayout(context) != AppLayout.mobile;
      double toggleWidth = (constraints.maxWidth - padding) / tabLabels!.length;
      if (isDesktop) {
        toggleWidth -= 46 / tabLabels!.length;
      }

      final isSelected = tabLabels!.length == 4
          ? (selectedIndex == 0
              ? [true, false, false, false]
              : selectedIndex == 1
                  ? [false, true, false, false]
                  : selectedIndex == 2
                      ? [false, false, true, false]
                      : [false, false, false, true])
          : tabLabels!.length == 3
              ? (selectedIndex == 0
                  ? [true, false, false]
                  : selectedIndex == 1
                      ? [false, true, false]
                      : [false, false, true])
              : selectedIndex == 0
                  ? [true, false]
                  : [false, true];

      final children = tabLabels!
          .map((label) => Container(
                width: toggleWidth,
                child: Center(
                    child: Text(
                  label![0].toUpperCase() + label.substring(1),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                )),
              ))
          .toList();

      return ToggleButtons(
        children: children,
        isSelected: isSelected,
        onPressed: (index) => onTabChanged(index),
      );
    });
  }
}
