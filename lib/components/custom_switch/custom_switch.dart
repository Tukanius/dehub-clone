import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool? isDefault;
  final Color? color;
  const CustomSwitch({
    Key? key,
    this.color,
    this.isDefault,
  }) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.isDefault == true ? widget.color : grey,
      ),
      child: Row(
        children: [
          widget.isDefault == false
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white,
                  ),
                  height: 18,
                  width: 18,
                )
              : SizedBox(),
          SizedBox(
            width: 5,
          ),
          widget.isDefault == true
              ? Text(
                  'Тийм',
                  style: TextStyle(
                    color: white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Text(
                  'Үгүй',
                  style: TextStyle(
                    color: white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          SizedBox(
            width: 5,
          ),
          widget.isDefault == true
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white,
                  ),
                  height: 18,
                  width: 18,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
