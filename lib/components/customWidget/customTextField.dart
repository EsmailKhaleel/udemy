// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget CustomTextField({
  // required this.onClick,
  required String hint,
  required IconData icon,
  required TextEditingController controller,
  required String label,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required TextInputType type,
  IconData? Suffix,
  void Function()? suffixPressed,
  void Function()? onTap,
  bool isClickable = true,
  void Function(String)? onSubmit,
  String? textData,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        initialValue: textData,
        onFieldSubmitted: onSubmit,
        enabled: isClickable,
        onTap: onTap,
        keyboardType: type,
        controller: controller,
        // onSaved: onClick(key),
        obscureText: isPassword,
        validator: validate,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          suffixIcon: Suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed;
                  },
                  icon: Icon(Suffix),
                )
              : null,
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey)),
        ),
      ),
    );
