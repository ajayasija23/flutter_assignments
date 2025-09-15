import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
class FirebaseHelper{

  static void createAccountWithEmailPassword(String email,String password, Function(int code,String message) onComplete) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      onComplete(200,"Login Successful");
    } on FirebaseAuthException catch (e) {
      onComplete(400,e.message!);
      print(e);
    } on Exception catch (e) {
      onComplete(400,e.toString());
      print(e);
    }
  }
  static void loginWithEmailPassword(String email,String password, Function(int code,String message) onComplete) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      onComplete(200,"Login Successful");
    } on FirebaseAuthException catch (e) {
      onComplete(400,e.message!);
      print(e);
    } on Exception catch (e) {
      onComplete(400,e.toString());
      print(e);
    }
  }
}