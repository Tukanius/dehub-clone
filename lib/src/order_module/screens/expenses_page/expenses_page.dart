import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/enter_phone_page/enter_phone_page.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class ExpensesPageArguments {
  String id;
  ExpensesPageArguments({
    required this.id,
  });
}

class ExpensesPage extends StatefulWidget {
  final String id;
  static const routeName = '/ExpensesPage';
  const ExpensesPage({
    super.key,
    required this.id,
  });

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> with AfterLayoutMixin {
  User user = User();
  Order receipt = Order();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    receipt = await OrderApi().receiptGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  onSubmit() async {
    try {
      await OrderApi().receiptConfirm('${receipt.id}', Order());
      showCustomDialog(
        context,
        'Баталгаажуулах хүсэлт амжилттай илгээгдлээ',
        true,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  confirm(String id) async {
    await OrderApi().receiptConfirm(id, Order());
    showCustomDialog(
      context,
      'Амжилттай баталгаажууллаа',
      true,
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: orderColor,
        surfaceTintColor: orderColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: white,
          ),
        ),
        centerTitle: false,
        title: user.currentBusiness?.type == "SUPPLIER"
            ? const Text(
                "ЗАРЛАГЫН ПАДААН",
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            : const Text(
                "ОРЛОГЫН ПАДААН",
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
        actions: const [
          Center(
            child: Text(
              "№97278",
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: orderColor,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                  ),
                  child: Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          color: orderColor,
                          margin: const EdgeInsets.only(top: 28, bottom: 10),
                          child: Text(
                            '${receipt.purchaseCode}',
                            style: const TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Эхэлсэн цаг:',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Хүлээлгэн өгсөн:',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Дууссан:',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat("yyyy-MM-dd hh:mm").format(
                                    DateTime.parse(
                                        receipt.deliveryNote!.startDate!)),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: orderColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${receipt.deliveryStaff?.firstName}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: orderColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                DateFormat("yyyy-MM-dd hh:mm")
                                    .format(receipt.deliveredDate!),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: orderColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              information(
                                  receipt.supplierBusiness, 'Нийлүүлэгч'),
                              information(
                                  receipt.buyerBusiness, 'Худалдан авагч')
                            ],
                          ),
                        ),
                        const Divider(
                          color: orderColor,
                          thickness: 1,
                        ),
                        OrderGoodsInfo(
                          data: receipt.receiptLines,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'ПАДААНЫ ДҮН',
                            style: TextStyle(
                              color: coolGrey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Нийт дүн',
                                    style: TextStyle(
                                      color: black,
                                    ),
                                  ),
                                  Text(
                                    '${Utils().formatCurrency(receipt.totalAmount.toString())} ₮',
                                    style: const TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Нэр төрлийн тоо',
                                    style: TextStyle(
                                      color: black,
                                    ),
                                  ),
                                  Text(
                                    '${receipt.receiptLines?.length}',
                                    style: const TextStyle(
                                      color: orderColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Хүлээн авах барааны тоо',
                                    style: TextStyle(
                                      color: black,
                                    ),
                                  ),
                                  Text(
                                    '${receipt.receiptLines?.fold(0, (previousValue, element) => previousValue + element.quantity!)}',
                                    style: const TextStyle(
                                      color: orderColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                user.currentBusiness?.type == "SUPPLIER"
                    ? Container(
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            if (receipt.isBuyerConfirmed == false)
                              Expanded(
                                child: CustomButton(
                                  borderColor: orderColor,
                                  isGradient: true,
                                  onClick: () {
                                    Navigator.of(context).pushNamed(
                                      EnterPhonePage.routeName,
                                      arguments: EnterPhonePageArguments(
                                          data: receipt),
                                    );
                                  },
                                  gradient: const LinearGradient(
                                    colors: [white, white],
                                  ),
                                  container: Container(
                                    color: transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/lock.svg',
                                          height: 16,
                                          width: 16,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Код илгээх',
                                          style: TextStyle(
                                            color: orderColor,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: receipt.isBuyerConfirmed == false &&
                                      receipt.isSupplierConfirmed == false
                                  ? 10
                                  : 0,
                            ),
                            if (receipt.isSupplierConfirmed == false)
                              Expanded(
                                child: CustomButton(
                                  isGradient: true,
                                  onClick: () {
                                    onSubmit();
                                  },
                                  gradient: const LinearGradient(
                                    colors: [orderColor, orderColor],
                                  ),
                                  container: Container(
                                    color: transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/mobile_message.svg',
                                          height: 16,
                                          width: 16,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Батлуулах',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      )
                    : user.currentBusiness?.type == "BUYER" &&
                            receipt.isBuyerConfirmed == false
                        ? Container(
                            decoration: const BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(right: 30, left: 30),
                              child: CustomButton(
                                labelColor: orderColor,
                                labelText: "Баталгаажуулах",
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    PinCheckScreen.routeName,
                                    arguments: PinCheckScreenArguments(
                                      onSubmit: () {
                                        confirm(receipt.id!);
                                      },
                                      color: orderColor,
                                      labelText:
                                          'Захиалга хүлээн авснаа баталгаажуулах ПИН кодоо оруулна уу.',
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : const SizedBox(),
              ],
            ),
    );
  }

  Widget information(Order? data, String labeltext) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labeltext,
            style: const TextStyle(
              color: coolGrey,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 7.5,
          ),
          Text(
            '${data?.profileName}',
            style: const TextStyle(
              color: black,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${data?.partnerName}',
            style: const TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'ТТД: ${data?.regNumber}',
            style: const TextStyle(
              color: black,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${data?.partnerEmail}',
            style: const TextStyle(
              color: black,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${data?.partnerPhone}',
            style: const TextStyle(
              color: black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
