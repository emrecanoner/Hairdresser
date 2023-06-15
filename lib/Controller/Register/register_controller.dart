import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart' as material;
import 'package:hairdresser/Constant/constant.dart';
import 'package:hairdresser/Constant/state.dart';
import 'package:hairdresser/Model/user_modal.dart';
import 'package:hairdresser/Pages/Login/login_screen.dart';
import 'package:hairdresser/Service/firebase_service.dart';

class RegisterController extends StateNotifier<States> {
  final FirebaseService firebaseService;

  RegisterController({required this.firebaseService}) : super(States.initial);

  Future<void> registerWithEmailAndPassword(String email, String password,
      String nameSurname, material.BuildContext context) async {
    if (nameSurname.isEmpty || email.isEmpty || password.isEmpty) {
      messenger(context, "Please fill the blanks");
    } else {
      try {
        state = States.loading;
        openScreen(context);
        // Firebase Authentication ile kullanıcı kaydı yap
        final userCredential =
            await firebaseService.registerWithEmailAndPassword(email, password);

        // Firestore'a kullanıcı bilgilerini kaydet
        final user = UserModal(
            id: userCredential.user!.uid,
            nameSurname: nameSurname,
            email: email,
            password: password);
        await firebaseService.createUser(user);
        state = States.success;
        await closeScreen();
        material.Navigator.pushReplacement(
          context,
          material.MaterialPageRoute(builder: (context) => LoginScreen()),
        );

        // Başarılı kayıt mesajı göster
        // TODO: İşlem tamamlandıktan sonra kullanıcıyı giriş sayfasına yönlendir
      } catch (e) {
        state = States.error;
        messenger(context, e.toString());
        await closeScreen();
      }
    }
  }
}
