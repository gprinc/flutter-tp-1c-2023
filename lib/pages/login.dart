import 'package:dam_1c_2023/cells/forms.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: LoginForm(),
        ),
      ),
    );
  }
}
