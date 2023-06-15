import 'package:flutter/material.dart';
import 'package:hairdresser/Constant/snackbar.dart';
import 'package:lottie/lottie.dart';

void messenger(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    dismissDirection: DismissDirection.down,
    content: SnackBarClass(errorMessage: errorMessage),
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}

late BuildContext alertContext;
Future openScreen(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      alertContext = context;
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Lottie.asset("assets/jsons/scissors.json"),
      );
    },
  );
}

Future closeScreen() {
  Navigator.of(alertContext).pop(true);
  return Future.value(true);
}
