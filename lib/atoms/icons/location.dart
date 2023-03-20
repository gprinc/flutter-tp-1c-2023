import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart' as colors;

class LocationIcon extends StatefulWidget {
  const LocationIcon({super.key});

  @override
  State<LocationIcon> createState() => _LocationIconState();
}

class _LocationIconState extends State<LocationIcon> {
  IconData _icon = Icons.location_on;
  Color _color = colors.btnSecondary;

  @override
  Widget build(BuildContext context) {
    return Icon(
      _icon,
      color: _color,
    );
  }
}
