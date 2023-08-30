import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';

class PossibleScheduleCard extends StatefulWidget {
  final String? data;
  final Function()? onClick;
  final String? formattedDate;
  final bool? isSelected;
  const PossibleScheduleCard({
    this.formattedDate,
    this.onClick,
    Key? key,
    this.isSelected,
    this.data,
  }) : super(key: key);

  @override
  State<PossibleScheduleCard> createState() => _PossibleScheduleCardState();
}

class _PossibleScheduleCardState extends State<PossibleScheduleCard> {
  getFormattedDate() {
    switch (widget.formattedDate) {
      case "Monday":
        return "Даваа";
      case "Tuesday":
        return "Мягмар";
      case "Wednesday":
        return "Лхагва";
      case "Thursday":
        return "Пүрэв";
      case "Friday":
        return "Баасан";
      case "Saturday":
        return "Бямба";
      case "Sunday":
        return "Ням";
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.isSelected == true ? orderColor : transparent,
            width: 2,
          ),
          color: lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${Moment.parse(widget.data.toString()).format("YYYY-MM-DD")}',
              style: TextStyle(
                color: widget.isSelected == true
                    ? orderColor
                    : buttonColor.withOpacity(0.6),
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${getFormattedDate()}',
              style: TextStyle(
                color: widget.isSelected == true
                    ? orderColor
                    : buttonColor.withOpacity(0.6),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}