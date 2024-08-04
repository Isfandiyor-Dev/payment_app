import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/blocs/auth/auth_bloc.dart';
import 'package:payment_app/blocs/auth/auth_event.dart';
import 'package:payment_app/blocs/auth/auth_state.dart';
import 'package:payment_app/ui/auth/widgets/my_text_field.dart';
import 'package:payment_app/ui/auth/widgets/validators.dart';

class RegisterScreen extends StatefulWidget {
  final void Function() togglePage;
  const RegisterScreen({super.key, required this.togglePage});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _onTapRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SingUpEvent(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state is AuthError) {
            Navigator.pop(context);
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
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Center(
                    child: Icon(
                      Icons.lock,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Create a Payment account",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  MyTextField(
                    textInputType: TextInputType.name,
                    label: "Name",
                    controller: nameController,
                    validator: Validators.validateName,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  MyTextField(
                    textInputType: TextInputType.visiblePassword,
                    label: "Confirm Password",
                    controller: confirmPasswordController,
                    isObscuringField: true,
                    validator: (value) => Validators.validateConfirmPassword(
                      value,
                      passwordController.text,
                    ),
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
                          onPressed: _onTapRegister,
                          child: const Text(
                            "Register",
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
