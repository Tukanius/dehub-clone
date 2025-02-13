import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InformationCard extends StatefulWidget {
  final String labelText;
  final double paddingVertical;
  final String? value;
  const InformationCard({
    super.key,
    this.value,
    required this.paddingVertical,
    required this.labelText,
  });

  @override
  State<InformationCard> createState() => InformationCardState();
}

class InformationCardState extends State<InformationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: widget.paddingVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: grey3,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: grey3),
            ),
            child: widget.value != null && widget.value != 'null'
                ? Text(
                    '${widget.value}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: grey3,
                    ),
                  )
                : const Text(
                    '-',
                    style: TextStyle(
                      fontSize: 14,
                      color: grey3,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
