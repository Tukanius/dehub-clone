import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class RegisterLetter extends StatefulWidget {
  final String? text;
  final Function()? onPressed;
  final double width;
  final double height;
  final Color? color;
  final Color textColor;
  final double fontSize;
  final Radius radius;

  const RegisterLetter({
    super.key,
    this.text,
    this.onPressed,
    this.color,
    this.width = 50,
    this.height = 50,
    this.textColor = buttonColor,
    this.radius = const Radius.circular(10.0),
    this.fontSize = 16,
  });

  @override
  RegisterItemState createState() => RegisterItemState();
}

class RegisterItemState extends State<RegisterLetter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: widget.color ?? black,
          border: Border.all(
            color: greyDark.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.all(widget.radius)),
      child: GestureDetector(
        onTap: widget.onPressed ?? () {},
        child: Container(
          color: transparent,
          child: Center(
            child: Text(
              widget.text ?? "A",
              style: TextStyle(color: black, fontSize: widget.fontSize),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
