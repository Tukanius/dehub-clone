import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SelectionField extends StatefulWidget {
  final Function()? onClick;
  final String? value;
  final String hintText;
  final String? labelText;
  final Color? backgroundColor;
  final Color? labelTextColor;
  const SelectionField({
    super.key,
    this.labelTextColor,
    this.backgroundColor,
    this.labelText,
    required this.hintText,
    this.value,
    this.onClick,
  });

  @override
  State<SelectionField> createState() => _SelectionFieldState();
}

class _SelectionFieldState extends State<SelectionField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text('${widget.labelText}'),
          ),
        GestureDetector(
          onTap: widget.onClick,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: grey2.withOpacity(0.3),
              ),
              color: widget.backgroundColor ?? white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.value ?? widget.hintText,
                    style: TextStyle(
                      color: widget.labelTextColor ??
                          (widget.value == null ? grey2 : black),
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: grey3,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
