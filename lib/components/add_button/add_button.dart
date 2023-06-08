import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final Function()? onClick;
  final Color? addColor;
  final Color? color;
  AddButton({
    this.color,
    Key? key,
    this.addColor,
    this.onClick,
  }) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Ink(
        height: 30,
        width: 30,
        decoration: ShapeDecoration(
          color: widget.color,
          shape: CircleBorder(),
        ),
        child: IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.add,
            size: 15,
            color: widget.addColor == null ? white : widget.addColor,
          ),
          onPressed: widget.onClick,
        ),
      ),
    );
  }
}
