import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart' as colors;

class ArrowBackIcon extends StatefulWidget {
  const ArrowBackIcon({super.key});

  @override
  State<ArrowBackIcon> createState() => _ArrowBackIconState();
}

class _ArrowBackIconState extends State<ArrowBackIcon> {
  IconData _icon = Icons.arrow_back;
  Color _color = Color.fromRGBO(224, 224, 224, 1.0);

  @override
  Widget build(BuildContext context) {
    return Icon(
      _icon,
      color: _color,
    );
  }
}
