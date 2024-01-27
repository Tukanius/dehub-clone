import 'package:dehub/models/finance.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class CompromiseCard extends StatefulWidget {
  final Finance data;
  const CompromiseCard({
    super.key,
    required this.data,
  });

  @override
  State<CompromiseCard> createState() => _CompromiseCardState();
}

class _CompromiseCardState extends State<CompromiseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(),
            ],
          )
        ],
      ),
    );
  }
}
