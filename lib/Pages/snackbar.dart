import 'package:flutter/material.dart';
import 'package:weatherweather/theme/constants.dart';

void showSnackBar(BuildContext context, String message) {
  final colorScheme = Theme.of(context).colorScheme;
  final snackBar = SnackBar(
    duration: Duration(milliseconds: 999),
    elevation: 10,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: colorScheme.primary,
    content: Text(
      message,
      style: TextStyle(color: colorScheme.surface),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
