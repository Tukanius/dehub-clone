import 'package:dehub/models/stats.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsCard extends StatefulWidget {
  final Stats data;
  final String? module;
  const StatsCard({
    super.key,
    this.module,
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
      width: 250,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffDFE4EC),
        ),
        color: white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                '${widget.data.image}',
                colorFilter: const ColorFilter.mode(grey, BlendMode.srcIn),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  '${widget.data.name}',
                  style: const TextStyle(
                    color: grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          Text(
            widget.module == "INVENTORY"
                ? "${widget.data.count?.toInt() ?? 0}"
                : '${Utils().formatCurrency("${widget.data.amount ?? widget.data.changedAmount}")}₮',
            style: const TextStyle(
              color: dark,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Өмнөх өдрөөс',
                style: TextStyle(
                  fontSize: 10,
                  color: grey,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: widget.data.changedCount == null ||
                            widget.data.changedCount! >= 0
                        ? neonGreen
                        : red,
                  ),
                  color: widget.data.changedCount == null ||
                          widget.data.changedCount! >= 0
                      ? neonGreen.withOpacity(0.3)
                      : red.withOpacity(0.3),
                ),
                child: Row(
                  children: [
                    widget.data.changedCount == null ||
                            widget.data.changedCount! == 0
                        ? const SizedBox()
                        : widget.data.changedCount! > 0
                            ? const Icon(
                                Icons.arrow_upward,
                                color: neonGreen,
                                size: 10,
                              )
                            : const Icon(
                                Icons.arrow_downward,
                                color: red,
                                size: 10,
                              ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.data.changedCount != null
                          ? widget.module == "INVENTORY"
                              ? "${widget.data.changedCount?.toInt()}"
                              : '${widget.data.changedCount?.toInt()}%'
                          : '0%',
                      style: TextStyle(
                        color: widget.data.changedCount == null ||
                                widget.data.changedCount! >= 0
                            ? neonGreen
                            : red,
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
