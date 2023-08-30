import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCloseButton extends StatefulWidget {
  final Color? color;
  const CustomCloseButton({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  State<CustomCloseButton> createState() => _CustomCloseButtonState();
}

class _CustomCloseButtonState extends State<CustomCloseButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: widget.color,
        padding: const EdgeInsets.all(13),
        child: SvgPicture.asset(
          'images/close.svg',
          height: 30,
        ),
      ),
    );
  }
}
