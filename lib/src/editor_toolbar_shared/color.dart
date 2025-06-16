import 'package:flutter/material.dart';

/// Converts a 3-, 6-, or 8-digit hex string (with or without “#”) into a [Color].
/// 
/// Examples:
///  - `'#03F'`      → opaque #0033FF  
///  - `'abcdef'`    → opaque #ABCDEF  
///  - `'80FF0000'`  → 50%-alpha red  
Color hexToColor(String hexString) {
  // Strip leading “#”, make uppercase
  var hex = hexString.replaceFirst('#', '').toUpperCase();

  // Expand 3-char “ABC” → “AABBCC”
  if (hex.length == 3) {
    hex = hex.split('').map((c) => c + c).join();
  }

  // If only RRGGBB is provided, default alpha to “FF”
  if (hex.length == 6) {
    hex = 'FF$hex';
  }

  // Now we must have 8 chars ARGB
  assert(hex.length == 8, 'hex color must be 3, 6 or 8 hex digits long');
  return Color(int.parse(hex, radix: 16));
}

/// Converts a [Color] into an 8-digit ARGB hex string (no “#”)  
/// or, if [leadingHashSign] is true, prefixes it with “#”.
/// 
/// By default returns uppercase, e.g. `'80FF0000'` for 50% red.
String colorToHex(Color color, {bool leadingHashSign = false}) {
  final a = color.alpha.toRadixString(16).padLeft(2, '0');
  final r = color.red  .toRadixString(16).padLeft(2, '0');
  final g = color.green.toRadixString(16).padLeft(2, '0');
  final b = color.blue .toRadixString(16).padLeft(2, '0');
  final hex = (a + r + g + b).toUpperCase();
  return leadingHashSign ? '#$hex' : hex;
}
