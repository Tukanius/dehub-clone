import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardCard extends StatefulWidget {
  final Function()? onClick;
  final String svg;
  final Color svgColor;
  final String labelText;
  final double padding;
  final Color boxColor;
  const DashboardCard({
    Key? key,
    required this.boxColor,
    required this.padding,
    required this.labelText,
    required this.svgColor,
    required this.svg,
    this.onClick,
  }) : super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
        ),
        padding: const EdgeInsets.all(8),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(widget.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.boxColor,
              ),
              child: SvgPicture.asset(
                '${widget.svg}',
                colorFilter: ColorFilter.mode(widget.svgColor, BlendMode.srcIn),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '${widget.labelText}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
