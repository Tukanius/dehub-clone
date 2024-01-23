import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatefulWidget {
  final String labelText;
  final int count;
  const ScheduleCard({
    super.key,
    required this.count,
    required this.labelText,
  });

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  double width = 0;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width - 20;

    return Card(
      shadowColor: Colors.grey,
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: white,
        ),
        height: 100,
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.count}',
              style: const TextStyle(
                color: buttonColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.labelText,
              style: const TextStyle(color: buttonColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  height: 4,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffF6F6F6),
                  ),
                ),
                Container(
                  height: 4,
                  width: width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.labelText == "Нээлттэй нэхэмжлэх"
                        ? pink
                        : widget.labelText == "Батлах хүлээж буй"
                            ? yellow
                            : blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
