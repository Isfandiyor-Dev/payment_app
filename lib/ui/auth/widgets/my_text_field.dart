import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextInputType textInputType;
  final String label;
  final bool isObscuringField;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const MyTextField({
    super.key,
    required this.textInputType,
    required this.label,
    this.isObscuringField = false,
    required this.controller,
    required this.validator,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isObscure = true;

  bool obscure() {
    if (widget.isObscuringField) {
      return isObscure;
    } else {
      return false;
    }
  }

  Widget? sufixIconObscure() {
    if (widget.isObscuringField) {
      return IconButton(
        onPressed: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        icon: isObscure
            ? const Icon(CupertinoIcons.eye_slash_fill)
            : const Icon(CupertinoIcons.eye_fill),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      obscureText: obscure(),
      validator: widget.validator,
      decoration: InputDecoration(
        label: Text(widget.label),
        border: const OutlineInputBorder(),
        fillColor: Colors.blue[50],
        filled: true,
        suffixIcon: sufixIconObscure(),
      ),
    );
  }
}
