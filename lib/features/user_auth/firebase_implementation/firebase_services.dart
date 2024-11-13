import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;

  Future<User?> registerWithEmailPassword(String email, String password) async
    try {
      UserCredential authResult = await _firebaseAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The email address is already been in use.');
      } else {
        print('An error occured: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuthInstance
          .signInWithEmailAndPassword(email: email, password: password);
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'Wrong-Password') {
        print('Invalid email or password.');
      } else {
        print('An error has been occured: ${e.code}');
      }
    }
    return null;
  }

}