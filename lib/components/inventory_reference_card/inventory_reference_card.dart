import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InventoryReferenceCard extends StatefulWidget {
  final Function()? onClick;
  final String refCode;
  final String labelText;
  const InventoryReferenceCard({
    super.key,
    required this.labelText,
    required this.refCode,
    this.onClick,
  });

  @override
  State<InventoryReferenceCard> createState() => _InventoryReferenceCardState();
}

class _InventoryReferenceCardState extends State<InventoryReferenceCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.labelText,
                  style: const TextStyle(color: productColor),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  widget.refCode,
                  style: const TextStyle(
                    color: grey2,
                  ),
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: productColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
