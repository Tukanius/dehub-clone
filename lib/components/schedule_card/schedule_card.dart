import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 3,
          //     offset: Offset(3, 3),
          //     color: Colors.grey,
          //     spreadRadius: 3,
          //   )
          // ],
        ),
        height: 100,
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '5',
              style: TextStyle(
                color: buttonColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Хугацаа хэтэрсэн',
              style: TextStyle(color: buttonColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
