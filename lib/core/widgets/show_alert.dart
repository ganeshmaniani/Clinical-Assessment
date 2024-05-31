import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

showAlertBox(
  BuildContext context, {
  required String title,
  required String description,
  required String btnCancelText,
  required String btnOkText,
  required DialogType dialogType,
  required AnimType animType,
  required VoidCallback btnOkOnPress,
  required VoidCallback btnCancelOnPress,
}) {
  return AwesomeDialog(
          context: context,
          btnCancelText: btnCancelText,
          btnOkText: btnOkText,
          dialogType: dialogType,
          animType: animType,
          btnOkOnPress: btnOkOnPress,
          btnCancelOnPress: btnCancelOnPress,
          title: title,
          desc: description)
      .show();
}
