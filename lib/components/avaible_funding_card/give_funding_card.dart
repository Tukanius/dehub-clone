import 'package:dehub/screens/received_funding_page/give_funding_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GiveFundingCard extends StatefulWidget {
  final Function()? onClick;
  const GiveFundingCard({Key? key, this.onClick}) : super(key: key);

  @override
  State<GiveFundingCard> createState() => _GiveFundingCardState();
}

class _GiveFundingCardState extends State<GiveFundingCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(GiveFundingDetailPage.routeName);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(15),
            color: white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SFC-SL-100086-01',
                      style: TextStyle(
                          color: dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: financingColor),
                        color: financingColor.withOpacity(0.1),
                      ),
                      child: SvgPicture.asset('images/note.svg'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: yellow.withOpacity(0.2),
                      ),
                      child: Text(
                        'Хүлээж буй',
                        style: TextStyle(
                            color: yellow,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      'Supplier_User',
                      style: TextStyle(
                        color: financingColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Хүсэлтийн дүн: ',
                      style: TextStyle(
                        color: Color(0xff555555),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '49,510,000.00 ₮',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                      'Нийт шимтгэл: xxx,xxx,xxx.xx ₮',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff555555),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'images/inv.svg',
                          color: buttonColor,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'INV 23897',
                          style: TextStyle(
                            color: dark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}