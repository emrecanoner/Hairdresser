import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hairdresser/Service/firebase_service.dart';

final authServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});
