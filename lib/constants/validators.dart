import 'common_string.dart';

String? emailValidator(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (value!.isEmpty) {
    return CommonString.emailValidationText;
  } else if (!regex.hasMatch(value)) {
    return CommonString.emailValidationFormateText;
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value!.isEmpty) {
    return CommonString.phonValidationText;
  }
  if (value.length < 9 || value.length > 11) {
    return CommonString.phonInvalidValidationText;
  }
  return null;
}

String? passwordValidatorForRegister(String? value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);

  if (value!.isEmpty) {
    return CommonString.passwordValidation;
  } else if (value.length < 8) {
    return CommonString.minEightCharcters;
  } else if (value.length > 16) {
    return CommonString.maxCharcters;
  } else if (!regExp.hasMatch(value)) {
    return CommonString.lowercasePassword;
  } else if (value.contains(' ')) {
    return CommonString.spaceNotAllowed;
  }
  return null;
}

String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Username is required';
  } else if (value.length < 4) {
    return 'Username must be at least 4 characters long';
  } else if (!RegExp(r'^[a-z0-9_]+$').hasMatch(value)) {
    return 'Only lowercase letters, numbers, and underscores allowed';
  }
  return null;
}
