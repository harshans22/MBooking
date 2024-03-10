import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:movieticket/models/registration.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String name,
    required String password,
    required String city,
  }) async {
    String res = "some error occured";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserDetails user =
          UserDetails(Password: password, city: city, email: email, name: name);
      await _firestore
          .collection('Users')
          .doc(cred.user!.uid)
          .set(user.toJson());
      res = "success";
    } on FirebaseAuthException catch (error) {
      // this is used to show the error which is thrown my firebaseauth
      if (error.code == "email-already-in-use") {
        res = "The email address is already in use by another account.";
      } else if (error.code == "weak-password") {
        res = "Password should be at least 6 characters";
      }
    } catch (err) {
      res = err.toString();
      
    }
    return res;
  }
  //Login User
  Future<String> loginuser(
      {required String email, required String password}) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res =
            "Please enter all the fields"; //when user does not enter all the fields
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-credential") {
        res = "invalid-credential";
      }
    } catch (error) {
      res = error.toString();
    }
    //print(res);
    return res;
  }
}
