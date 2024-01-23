import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatefulWidget {
  final Color color;
  const CustomBackButton({
    super.key,
    required this.color,
  });

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
        color: transparent,
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new,
              color: widget.color,
            ),
            const SizedBox(
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
