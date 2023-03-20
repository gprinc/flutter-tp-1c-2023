import 'package:dam_1c_2023/atoms/logos.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';

import '../molecules/inputs.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _enabled = true;
  late bool _isFresh;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isFresh = true;
    });
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return 'Campo requerido';

    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return !regex.hasMatch(email) ? 'Ingrese un mail valido' : null;
  }

  String? passwordValidator(String? pass) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (pass == null || pass.isEmpty) return 'Ingrese una contraseña';

    return !regex.hasMatch(pass) ? 'Ingrese contraseña valida' : null;
  }

  _validate() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Validando')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      onChanged: () {
        setState(() {
          _enabled = _formKey.currentState!.validate();
          _isFresh = false;
        });
      },
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          squareLogo,
          const SizedBox(
            height: 38,
          ),
          Input(
            placeHolder: 'Email',
            validator: emailValidator,
          ),
          const SizedBox(
            height: 46,
          ),
          Input(
            placeHolder: 'Contraseña',
            validator: passwordValidator,
            obscureInput: true,
          ),
          const SizedBox(
            height: 141,
          ),
          CtaButton(
            text: 'Ingresar',
            handlePress: _validate,
            enabledState: _isFresh ? false : _enabled,
            disableAfterPress: true,
          ),
          const SizedBox(
            height: 28,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('No tengo cuenta', style: btn),
          )
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _enabled = true;
  late bool _isFresh;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isFresh = true;
    });
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return 'Campo requerido';

    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return !regex.hasMatch(email) ? 'Ingrese un mail valido' : null;
  }

  String? passwordValidator(String? pass) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (pass == null || pass.isEmpty) return 'Ingrese una contraseña';

    return !regex.hasMatch(pass) ? 'Ingrese contraseña valida' : null;
  }

  String? nameValidator(String? name) {
    if (name == null || name.isEmpty) return 'Campo requerido';
    return null;
  }

  _validate() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Validando')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      onChanged: () {
        setState(() {
          _enabled = _formKey.currentState!.validate();
          _isFresh = false;
        });
      },
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          squareLogo,
          const SizedBox(
            height: 25,
          ),
          LabelTextInput(
            placeHolder: 'Ej: Juan',
            validator: nameValidator,
            label: 'Nombre',
          ),
          const SizedBox(
            height: 25,
          ),
          LabelTextInput(
            placeHolder: 'Ej: Barcena',
            validator: nameValidator,
            label: 'Apellido',
          ),
          const SizedBox(
            height: 25,
          ),
          LabelTextInput(
            placeHolder: 'Contraseña',
            validator: passwordValidator,
            obscureInput: true,
            label: 'Ej: ABCD1234',
          ),
          const SizedBox(
            height: 25,
          ),
          LabelTextInput(
            placeHolder: 'Email',
            validator: emailValidator,
            label: 'Ej: juanbarcena@mail.com',
          ),
          const SizedBox(
            height: 80,
          ),
          CtaButton(
            text: 'Ingresar',
            handlePress: _validate,
            enabledState: _isFresh ? false : _enabled,
            disableAfterPress: true,
          ),
          const SizedBox(
            height: 5,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Ya tengo cuenta', style: btn),
          )
        ],
      ),
    );
  }
}
