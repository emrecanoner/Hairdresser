import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hairdresser/Controller/Register/register_controller.dart';

import '../provider.dart';

final registerControllerProvider = Provider<RegisterController>((ref) {
  final firebaseService = ref.watch(authServiceProvider);
  return RegisterController(firebaseService: firebaseService);
});
