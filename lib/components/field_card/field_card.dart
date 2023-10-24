import 'package:dehub/widgets/dialog_manager/colors.dart';
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
  final Color? thirdTextColor;
  final Color? arrowColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? validate;
  final GlobalKey? fbKey;
  final FontWeight? secondTextFontWeight;
  const FieldCard({
    Key? key,
    this.secondTextFontWeight,
    this.fbKey,
    this.validate,
    this.fontWeight,
    this.fontSize,
    this.arrowColor,
    this.thirdTextColor,
    this.thirdText,
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
        key: widget.fbKey,
        decoration: BoxDecoration(
          color: widget.color,
          border:
              Border.all(color: widget.validate == true ? red : transparent),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widget.marginHorizontal,
          vertical: widget.marginVertical,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                '${widget.labelText}',
                style: TextStyle(
                  color: widget.validate == true ? red : widget.labelTextColor,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Expanded(
                      child: widget.secondText != null
                          ? Text(
                              '${widget.secondText}',
                              style: TextStyle(
                                color: widget.validate == true
                                    ? red
                                    : widget.secondTextColor,
                                fontSize: widget.fontSize ?? widget.fontSize,
                                fontWeight: widget.fontWeight != null
                                    ? widget.fontWeight
                                    : widget.secondTextFontWeight != null
                                        ? widget.secondTextFontWeight
                                        : FontWeight.normal,
                              ),
                              textAlign: TextAlign.end,
                            )
                          : Text(
                              '-',
                              style: TextStyle(
                                color: widget.secondTextColor,
                                fontSize: widget.fontSize ?? widget.fontSize,
                                fontWeight: widget.fontWeight != null
                                    ? widget.fontWeight
                                    : widget.secondTextFontWeight != null
                                        ? widget.secondTextFontWeight
                                        : FontWeight.normal,
                              ),
                              textAlign: TextAlign.end,
                            )),
                  widget.thirdText != null
                      ? Text(
                          '${widget.thirdText}',
                          style: TextStyle(
                              color: widget.thirdTextColor,
                              fontWeight: widget.secondTextFontWeight ??
                                  widget.secondTextFontWeight),
                        )
                      : SizedBox(),
                  SizedBox(
                    width: widget.onClick == null ? 0 : 10,
                  ),
                  widget.onClick != null
                      ? Icon(
                          Icons.arrow_forward_ios,
                          color:
                              widget.validate == true ? red : widget.arrowColor,
                          size: 14,
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
