import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartnerCard extends StatefulWidget {
  final Function()? onClick;
  final BusinessNetwork? data;
  final int index;
  final bool? type;
  final bool startAnimation;
  PartnerCard({
    required this.index,
    required this.startAnimation,
    this.data,
    this.type,
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  _PartnerCardState createState() => _PartnerCardState();
}

class _PartnerCardState extends State<PartnerCard> {
  General general = General();

  status() {
    final status = general.businessStatus!
        .firstWhere((element) => element.code == widget.data?.businessStatus)
        .name;
    return status;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).businessGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        curve: Curves.ease,
        transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
          0,
          0,
        ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   height: 40,
                      //   width: 40,
                      //   decoration: BoxDecoration(
                      //     color: grey,
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //       image: widget.data?.logo == null
                      //           ? NetworkImage(
                      //               'https://camo.githubusercontent.com/137115c4e2eab897b580d1f0db934f330d84654bccb0947c5e9af4bc8a66c6b6/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f323639323831302f323130343036312f34643839316563302d386637362d313165332d393230322d6637333934306431306632302e706e67')
                      //           : NetworkImage('${widget.data?.logo}'),
                      //       fit: BoxFit.contain,
                      //     ),
                      //   ),
                      // ),
                      widget.data?.logo == null
                          ? CircleAvatar(
                              radius: 20,
                              backgroundColor: grey,
                              backgroundImage: AssetImage('images/avatar.png'),
                            )
                          : CircleAvatar(
                              radius: 20,
                              backgroundColor: grey,
                              backgroundImage:
                                  NetworkImage('${widget.data?.logo}')),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.data!.partner?.businessName}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              '${widget.data?.partnerName}',
                              style: TextStyle(fontSize: 12, color: grey3),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Нэхэмжлэх - 30 хоног дараа',
                              style: TextStyle(fontSize: 12, color: grey3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data!.refCode}',
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
                              '${widget.data?.regNumber}',
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
                        widget.type == true || widget.type == null
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffEDF4E9),
                                ),
                                child: Text(
                                  '${status()}',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : SizedBox(),
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
