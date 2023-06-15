import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hairdresser/Constant/state.dart';
import 'package:hairdresser/Service/firebase_service.dart';

class HomeController extends StateNotifier<States> {
  final FirebaseService _firebaseService;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  HomeController(this._firebaseService) : super(States.initial);

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String userName = '';
  List<String> salons = [];
  List<Map<String, dynamic>> reservations = [];
  String selectedSalon = '';
  String selectedDate = '';
  String selectedTime = '';

  Future<void> init() async {
    salons = await _firebaseService.getSalons();
    reservations = await _firebaseService.getUserReservations();
  }

  Future<void> addReservation() async {
    if (selectedSalon.isNotEmpty &&
        selectedDate.isNotEmpty &&
        selectedTime.isNotEmpty) {
      // Seçilen kuaförün bilgilerini ayır
      List<String> salonInfo = selectedSalon.split(' -*- ');
      String salonName = salonInfo[0];
      String salonAddress = salonInfo[1];

      await _firebaseService.addReservation(salonName, salonAddress,
          selectedDate, selectedTime, _firebaseAuth.currentUser!.uid);
      reservations = await _firebaseService.getUserReservations();
      clearForm();
    }
  }

  void clearForm() {
    userNameController.clear();
    dateController.clear();
    timeController.clear();
    selectedSalon = '';
    selectedDate = '';
    selectedTime = '';
  }

  Future<void> removeReservation(int index) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final reservation = reservations[index];
      final reservationId = reservation['id'];
      final documentReference = FirebaseFirestore.instance
          .collection('Reservation')
          .doc(reservationId);

      await documentReference.delete();

      // Silinen rezervasyonu yerel listeden de kaldırın
      reservations.removeAt(index);
    }
  }
}
