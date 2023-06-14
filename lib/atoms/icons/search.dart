import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';

class SearchIcon extends StatefulWidget {
  const SearchIcon({super.key});

  @override
  State<SearchIcon> createState() => _SearchIconState();
}

class _SearchIconState extends State<SearchIcon> {
  final IconData _icon = Icons.search;
  final Color _color = btnSecondary;

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
