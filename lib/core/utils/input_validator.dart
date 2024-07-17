import 'package:flutter/services.dart';

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 8;

  bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }

  bool isConformPassword(String newPassword, String conformPassword) =>
      newPassword == conformPassword;

  bool isCheckTextFieldIsEmpty(String val) => val.isNotEmpty;
}

class RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final int? newInt = int.tryParse(newValue.text);
    if (newInt == null) {
      return oldValue;
    }

    if (newInt < min || newInt > max) {
      return oldValue;
    }

    return newValue;
  }
}
