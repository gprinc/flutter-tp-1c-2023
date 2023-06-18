import 'package:flutter/material.dart';

class ApplyDialog extends StatelessWidget {
  final String title;
  final String cancelButtonText;
  final String confirmButtonText;
  final void Function() onCancelPressed;
  final void Function() onConfirmPressed;

  const ApplyDialog({
    Key? key,
    required this.title,
    required this.cancelButtonText,
    required this.confirmButtonText,
    required this.onCancelPressed,
    required this.onConfirmPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Te estas por postular a',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 20 / 16,
              letterSpacing: 0.15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 20,
              height: 24 / 20,
              letterSpacing: 0.15,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        SizedBox(
          width: 80,
          height: 36,
          child: TextButton(
            onPressed: onCancelPressed,
            child: Text(
              cancelButtonText,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 20 / 14,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 90,
          height: 36,
          child: TextButton(
            onPressed: onConfirmPressed,
            child: Text(
              confirmButtonText,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 20 / 14,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
