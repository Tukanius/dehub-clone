import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ProfileFieldCard extends StatefulWidget {
  final String? labelText;
  final String? text;
  const ProfileFieldCard({
    Key? key,
    this.text,
    this.labelText,
  }) : super(key: key);

  @override
  State<ProfileFieldCard> createState() => _ProfileFieldCardState();
}

class _ProfileFieldCardState extends State<ProfileFieldCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            '${widget.labelText}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: grey3,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 3, right: 12),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: grey3),
          ),
          child: widget.text == null
              ? Text(
                  '-',
                  style: TextStyle(
                    fontSize: 14,
                    color: grey3,
                  ),
                )
              : Text(
                  '${widget.text}',
                  style: TextStyle(
                    fontSize: 14,
                    color: grey3,
                  ),
                ),
        ),
      ],
    );
  }
}
