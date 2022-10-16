import 'package:flutter/material.dart';

void snackbar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    backgroundColor: const Color.fromARGB(255, 214, 106, 18),
    content: Text(
      message,
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
