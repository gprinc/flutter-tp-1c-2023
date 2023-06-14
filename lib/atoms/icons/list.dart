import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';

class ListIcon extends StatefulWidget {
  final void Function(bool value) onPressed;

  const ListIcon({super.key, required this.onPressed});

  @override
  State<ListIcon> createState() => _ListIconState();
}

class _ListIconState extends State<ListIcon> {
  final IconData _icon = Icons.format_list_bulleted;
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
