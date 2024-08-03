import 'package:flutter/material.dart';
import 'package:payment_app/ui/auth/widgets/my_text_field.dart';
import 'package:payment_app/ui/auth/widgets/validators.dart';

class RegisterScreen extends StatelessWidget {
  final void Function() togglePage;
  RegisterScreen({super.key, required this.togglePage});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _onTapRegister() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    value, passwordController.text),
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
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: togglePage,
                    child: Text("Sign up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
