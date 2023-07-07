import 'package:flutter/material.dart';

SnackBar customToastMessage (String message) {
  return SnackBar(
    content: Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.blue,
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(30),

    );
}