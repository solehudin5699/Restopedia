import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
    required this.message,
    this.icon,
  }) : super(key: key);

  final String message;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon ??
                  const Icon(
                    Icons.error_outline,
                    size: 50,
                    color: Color.fromARGB(255, 255, 65, 59),
                  ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 65, 59),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
