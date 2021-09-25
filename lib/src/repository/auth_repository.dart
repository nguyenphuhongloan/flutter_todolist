import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
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

  Future<void> googleSignIn() async {
    try {
     
      GoogleSignInAccount? user = await _googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await user!.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print("error: $error");
    }
   
  }

  Future<void> googleSignOut() => _googleSignIn.disconnect();
}
