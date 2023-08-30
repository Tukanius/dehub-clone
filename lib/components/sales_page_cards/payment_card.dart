import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({Key? key}) : super(key: key);

  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          GestureDetector(
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
                                  color: buttonColor,
                                  width: 2,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: buttonColor,
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
                                  'INV 23897',
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
                                  height: 5,
                                ),
                                Text(
                                  'Бэлэн төлөлт',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: buttonColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundImage:
                                          AssetImage('images/map.jpg'),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Tsetsgee.G',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff555555),
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
                              '-75,000.00 ₮',
                              style: TextStyle(
                                color: buttonColor,
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
                                color: grey3.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: grey),
                              ),
                              child: Text(
                                'Хүлээж буй',
                                style: TextStyle(fontSize: 12, color: grey2),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Төлөв: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff555555),
                                  ),
                                ),
                                // widget.data!.overDueStatus == "NORMAL"
                                Text(
                                  'Амжилттай',
                                  style: TextStyle(
                                    color: green,
                                    fontSize: 12,
                                  ),
                                )
                                // : Text(
                                //     'Хугацаа хэтэрсэн',
                                //     style: TextStyle(
                                //       color: buttonColor,
                                //       fontSize: 12,
                                //     ),
                                //   )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Лавлах №: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff555555),
                                  ),
                                ),
                                // widget.data!.overDueStatus == "NORMAL"
                                Text(
                                  'TR098983',
                                  style: TextStyle(
                                    color: grey2,
                                    fontSize: 12,
                                  ),
                                )
                                // : Text(
                                //     'Хугацаа хэтэрсэн',
                                //     style: TextStyle(
                                //       color: buttonColor,
                                //       fontSize: 12,
                                //     ),
                                //   )
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
