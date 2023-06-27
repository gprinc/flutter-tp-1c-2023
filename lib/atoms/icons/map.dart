import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';

class MapIcon extends StatefulWidget {
  final void Function(bool value) onPressed;

  const MapIcon({super.key, required this.onPressed});

  @override
  State<MapIcon> createState() => _MapIconState();
}

class _MapIconState extends State<MapIcon> {
  final IconData _icon = Icons.map_outlined;
  final Color _color = primary;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          _icon,
          color: _color,
        ),
        onPressed: () => widget.onPressed(true));
  }
}
