import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool? isDefault;
  final Color? color;
  const CustomSwitch({
    super.key,
    this.color,
    this.isDefault,
  });

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
          const SizedBox(
            width: 5,
          ),
          widget.isDefault == true
              ? const Text(
                  'Тийм',
                  style: TextStyle(
                    color: white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : const Text(
                  'Үгүй',
                  style: TextStyle(
                    color: white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
