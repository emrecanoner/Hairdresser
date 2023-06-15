import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hairdresser/Constant/state.dart';
import 'package:hairdresser/Service/firebase_service.dart';

class ProfileController extends StateNotifier<States> {
  final FirebaseService firebaseService;

  ProfileController({required this.firebaseService}) : super(States.initial);
}
