import 'package:flutter/material.dart';
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
    final bool isDesktop = calculateLayout(context) != AppLayout.mobile;
    final width = MediaQuery.of(context).size.width;
    final double toggleWidth = isDesktop ? 177 : (width - 70) / 2;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ToggleButtons(
        children: [
          Container(
            width: toggleWidth,
            height: 40,
            child: Center(child: Text(tabLabels[0].toUpperCase())),
          ),
          Container(
            width: toggleWidth,
            height: 40,
            child: Center(child: Text(tabLabels[1].toUpperCase())),
          ),
        ],
        isSelected: selectedIndex == 0 ? [true, false] : [false, true],
        onPressed: (index) => onTabChanged(index),
      ),
    );
  }
}
