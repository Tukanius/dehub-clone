import 'package:dehub/models/stats.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsCard extends StatefulWidget {
  final Stats data;
  const StatsCard({
    super.key,
    required this.data,
  });

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 230,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xffDFE4EC),
        ),
        color: white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                '${widget.data.image}',
                colorFilter: ColorFilter.mode(grey, BlendMode.srcIn),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${widget.data.name}',
                style: TextStyle(
                  color: grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              )
            ],
          ),
          Text(
            '${Utils().formatCurrency(widget.data.amount.toString())}₮',
            style: TextStyle(
              color: dark,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Өмнөх өдрөөс',
                style: TextStyle(
                  fontSize: 10,
                  color: grey,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: widget.data.percent! > 0 ? neonGreen : red,
                  ),
                  color: widget.data.percent! > 0
                      ? neonGreen.withOpacity(0.3)
                      : red.withOpacity(0.3),
                ),
                child: Row(
                  children: [
                    widget.data.percent! > 0
                        ? Icon(
                            Icons.arrow_upward,
                            color: neonGreen,
                            size: 10,
                          )
                        : Icon(
                            Icons.arrow_downward,
                            color: red,
                            size: 10,
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${widget.data.percent?.toInt()}%',
                      style: TextStyle(
                        color: widget.data.percent! > 0 ? neonGreen : red,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
