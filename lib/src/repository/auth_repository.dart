import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/src/widget/build_dialog.dart';

class AuthRepository {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<int> register(email, password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (user.user != null) {
        await FirebaseFirestore.instance.collection('user').add({
          'idUser': user.user!.uid,
          'email': user.user!.email,
          'phone': '',
          'avatar': '',
          'fullName': '',
        }); 
      }
      return 1;
    } catch (error) {
      print("aa");
      FirebaseAuthException exception = error as FirebaseAuthException;
      print("err = " + exception.code);
      switch (exception.code) {
        case 'invalid-email':
          return 2;
        case 'email-already-in-use':
          return 3;
        case 'weak-password':
          return 4;
        default:
          return 0;
      }
    }
  }

  Future<int> login(email, password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return 1;
    } catch (error) {
      FirebaseAuthException exception = error as FirebaseAuthException;
      print("err = " + exception.code);
      switch (exception.code) {
        case 'invalid-email':
          return 2;
        case 'wrong-password':
          return 3;
        case 'user-not-found':
          return 4;
        default:
          return 0;
      }
    }
  }

  Future<bool> googleSignIn() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print(googleUser!.email + ' lambiengcode');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print(googleAuth);
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (error) {
      print("error: $error");
      return false;
    }
  }

  // Future<void> googleSignOut() => _googleSignIn.disconnect();
}
