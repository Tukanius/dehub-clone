import 'package:dehub/screens/network_page/tabs/sent_tab/tabs/invitation_detail_page/invitation_detail_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';

class SentCard extends StatefulWidget {
  final Function()? onClick;
  const SentCard({
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  _SentCardState createState() => _SentCardState();
}

class _SentCardState extends State<SentCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // widget.onClick;
        Navigator.of(context).pushNamed(SentInvitationDetail.routeName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Бизнэсийн нэр',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Партнерийн нэр',
                          style: TextStyle(fontSize: 12, color: grey3),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Нэхэмжлэх - 30 хоног дараа',
                          style: TextStyle(fontSize: 12, color: grey3),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BusRef#',
                          style: TextStyle(
                            fontSize: 12,
                            color: grey3,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(
                          height: 6,
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
                                  color: grey3),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffEDF4E9),
                          ),
                          child: Text(
                            'Ангилал',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
