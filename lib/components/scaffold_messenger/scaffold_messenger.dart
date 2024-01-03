import 'package:flutter/material.dart';

void CustomScaffoldMessenger(BuildContext context,
    {required Color color, required String labelText}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 300),
      backgroundColor: color,
      shape: StadiumBorder(),
      content: Center(
        child: Text('${labelText}'),
      ),
    ),
  );
}
