import 'package:flutter/material.dart';

Color hexToColor(String? hexString) {
  if (hexString == null) {
    return Colors.black;
  }
  final hexRegex = RegExp(r'([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$');

  hexString = hexString.replaceAll('#', '');
  if (!hexRegex.hasMatch(hexString)) {
    return Colors.black;
  }

  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString);
  return Color(int.tryParse(buffer.toString(), radix: 16) ?? 0xFF000000);
}

// Without the hash sign (`#`).

String colorToHex(Color color, {bool includeAlpha = true}) {
  String toHex(int value) => value.toRadixString(16).padLeft(2, '0').toUpperCase();

  final red = toHex(color.red);
  final green = toHex(color.green);
  final blue = toHex(color.blue);
  final alpha = toHex(color.alpha);

  return includeAlpha ? '$alpha$red$green$blue' : '$red$green$blue';
}
