import 'package:dam_1c_2023/cells/forms.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: RegisterForm(),
      ),
    );
  }
}
