import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';

class PossibleScheduleCard extends StatefulWidget {
  final DateTime? data;
  final Function()? onClick;
  final String? formattedDate;
  final bool? isSelected;
  final bool? validate;
  const PossibleScheduleCard({
    this.formattedDate,
    this.validate,
    this.onClick,
    super.key,
    this.isSelected,
    this.data,
  });

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
            color: widget.isSelected == true
                ? orderColor
                : widget.validate == true
                    ? red
                    : transparent,
            width: 2,
          ),
          color: lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("yyyy-MM-dd").format(widget.data!),
              style: TextStyle(
                color: widget.isSelected == true
                    ? orderColor
                    : widget.validate == true
                        ? red
                        : buttonColor.withOpacity(0.6),
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${getFormattedDate()}',
              style: TextStyle(
                color: widget.isSelected == true
                    ? orderColor
                    : widget.validate == true
                        ? red
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
