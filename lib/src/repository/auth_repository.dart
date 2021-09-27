import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  Future<bool> register(email, password) async {
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
      return true;
    }
    return false;
  }

  Future<bool> login(email, password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return true;
    } catch (error) {
      FirebaseAuthException exception = error as FirebaseAuthException;
      switch (exception.code) {
        case '':
          break;
        default:
      }
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
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
