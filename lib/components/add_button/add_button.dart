import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final Function()? onClick;
  final Color? addColor;
  final Color? color;
  const AddButton({
    this.color,
    super.key,
    this.addColor,
    this.onClick,
  });

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        height: 30,
        width: 30,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
        child: Icon(
          Icons.add,
          size: 15,
          color: widget.addColor ?? white,
        ),
      ),
    );
  }
}
