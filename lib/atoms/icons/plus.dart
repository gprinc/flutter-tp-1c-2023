import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart' as colors;

class PlusIcon extends StatelessWidget {
  const PlusIcon({super.key});

  final IconData _icon = Icons.add;

  final Color _color = colors.neutralBg;

  @override
  Widget build(BuildContext context) {
    return Icon(
      _icon,
      color: _color,
      size: 14,
    );
  }
}
