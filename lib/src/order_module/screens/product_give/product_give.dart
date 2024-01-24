import 'dart:async';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/shipment_product_card/shipment_product_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/expenses_page/expenses_page.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class ProductGiveArguments {
  Order data;
  ProductGiveArguments({
    required this.data,
  });
}

class ProductGive extends StatefulWidget {
  final Order data;
  static const routeName = '/ProductGive';
  const ProductGive({
    super.key,
    required this.data,
  });

  @override
  State<ProductGive> createState() => _ProductGiveState();
}

class _ProductGiveState extends State<ProductGive> with AfterLayoutMixin {
  bool isStart = false;
  Duration duration = const Duration();
  bool isLoading = true;
  Order shipment = Order();
  User user = User();
  Timer? timer;
  bool isCountDown = true;
  bool startShipment = false;
  bool isSubmit = false;
  Order endResponse = Order();
  Duration resume = const Duration();
  Duration difference = const Duration();
  Duration difference1 = const Duration();

  @override
  afterFirstLayout(BuildContext context) async {
    shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
    if (shipment.dispatchedDate != null) {
      difference = DateTime.now()
          .difference(DateTime.parse(shipment.dispatchedDate.toString()));
      int pausedDurationInSeconds = (shipment.pausedDuration!).round();
      if (shipment.isPaused == true) {
        difference1 = DateTime.now()
            .difference(DateTime.parse(shipment.pausedDate.toString()));
      }
      resume =
          difference - Duration(seconds: pausedDurationInSeconds) - difference1;
    }
    if (shipment.dispatchedDate != null &&
        shipment.isPaused == false &&
        shipment.isEnded == false) {
      startTimer(false);
    }
    setState(() {
      isLoading = false;
    });
  }

  void addTimer() {
    if (shipment.dispatchedDate == null) {
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

  void reset() {
    if (isCountDown) {
      setState(() => duration = const Duration());
    } else {
      setState(() => duration = const Duration());
    }
  }

  void startTimer(bool isProceed) async {
    if (shipment.dispatchedDate == null) {
      try {
        setState(() {
          startShipment = true;
        });
        await OrderApi().deliveryNoteStart(widget.data.id!);
        timer =
            Timer.periodic(const Duration(seconds: 1), (timer) => addTimer());
        shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
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
          await OrderApi().deliveryNoteProceed(widget.data.id!);
        }
        timer =
            Timer.periodic(const Duration(seconds: 1), (timer) => addTimer());
        shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
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
    if (shipment.dispatchedDate == null) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return Text('$hours:$minutes:$seconds');
    } else {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      final hours = twoDigits(resume.inHours);
      final minutes = twoDigits(resume.inMinutes.remainder(60));
      final seconds = twoDigits(resume.inSeconds.remainder(60));
      return Text('$hours:$minutes:$seconds');
    }
  }

  void stopTimer({bool resets = true}) async {
    if (resets) {
      reset();
    }
    await OrderApi().deliveryNotePause(widget.data.id!);
    shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
    setState(() {
      startShipment = false;
      isStart = false;
    });
    setState(() => timer?.cancel());
  }

  end() async {
    try {
      setState(() {
        isLoading = true;
      });
      endResponse = await OrderApi().deliveryNoteEnd(widget.data.id!);
      await Navigator.of(context).pushNamed(
        ExpensesPage.routeName,
        arguments: ExpensesPageArguments(id: endResponse.id!),
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('============endError==========');
      debugPrint(e.toString());
      debugPrint('============endError==========');
    }
  }

  lineConfirm(Order item) async {
    setState(() {
      isSubmit = true;
    });
    await OrderApi().deliveryNoteLineConfirm(
      Order(
        lineId: item.id,
        confirmedQuantity: item.quantity,
      ),
      '${shipment.id}',
    );
    shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
    setState(() {
      isSubmit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
        iconTheme: const IconThemeData(color: orderColor),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pop();
        //     if (shipment.isPaused == false && shipment.isConfirmed == false) {
        //       stopTimer();
        //     }
        //   },
        //   child: const Icon(
        //     Icons.arrow_back_ios_new,
        //     color: orderColor,
        //   ),
        // ),
        title: const Text(
          'Захиалга хүлээлцэх',
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
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (user.currentBusiness?.type == "SUPPLIER")
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
                                        shipment.deliveredDate == null) {
                                      startTimer(true);
                                    }
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: isStart == true
                                          ? orderColor
                                          : lightGrey,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/bx_timer.svg',
                                          colorFilter: ColorFilter.mode(
                                              isStart == true
                                                  ? white
                                                  : buttonColor,
                                              BlendMode.srcIn),
                                        ),
                                        shipment.dispatchedDate == null
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
                                  width: 75,
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
                                        shipment.deliveredDate == null) {
                                      stopTimer(resets: false);
                                    }
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: shipment.isPaused == true
                                          ? orderColor
                                          : lightGrey,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    width: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: shipment.isEnded == false
                                          ? lightGrey
                                          : orderColor,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/check_underline.svg',
                                          colorFilter: ColorFilter.mode(
                                              shipment.isEnded == true
                                                  ? white
                                                  : buttonColor,
                                              BlendMode.srcIn),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        shipment.isEnded == false
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
                        Column(
                          children: shipment.lines!
                              .map(
                                (item) => Column(
                                  children: [
                                    ShipmentProductCard(
                                      approveButtonClick: () async {
                                        if (isSubmit == false) {
                                          lineConfirm(item);
                                        }
                                      },
                                      lineConfirmText:
                                          user.currentBusiness?.type ==
                                                  "SUPPLIER"
                                              ? "Өгсөн"
                                              : "Авсан",
                                      data: item,
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
                        Container(
                          color: white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Нийт дүн',
                                style: TextStyle(
                                  color: buttonColor,
                                ),
                              ),
                              Text(
                                "${Utils().formatCurrency(shipment.lines?.map((e) => e.totalAmount).reduce((value, element) => value! + element!).toString())} ₮",
                                style: const TextStyle(
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
                              const Text(
                                'Нэр төрлийн тоо',
                                style: TextStyle(
                                  color: buttonColor,
                                ),
                              ),
                              Text(
                                "${shipment.lines?.length}",
                                style: const TextStyle(
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
                              const Text(
                                'Хүлээн авах барааны тоо',
                                style: TextStyle(
                                  color: buttonColor,
                                ),
                              ),
                              Text(
                                "${shipment.lines?.fold(0, (previousValue, element) => previousValue + element.quantity!)}",
                                style: const TextStyle(
                                  color: orderColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Хасагдсан',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Column(
                          children: shipment.lines!
                              .map(
                                (e) => Column(
                                  children: [
                                    e.confirmedQuantity != null
                                        ? e.quantity! - e.confirmedQuantity! > 0
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                color: white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('${e.name}'),
                                                    Text(
                                                        '${e.quantity! - e.confirmedQuantity!}'),
                                                  ],
                                                ))
                                            : const SizedBox()
                                        : const SizedBox(),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                if (user.currentBusiness?.type == "BUYER")
                  Container(
                    decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: CustomButton(
                      onClick: () {
                        end();
                      },
                      labelText: "Шалгаж хүлээн авлаа",
                      labelColor: orderColor,
                    ),
                  ),
              ],
            ),
    );
  }
}
