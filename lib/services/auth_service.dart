// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // Sign In function
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userID", user.uid);
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthXatoligi: ${e.message}");
      return e.message;
    } catch (e) {
      print("SignIn error: $e");
      return "Hisobga kirib bo'lmadi: $e";
    }
    return null;
  }

  // Sign Up function
  Future<String?> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _db.collection("users").doc(user.uid).set({
          "id": user.uid,
          "name": name,
          "email": email,
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userID", user.uid);
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthXatoligi: ${e}");
      return e.message;
    } catch (e) {
      print("SignUp error: $e");
      return "Xatolik, ro'yxatdan o'tib bo'lmadi: $e";
    }
    return null;
  }

  // Logout function
  Future<void> signOut() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userID');
  }

  // SharedPreferences'dan foydalanuvchini olish
  Future<String?> getUserIdFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID');
  }
}
