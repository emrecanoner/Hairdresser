import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as material;
import 'package:hairdresser/Constant/constant.dart';
import 'package:hairdresser/Model/user_modal.dart';
import 'package:hairdresser/Pages/Profile/profile_screen.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference shops =
      FirebaseFirestore.instance.collection('Shop');
  final CollectionReference reservations =
      FirebaseFirestore.instance.collection('Reservation');

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      throw e;
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      throw error;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getCurrentUser(
      material.BuildContext context) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        final userSnapshot = await users.doc(currentUser.uid).get();
        if (userSnapshot.exists) {
          return userSnapshot;
        } else {
          messenger(context, 'Existing user not found');
        }
      } else {
        messenger(context, 'User is not logged in');
      }
    } catch (e) {
      messenger(context, e.toString());
    }
    return null;
  }

  Future? signOut(material.BuildContext context) {
    _firebaseAuth.signOut();
    return null;
  }

  Future<void> updateUserProfile(
    material.BuildContext context, {
    required String nameSurname,
    required String email,
    required String password,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser;
      openScreen(context);
      if (user != null) {
        UserCredential credential = await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(email: user.email!, password: password),
        );
        if (credential.user != null) {
          await user.updateEmail(email);
          // Parolayı güncellemek için:
          await user.updatePassword(password);

          await users.doc(user.uid).update({
            'nameSurname': nameSurname,
            'email': email,
            'password': password
          });
          await _firebaseAuth.signOut();
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);
        }
        await closeScreen();
        material.Navigator.pushReplacement(context,
            material.MaterialPageRoute(builder: (context) => ProfileScreen()));
      }
    } catch (e) {
      messenger(context, e.toString());
      await closeScreen();
    }
  }

  Future<List<String>> getSalons() async {
    List<String> salons = [];

    QuerySnapshot snapshot = await shops.get();

    for (QueryDocumentSnapshot document in snapshot.docs) {
      String salonName = document['name'];
      String salonAddress = document['address'];
      String salonInfo = '$salonName -*- $salonAddress';
      salons.add(salonInfo);
    }

    return salons;
  }

  Future<List<Map<String, dynamic>>> getUserReservations() async {
    ;
    final snapshot = await reservations
        .where('userId', isEqualTo: _firebaseAuth.currentUser!.uid)
        .get();

    return snapshot.docs.map((doc) {
      final reservation = doc.data() as Map<String, dynamic>;
      reservation['id'] = doc.reference.id;
      return reservation;
    }).toList();
  }

  Future<void> addReservation(String name, String address, String date,
      String time, String userId) async {
    await reservations.add({
      'name': name,
      'address': address,
      'date': date,
      'time': time,
      'userId': userId,
    });
  }

  Future<void> createUser(UserModal user) async {
    try {
      await users.doc(user.id).set({
        'nameSurname': user.nameSurname,
        'email': user.email,
        'password': user.password
      });
    } catch (error) {
      throw error;
    }
  }
}
