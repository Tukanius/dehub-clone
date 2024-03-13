import 'package:dehub/models/finance.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReminderHistoryCard extends StatefulWidget {
  final Finance data;
  final int index;
  final bool startAnimation;
  const ReminderHistoryCard({
    super.key,
    required this.startAnimation,
    required this.index,
    required this.data,
  });

  @override
  State<ReminderHistoryCard> createState() => _ReminderHistoryCardState();
}

class _ReminderHistoryCardState extends State<ReminderHistoryCard> {
  @override
  Widget build(BuildContext context) {
    final source = Provider.of<FinanceProvider>(context, listen: true);

    return AnimatedContainer(
      duration: Duration(milliseconds: 200 + (widget.index * 200)),
      transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
      curve: Curves.ease,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${widget.data.clientText}",
                  style: TextStyle(
                    color: source.currentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/svg/notification.svg',
                colorFilter:
                    ColorFilter.mode(source.currentColor, BlendMode.srcIn),
              )
            ],
          )
        ],
      ),
    );
  }
}
