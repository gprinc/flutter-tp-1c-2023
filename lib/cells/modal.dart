import 'package:flutter/material.dart';

import '../tokens/token_colors.dart';

buildModal(BuildContext context, Widget body) {
  showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        // Adjust the modal height factor based on the orientation of the device
        return FractionallySizedBox(
          heightFactor: 1.0,
          child: Container(
              decoration: const BoxDecoration(
                color: neutralBg,
              ),
              child: Column(
                children: [body],
              )),
        );
      });
}
