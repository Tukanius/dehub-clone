import 'package:dehub/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/enter_phone_page/enter_phone_page.dart';
import 'package:dehub/screens/receiver_otp_verify/receiver_otp_verify.dart';
// import 'package:dehub/screens/product_give/product_give.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ExpensesPageArguments {
  Order data;
  ExpensesPageArguments({
    required this.data,
  });
}

class ExpensesPage extends StatefulWidget {
  final Order data;
  static const routeName = '/ExpensesPage';
  const ExpensesPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: orderColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
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
        actions: [
          const Center(
            child: Text(
              "№97278",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            color: orderColor,
                            margin: const EdgeInsets.only(top: 28, bottom: 10),
                            child: Text(
                              'PO - 212323',
                              style: TextStyle(
                                color: white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Column(
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
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${Moment.parse(widget.data.deliveryDate.toString()).format("YYYY-MM-DD HH:mm")}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: orderColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${widget.data.deliveryStaff?.firstName}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: orderColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '-',
                                  style: TextStyle(
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Нийлүүлэгч',
                                style: TextStyle(
                                  color: coolGrey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                              Text(
                                '${widget.data.supplierBusiness?.profileName}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${widget.data.supplierBusiness?.partnerName}',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'ТТД: ${widget.data.supplierBusiness?.regNumber}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${widget.data.supplierBusiness?.partnerEmail}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${widget.data.supplierBusiness?.partnerPhone}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Худалдан авагч',
                                style: TextStyle(
                                  color: coolGrey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                              Text(
                                '${widget.data.buyerBusiness?.profileName}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${widget.data.buyerBusiness?.partnerName}',
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'ТТД: ${widget.data.buyerBusiness?.regNumber}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${widget.data.buyerBusiness?.partnerEmail}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${widget.data.buyerBusiness?.partnerPhone}',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: orderColor,
                      thickness: 1,
                    ),
                    Text(
                      'БАРААНЫ МЭДЭЭЛЭЛ',
                      style: TextStyle(
                        color: coolGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      children: widget.data.receiptLines!
                          .map(
                            (e) => OrderGoodsInfo(
                              index: widget.data.receiptLines?.indexOf(e),
                              data: e,
                            ),
                          )
                          .toList(),
                    ),
                    Text(
                      'ПАДААНЫ ДҮН',
                      style: TextStyle(
                        color: coolGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Нийт дүн',
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                        Text(
                          '351,670 ₮',
                          style: TextStyle(
                            color: orderColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Нэр төрлийн тоо',
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                        Text(
                          '${widget.data.receiptLines?.length}',
                          style: const TextStyle(
                            color: orderColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Хүлээн авах барааны тоо',
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                        Text(
                          '${widget.data.receiptLines?.fold(0, (previousValue, element) => previousValue + element.quantity!)}',
                          style: const TextStyle(
                            color: orderColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
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
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: orderColor),
                          ),
                          child: CustomButton(
                            isGradient: true,
                            onClick: () {
                              Navigator.of(context)
                                  .pushNamed(EnterPhonePage.routeName);
                            },
                            gradient: const LinearGradient(
                              colors: [white, white],
                            ),
                            container: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'images/lock.svg',
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
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: orderColor),
                          ),
                          child: CustomButton(
                            isGradient: true,
                            onClick: () {},
                            gradient: const LinearGradient(
                              colors: [orderColor, orderColor],
                            ),
                            container: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'images/mobile_message.svg',
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
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    margin: const EdgeInsets.only(right: 30, left: 30),
                    child: CustomButton(
                      labelColor: orderColor,
                      labelText: "Баталгаажуулах",
                      onClick: () {
                        Navigator.of(context)
                            .pushNamed(ReceiverOtpVerify.routeName);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
