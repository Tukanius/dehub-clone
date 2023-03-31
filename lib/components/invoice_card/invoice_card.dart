import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvoiceCard extends StatefulWidget {
  static const routeName = '/invoicecard';
  final Function()? onClick;
  const InvoiceCard({
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10),
            child: Text(
              '2021-12-01',
              style: TextStyle(
                color: Color(0xff636E72),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: widget.onClick,
            child: Container(
              color: white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                  color: brownButtonColor,
                                  width: 2,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: brownButtonColor,
                              value: value,
                              onChanged: (value1) {
                                setState(() {
                                  value = value1!;
                                });
                              },
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 13,
                                ),
                                Text(
                                  'Buyer Business Name',
                                  style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '2021-12-01 15:05 PM',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff555555),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Баталгаажсан',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: brownButtonColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Төлөх: 2021-12-02',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff555555),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/inv.svg',
                                      color: brownButtonColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'INV 23897',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: black,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '417,450.00 ₮',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              decoration: BoxDecoration(
                                color: brownButtonColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: grey3.withOpacity(0.4),
                                ),
                              ),
                              child: Text(
                                'Төлөлт хүлээж буй',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: brownButtonColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Төлбөл зохих: 417,450.00 ₮',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff555555),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Хугацаа: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff555555),
                                  ),
                                ),
                                Text(
                                  'Хэвийн',
                                  style: TextStyle(
                                    color: Color(0xff33A853),
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Нийт дүн:',
                                  style: TextStyle(
                                    color: Color(0xff555555),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '417,450.00',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: grey2,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
