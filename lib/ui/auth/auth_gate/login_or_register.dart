import 'package:flutter/material.dart';
import 'package:payment_app/ui/auth/login/login_screen.dart';
import 'package:payment_app/ui/auth/register/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isLoginPage = true;

  void togglePage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return LoginScreen(
        togglePage: togglePage,
      );
    } else {
      return RegisterScreen(
        togglePage: togglePage,
      );
    }
  }
}
