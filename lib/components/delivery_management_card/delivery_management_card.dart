import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryManagementCard extends StatefulWidget {
  final Function()? onClick;
  final bool isFinished;
  const DeliveryManagementCard({
    Key? key,
    required this.isFinished,
    this.onClick,
  }) : super(key: key);

  @override
  State<DeliveryManagementCard> createState() => _DeliveryManagementCardState();
}

class _DeliveryManagementCardState extends State<DeliveryManagementCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/order_note.svg',
                    colorFilter: ColorFilter.mode(orderColor, BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'DN-100091',
                    style: TextStyle(
                      color: orderColor,
                      fontSize: 14,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('images/avatar.png'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Биг супермаркет",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'BU-100072',
                        style: TextStyle(
                          color: grey2,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Статус:  ',
                    style: TextStyle(fontSize: 14, color: grey2),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey2)),
                    child: Text(
                      'ДРАФТ',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: grey2,
                      ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Хүргэлт: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: widget.isFinished == true
                          ? Text(
                              'Баяр Амгалан',
                              style: TextStyle(
                                color: depBrown,
                                fontSize: 14,
                              ),
                            )
                          : Text(
                              '-',
                              style: TextStyle(
                                color: depBrown,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: widget.onClick,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: orderColor,
                  ),
                  child: widget.isFinished == true
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Ачилт',
                              style: TextStyle(color: white),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/zahialga.svg',
                              colorFilter:
                                  ColorFilter.mode(white, BlendMode.srcIn),
                              height: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Хүргэлт хуваарилах',
                              style: TextStyle(
                                color: white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
