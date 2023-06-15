import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hairdresser/Controller/Profile/profile_controller.dart';
import 'package:hairdresser/Provider/provider.dart';

final profileControllerProvider = Provider<ProfileController>((ref) {
  final firebaseService = ref.watch(authServiceProvider);
  return ProfileController(firebaseService: firebaseService);
});
