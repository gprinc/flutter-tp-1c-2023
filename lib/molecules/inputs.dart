import 'package:dam_1c_2023/atoms/icons/list.dart';
import 'package:dam_1c_2023/tokens/token_shadows.dart';
import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:intl/intl.dart';

import '../atoms/icons/map.dart';
import '../tokens/token_colors.dart';

class Input extends StatefulWidget {
  final String? Function(String?) validator;
  final String placeHolder;
  final bool obscureInput;
  final String? value;

  const Input(
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
  bool _isObscured = true;
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();

  Widget? _getStateIcon() {
    if (_hasError) return const Icon(Icons.error, color: Colors.red);

    if (widget.obscureInput) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      );
    }

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
    final formKey = GlobalKey<FormState>();
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        onChanged: (value) {
          setState(() {
            formKey.currentState!.validate();
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
        obscureText: _isObscured,
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
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? value;

  const LabelTextInput(
      {super.key,
      required this.validator,
      required this.controller,
      required this.placeHolder,
      required this.label,
      this.obscureInput = false,
      this.value = '',
      this.keyboardType = TextInputType.text});

  @override
  State<LabelTextInput> createState() => _LabelTextInputState();
}

class _LabelTextInputState extends State<LabelTextInput> {
  bool _hasError = false;
  bool _hasFocus = false;
  bool _isObscured = true;
  final FocusNode _focus = FocusNode();
  late TextEditingController _controller;

  Widget? _getStateIcon() {
    if (_hasError) return const Icon(Icons.error, color: Colors.red);

    if (widget.obscureInput) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      );
    }

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
    _controller = widget.controller;
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
        keyboardType: widget.keyboardType,
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
        obscureText: _isObscured,
        validator: (value) {
          String? validation = widget.validator(value);
          setState(() {
            _hasError = validation != null;
          });
          return validation;
        },
        focusNode: _focus);
  }
}

class SearchInput extends StatefulWidget {
  final void Function(String value) search;
  final void Function(bool value) toggleMapVisibility;
  final bool isMapVisible;
  //final String placeHolder;

  const SearchInput({
    Key? key,
    required this.search,
    required this.toggleMapVisibility,
    required this.isMapVisible,
  }) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool _hasFocus = false;
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();

  Widget? _getPrefixStateIcon() {
    return _controller.text.isNotEmpty
        ? null
        : const Icon(
            Icons.search,
            color: btnSecondary,
          );
  }

  Widget? _getSuffixStateIcon(bool isMapVisible) {
    // If no focus, and no text => Map Icon
    return _controller.text.isEmpty && !_hasFocus
        ? isMapVisible
            ? ListIcon(
                onPressed: (value) {
                  widget.toggleMapVisibility(!isMapVisible);
                },
              )
            : MapIcon(
                onPressed: (value) {
                  widget.toggleMapVisibility(!isMapVisible);
                },
              )
        : _hasFocus && _controller.text.isNotEmpty
            // If focus and text => return Clear Icon
            ? IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: btnSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _controller.clear();
                  });
                  widget.search(''); // Call _runFilter with an empty string
                },
              )
            : null;
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
      decoration: const BoxDecoration(
        color: cardBg,
        boxShadow: [
          searchBarShadow,
        ],
      ),
      child: TextField(
          onChanged: (value) {
            widget.search(value);
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
              prefixIcon: _getPrefixStateIcon(),
              suffixIcon: _getSuffixStateIcon(widget.isMapVisible)),
          style: subtitle01,
          focusNode: _focus),
    );
  }
}

class LabelDateInput extends StatefulWidget {
  final String? Function(String?) validator;
  final String placeHolder;
  final String label;
  final TextEditingController controller;
  final String? value;

  const LabelDateInput(
      {super.key,
      required this.validator,
      required this.controller,
      required this.placeHolder,
      required this.label,
      this.value = ''});

  @override
  State<LabelDateInput> createState() => _LabelDateInputState();
}

class _LabelDateInputState extends State<LabelDateInput> {
  bool _hasError = false;
  bool _hasFocus = false;
  final FocusNode _focus = FocusNode();
  late TextEditingController _controller;
  bool autoCompleted = false;
  late int currLength;
  String? previousValue = '';

  Widget? _getStateIcon() {
    if (_hasError) return const Icon(Icons.error, color: Colors.red);

    return IconButton(
        onPressed: () async => await _handlePick(),
        icon: const Icon(Icons.calendar_month),
        color: primary);
  }

  _handlePick() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(
          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

      setState(() {
        _controller.text =
            formattedDate; //set foratted date to TextField value.
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    currLength = widget.value?.length ?? 0;
    _controller = widget.controller;
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
            if (autoCompleted && value.length < previousValue!.length) {
              // Backspace pressed, remove the trailing '/'
              value = value.substring(0, value.length - 1);
            }

            if (value.length == 2 || value.length == 5) {
              // Add a '/' after the second and fifth characters
              value += '/';
              autoCompleted = true;
            }

            previousValue = value;
            _controller.value = _controller.value.copyWith(
              text: value,
              selection: TextSelection.collapsed(offset: value.length),
            );
          });
        },
        controller: _controller,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
            helperText: 'Día / Mes / Año',
            helperStyle: body02,
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
        validator: (value) {
          String? validation = widget.validator(value);
          setState(() {
            _hasError = validation != null;
          });
          return validation;
        },
        focusNode: _focus);
  }
}
