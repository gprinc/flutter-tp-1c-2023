import 'package:dam_1c_2023/cells/forms.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: LoginForm(),
      ),
      /*SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: width, minHeight: height),
          child: const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: LoginForm(),
          ),
        ),
      ),*/
    );
  }
}
