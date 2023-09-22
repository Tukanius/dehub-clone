import 'package:flutter/material.dart';

class FieldCard extends StatefulWidget {
  final Function()? onClick;
  final double marginHorizontal;
  final double marginVertical;
  final Color? color;
  final String? labelText;
  final String? secondText;
  final Color? labelTextColor;
  final String? thirdText;
  final Color? secondTextColor;
  final bool? hasThirdText;
  final Color? thirdTextColor;
  final Color? arrowColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  const FieldCard({
    Key? key,
    this.fontWeight,
    this.fontSize,
    this.arrowColor,
    this.thirdTextColor,
    this.thirdText,
    this.hasThirdText,
    this.secondTextColor,
    this.labelTextColor,
    this.secondText,
    this.color,
    this.labelText,
    required this.marginHorizontal,
    required this.marginVertical,
    this.onClick,
  }) : super(key: key);

  @override
  State<FieldCard> createState() => _FieldCardState();
}

class _FieldCardState extends State<FieldCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        color: widget.color,
        padding: EdgeInsets.symmetric(
          horizontal: widget.marginHorizontal,
          vertical: widget.marginVertical,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.labelText}',
              style: TextStyle(
                color: widget.labelTextColor,
              ),
            ),
            Row(
              children: [
                Text(
                  '${widget.secondText}',
                  style: TextStyle(
                    color: widget.secondTextColor,
                    fontSize: widget.fontSize ?? widget.fontSize,
                    fontWeight: widget.fontWeight ?? widget.fontWeight,
                  ),
                ),
                widget.hasThirdText == true
                    ? Text(
                        '${widget.thirdText}',
                        style: TextStyle(color: widget.thirdTextColor),
                      )
                    : SizedBox(),
                widget.onClick != null
                    ? Icon(
                        Icons.arrow_forward_ios,
                        color: widget.arrowColor,
                        size: 14,
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
