import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Card extends StatefulWidget {
  final String labelText;
  const Card({
    Key? key,
    this.labelText = '',
  }) : super(key: key);

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/svg/pie.svg'),
              Text(widget.labelText),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 12,
          ),
        ],
      ),
    );
  }
}
