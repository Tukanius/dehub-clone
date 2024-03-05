import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatefulWidget {
  final String labelText;
  final Function() onClick;
  final Color? labelColor;
  final Color? textColor;
  final Color? borderColor;
  final String? svgIcon;
  const CustomButton({
    this.svgIcon,
    this.borderColor,
    this.textColor,
    this.labelColor,
    required this.onClick,
    this.labelText = '',
    super.key,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 48,
        width: 360,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.grey,
            backgroundColor: widget.labelColor,
            side: BorderSide(color: widget.borderColor ?? transparent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: widget.onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.svgIcon != null)
                SvgPicture.asset(
                  widget.svgIcon!,
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                      widget.textColor ?? white, BlendMode.srcIn),
                ),
              SizedBox(
                width: widget.svgIcon == null ? 0 : 5,
              ),
              Text(
                widget.labelText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: widget.textColor ?? white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
