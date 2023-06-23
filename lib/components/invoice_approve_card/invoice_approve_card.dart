import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moment_dart/moment_dart.dart';

class InvoiceApproveCard extends StatefulWidget {
  const InvoiceApproveCard({super.key});

  @override
  State<InvoiceApproveCard> createState() => _InvoiceApproveCardState();
}

class _InvoiceApproveCardState extends State<InvoiceApproveCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Supplier Business Name',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Батлах',
                    style: TextStyle(
                      color: blue,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: blue,
                    size: 14,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'images/inv.svg',
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'INV 23897',
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Text(
                '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD HH:mm")}',
                style: TextStyle(color: buttonColor, fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: lightYellow),
                  borderRadius: BorderRadius.circular(5),
                  color: lightYellow.withOpacity(0.5),
                ),
                child: Text(
                  'Илгээсэн',
                  style: TextStyle(
                    color: buttonColor,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                'Дүн: 417,450.00₮',
                style: TextStyle(
                  color: buttonColor,
                  fontSize: 12,
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Төлөх: 2023-04-14',
                style: TextStyle(
                  color: buttonColor,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(
                      'images/map.jpg',
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'D.Delgerjargal',
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
