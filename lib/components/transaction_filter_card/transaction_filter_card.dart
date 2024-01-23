import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class TransactionFilterCard extends StatefulWidget {
  final Function()? onClick;
  final bool? isTap;
  final String? text;
  const TransactionFilterCard({
    super.key,
    this.text,
    this.isTap,
    this.onClick,
  });

  @override
  State<TransactionFilterCard> createState() => _TransactionFilterCardState();
}

class _TransactionFilterCardState extends State<TransactionFilterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: widget.isTap == true ? paymentColor : white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            widget.isTap == false
                ? BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  )
                : const BoxShadow(),
          ],
        ),
        child: Center(
          child: Text(
            '${widget.text}',
            style: TextStyle(
              color: widget.isTap == true ? white : grey2,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
