import 'package:dehub/api/order_api.dart';
import 'package:dehub/src/order_module/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/src/order_module/screens/product_give/product_give.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';

class DeliveryDetailArguments {
  Order data;
  DeliveryDetailArguments({
    required this.data,
  });
}

class DeliveryDetail extends StatefulWidget {
  final Order data;
  static const routeName = '/DeliveryDetail';
  const DeliveryDetail({
    super.key,
    required this.data,
  });

  @override
  State<DeliveryDetail> createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> with AfterLayoutMixin {
  Order get = Order();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    get = await OrderApi().deliveryNoteGet(widget.data.id!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: orderColor,
        surfaceTintColor: orderColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: white),
        centerTitle: false,
        title: Text(
          "${widget.data.receiverBusiness?.profileName}",
          style: const TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Center(
            child: Text(
              "№${widget.data.refCode}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: white,
              ),
            ),
          ),
          const SizedBox(
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
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                                margin:
                                    const EdgeInsets.only(top: 28, bottom: 10),
                                child: const Text(
                                  'ХҮРГЭЛТ',
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
                                      DateFormat("yyyy-MM-dd")
                                          .format(DateTime.now()),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: orderColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Х.Баярбат',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: orderColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
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
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                SvgPicture.asset(
                                  'assets/svg/map.svg',
                                  colorFilter: const ColorFilter.mode(
                                      orderColor, BlendMode.srcIn),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Байршил",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                FlutterPhoneDirectCaller.callNumber(
                                    "+97696119230");
                              },
                              child: Container(
                                color: transparent,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Утас',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      height: 36,
                                      width: 36,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: orderColor),
                                      child: Center(
                                        child: SvgPicture.asset(
                                            'assets/svg/call.svg'),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Нийлүүлэгч',
                                      style: TextStyle(
                                        color: coolGrey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7.5,
                                    ),
                                    Text(
                                      '${get.supplierBusiness?.profileName}',
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.supplierBusiness?.partner?.businessName}',
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
                                      'ТТД: ${get.supplierBusiness?.regNumber}',
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.supplierBusiness?.partner?.email}',
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.supplierBusiness?.partner?.phone}',
                                      style: const TextStyle(
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
                                    const Text(
                                      'Худалдан авагч',
                                      style: TextStyle(
                                        color: coolGrey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7.5,
                                    ),
                                    Text(
                                      '${get.buyerBusiness?.profileName}',
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.buyerBusiness?.partner?.businessName}',
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
                                      'ТТД: ${get.buyerBusiness?.regNumber}',
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.buyerBusiness?.partner?.email}',
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.buyerBusiness?.partner?.phone}',
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        OrderGoodsInfo(
                          data: get.lines,
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
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: const Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Нэр төрлийн тоо',
                                    style: TextStyle(
                                      color: black,
                                    ),
                                  ),
                                  Text(
                                    '13',
                                    style: TextStyle(
                                      color: orderColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Хүлээн авах барааны тоо',
                                    style: TextStyle(
                                      color: black,
                                    ),
                                  ),
                                  Text(
                                    '90',
                                    style: TextStyle(
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
                if (get.deliveryNoteStatus == "DELIVERING")
                  Container(
                    decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: CustomButton(
                      labelColor: orderColor,
                      labelText: 'Хүрсэн. Бараа олгоё',
                      onClick: () {
                        Navigator.of(context).pushNamed(
                          ProductGive.routeName,
                          arguments: ProductGiveArguments(data: widget.data),
                        );
                      },
                    ),
                  ),
              ],
            ),
    );
  }
}
