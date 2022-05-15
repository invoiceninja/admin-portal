// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class AppToggleButtons extends StatelessWidget {
  const AppToggleButtons({
    @required this.selectedIndex,
    @required this.onTabChanged,
    @required this.tabLabels,
  });

  final List<String> tabLabels;
  final int selectedIndex;
  final Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isDesktop = calculateLayout(context) != AppLayout.mobile;
      final double toggleWidth =
          isDesktop ? 208 : (constraints.maxWidth - 36) / 2;

      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ToggleButtons(
          children: [
            Container(
              width: toggleWidth,
              height: 40,
              child: Center(child: Text(tabLabels[0])),
            ),
            Container(
              width: toggleWidth,
              height: 40,
              child: Center(child: Text(tabLabels[1])),
            ),
          ],
          isSelected: selectedIndex == 0 ? [true, false] : [false, true],
          onPressed: (index) => onTabChanged(index),
        ),
      );
    });
  }
}
