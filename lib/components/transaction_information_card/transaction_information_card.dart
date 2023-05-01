import 'package:dehub/screens/account_info_page/tabs/tabs/transaction_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class TransactionInformationCard extends StatefulWidget {
  final Color? color;
  const TransactionInformationCard({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  _TransactionInformationCardState createState() =>
      _TransactionInformationCardState();
}

class _TransactionInformationCardState
    extends State<TransactionInformationCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            '2023-03-12',
            style: TextStyle(
                color: grey3, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          color: white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Гүйлгээний утга',
                    style: TextStyle(color: grey2, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(TransactionDetailPage.routeName);
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Color(0xff545454),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '2021-12-01 15:05 PM',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff555555),
                    ),
                  ),
                  Text(
                    '250,000.00 ₮',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: widget.color),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
