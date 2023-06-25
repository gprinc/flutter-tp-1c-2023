import 'package:flutter/material.dart';
import '../../molecules/buttons.dart';

class FavoriteIcon extends StatefulWidget {
  final void Function() callback;
  final IconData icon;
  final Color color;
  const FavoriteIcon(
      {super.key,
      required this.callback,
      required this.icon,
      required this.color});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return IconSplashButton(
        icon: widget.icon,
        color: widget.color,
        onPress: () => widget.callback());
  }
}
