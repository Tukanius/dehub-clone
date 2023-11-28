import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class InformationCard extends StatefulWidget {
  final String labelText;
  final double marginVertical;
  final String? value;
  const InformationCard({
    Key? key,
    this.value,
    required this.marginVertical,
    required this.labelText,
  }) : super(key: key);

  @override
  State<InformationCard> createState() => InformationCardState();
}

class InformationCardState extends State<InformationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: widget.marginVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.labelText}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: grey3,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: grey3),
            ),
            child: widget.value != null && widget.value != 'null'
                ? Text(
                    '${widget.value}',
                    style: TextStyle(
                      fontSize: 14,
                      color: grey3,
                    ),
                  )
                : Text(
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
