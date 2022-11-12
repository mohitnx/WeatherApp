import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: Duration(milliseconds: 999),
    elevation: 10,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: Color.fromARGB(255, 85, 7, 255),
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
