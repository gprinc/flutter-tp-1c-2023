import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';

class MapIcon extends StatefulWidget {
  const MapIcon({super.key});

  @override
  State<MapIcon> createState() => _MapIconState();
}

class _MapIconState extends State<MapIcon> {
  final IconData _icon = Icons.map;
  final Color _color = primary;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          _icon,
          color: _color,
        ),
        onPressed: () => context.go("/home"));
  }
}
