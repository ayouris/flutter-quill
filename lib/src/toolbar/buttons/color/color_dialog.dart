import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as color_picker
    show ColorPicker, MaterialPicker, colorToHex;
import 'package:nawat_mobile/core/theme/app_theme.dart';
import '../../../document/style.dart';
import '../../../editor_toolbar_shared/color.dart';
import '../../../l10n/extensions/localizations_ext.dart';
import 'package:nawat_mobile/core/theme/app_theme.dart';

enum _PickerType {
  material,
  color,
}

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({
    required this.isBackground,
    required this.onRequestChangeColor,
    required this.isToggledColor,
    required this.selectionStyle,
    super.key,
  });

  final bool isBackground;

  final bool isToggledColor;
  final Function(BuildContext context, Color? color) onRequestChangeColor;
  final Style selectionStyle;

  @override
  State<ColorPickerDialog> createState() => ColorPickerDialogState();
}

class ColorPickerDialogState extends State<ColorPickerDialog> {
  var pickerType = _PickerType.material;
  var selectedColor = Colors.black;

  late final TextEditingController hexController;
  late void Function(void Function()) colorBoxSetState;

  @override
  void initState() {
    super.initState();
    if (widget.isToggledColor) {
      selectedColor = widget.isBackground
          ? hexToColor(widget.selectionStyle.attributes['background']?.value)
          : hexToColor(widget.selectionStyle.attributes['color']?.value);
    }
    hexController =
        TextEditingController(text: color_picker.colorToHex(selectedColor));
  }

  List<Color> colors = [
    AppThemeConfig().titleColor,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lime,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.loc.selectColor,
          style: TextStyle(color: AppThemeConfig().titleColor)),
      backgroundColor: AppThemeConfig().backgroundColor,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 6),

            Wrap(
              children: colors
                  .map(
                    (element) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          widget.onRequestChangeColor(context, element);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: element,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
