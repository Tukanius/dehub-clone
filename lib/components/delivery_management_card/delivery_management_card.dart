import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryManagementCard extends StatefulWidget {
  final Function()? onClick;
  final bool isFinished;
  final Order data;
  const DeliveryManagementCard({
    super.key,
    required this.data,
    required this.isFinished,
    this.onClick,
  });

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/order_note.svg',
                    colorFilter:
                        const ColorFilter.mode(orderColor, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${widget.data.refCode}',
                    style: const TextStyle(
                      color: black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Text(
                'Захиалга №: ${widget.data.order?.salesCode}',
                style: const TextStyle(color: orderColor),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    widget.data.order?.receiverBranch?.logo == null
                        ? const CircleAvatar(
                            radius: 16,
                            backgroundImage: AssetImage('images/avatar.png'),
                          )
                        : CircleAvatar(
                            radius: 16,
                            backgroundColor: grey,
                            backgroundImage: NetworkImage(
                                '${widget.data.order?.receiverBranch?.logo}'),
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.data.receiverBusiness?.profileName}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${widget.data.receiverBusiness?.refCode}',
                            style: const TextStyle(
                              color: grey2,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Статус:  ',
                    style: TextStyle(fontSize: 14, color: grey2),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey2)),
                    child: const Text(
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
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Text(
                      'Хүргэлт: ',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child:
                          widget.isFinished == true && widget.data.staff != null
                              ? Text(
                                  '${widget.data.staff?.lastName?[0]}. ${widget.data.staff?.firstName}',
                                  style: const TextStyle(
                                    color: depBrown,
                                    fontSize: 14,
                                  ),
                                )
                              : const Text(
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
                      ? const Row(
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
                              colorFilter: const ColorFilter.mode(
                                  white, BlendMode.srcIn),
                              height: 14,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
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
