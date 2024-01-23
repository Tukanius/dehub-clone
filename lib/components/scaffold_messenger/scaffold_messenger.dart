import 'package:flutter/material.dart';

void customScaffoldMessenger(BuildContext context,
    {required Color color, required String labelText}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 300),
      backgroundColor: color,
      shape: const StadiumBorder(),
      content: Center(
        child: Text(labelText),
      ),
    ),
  );
}
