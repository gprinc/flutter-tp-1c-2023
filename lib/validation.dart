import 'package:intl/intl.dart';

class Validator {
  static String? required(value) {
    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    }
    return null;
  }

  static String? alphabetic(value) {
    return value.contains(RegExp('^[a-zA-Z ]+\$')) ? null : 'Campo alfabetico';
  }

  static String? alphanumeric(value) {
    return value.contains(RegExp('^[a-zA-Z0-9 ]+\$'))
        ? null
        : 'Campo alfabetico';
  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo requerido';
    }

    final phoneRegExp = RegExp(r'^\+\d{1,3}\d{6,14}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Telefono invalido';
    }

    return null;
  }

  static String? isInt(value) {
    return int.tryParse(value) != null ? null : 'Campo numerico';
  }

  static String? dateValidator(String? value) {
    if (value == null || value == '') return 'Campo requerido';
    try {
      var dateTime2 = DateFormat('dd/MM/yy').parse(value);
      return null;
    } on Exception {
      return 'Fecha invalida';
    }
  }

  static String? emailValidator(email) {
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

  static String? passwordValidator(pass) {
    //RegExp regex =
    //    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return null;
    //return !regex.hasMatch(pass) ? 'Ingrese contraseña valida' : null;
  }

  static String? requiredAlpha(value) {
    String? isPresent = required(value);
    return isPresent ?? alphabetic(value);
  }

  static String? requiredAlphaNum(value) {
    String? isPresent = required(value);
    return isPresent ?? alphanumeric(value);
  }

  static String? requiredInt(value) {
    String? isPresent = required(value);
    return isPresent ?? isInt(value);
  }

  static String? requiredEmail(value) {
    String? isPresent = required(value);
    return isPresent ?? emailValidator(value);
  }

  static String? requiredPassword(value) {
    String? isPresent = required(value);
    return isPresent ?? passwordValidator(value);
  }
}
