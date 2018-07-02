import 'package:flutter/material.dart';

String getMapURL(BuildContext context) {
  final bool iOS = Theme.of(context).platform == TargetPlatform.iOS;
  return iOS ? 'http://maps.apple.com/?address=' : 'https://maps.google.com/?q=';
}