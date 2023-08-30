import 'package:dehub/models/business.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyerBusinessCard extends StatefulWidget {
  final Function()? onClick;
  final Business? data;
  const BuyerBusinessCard({
    Key? key,
    this.data,
    this.onClick,
  }) : super(key: key);

  @override
  _BuyerBusinessCardState createState() => _BuyerBusinessCardState();
}

class _BuyerBusinessCardState extends State<BuyerBusinessCard> {
  bool isCheck = false;
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
                    widget.data?.logo == null
                        ? Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: grey,
                            ),
                          )
                        : Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: grey,
                              image: DecorationImage(
                                image: NetworkImage('${widget.data?.logo}'),
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
                              '${widget.data?.partner?.businessName},',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.data?.refCode}',
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
                              '${widget.data?.partnerName},',
                              style: TextStyle(fontSize: 12, color: grey3),
                            ),
                            Text(
                              '${widget.data?.partner?.refCode}',
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
                              '${widget.data?.partner?.regNumber}',
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
                                  widget.data?.staff?.avatar == null
                                      ? CircleAvatar(
                                          radius: 12,
                                          backgroundColor: grey,
                                        )
                                      : CircleAvatar(
                                          radius: 12,
                                          backgroundImage: NetworkImage(
                                              '${widget.data?.staff?.avatar}'),
                                        ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    child: Text(
                                      '${widget.data?.staff?.firstName}',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${widget.data?.staff?.email}',
                                    style:
                                        TextStyle(color: grey3, fontSize: 10),
                                  ),
                                  Text(
                                    '${widget.data?.staff?.phone}',
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
