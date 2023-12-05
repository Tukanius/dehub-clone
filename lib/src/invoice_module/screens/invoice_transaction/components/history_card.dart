import 'package:dehub/models/invoice.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatefulWidget {
  final Function()? onClick;
  final Invoice data;
  const HistoryCard({
    Key? key,
    required this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.only(right: 15, bottom: 15),
        color: white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(
                  color: invoiceColor,
                  width: 2,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              activeColor: invoiceColor,
              value: value,
              onChanged: (value1) {
                setState(() {
                  value = value1!;
                });
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Гүйлгээний лавлах',
                          style: TextStyle(
                            color: invoiceColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: grey3,
                        size: 18,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.createdAt!)}',
                          style: TextStyle(
                            color: grey2,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${Utils().formatCurrency(widget.data.trxAmount.toString())}₮',
                          style: TextStyle(
                            color: grey2,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.data.description}',
                          style: TextStyle(
                            color: invoiceColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.data.actionUser?.firstName}',
                          style: TextStyle(
                            color: grey2,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.data.paymentMethod}',
                    style: TextStyle(
                      color: invoiceColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
