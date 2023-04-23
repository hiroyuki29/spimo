import 'package:flutter/material.dart';
import 'package:spimo/common/widget/color/color.dart';

class ChartRageChip extends StatelessWidget {
  const ChartRageChip({
    Key? key,
    required this.title,
    required this.isActive,
    required this.onSelected,
  }) : super(key: key);

  final String title;
  final bool isActive;
  final Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Text(title),
        labelStyle: TextStyle(
          color: isActive ? white : primaryDark,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
        selectedColor: accent,
        disabledColor: primaryLight,
        onSelected: onSelected,
        selected: isActive,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        tooltip: '$title文字の区間で\n区切って表示します',
      ),
    );
  }
}
