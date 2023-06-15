import 'package:flutter/material.dart' as material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hairdresser/Constant/constant.dart';
import 'package:hairdresser/Constant/state.dart';
import 'package:hairdresser/Pages/Home/home_screen.dart';
import 'package:hairdresser/Service/firebase_service.dart';

class LoginController extends StateNotifier<States> {
  final FirebaseService _firebaseService;

  LoginController(this._firebaseService) : super(States.initial);

  Future<void> loginWithEmailAndPassword(
      String email, String password, material.BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      messenger(context, "Please fill the blanks");
    } else {
      try {
        state = States.loading;
        openScreen(context);
        await _firebaseService.signInWithEmailAndPassword(email, password);
        state = States.success;
        await closeScreen();
        material.Navigator.pushReplacement(
          context,
          material.MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        await closeScreen();
        state = States.error;
        messenger(context, e.toString());
      }
    }
  }
}
