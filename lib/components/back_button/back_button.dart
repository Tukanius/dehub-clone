import 'package:flutter/material.dart';

class CustomBackButton extends StatefulWidget {
  final Color color;
  const CustomBackButton({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new,
              color: widget.color,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Буцах',
              style: TextStyle(
                color: widget.color,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
