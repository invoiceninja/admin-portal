import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/constants.dart';

class ColorTheme {
  ColorTheme(
      {this.colorPrimary,
      this.colorSecondary,
      this.colorInfo,
      this.colorSuccess,
      this.colorWarning,
      this.colorDanger,
      this.colorLightGray = const Color(0xff888888),
      this.colorDarkGray = const Color(0xff333333)});

  Color colorPrimary;
  Color colorSecondary;
  Color colorInfo;
  Color colorSuccess;
  Color colorWarning;
  Color colorDanger;
  Color colorLightGray;
  Color colorDarkGray;
}

Map<String, ColorTheme> colorThemesMap = {
  kColorThemeLight: ColorTheme(
    colorPrimary: const Color(0xff1266F1),
    colorSecondary: const Color(0xffB23CFD),
    colorInfo: const Color(0xff39C0ED),
    colorSuccess: const Color(0xff00B74A),
    colorWarning: const Color(0xffffA900),
    colorDanger: const Color(0xffF93154),
  ),
  kColorThemeDark: ColorTheme(
    colorPrimary: const Color(0xff1266F1),
    colorSecondary: const Color(0xffB23CFD),
    colorInfo: const Color(0xff505f73),
    colorSuccess: const Color(0xff407535),
    colorWarning: const Color(0xffdd5600),
    colorDanger: const Color(0xff8b3d40),
  ),
  'cerulean': ColorTheme(
    colorPrimary: const Color(0xff2fa4e7),
    colorSecondary: const Color(0xffe9ecef),
    colorInfo: const Color(0xff033c73),
    colorSuccess: const Color(0xff73a839),
    colorWarning: const Color(0xffdd5600),
    colorDanger: const Color(0xffc71c22),
  ),
  'cosmo': ColorTheme(
    colorPrimary: const Color(0xff2780e3),
    colorSecondary: const Color(0xff373a3c),
    colorInfo: const Color(0xff9954bb),
    colorSuccess: const Color(0xff3fb618),
    colorWarning: const Color(0xffff7518),
    colorDanger: const Color(0xffff0039),
  ),
  'cyborg': ColorTheme(
    colorPrimary: const Color(0xff2a9fd6),
    colorSecondary: const Color(0xff555555),
    colorInfo: const Color(0xff9933cc),
    colorSuccess: const Color(0xff77b300),
    colorWarning: const Color(0xffff8800),
    colorDanger: const Color(0xffcc0000),
  ),
  'darkly': ColorTheme(
    colorPrimary: const Color(0xff375a7f),
    colorSecondary: const Color(0xff444444),
    colorInfo: const Color(0xff3498db),
    colorSuccess: const Color(0xff00bc8c),
    colorWarning: const Color(0xfff39c12),
    colorDanger: const Color(0xffe74c3c),
  ),
  'flatly': ColorTheme(
    colorPrimary: const Color(0xff2c3e50),
    colorSecondary: const Color(0xff95a5a6),
    colorInfo: const Color(0xff3498db),
    colorSuccess: const Color(0xff18bc9c),
    colorWarning: const Color(0xfff39c12),
    colorDanger: const Color(0xffe74c3c),
  ),
  'journal': ColorTheme(
    colorPrimary: const Color(0xffeb6864),
    colorSecondary: const Color(0xff888888),
    colorInfo: const Color(0xff336699),
    colorSuccess: const Color(0xff22b24c),
    colorWarning: const Color(0xfff5e625),
    colorDanger: const Color(0xfff57a00),
  ),
  'litera': ColorTheme(
    colorPrimary: const Color(0xff4582ec),
    colorSecondary: const Color(0xffadb5bd),
    colorInfo: const Color(0xff17a2b8),
    colorSuccess: const Color(0xff02b875),
    colorWarning: const Color(0xfff0ad4e),
    colorDanger: const Color(0xffd9534f),
  ),
  'lumen': ColorTheme(
    colorPrimary: const Color(0xff158cba),
    colorSecondary: const Color(0xfff0f0f0),
    colorInfo: const Color(0xff75caeb),
    colorSuccess: const Color(0xff28b62c),
    colorWarning: const Color(0xffff851b),
    colorDanger: const Color(0xffff4136),
  ),
  'lux': ColorTheme(
    colorPrimary: const Color(0xff1a1a1a),
    colorSecondary: const Color(0xff888888),
    colorInfo: const Color(0xff1f9bcf),
    colorSuccess: const Color(0xff4bbf73),
    colorWarning: const Color(0xfff0ad4e),
    colorDanger: const Color(0xffd9534f),
  ),
  'materia': ColorTheme(
    colorPrimary: const Color(0xff2196f3),
    colorSecondary: const Color(0xff888888),
    colorInfo: const Color(0xff9c27b0),
    colorSuccess: const Color(0xff4caf50),
    colorWarning: const Color(0xffff9800),
    colorDanger: const Color(0xffe51c23),
  ),
  'minty': ColorTheme(
    colorPrimary: const Color(0xff78c2ad),
    colorSecondary: const Color(0xfff3969a),
    colorInfo: const Color(0xff6cc3d5),
    colorSuccess: const Color(0xff56cc9d),
    colorWarning: const Color(0xffffce67),
    colorDanger: const Color(0xffff7851),
  ),
  'pulse': ColorTheme(
    colorPrimary: const Color(0xff593196),
    colorSecondary: const Color(0xffa991d4),
    colorInfo: const Color(0xff009cdc),
    colorSuccess: const Color(0xff13b955),
    colorWarning: const Color(0xffefa31d),
    colorDanger: const Color(0xfffc3939),
  ),
  'sandstone': ColorTheme(
    colorPrimary: const Color(0xff325d88),
    colorSecondary: const Color(0xff8e8c84),
    colorInfo: const Color(0xff29abe0),
    colorSuccess: const Color(0xff93c54b),
    colorWarning: const Color(0xfff47c3c),
    colorDanger: const Color(0xffd9534f),
  ),
  'simplex': ColorTheme(
    colorPrimary: const Color(0xffd9230f),
    colorSecondary: const Color(0xff888888),
    colorInfo: const Color(0xff029acf),
    colorSuccess: const Color(0xff469408),
    colorWarning: const Color(0xffd9831f),
    colorDanger: const Color(0xff9b479f),
  ),
  'sketchy': ColorTheme(
    colorPrimary: const Color(0xff333333),
    colorSecondary: const Color(0xff555555),
    colorInfo: const Color(0xff17a2b8),
    colorSuccess: const Color(0xff28a745),
    colorWarning: const Color(0xffffc107),
    colorDanger: const Color(0xffdc3545),
  ),
  'slate': ColorTheme(
    colorPrimary: const Color(0xff3a3f44),
    colorSecondary: const Color(0xff7a8288),
    colorInfo: const Color(0xff5bc0de),
    colorSuccess: const Color(0xff62c462),
    colorWarning: const Color(0xfff89406),
    colorDanger: const Color(0xffee5f5b),
  ),
  'solar': ColorTheme(
    colorPrimary: const Color(0xffb58900),
    colorSecondary: const Color(0xff839496),
    colorInfo: const Color(0xff268bd2),
    colorSuccess: const Color(0xff2aa198),
    colorWarning: const Color(0xffcb4b16),
    colorDanger: const Color(0xffd33682),
  ),
  'spacelab': ColorTheme(
    colorPrimary: const Color(0xff446e9b),
    colorSecondary: const Color(0xff888888),
    colorInfo: const Color(0xff3399f3),
    colorSuccess: const Color(0xff3cb521),
    colorWarning: const Color(0xffd47500),
    colorDanger: const Color(0xffcd0200),
  ),
  'superhero': ColorTheme(
    colorPrimary: const Color(0xffdf691a),
    colorSecondary: const Color(0xff4e5d6c),
    colorInfo: const Color(0xff5bc0de),
    colorSuccess: const Color(0xff5cb85c),
    colorWarning: const Color(0xfff0ad4e),
    colorDanger: const Color(0xffd9534f),
  ),
  'united': ColorTheme(
    colorPrimary: const Color(0xffe95420),
    colorSecondary: const Color(0xffaea79f),
    colorInfo: const Color(0xff17a2b8),
    colorSuccess: const Color(0xff38b44a),
    colorWarning: const Color(0xffefb73e),
    colorDanger: const Color(0xffdf382c),
  ),
  'yeti': ColorTheme(
    colorPrimary: const Color(0xff008cba),
    colorSecondary: const Color(0xff888888),
    colorInfo: const Color(0xff5bc0de),
    colorSuccess: const Color(0xff43ac6a),
    colorWarning: const Color(0xffe99002),
    colorDanger: const Color(0xfff04124),
  ),
};
