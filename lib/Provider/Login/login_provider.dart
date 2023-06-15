import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hairdresser/Controller/Login/login_controller.dart';
import 'package:hairdresser/Service/firebase_service.dart';

final loginControllerProvider = Provider<LoginController>((ref) {
  final firebaseService = FirebaseService();
  return LoginController(firebaseService);
});
