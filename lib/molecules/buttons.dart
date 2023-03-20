import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';

class Button extends StatefulWidget {
  final String text;
  final void Function() handlePress;
  final bool initialEnabledState;
  final bool disableAfterPress;
  final ButtonStyle buttonStyle;
  final TextStyle textStyle;

  const Button(
      {super.key,
      required this.text,
      required this.handlePress,
      required this.initialEnabledState,
      required this.buttonStyle,
      required this.textStyle,
      this.disableAfterPress = false});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    setState(() {
      _enabled = widget.initialEnabledState;
    });
  }

  onPressed() {
    if (widget.disableAfterPress) {
      setState(() {
        _enabled = !_enabled;
      });
    }
    return widget.handlePress;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _enabled ? onPressed : null,
      style: widget.buttonStyle,
      child: Text(
        widget.text,
        style: widget.textStyle,
      ),
    );
  }
}

class CtaButton extends StatelessWidget {
  final String text;
  final void Function() handlePress;
  final bool initialEnabledState;
  final bool disableAfterPress;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // <-- Radius,
      ));

  final TextStyle textStyle = btn;

  CtaButton(
      {super.key,
      required this.text,
      required this.handlePress,
      required this.initialEnabledState,
      this.disableAfterPress = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328,
      height: 44,
      child: Button(
        text: text,
        handlePress: handlePress,
        initialEnabledState: initialEnabledState,
        buttonStyle: buttonStyle,
        textStyle: textStyle,
        disableAfterPress: disableAfterPress,
      ),
    );
  }
}

class ShortButton extends StatelessWidget {
  final String text;
  final void Function() handlePress;
  final bool initialEnabledState;
  final bool disableAfterPress;

  final TextStyle textStyle = btn;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // <-- Radius,
      ));

  ShortButton(
      {super.key,
      required this.text,
      required this.handlePress,
      required this.initialEnabledState,
      this.disableAfterPress = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 123,
      height: 48,
      child: Button(
          text: text,
          handlePress: handlePress,
          initialEnabledState: initialEnabledState,
          buttonStyle: buttonStyle,
          textStyle: textStyle),
    );
  }
}