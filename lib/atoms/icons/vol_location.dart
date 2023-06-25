import 'package:dam_1c_2023/molecules/buttons.dart';
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

class VolLocationNoPadding extends StatefulWidget {
  final void Function() callback;
  const VolLocationNoPadding(this.callback, {super.key});

  @override
  State<VolLocationNoPadding> createState() => _VolLocationNoPaddingIconState();
}

class _VolLocationNoPaddingIconState extends State<VolLocationNoPadding> {
  final IconData _icon = Icons.location_on;
  final Color _color = primary;

  @override
  Widget build(BuildContext context) {
    return IconSplashButton(
        icon: _icon, color: _color, onPress: () => widget.callback());
  }
}
