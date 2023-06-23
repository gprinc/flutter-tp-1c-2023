import 'package:dam_1c_2023/cells/cards.dart';
import 'package:dam_1c_2023/molecules/inputs.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';
import '../molecules/buttons.dart';
import '../validation.dart';

class ProfileModal extends StatefulWidget {
  const ProfileModal({super.key});

  @override
  State<ProfileModal> createState() => _ProfileModalState();
}

class _ProfileModalState extends State<ProfileModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController dateController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late String? gender;
  bool _enabled = true;
  late bool _isFresh;

  _setGender(String? value) {
    setState(() {
      gender = value;
    });
  }

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _isFresh = true;
  }

  _validate() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      print(dateController.text);
      print(_emailController.text);
      print(_phoneController.text);
      print(gender);
      Navigator.pop(context);
      //context.goNamed('home');
    }
  }

  bool _isComplete() {
    return dateController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        gender != null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: () {
        setState(() {
          _enabled = _isComplete();
          _isFresh = false;
        });
      },
      key: _formKey,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 35, bottom: 33),
        child: Column(children: [
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context))
              /*IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: btnSecondary)),*/
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: const [
              Text(
                'Datos de perfil',
                style: headLine01,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          LabelDateInput(
              validator: Validator.dateValidator,
              controller: dateController,
              placeHolder: 'DD/MM/YYYY',
              label: 'Fecha de nacimiento'),
          const SizedBox(
            height: 30,
          ),
          InputCard(handlePick: _setGender),
          const SizedBox(
            height: 24,
          ),
          ProfilePicture(),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              const Text(
                'DATOS DE CONTACTO',
                style: headLine01,
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Estos datos serán compartidos con la organización para ponerse en contacto contigo',
            textAlign: TextAlign.start,
            style: subtitle01,
          ),
          const SizedBox(
            height: 16,
          ),
          LabelTextInput(
            placeHolder: 'Ej: +541178445459',
            controller: _phoneController,
            validator: Validator.phoneNumberValidator,
            label: 'Telefono',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(
            height: 22,
          ),
          LabelTextInput(
            placeHolder: 'Ej: mimail@mail.com',
            controller: _emailController,
            validator: Validator.emailValidator,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 38,
          ),
          CtaButton(
            text: 'Guardar datos',
            handlePress: _validate,
            enabledState: _isFresh ? false : _enabled,
            disableAfterPress: true,
          ),
        ]),
      ),
    );
  }
}
