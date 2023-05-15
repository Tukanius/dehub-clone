import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyerBusinessCard extends StatefulWidget {
  final Function()? onClick;
  const BuyerBusinessCard({
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  _BuyerBusinessCardState createState() => _BuyerBusinessCardState();
}

class _BuyerBusinessCardState extends State<BuyerBusinessCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
          border: Border.all(width: 0.5, color: Color(0xffF2F2F2)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: AssetImage('images/map.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Business name,',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'BusRef#',
                              style: TextStyle(
                                fontSize: 12,
                                color: grey3,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Партнерийн нэр,',
                              style: TextStyle(fontSize: 12, color: grey3),
                            ),
                            Text(
                              'PartnerRef#',
                              style: TextStyle(
                                fontSize: 12,
                                color: grey3,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'ТТД: ',
                              style: TextStyle(color: grey3, fontSize: 10),
                            ),
                            Text(
                              '6324142',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: grey3,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 250,
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Container(
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundImage:
                                        AssetImage('images/map.jpg'),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'UserName',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'mail@address.com',
                                    style:
                                        TextStyle(color: grey3, fontSize: 10),
                                  ),
                                  Text(
                                    '9919-3460',
                                    style:
                                        TextStyle(color: grey3, fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: networkColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: SvgPicture.asset('images/message_sent.svg'),
                      ),
                    ],
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
