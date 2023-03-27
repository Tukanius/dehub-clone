import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final Function()? onClick;
  const AddButton({
    Key? key,
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
          color: Colors.orange,
          shape: CircleBorder(),
        ),
        child: IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.add,
            size: 15,
            color: white,
          ),
          onPressed: widget.onClick,
        ),
      ),
    );
  }
}
