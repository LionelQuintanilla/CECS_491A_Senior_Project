import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    this.keyboardType,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.maxLength = 30,
    this.controller,
    required this.textCapitalization
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      autocorrect: false,
      textCapitalization: textCapitalization,
      validator: validator,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black, width: 5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black, width: 5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.red, width: 5)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.red, width: 5)),
        )
      );
  }
}