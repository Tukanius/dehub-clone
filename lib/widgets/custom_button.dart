import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String labelText;
  final Function()? onClick;
  final Color? labelColor;
  final Color? textColor;
  CustomButton({
    this.textColor,
    this.labelColor,
    this.onClick,
    this.labelText = '',
    Key? key,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 48,
        width: 360,
        child: ElevatedButton(
          onPressed: widget.onClick,
          child: Text(
            widget.labelText.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: widget.textColor == null ? white : widget.textColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: widget.labelColor,
          ),
        ),
      ),
    );
  }
}
