import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart' as colors;

class PlusIcon extends StatefulWidget {
  const PlusIcon({super.key});

  @override
  State<PlusIcon> createState() => _PlusIcon();
}

class _PlusIcon extends State<PlusIcon> {
  IconData _icon = Icons.add;
  Color _color = colors.neutralBg;

  @override
  Widget build(BuildContext context) {
    return Icon(
      _icon,
      color: _color,
      size: 14,
    );
  }
}
