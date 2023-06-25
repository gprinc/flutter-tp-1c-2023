import 'package:dam_1c_2023/cells/cards.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:dam_1c_2023/molecules/inputs.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../molecules/buttons.dart';
import '../validation.dart';

class ProfileModal extends StatefulWidget {
  final UserModel user;

  const ProfileModal({super.key, required this.user});

  @override
  State<ProfileModal> createState() => _ProfileModalState();
}

class _ProfileModalState extends State<ProfileModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController dateController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late String? gender;
  String? _image = null;
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
    dateController.text = widget.user.birthDay ?? '';
    _emailController.text = widget.user.email;
    _phoneController.text = widget.user.phoneNumber ?? '';
    _isFresh = true;
  }

  _validate() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      UserModel u = UserModel(
          email: widget.user.email,
          name: widget.user.name,
          lastName: widget.user.lastName,
          volunteeringId: widget.user.volunteeringId,
          birthDay: dateController.text,
          phoneNumber: _phoneController.text,
          encodedPicture: '',
          gender: gender);
      UserService().updateUser(u);
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

  void _onImageSelected(String? image) {
    setState(() {
      _image = image;
    });
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
            const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 33),
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
            height: 36,
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
            height: 24,
          ),
          LabelDateInput(
              validator: Validator.dateValidator,
              controller: dateController,
              placeHolder: 'DD/MM/YYYY',
              value: dateController.text,
              label: 'Fecha de nacimiento'),
          const SizedBox(
            height: 24,
          ),
          InputCard(handlePick: _setGender),
          const SizedBox(
            height: 24,
          ),
          ProfilePicture(
            handleImageSelect: _onImageSelected,
            encodedImage: _image,
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: const [
              Text(
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
            height: 24,
          ),
          LabelTextInput(
            placeHolder: 'Ej: +541178445459',
            controller: _phoneController,
            value: _phoneController.text,
            validator: Validator.phoneNumberValidator,
            label: 'Telefono',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(
            height: 24,
          ),
          LabelTextInput(
            placeHolder: 'Ej: mimail@mail.com',
            controller: _emailController,
            value: _emailController.text,
            validator: Validator.emailValidator,
            label: 'Mail',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 32,
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
