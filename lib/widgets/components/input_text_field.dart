import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String errorLabel;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;

  const InputTextField({
    super.key,
    required this.controller,
    required this.label,
    this.errorLabel = 'Por favor, insira um email válido.',
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorLabel;
        }
        return null;
      },
    );
  }
}
