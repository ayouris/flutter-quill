import 'package:flutter/material.dart';

/// Parses a 3-, 6- or 8-digit hex string (“#” optional) into a Flutter [Color].
///  - “03F”    → opaque #0033FF  
///  - “ABCDEF” → opaque #ABCDEF  
///  - “80FF0000” → 50%-alpha red  
Color hexToColor(String hexString) {
  var hex = hexString.replaceFirst('#', '');

  // expand 3-digit “ABC” → “AABBCC”
  if (hex.length == 3) {
    hex = hex.split('').map((c) => c + c).join();
  }

  // if only RRGGBB, default alpha to “FF”
  if (hex.length == 6) {
    hex = 'FF$hex';
  }

  assert(
    hex.length == 8,
    'hexColor must be 3, 6 or 8 hex digits (without “#”)',
  );

  // parse as ARGB
  return Color(int.parse(hex, radix: 16));
}

/// Converts a [Color] into a 6-digit uppercase hex string (no “#”).
/// Use this when passing to Quill’s Attribute.color().
String colorToHex(Color color) {
  // This yields AARRGGBB, we drop the first two (the alpha).
  final argb = color.value.toRadixString(16).padLeft(8, '0');
  return argb.substring(2).toUpperCase();  // RRGGBB
}
