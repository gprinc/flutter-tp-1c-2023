import 'package:flutter/material.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';

import '../atoms/icons/plus.dart';

class Button extends StatefulWidget {
  final String text;
  final void Function() handlePress;
  final bool enabledState;
  final bool disableAfterPress;
  final ButtonStyle buttonStyle;
  final TextStyle textStyle;

  const Button(
      {super.key,
      required this.text,
      required this.handlePress,
      required this.enabledState,
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
      _enabled = widget.enabledState;
    });
  }

  onPressed() {
    if (widget.disableAfterPress) {
      setState(() {
        _enabled = !_enabled;
      });
    }
    widget.handlePress.call();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _enabled = widget.enabledState;
    });
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
  final bool enabledState;
  final bool disableAfterPress;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // <-- Radius,
      ));

  final TextStyle textStyle = btn.copyWith(color: Colors.white);

  CtaButton(
      {super.key,
      required this.text,
      required this.handlePress,
      required this.enabledState,
      this.disableAfterPress = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328,
      height: 44,
      child: Button(
        text: text,
        handlePress: handlePress,
        enabledState: enabledState,
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
  final bool enabledState;
  final bool disableAfterPress;

  final TextStyle textStyle = btn;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // <-- Radius,
    ),
  );

  ShortButton({
    Key? key,
    required this.text,
    required this.handlePress,
    required this.enabledState,
    this.disableAfterPress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 123,
      child: ElevatedButton(
        onPressed: enabledState ? handlePress : null,
        style: buttonStyle,
        child: Row(
          children: [
            const PlusIcon(),
            const SizedBox(width: 5),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(text, style: textStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
