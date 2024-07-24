import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  //initialize object for firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign up function (for account create)
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      //User credential for create account -> in built function
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //if user created then user data will return by this statement
      return credential.user;
    } catch (e) {
      //if user not created then this error msg will printed
      print('something went wrong');
    }
    return null;
  }

  //function created for user login
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      //by this function user can login into app by email password
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('something went wrong');
    }
    return null;
  }
}
