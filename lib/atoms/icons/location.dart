import 'package:dam_1c_2023/tokens/token_shadows.dart';
import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart' as colors;

import '../../tokens/token_colors.dart';

class LocationIcon extends StatefulWidget {
  const LocationIcon({super.key});

  @override
  State<LocationIcon> createState() => _LocationIconState();
}

class _LocationIconState extends State<LocationIcon> {
  final IconData _icon = Icons.near_me;
  final Color _color = colors.primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48,
        width: 48,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: locationBackground,
              boxShadow: const [searchBarShadow],
              borderRadius: BorderRadius.circular(4)),
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              _icon,
              color: _color,
            ),
          ),
        ));
  }
}
