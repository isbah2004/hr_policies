import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr_policies/Utils/utils.dart';
import 'package:hr_policies/homescreen/home_screen.dart';

class ObscureTextProvider extends ChangeNotifier {
  bool _isNotVisible = true;
  bool get isNotVisible => _isNotVisible;
  void setVisibility() {
    _isNotVisible = !_isNotVisible;
    notifyListeners();
  }
}

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login(
      {required TextEditingController emailController,
      required TextEditingController passwordController,
      required BuildContext context}) async {
    try {
      setLoading(true);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomeScreen()), // Replace with your Home screen
      );
    } on FirebaseAuthException catch (e) {
      // Handle login error
      Utils.showMessage(
          context: context, title: 'Error', message: e.toString());
    } finally {
      setLoading(false);
    }
  }
}

class SignUpProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signUp(
      {required TextEditingController emailController,
      required TextEditingController passwordController,
      required BuildContext context}) async {
    try {
      setLoading(true);
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomeScreen()), // Replace with your Home screen
      );
    } on FirebaseAuthException catch (e) {
      // Handle sign-up error
      Utils.showMessage(
          context: context, title: 'Error', message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> resetPassword(
      {required TextEditingController emailController,
      required BuildContext context}) async {
    setLoading(true);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent to your email.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setLoading(false);
    }
  }
}

class ResetProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> resetPassword(
      {required TextEditingController emailController,
      required BuildContext context}) async {
    setLoading(true);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent to your email.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setLoading(false);
    }
  }
}
