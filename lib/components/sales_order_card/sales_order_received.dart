import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moment_dart/moment_dart.dart';

class SalesOrderReceived extends StatefulWidget {
  final Function()? onClick;
  const SalesOrderReceived({
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  State<SalesOrderReceived> createState() => _SalesOrderReceivedState();
}

class _SalesOrderReceivedState extends State<SalesOrderReceived> {
  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: grey,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Buyer Business Name',
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
                      'images/inv.svg',
                      color: orderColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'PO-238898',
                      style: TextStyle(
                        color: orderColor,
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
                      'Түр төлөв',
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
                Row(
                  children: [
                    Text(
                      'Нөхцөл: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Урьдчилсан төлбөр',
                      style: TextStyle(
                        color: orderColor,
                        fontSize: 12,
                      ),
                    )
                  ],
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
                      '8,820,000.00₮',
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
                      '8,820,000.00₮',
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
                      '2023-06-23',
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
