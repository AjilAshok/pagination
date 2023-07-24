import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  User? _user;

  User? get user => _user;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  void _verificationCompleted(PhoneAuthCredential credential) {
    _signInWithCredential(credential);
  }

  void _verificationFailed(FirebaseAuthException e) {
    // Handle verification failure, if needed.
    print('Verification failed: ${e.message}');
  }

  void _codeSent(String verificationId, int? resendToken) {
    _verificationId = verificationId;
    // Perform any actions when OTP code is sent.
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    _verificationId = verificationId;
    // Perform any actions when OTP auto-retrieval timeout.
  }

  Future<void> signInWithOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      _signInWithCredential(credential);
    } catch (e) {
      // Handle sign-in with OTP failure, if needed.
      print('Sign in with OTP failed: ${e.toString()}');
    }
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      final authResult = await _auth.signInWithCredential(credential);
      _user = authResult.user;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", _user!.uid);
      notifyListeners(); // Notify listeners about the updated user state
    } catch (e) {
      // Handle sign-in with credential failure, if needed.
      print('Sign in with credential failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("user_id");
      notifyListeners();
    } catch (e) {
      print('Sign out failed: ${e.toString()}');
    }
  }
}
