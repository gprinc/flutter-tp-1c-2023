import 'package:dam_1c_2023/cells/forms.dart';
import 'package:dam_1c_2023/molecules/inputs.dart';
import 'package:flutter/material.dart';

import 'cells/cards.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  String? validator(String? value) {
    if (value == null || value.isEmpty) return 'requerido';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            )),
      ),
    );
  }
}
