import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final  Function(String?) onSaved;
  final bool obscureText;

  const MyTextFormField({
    Key? key,
    required this.hintText,
    required this.onSaved,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Lütfen bilgilerinizi eksiksiz giriniz";
          }
          return null;
        },
        onSaved: onSaved,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent.shade700,
            ),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
