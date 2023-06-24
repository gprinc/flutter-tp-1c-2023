import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArrowBackIcon extends StatefulWidget {
  final String? route;

  const ArrowBackIcon({super.key, this.route});

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
        onPressed: () => widget.route != null
            ? context.go(widget.route!)
            : context.go("/home"));
  }
}
