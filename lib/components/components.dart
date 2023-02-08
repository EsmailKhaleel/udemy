// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../shop_app/cubit/cubit.dart';
import '../shop_app/models/favourites_model.dart';

void navigateTo(context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

//______________________________________________________________________________
void navigateNoBack(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    ((route) => false),
  );
}

//______________________________________________________________________________
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: changeToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color changeToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

//______________________________________________________________________________
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );



//______________________________________________________________________________
Widget popupMenu(context) => PopupMenuButton<MenuItem>(
      onSelected: (value) {
        if (value == MenuItem.item1) {}
        if (value == MenuItem.item2) {}
      },
      itemBuilder: (context) => [
            PopupMenuItem(
              value: MenuItem.item1,
              child: Text('Update'),
            ),
            PopupMenuItem(
              value: MenuItem.item2,
              child: Text('Delete'),
            ),
          ]);
enum MenuItem {
  item1,
  item2,
}