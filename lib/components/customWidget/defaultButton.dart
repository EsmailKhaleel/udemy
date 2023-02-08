import 'package:flutter/material.dart';

Widget defaultButton({
  required final String text,
  Color textColor = Colors.white,
  Color backgroundColor = Colors.purple,
  required void Function() onClicked,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(15)),
        width: double.infinity,
        child: MaterialButton(
          onPressed: onClicked,
          child: Text(
            text.toUpperCase(),
            style: TextStyle(color: textColor, fontSize: 15),
          ),
        ),
      ),
    );
