import 'dart:async';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/src/order_module/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/src/order_module/components/shipment_product_card/shipment_product_card.dart';
import 'package:dehub/src/order_module/components/shipping_card/shipping_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/order_module/screens/pull_sheet_expenses/pull_sheet_expenses.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

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
    super.key,
    required this.data,
  });

  @override
  State<OrderShipment> createState() => _OrderShipmentState();
}

class _OrderShipmentState extends State<OrderShipment> with AfterLayoutMixin {
  bool isStart = false;
  Duration duration = const Duration();
  bool isLoading = true;
  Order shipment = Order();
  Timer? timer;
  bool startShipment = false;
  Duration resume = const Duration();
  Duration difference1 = const Duration();
  Duration difference = const Duration();
  String? lineId;

  @override
  afterFirstLayout(BuildContext context) async {
    shipment = await OrderApi().pullSheetGet(widget.data.id!);
    if (shipment.startedDate != null) {
      difference = DateTime.now()
          .difference(DateTime.parse(shipment.startedDate.toString()));
      int pausedDurationInSeconds = (shipment.pausedDuration!).round();
      if (shipment.isPaused == true) {
        difference1 = DateTime.now()
            .difference(DateTime.parse(shipment.pausedDate.toString()));
      }
      resume =
          difference - Duration(seconds: pausedDurationInSeconds) - difference1;
    }
    if (shipment.startedDate != null &&
        shipment.isPaused == false &&
        shipment.endedDate == null) {
      startTimer(false);
    }
    setState(() {
      isLoading = false;
    });
  }

  void addTimer() {
    if (shipment.startedDate == null) {
      const addSeconds = 1;

      setState(() {
        final seconds = duration.inSeconds + addSeconds;
        duration = Duration(seconds: seconds);
      });
    } else {
      const addSeconds = 1;

      setState(() {
        final seconds = resume.inSeconds + addSeconds;
        resume = Duration(seconds: seconds);
      });
    }
  }

  void startTimer(bool isProceed) async {
    if (shipment.startedDate == null) {
      try {
        setState(() {
          startShipment = true;
        });
        await OrderApi().pullSheetStart(widget.data.id!);
        timer =
            Timer.periodic(const Duration(seconds: 1), (timer) => addTimer());
        shipment = await OrderApi().pullSheetGet(widget.data.id!);
        setState(() {
          isStart = true;
        });
      } catch (e) {
        setState(() {
          startShipment = false;
        });
        debugPrint('================start================');
        debugPrint(e.toString());
      }
    } else {
      try {
        if (isProceed == true) {
          await OrderApi().pullSheetProceed(widget.data.id!);
        }
        timer =
            Timer.periodic(const Duration(seconds: 1), (timer) => addTimer());
        shipment = await OrderApi().pullSheetGet(widget.data.id!);
        setState(() {
          isStart = true;
        });
      } catch (e) {
        setState(() {
          startShipment = false;
        });
        debugPrint('================proceed================');
        debugPrint(e.toString());
      }
    }
  }

  Widget buildTime() {
    if (shipment.startedDate == null) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return Text(
        '$hours:$minutes:$seconds',
        style: const TextStyle(fontSize: 13),
      );
    } else {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      final hours = twoDigits(resume.inHours);
      final minutes = twoDigits(resume.inMinutes.remainder(60));
      final seconds = twoDigits(resume.inSeconds.remainder(60));
      return Text(
        '$hours:$minutes:$seconds',
        style: const TextStyle(fontSize: 13),
      );
    }
  }

  void stopTimer({bool resets = true}) async {
    await OrderApi().pullSheetPause(widget.data.id!);
    shipment = await OrderApi().pullSheetGet(widget.data.id!);
    setState(() {
      startShipment = false;
      isStart = false;
    });
    setState(() => timer?.cancel());
  }

  end() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      if (widget.data.endedDate == null) {
        await OrderApi().pullSheetEnd(widget.data.id!);
      }
      shipment = await OrderApi().pullSheetGet(widget.data.id!);
      loading.loading(false);
      await Navigator.of(context).pushNamed(
        PullSheetExpenses.routeName,
        arguments: PullSheetExpensesArguments(data: shipment),
      );
    } catch (e) {
      loading.loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = Provider.of<LoadingProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: orderColor),
        title: const Text(
          'Ачилт хийх',
          style: TextStyle(
            color: buttonColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
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
                            if (startShipment == false &&
                                widget.data.endedDate == null) {
                              startTimer(true);
                            }
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
                                  'assets/svg/bx_timer.svg',
                                  colorFilter: ColorFilter.mode(
                                      isStart == true ? white : buttonColor,
                                      BlendMode.srcIn),
                                ),
                                shipment.startedDate == null
                                    ? Text(
                                        'Эхлэх',
                                        style: TextStyle(
                                          color: isStart == true
                                              ? white
                                              : buttonColor,
                                        ),
                                      )
                                    : Text(
                                        'Үргэлжлүүлэх',
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: isStart == true
                                              ? white
                                              : buttonColor,
                                        ),
                                      ),
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
                                'assets/svg/timer.svg',
                                colorFilter: const ColorFilter.mode(
                                    buttonColor, BlendMode.srcIn),
                              ),
                              buildTime()
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (shipment.isPaused == false &&
                                widget.data.endedDate == null) {
                              stopTimer(resets: false);
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: shipment.isPaused == true
                                  ? orderColor
                                  : lightGrey,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pause_circle,
                                  color: shipment.isPaused == true
                                      ? white
                                      : buttonColor,
                                ),
                                Text(
                                  'Зогсоох',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: shipment.isPaused == true
                                        ? white
                                        : buttonColor,
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
                              color: widget.data.endedDate == null
                                  ? lightGrey
                                  : orderColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/check_underline.svg',
                                  colorFilter: ColorFilter.mode(
                                      widget.data.endedDate != null
                                          ? white
                                          : buttonColor,
                                      BlendMode.srcIn),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                widget.data.endedDate == null
                                    ? const Text(
                                        'Дуусгах',
                                        style: TextStyle(
                                          color: buttonColor,
                                          fontSize: 13,
                                        ),
                                      )
                                    : const Text(
                                        'Дууссан',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 13,
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
                              index: 0,
                              startAnimation: true,
                              data: widget.data,
                            ),
                            OrderGoodsInfo(
                              data: shipment.pullSheetLines,
                            ),
                            const SizedBox(
                              height: 10,
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
                                        try {
                                          loading.loading(true);
                                          await OrderApi().pullSheetLineConfirm(
                                            Order(
                                              pullSheetLineId: e.id,
                                              confirmedQuantity: e.quantity,
                                            ),
                                            widget.data.id!,
                                          );
                                          shipment = await OrderApi()
                                              .pullSheetGet(widget.data.id!);
                                          loading.loading(false);
                                        } catch (e) {
                                          loading.loading(false);
                                        }
                                      },
                                      data: e,
                                    ),
                                    const SizedBox(
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
                    child: const Text(
                      'ПАДААНЫ ДҮН',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FieldCard(
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    labelText: "Нэр төрлийн тоо",
                    secondText: "${shipment.pullSheetLines?.length}",
                    secondTextColor: orderColor,
                    color: white,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Хүлээн авах барааны тоо',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          "${shipment.pullSheetLines?.fold(0, (previousValue, element) => previousValue + element.quantity!)}",
                          style: const TextStyle(
                            color: orderColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
    );
  }
}
