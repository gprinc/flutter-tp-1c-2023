import 'package:dam_1c_2023/tokens/token_shadows.dart';
import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';

import '../tokens/token_colors.dart';

class Input extends StatefulWidget {
  final String? Function(String?) validator;
  final String placeHolder;
  final bool obscureInput;
  String? value;

  Input(
      {super.key,
      required this.validator,
      required this.placeHolder,
      this.obscureInput = false,
      this.value = ''});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _hasError = false;
  bool _hasFocus = false;
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();

  Widget? _getStateIcon() {
    if (_hasError) return const Icon(Icons.error, color: Colors.red);

    Widget? result = _controller.text.isNotEmpty && _hasFocus
        ? IconButton(
            icon: const Icon(
              Icons.clear,
              color: btnSecondary,
            ),
            onPressed: () {
              _controller.clear();
            },
          )
        : null;
    return result;
  }

  String? _getLabelText() {
    if (_hasFocus) return widget.placeHolder;
    return null;
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _controller.text = widget.value ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    _controller.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = !_hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (value) {
          setState(() {
            widget.value = value;
          });
        },
        controller: _controller,
        decoration: InputDecoration(
            labelText: _getLabelText(),
            labelStyle: subtitle01,
            hintText: _hasFocus ? '' : widget.placeHolder,
            hintStyle: subtitle01,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            suffixIcon: _getStateIcon()),
        style: subtitle01,
        obscureText: widget.obscureInput,
        validator: (value) {
          String? validation = widget.validator(value);
          setState(() {
            _hasError = validation == null;
          });
          return validation;
        },
        focusNode: _focus);
  }
}

class LabelTextInput extends StatefulWidget {
  final String? Function(String?) validator;
  final String placeHolder;
  final String label;
  final bool obscureInput;
  String? value;

  LabelTextInput(
      {super.key,
      required this.validator,
      required this.placeHolder,
      required this.label,
      this.obscureInput = false,
      this.value = ''});

  @override
  State<LabelTextInput> createState() => _LabelTextInputState();
}

class _LabelTextInputState extends State<LabelTextInput> {
  bool _hasError = false;
  bool _hasFocus = false;
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();

  Widget? _getStateIcon() {
    if (_hasError) return const Icon(Icons.error, color: Colors.red);

    return _controller.text.isNotEmpty && _hasFocus
        ? IconButton(
            icon: const Icon(Icons.clear, color: btnSecondary),
            onPressed: () {
              _controller.clear();
            },
          )
        : null;
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _controller.text = widget.value ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    _controller.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = !_hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (value) {
          setState(() {
            widget.value = value;
          });
        },
        controller: _controller,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.label,
            labelStyle: subtitle01,
            hintText: widget.placeHolder,
            hintStyle: subtitle01,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            suffixIcon: _getStateIcon()),
        style: subtitle01,
        obscureText: widget.obscureInput,
        validator: (value) {
          String? validation = widget.validator(value);
          setState(() {
            _hasError = validation == null;
          });
          return validation;
        },
        focusNode: _focus);
  }
}

class SearchInput extends StatefulWidget {
  final void Function() search;
  //final String placeHolder;

  SearchInput({super.key, required this.search});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool _hasFocus = false;
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();

  Widget? _getStateIcon() {
    return _controller.text.isNotEmpty && !_hasFocus
        ? IconButton(
            icon: const Icon(
              Icons.clear,
              color: btnSecondary,
            ),
            onPressed: () {
              _controller.clear();
            },
          )
        : IconButton(
            icon: const Icon(Icons.search),
            onPressed: widget.search,
          );
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    _controller.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = !_hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: shadow01,
      child: TextFormField(
          onChanged: (value) {
            setState(() {});
          },
          controller: _controller,
          decoration: InputDecoration(
              hintText: 'Buscar',
              hintStyle: subtitle01,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              suffixIcon: _getStateIcon()),
          style: subtitle01,
          focusNode: _focus),
    );
  }
}
