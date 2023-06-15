import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hairdresser/Controller/Home/home_controller.dart';
import 'package:hairdresser/Service/firebase_service.dart';

final homeControllerProvider = Provider<HomeController>((ref) {
  final firebaseService = FirebaseService();
  return HomeController(firebaseService);
});
