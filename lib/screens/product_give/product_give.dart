import 'dart:async';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/shipment_product_card/shipment_product_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/expenses_page/expenses_page.dart';
import 'package:dehub/screens/income_guarantee/income_Guarantee.dart';
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
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ProductGive> createState() => _ProductGiveState();
}

class _ProductGiveState extends State<ProductGive> with AfterLayoutMixin {
  bool isStart = false;
  Duration duration = Duration();
  bool isLoading = true;
  Order shipment = Order();
  User user = User();
  Timer? timer;
  bool isCountDown = true;
  bool startShipment = false;
  Duration resume = Duration();
  Duration difference = Duration();

  @override
  afterFirstLayout(BuildContext context) async {
    shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
    if (shipment.startedDate != null) {
      difference = DateTime.now()
          .difference(DateTime.parse(shipment.startedDate.toString()));
      int pausedDurationInSeconds = (shipment.pausedDuration!).round();
      resume = difference - Duration(seconds: pausedDurationInSeconds);
    }
    setState(() {
      isLoading = false;
    });
  }

  void addTimer() {
    if (shipment.startedDate == null) {
      final addSeconds = 1;

      setState(() {
        final seconds = duration.inSeconds + addSeconds;
        duration = Duration(seconds: seconds);
      });
    } else {
      final addSeconds = 1;

      setState(() {
        final seconds = resume.inSeconds + addSeconds;
        resume = Duration(seconds: seconds);
      });
    }
  }

  void reset() {
    if (isCountDown) {
      setState(() => duration = Duration());
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer() async {
    if (shipment.startedDate == null) {
      try {
        await OrderApi().deliveryNotestart(widget.data.id!);
        timer = Timer.periodic(Duration(seconds: 1), (timer) => addTimer());
        shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
        setState(() {
          isStart = true;
        });
      } catch (e) {
        print('================start================');
        print(e);
      }
    } else {
      try {
        await OrderApi().deliveryNoteProceed(widget.data.id!);
        timer = Timer.periodic(Duration(seconds: 1), (timer) => addTimer());
        shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
        setState(() {
          isStart = true;
        });
      } catch (e) {
        print('================proceed================');
        print(e);
      }
    }
    shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
  }

  Widget buildTime() {
    if (shipment.startedDate == null) {
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
    shipment = await OrderApi().deliveryNoteGet(widget.data.id!);
    await OrderApi().deliveryNotePause(widget.data.id!);
    setState(() {
      startShipment = false;
      isStart = false;
    });
    setState(() => timer?.cancel());
  }

  end() async {
    try {
      await OrderApi().deliveryNoteEnd(widget.data.id!);
      Navigator.of(context).pop();
    } catch (e) {
      print('============endError==========');
      print(e.toString());
      print('============endError==========');
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;

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
          'Захиалга хүлээлцэх',
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
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                                    color: isStart == true
                                        ? orderColor
                                        : lightGrey,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'images/bx_timer.svg',
                                        color: isStart == true
                                            ? white
                                            : buttonColor,
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
                                      'images/timer.svg',
                                      color: buttonColor,
                                    ),
                                    buildTime()
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (shipment.isPaused == false) {
                                    stopTimer(resets: false);
                                  }
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
                        Column(
                          children: shipment.lines!
                              .map(
                                (item) => Column(
                                  children: [
                                    ShipmentProductCard(
                                      approveButtonClick: () async {
                                        await OrderApi()
                                            .deliveryNoteLineConfirm(
                                          Order(
                                            lineId: item.id,
                                            confirmedQuantity: item.quantity,
                                          ),
                                        );
                                      },
                                      lineConfirmText:
                                          user.currentBusiness?.type ==
                                                  "SUPPLIER"
                                              ? "Өгсөн"
                                              : "Авсан",
                                      data: item,
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
                                "${Utils().formatCurrency(shipment.lines?.map((e) => e.totalAmount).reduce((value, element) => value! + element!).toString())} ₮",
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
                                "${shipment.lines?.length}",
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
                                "${shipment.lines?.fold(0, (previousValue, element) => previousValue + element.quantity!)}",
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
                ),
                user.currentBusiness?.type == "BUYER"
                    ? Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: CustomButton(
                          onClick: () {
                            if (user.currentBusiness?.type == "SUPPLIER") {
                              Navigator.of(context).pushNamed(
                                ExpensesPage.routeName,
                                arguments:
                                    ExpensesPageArguments(data: widget.data),
                              );
                            } else {
                              Navigator.of(context)
                                  .pushNamed(IncomeGuarantee.routeName);
                            }
                          },
                          labelText: "Шалгаж хүлээн авлаа",
                          labelColor: orderColor,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
    );
  }
}
