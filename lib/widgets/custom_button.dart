import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String labelText;
  final Function() onClick;
  final Color? labelColor;
  final Color? textColor;
  final bool? isGradient;
  final Container? container;
  final LinearGradient? gradient;
  final bool? isLoading;
  CustomButton({
    this.isLoading,
    this.gradient,
    this.container,
    this.isGradient,
    this.textColor,
    this.labelColor,
    required this.onClick,
    this.labelText = '',
    Key? key,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0.7,
        duration: Duration(milliseconds: 50),
        curve: Curves.slowMiddle,
        child: GestureDetector(
          onTap: () {
            setState(() {
              isVisible = false;
            });
            Future.delayed(Duration(milliseconds: 50), () {
              setState(() {
                isVisible = true;
              });
            });
            widget.onClick();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 48,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.isGradient == false || widget.isGradient == null
                  ? widget.labelColor
                  : null,
              gradient: widget.isGradient == true ? widget.gradient : null,
            ),
            child: widget.isLoading == true
                ? Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: white,
                      ),
                    ),
                  )
                : widget.isGradient != true
                    ? Center(
                        child: Text(
                          '${widget.labelText}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: widget.textColor == null
                                ? white
                                : widget.textColor,
                          ),
                        ),
                      )
                    : widget.container != null
                        ? widget.container
                        : Center(
                            child: Text(
                              '${widget.labelText}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: widget.textColor == null
                                    ? white
                                    : widget.textColor,
                              ),
                            ),
                          ),
          ),
        ),
      ),
    );
  }
}
