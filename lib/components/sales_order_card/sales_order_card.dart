import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:provider/provider.dart';

class SalesOrderCard extends StatefulWidget {
  final Function()? onClick;
  final bool isReceiver;
  final Order? data;
  final int index;
  final bool startAnimation;
  const SalesOrderCard({
    Key? key,
    required this.startAnimation,
    required this.index,
    required this.isReceiver,
    this.data,
    this.onClick,
  }) : super(key: key);

  @override
  State<SalesOrderCard> createState() => _SalesOrderCardState();
}

class _SalesOrderCardState extends State<SalesOrderCard> {
  User user = User();
  orderStatus() {
    switch (widget.data?.orderStatus) {
      case "DRAFT":
        return "Түр төлөв";
      case "REGISTERED":
        return "Бүртгэсэн";
      case "REVIEW_REJECTED":
        return "Хяналтаас татгалзсан";
      case "REVIEWED":
        return "Хянаад илгээсэн";
      case "CANCELED":
        return "Цуцалсан";
      case "APPROVED":
        return "Баталсан";
      case "AUTHORIZED":
        return "Баталгаажсан";
      case "REJECTED":
        return "Татгалзсан";
      case "AUTO_CANCELED":
        return "Авто цуцлагдсан";
      case "PREPARING":
        return "Бэлтгэж байна";
      case "DELIVERING":
        return "Хүргэж байна";
      case "DELIVERED":
        return "Хүргэсэн";
      case "CLOSED":
        return "Дууссан";
      default:
    }
  }

  paymentTerm() {
    switch (widget.data?.paymentTerm?.condition) {
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
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300 + (widget.index * 100)),
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        curve: Curves.ease,
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        color: white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    widget.data?.respondedUser?.avatar != null &&
                            widget.data?.respondedUser?.avatar != ''
                        ? Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: grey,
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${widget.data?.respondedUser?.avatar}',
                                  scale: 1,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: grey,
                              image: DecorationImage(
                                image: AssetImage('images/avatar.png'),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    widget.isReceiver == true
                        ? Text(
                            '${widget.data?.receiverBusiness?.partner?.businessName}',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            '${widget.data?.senderBusiness?.partner?.businessName}',
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
                      color: orderColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${widget.data?.salesCode}',
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
              children: [
                Row(
                  children: [
                    Text(
                      'Статус: ',
                      style: TextStyle(
                        color: depBrown,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      orderStatus(),
                      style: TextStyle(
                        color: grey2,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD HH:mm")}',
                      style: TextStyle(
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
                      'Төлбөр:',
                      style: TextStyle(
                        color: depBrown,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: orange.withOpacity(0.15),
                      ),
                      child: Text(
                        'Хүлээж буй',
                        style: TextStyle(
                          color: orange,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
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
                      '${Utils().formatCurrency(widget.data?.amountToPay.toString())}₮',
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
                      '${Utils().formatCurrency(widget.data?.amountToPay.toString())}₮',
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
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Хүргэлт: ',
                      style: TextStyle(
                        color: depBrown,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Түр төлөв',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
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
                      '${Moment.parse(widget.data!.deliveryDate.toString()).format("YYYY-MM-DD")}',
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
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
