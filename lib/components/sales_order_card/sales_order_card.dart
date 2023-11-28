import 'package:dehub/models/general.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SalesOrderCard extends StatefulWidget {
  final Function()? onClick;
  final Order data;
  final int index;
  final bool startAnimation;
  const SalesOrderCard({
    Key? key,
    required this.startAnimation,
    required this.index,
    required this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<SalesOrderCard> createState() => _SalesOrderCardState();
}

class _SalesOrderCardState extends State<SalesOrderCard> {
  User user = User();
  General general = General();

  orderStatus() {
    final res = general.orderStatus!
        .firstWhere((element) => element.code == widget.data.orderStatus);
    return res;
  }

  paymentTerm() {
    switch (widget.data.paymentTerm?.condition) {
      case "COD":
        return "Бэлэн төлөх нөхцөл";
      case "INV_CONFIG":
        return "Нэхэмжлэхээр төлөх нөхцөл";
      case "AR_NET30":
        return "Авлага";
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).orderGeneral;
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        curve: Curves.ease,
        margin: const EdgeInsets.only(bottom: 1),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: grey,
                      backgroundImage: widget.data.type == "PURCHASE" &&
                                  user.currentBusiness?.type == "BUYER" ||
                              widget.data.type == "SALES" &&
                                  user.currentBusiness?.type == "SUPPLIER"
                          ? NetworkImage(
                              '${widget.data.receiverBusiness?.logo}')
                          : NetworkImage('${widget.data.senderBusiness?.logo}'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    widget.data.type == "PURCHASE" &&
                                user.currentBusiness?.type == "BUYER" ||
                            widget.data.type == "SALES" &&
                                user.currentBusiness?.type == "SUPPLIER"
                        ? Text(
                            '${widget.data.receiverBusiness?.partner?.businessName}',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            '${widget.data.senderBusiness?.partner?.businessName}',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/inv.svg',
                      colorFilter:
                          ColorFilter.mode(orderColor, BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    widget.data.purchaseCode != null
                        ? Text(
                            '${widget.data.purchaseCode}',
                            style: TextStyle(
                              color: grey2,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : widget.data.salesCode != null
                            ? Text(
                                '${widget.data.salesCode}',
                                style: TextStyle(
                                  color: grey2,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                '-',
                                style: TextStyle(
                                  color: grey2,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Статус:  ',
                      style: TextStyle(
                        color: depBrown,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(int.parse(
                                    orderStatus().color.substring(1, 7),
                                    radix: 16) +
                                0xff000000)
                            .withOpacity(0.2),
                      ),
                      child: widget.data.type == "PURCHASE" &&
                                  user.currentBusiness?.type == "BUYER" ||
                              widget.data.type == "SALES" &&
                                  user.currentBusiness?.type == "SUPPLIER"
                          ? Text(
                              orderStatus().sentName.toString(),
                              style: TextStyle(
                                color: Color(int.parse(
                                        orderStatus().color.substring(1, 7),
                                        radix: 16) +
                                    0xff000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            )
                          : Text(
                              orderStatus().receivedName.toString(),
                              style: TextStyle(
                                color: Color(int.parse(
                                        orderStatus().color.substring(1, 7),
                                        radix: 16) +
                                    0xff000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                    )
                  ],
                ),
                Text(
                  '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now())}',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Нөхцөл: ',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          paymentTerm(),
                          style: TextStyle(
                            color: orderColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Хүргэх: ',
                      style: TextStyle(
                        color: grey2,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(widget.data.deliveryDate.toString()))}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: grey2,
                        fontSize: 12,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Нийт дүн: ',
                      style: TextStyle(
                        color: depBrown,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
                      style: TextStyle(
                        color: orderColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Төлбөл зохих: ',
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
                      '${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
                      style: TextStyle(
                        color: orderColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
