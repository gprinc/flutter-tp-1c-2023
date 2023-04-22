import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArrowBackIcon extends StatefulWidget {
  const ArrowBackIcon({super.key});

  @override
  State<ArrowBackIcon> createState() => _ArrowBackIconState();
}

class _ArrowBackIconState extends State<ArrowBackIcon> {
  final IconData _icon = Icons.arrow_back;
  final Color _color = const Color.fromRGBO(224, 224, 224, 1.0);

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
