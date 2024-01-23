import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderCustomerCard extends StatefulWidget {
  final Function()? onClick;
  final Order? data;
  final int index;
  final bool startAnimation;
  const OrderCustomerCard({
    this.data,
    required this.index,
    required this.startAnimation,
    super.key,
    this.onClick,
  });

  @override
  State<OrderCustomerCard> createState() => _OrderCustomerCardState();
}

class _OrderCustomerCardState extends State<OrderCustomerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        curve: Curves.ease,
        duration: Duration(milliseconds: 300 + (widget.index * 100)),
        transform: Matrix4.translationValues(
            widget.startAnimation ? 0 : MediaQuery.of(context).size.width,
            0,
            0),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: white,
          border: Border(
            bottom: BorderSide(
              color: buttonColor.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: grey,
                    ),
                    child: widget.data?.logo != null && widget.data?.logo != ''
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage('${widget.data?.logo}', scale: 1),
                          )
                        : const CircleAvatar(
                            backgroundImage: AssetImage('images/avatar.png'),
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data?.partner?.businessName}',
                          style: const TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${widget.data?.partnerName} ',
                                style: const TextStyle(
                                  color: coolGrey,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              TextSpan(
                                text: 'РД${widget.data?.regNumber}',
                                style: const TextStyle(
                                  color: buttonColor,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '${widget.data?.receiverBrach?.name}',
                          style: const TextStyle(
                            color: orderColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  Icons.arrow_forward_ios,
                  color: orderColor,
                  size: 14,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    border: Border.all(color: orderColor),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/shopping-cart.svg',
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(
                        'Шинэ',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 12,
                        ),
                      )
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
