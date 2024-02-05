import 'package:dehub/models/finance.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class LimitUsageCard extends StatefulWidget {
  final Finance data;
  const LimitUsageCard({
    super.key,
    required this.data,
  });

  @override
  State<LimitUsageCard> createState() => _LimitUsageCardState();
}

class _LimitUsageCardState extends State<LimitUsageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: const Column(
        children: [
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
