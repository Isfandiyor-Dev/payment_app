import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/blocs/auth/auth_bloc.dart';
import 'package:payment_app/blocs/auth/auth_event.dart';
import 'package:payment_app/blocs/auth/auth_state.dart';
import 'package:payment_app/ui/auth/widgets/my_text_field.dart';
import 'package:payment_app/ui/auth/widgets/validators.dart';

class LoginScreen extends StatefulWidget {
  final void Function() togglePage;
  const LoginScreen({super.key, required this.togglePage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onTapLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SingInEvent(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          } else if (state is AuthAuthenticated) {
            Navigator.of(context, rootNavigator: true).pop();
          } else if (state is AuthError) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  const Center(
                    child: Icon(
                      Icons.lock,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Login to Payment account",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  MyTextField(
                    textInputType: TextInputType.emailAddress,
                    label: "Email",
                    controller: emailController,
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    textInputType: TextInputType.visiblePassword,
                    label: "Password",
                    controller: passwordController,
                    isObscuringField: true,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            overlayColor: Colors.blue,
                            fixedSize: const Size(double.infinity, 65),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: _onTapLogin,
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: widget.togglePage,
                        child: const Text("Sign up"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
