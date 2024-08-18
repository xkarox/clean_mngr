import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String labelText;
  final Function(String value) validator;
  final TextEditingController controller;
  final bool isObscure;

  const AuthField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.validator,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a value';
          }
          return validator(value);
        },
        decoration: InputDecoration(labelText: labelText, border: InputBorder.none),
      ),
    );
  }
}
