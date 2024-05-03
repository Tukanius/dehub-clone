import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCloseButton extends StatefulWidget {
  final Color? color;
  final Color? svgColor;
  const CustomCloseButton({
    super.key,
    this.color,
    this.svgColor,
  });

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
          'assets/svg/close.svg',
          colorFilter:
              ColorFilter.mode(widget.svgColor ?? white, BlendMode.srcIn),
          height: 30,
        ),
      ),
    );
  }
}
