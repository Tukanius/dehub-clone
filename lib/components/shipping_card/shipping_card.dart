import 'package:dehub/models/general.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:provider/provider.dart';

class ShippingCard extends StatefulWidget {
  final Function()? onClick;
  final Order? data;
  const ShippingCard({
    Key? key,
    this.onClick,
    this.data,
  }) : super(key: key);

  @override
  State<ShippingCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<ShippingCard> {
  General general = General();
  status(String pullSheetStatus) {
    final result = general.pullSheetStatus
        ?.firstWhere((element) => element.code == pullSheetStatus)
        .name;
    return result;
  }

  statusColor() {
    switch (widget.data?.pullSheetStatus) {
      case "APPROVED":
        return 0xffC8C9C9;
      case "LOADING":
        return 0xffFD8E31;
      case "LOADED":
        return 0xff01C129;
      case "CONFIRMED":
        return 0xff1642F4;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).orderGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.data?.warehouse?.name}',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'images/inv.svg',
                      color: darkGreen,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${widget.data?.refCode}',
                      style: TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: darkGreen,
                      size: 12,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Ачих огноо: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${Moment.parse(widget.data!.loadingDate.toString()).format("YYYY-MM-DD")}',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Нярав: ',
                      style: TextStyle(
                        color: depBrown,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${widget.data?.staff?.firstName}',
                      style: TextStyle(
                        color: orderColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Эхэлсэн: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    widget.data?.startedDate == null
                        ? Text(
                            '-',
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Text(
                            "${Moment.parse(widget.data!.startedDate!).format("YYYY-MM-DD")}",
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(statusColor()).withOpacity(0.2),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  child: Text(
                    '${status(widget.data!.pullSheetStatus!)}',
                    style: TextStyle(
                      color: Color(statusColor()),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     Text(
                //       'Агуулах:',
                //       style: TextStyle(
                //         color: depBrown,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 12,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     Text(
                //       'Төв агуулах',
                //       style: TextStyle(
                //         color: buttonColor,
                //         fontWeight: FontWeight.w700,
                //         fontSize: 12,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Дууссан: ',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                      ),
                    ),
                    widget.data?.endedDate == null
                        ? Text(
                            '-',
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Text(
                            "${Moment.parse(widget.data!.endedDate!).format("YYYY-MM-DD")}",
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                  ],
                ),
                // Row(
                //   children: [
                //     Text(
                //       'Нярав: ',
                //       style: TextStyle(
                //         color: depBrown,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 12,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     Text(
                //       '${widget.data?.staff?.firstName}',
                //       style: TextStyle(
                //         color: orderColor,
                //         fontSize: 12,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Text(
            //           'Нийт дүн: ',
            //           style: TextStyle(
            //             color: buttonColor,
            //             fontSize: 12,
            //           ),
            //         ),
            //         Text(
            //           '2,820,000 ₮',
            //           style: TextStyle(
            //             color: orderColor,
            //             fontSize: 12,
            //           ),
            //         ),
            //       ],
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4),
            //         color: yellow.withOpacity(0.2),
            //       ),
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            //       child: Text(
            //         'Хүлээж буй',
            //         style: TextStyle(
            //           color: yellow,
            //           fontSize: 12,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
