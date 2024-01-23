import 'package:flutter/material.dart';

class ImageDialog extends StatefulWidget {
  final String link;
  const ImageDialog({super.key, required this.link});

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.vertical,
      key: GlobalKey(),
      onDismissed: (direction) {
        Navigator.of(context).pop();
      },
      child: Dialog(
        child: Image.network(
          widget.link,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
