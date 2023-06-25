import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';

class VolLocation extends StatefulWidget {
  void Function() callback;
  VolLocation(this.callback, {super.key});

  @override
  State<VolLocation> createState() => _VolLocationIconState();
}

class _VolLocationIconState extends State<VolLocation> {
  final IconData _icon = Icons.location_on;
  final Color _color = primary;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          _icon,
          color: _color,
        ),
        onPressed: () => widget.callback());
  }
}
