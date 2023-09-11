import 'dart:async';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/components/shipment_product_card/shipment_product_card.dart';
// import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:dehub/components/shipping_card/shipping_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';

class OrderShipmentArguments {
  Order data;
  OrderShipmentArguments({
    required this.data,
  });
}

class OrderShipment extends StatefulWidget {
  final Order data;
  static const routeName = '/OrderShipment';
  const OrderShipment({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<OrderShipment> createState() => _OrderShipmentState();
}

class _OrderShipmentState extends State<OrderShipment> with AfterLayoutMixin {
  bool isStart = false;
  Duration duration = Duration();
  TextEditingController controller = TextEditingController();
  bool isSubmit = false;
  late Timer _timer;
  bool isLoading = true;
  Order shipment = Order();
  Timer? timer;
  bool isCountDown = true;
  String? minutes;
  String? seconds;
  bool startShipment = false;

  void addTimer() {
    final addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void reset() {
    if (isCountDown) {
      setState(() => duration = Duration());
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer() async {
    if (shipment.isPaused == false) {
      try {
        await OrderApi().pullSheetStart(widget.data.id!);
        timer = Timer.periodic(Duration(seconds: 1), (timer) => addTimer());
        setState(() {
          isStart = true;
        });
      } catch (e) {
        print('=======start================');
        print(e);
      }
    } else {
      try {
        await OrderApi().pullSheetProceed(widget.data.id!);
      } catch (e) {
        print('=======proceed================');
        print(e);
      }
    }
    shipment = await OrderApi().pullSheetGet(widget.data.id!);
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text('$minutes:$seconds');
  }

  void stopTimer({bool resets = true}) async {
    if (resets) {
      reset();
    }
    await OrderApi().pullSheetPause(widget.data.id!);
    setState(() {
      startShipment = false;
    });
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: orderColor,
          ),
        ),
        title: Text(
          'Ачилт хийх',
          style: TextStyle(
            color: buttonColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: orderColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: white,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (startShipment == false) {
                              startTimer();
                            }
                            setState(() {
                              startShipment = true;
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isStart == true ? orderColor : lightGrey,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'images/bx_timer.svg',
                                  color: isStart == true ? white : buttonColor,
                                ),
                                Text(
                                  'Эхлэх',
                                  style: TextStyle(
                                    color:
                                        isStart == true ? white : buttonColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: lightGrey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'images/timer.svg',
                                color: buttonColor,
                              ),
                              buildTime()
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // pause();
                            stopTimer(resets: false);
                          },
                          child: Container(
                            height: 60,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: lightGrey,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pause_circle,
                                  color: buttonColor,
                                ),
                                Text(
                                  'Зогсоох',
                                  style: TextStyle(
                                    color: buttonColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            end();
                          },
                          child: Container(
                            height: 60,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: lightGrey,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'images/check_underline.svg',
                                  color: buttonColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Дуусгах',
                                  style: TextStyle(
                                    color: buttonColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isStart == false
                      ? Column(
                          children: [
                            ShippingCard(
                              data: widget.data,
                            ),
                            Container(
                              color: white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: Text(
                                      'Барааны мэдээлэл',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: grey3,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '#',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Бараа',
                                              style: TextStyle(
                                                color: black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              child: Text(
                                                'Хэм.н',
                                                style: TextStyle(
                                                  color: black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              child: Text(
                                                'Тоо',
                                                style: TextStyle(
                                                  color: black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Container(
                                              child: Text(
                                                'Нэгж үнэ',
                                                style: TextStyle(
                                                  color: black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Column(
                                    children: shipment.pullSheetLines!
                                        .map(
                                          (e) => OrderGoodsInfo(
                                            index: shipment.pullSheetLines
                                                ?.indexOf(e),
                                            data: e,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: shipment.pullSheetLines!
                              .map(
                                (e) => Column(
                                  children: [
                                    ShipmentProductCard(
                                      approveButtonClick: () async {
                                        await OrderApi().lineConfirm(
                                          Order(
                                            pullSheetLineId: e.id,
                                            confirmedQuantity: e.quantity,
                                          ),
                                          widget.data.id!,
                                        );
                                      },
                                      data: e,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'ПАДААНЫ ДҮН',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Нийт дүн',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          "351,671 ₮",
                          style: TextStyle(
                            color: orderColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Нэр төрлийн тоо',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          "${shipment.pullSheetLines!.fold(0, (previousValue, element) => previousValue + element.quantity!)}",
                          style: TextStyle(
                            color: orderColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Хүлээн авах барааны тоо',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          "90",
                          style: TextStyle(
                            color: orderColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
    );
  }

  pause() async {
    await OrderApi().pullSheetPause(widget.data.id!);
    setState(() {
      isStart = false;
      _timer.cancel();
    });
  }

  resume() async {
    await OrderApi().pullSheetProceed(widget.data.id!);
    setState(() {});
  }

  end() async {
    await OrderApi().pullSheetEnd(widget.data.id!);
    Navigator.of(context).pop();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    shipment = await OrderApi().pullSheetGet(widget.data.id!);
    setState(() {
      isLoading = false;
    });
  }
}
