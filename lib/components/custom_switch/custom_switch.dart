import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: networkColor),
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          Text(
            'Тийм',
            style: TextStyle(
              color: white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white,
            ),
            height: 18,
            width: 18,
          ),
        ],
      ),
    );
  }
}
