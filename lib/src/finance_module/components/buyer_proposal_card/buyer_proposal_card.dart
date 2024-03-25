import 'package:dehub/models/finance.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class BuyerProposalCard extends StatefulWidget {
  final Finance data;
  final Function()? onClick;
  const BuyerProposalCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<BuyerProposalCard> createState() => _BuyerProposalCardState();
}

class _BuyerProposalCardState extends State<BuyerProposalCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Column(
          children: [
            Row(
              children: [
                Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
