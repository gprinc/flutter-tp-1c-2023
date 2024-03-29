import 'package:dam_1c_2023/atoms/logos.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../molecules/inputs.dart';
import '../tokens/token_colors.dart';
import '../validation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _enabled = true;
  late bool _isFresh;
  late TextEditingController _emailController;
  late TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    setState(() {
      _isFresh = true;
    });
  }

  bool _isComplete() {
    return _emailController.text.isNotEmpty && _passController.text.isNotEmpty;
  }

  _validate() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Validating')),
      );

      bool isValid = await Provider.of<UserService>(context, listen: false)
          .loginUser(_emailController.text, _passController.text);

      if (isValid) {
        // Navigate to home screen
        context.goNamed('home', params: {'index': '0'});
      } else {
        // Display an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            onChanged: () {
              setState(() {
                _enabled = _isComplete();
                _isFresh = false;
              });
            },
            child: Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    squareLogo,
                    const SizedBox(
                      height: 32,
                    ),
                    LabelTextInput(
                      placeHolder: 'Email',
                      controller: _emailController,
                      validator: Validator.emailValidator,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    LabelTextInput(
                      placeHolder: 'Contraseña',
                      controller: _passController,
                      validator: Validator.passwordValidator,
                      obscureInput: true,
                      label: 'Contraseña',
                    ),
                  ]),
                ),
              ),
            )),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CtaButton(
              text: 'Iniciar Sesión',
              handlePress: _validate,
              enabledState: _isFresh ? false : _enabled,
              disableAfterPress: true,
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () => context.goNamed('signup'),
              child: Text('No tengo cuenta', style: btnModif(primary)),
            )
          ],
        )
      ],
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
  late TextEditingController _emailController;
  late TextEditingController _passController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
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
    //RegExp regex =
    //    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (pass == null || pass.isEmpty) return 'Ingrese una contraseña';
    return null;
    //return !regex.hasMatch(pass) ? 'Ingrese contraseña valida' : null;
  }

  String? nameValidator(String? name) {
    if (name == null || name.isEmpty) return 'Campo requerido';
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');
    return !regex.hasMatch(name) ? 'Ingrese solo letras y espacios' : null;
  }

  _validate() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Validando')),
      );
      // context.goNamed('welcome');
      Provider.of<UserService>(context, listen: false)
          .registerUser(_emailController.text, _firstNameController.text,
              _lastNameController.text, _passController.text)
          .then((value) => context.goNamed('welcome'));
    }
  }

  bool _isComplete() {
    return _emailController.text.isNotEmpty &&
        _passController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          onChanged: () {
            setState(() {
              _enabled = _isComplete();
              _isFresh = false;
            });
          },
          child: Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo.png',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    LabelTextInput(
                      placeHolder: 'Ej: Juan ',
                      controller: _firstNameController,
                      validator: nameValidator,
                      label: 'Nombre',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    LabelTextInput(
                      placeHolder: 'Ej: Barcena',
                      controller: _lastNameController,
                      validator: nameValidator,
                      label: 'Apellido',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    LabelTextInput(
                      placeHolder: 'Ej: juanbarcena@mail.com',
                      controller: _emailController,
                      validator: emailValidator,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    LabelTextInput(
                      placeHolder: 'Ej: ABCD1234',
                      controller: _passController,
                      validator: passwordValidator,
                      obscureInput: true,
                      label: 'Contraseña',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //const SizedBox(height: 16),
        CtaButton(
          text: 'Registrarme',
          handlePress: _validate,
          enabledState: _isFresh ? false : _enabled,
          disableAfterPress: true,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.goNamed('login'),
          child: Text('Ya tengo cuenta', style: btnModif(primary)),
        ),
      ],
    );
  }
}
