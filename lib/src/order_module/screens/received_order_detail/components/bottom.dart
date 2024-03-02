import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/src/order_module/screens/new_order/new_order.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Bottom extends StatefulWidget {
  final Order order;
  final String id;
  final ListenController listenController;
  final double totalAmount;
  const Bottom({
    super.key,
    required this.totalAmount,
    required this.listenController,
    required this.id,
    required this.order,
  });

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  User user = User();
  Order approve = Order();

  respond(bool isApprove) async {
    approve.approve = isApprove;
    await OrderApi().respond(widget.id, approve);
    widget.listenController.changeVariable('respond');
    showCustomDialog(
      context,
      isApprove == true ? "Амжилттай зөвшөөрлөө" : 'Татгалзлаа',
      isApprove,
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

  create() async {
    Order create = Order();
    create.orderId = widget.order.id;
    await OrderApi().deliveryManagementCreate(create);
    showCustomDialog(
      context,
      "Амжилттай",
      true,
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  onSubmit(bool approve, String labelText, Function(bool approve) function) {
    Navigator.of(context).pushNamed(
      PinCheckScreen.routeName,
      arguments: PinCheckScreenArguments(
        onSubmit: () {
          function(approve);
        },
        color: orderColor,
        labelText: labelText,
      ),
    );
  }

  review(bool isReview) async {
    approve.review = isReview;
    await OrderApi().review(widget.id, approve);
    widget.listenController.changeVariable('review');
    showCustomDialog(
      context,
      isReview == true ? "Амжилттай" : 'Татгалзлаа',
      isReview,
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    return Container(
      padding: const EdgeInsets.only(bottom: 50, left: 15, right: 15, top: 15),
      decoration: const BoxDecoration(
        color: white,
        border: Border(
          top: BorderSide(
            color: orderColor,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Нийт дүн: ',
                style: TextStyle(color: orderColor),
              ),
              Text(
                '${Utils().formatCurrency(widget.totalAmount.toString())}₮',
                style: const TextStyle(
                  color: orderColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          user.currentBusiness?.type == "SUPPLIER" &&
                  widget.order.type == "SALES" &&
                  widget.order.orderStatus == "REGISTERED"
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        onSubmit(
                            false, "Татгалзах", (approve) => review(false));
                      },
                      child: SizedBox(
                        height: 38,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/alert-circle.svg',
                            ),
                            const Text(
                              'Татгалзах',
                              style: TextStyle(
                                color: Color(0xffFE2413),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        onSubmit(true, "SO үүсгэх", (approve) => review(true));
                      },
                      child: SizedBox(
                        height: 38,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/create-so.svg',
                              colorFilter: const ColorFilter.mode(
                                  orderColor, BlendMode.srcIn),
                            ),
                            const Text(
                              'SO болгох',
                              style: TextStyle(
                                color: orderColor,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )
              : user.currentBusiness?.type == "SUPPLIER" &&
                      widget.order.type == "PURCHASE" &&
                      widget.order.orderStatus == "REVIEWED"
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            onSubmit(false, "Захиалга цуцлах",
                                (approve) => respond(false));
                          },
                          child: SizedBox(
                            height: 38,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/alert-circle.svg',
                                ),
                                const Text(
                                  'Татгалзах',
                                  style: TextStyle(
                                    color: Color(0xffFE2413),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            onSubmit(true, "Захиалга зөвшөөрөх",
                                (approve) => respond(true));
                          },
                          child: SizedBox(
                            height: 38,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/create-so.svg',
                                  colorFilter: const ColorFilter.mode(
                                      orderColor, BlendMode.srcIn),
                                ),
                                const Text(
                                  'Зөвшөөрөх',
                                  style: TextStyle(
                                    color: orderColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : user.currentBusiness?.type == "BUYER" &&
                          widget.order.type == "PURCHASE" &&
                          widget.order.orderStatus == "REGISTERED"
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                onSubmit(false, "Татгалзах",
                                    (approve) => review(false));
                              },
                              child: SizedBox(
                                height: 38,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/alert-circle.svg',
                                    ),
                                    const Text(
                                      'Татгалзах',
                                      style: TextStyle(
                                        color: Color(0xffFE2413),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                onSubmit(true, "SO үүсгэх",
                                    (approve) => review(true));
                              },
                              child: SizedBox(
                                height: 38,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/create-so.svg',
                                      colorFilter: const ColorFilter.mode(
                                          orderColor, BlendMode.srcIn),
                                    ),
                                    const Text(
                                      'SO болгох',
                                      style: TextStyle(
                                        color: orderColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      : user.currentBusiness?.type == "BUYER" &&
                              widget.order.type == "SALES" &&
                              widget.order.orderStatus == "REVIEWED"
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    onSubmit(
                                      false,
                                      "Захиалга цуцлах",
                                      (approve) => respond(false),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/alert-circle.svg',
                                        ),
                                        const Text(
                                          'Татгалзах',
                                          style: TextStyle(
                                            color: Color(0xffFE2413),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    onSubmit(true, "Захиалга зөвшөөрөх",
                                        (approve) => respond(true));
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/create-so.svg',
                                          colorFilter: const ColorFilter.mode(
                                              orderColor, BlendMode.srcIn),
                                        ),
                                        const Text(
                                          'Зөвшөөрөх',
                                          style: TextStyle(
                                            color: orderColor,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          : user.currentBusiness?.type == "SUPPLIER" &&
                                  widget.order.deliveryNote == null &&
                                  widget.order.orderStatus == "AUTHORIZED"
                              ? GestureDetector(
                                  onTap: () {
                                    onSubmit(
                                      true,
                                      "Хүргэлт хуваарилах",
                                      (approve) => create(),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 38,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/create-so.svg',
                                          colorFilter: const ColorFilter.mode(
                                              orderColor, BlendMode.srcIn),
                                        ),
                                        const Text(
                                          'Хүргэлт хуваарилах',
                                          style: TextStyle(
                                            color: orderColor,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : widget.order.orderStatus == "DRAFT"
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          NewOrder.routeName,
                                          arguments: NewOrderArguments(
                                            data: widget.order,
                                            id: widget.order.receiverBusinessId,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        color: transparent,
                                        child: const Column(
                                          children: [
                                            Icon(
                                              Icons.edit_square,
                                              color: orderColor,
                                              size: 18,
                                            ),
                                            Text(
                                              'Засах',
                                              style: TextStyle(
                                                color: orderColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
        ],
      ),
    );
  }
}
