// Flutter imports:
import 'package:flutter/material.dart';

Color? convertHexStringToColor(String? value) {
  if (value == null) {
    return null;
  }
  value = value.replaceAll('#', '');
  if (value.length != 6) {
    return null;
  }
  try {
    return Color(int.parse(value, radix: 16) + 0xFF000000);
  } catch (e) {
    return null;
  }
}

String? convertColorToHexString(Color color) {
  try {
    final hex =
        color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase();
    return '#$hex';
  } catch (e) {
    return null;
  }
}

Color getColorByIndex(int index) {
  final colorIndex = index % Colors.primaries.length;
  return Colors.primaries[colorIndex];
}
