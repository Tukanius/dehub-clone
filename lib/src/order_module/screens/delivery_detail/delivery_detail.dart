import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/goods_info_card/order_goods_info_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/src/order_module/screens/product_give/product_give.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
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
    Key? key,
    required this.data,
  }) : super(key: key);

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
        title: Text(
          "${widget.data.receiverBusiness?.profileName}",
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Center(
            child: Text(
              "№${widget.data.refCode}",
              style: TextStyle(
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
          ? Center(
              child: CircularProgressIndicator(
                color: orderColor,
              ),
            )
          : Column(
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
                                  margin: const EdgeInsets.only(
                                      top: 28, bottom: 10),
                                  child: Text(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: orderColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Х.Баярбат',
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
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/map.svg',
                                    colorFilter: ColorFilter.mode(
                                        orderColor, BlendMode.srcIn),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Байршил",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Утас',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: orderColor),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          'assets/svg/call.svg'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Түмэн дэлгүүр, УБ-ЧД, 4-р хороо, Сансар телевиз байр, 1 давхарт 3 тоот',
                            style: TextStyle(
                              color: orderColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Image(
                            image: AssetImage('images/map.jpg'),
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 10,
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
                                      '${get.supplierBusiness?.profileName}',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.supplierBusiness?.partner?.businessName}',
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
                                      'ТТД: ${get.supplierBusiness?.regNumber}',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.supplierBusiness?.partner?.email}',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.supplierBusiness?.partner?.phone}',
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
                                      '${get.buyerBusiness?.profileName}',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.buyerBusiness?.partner?.businessName}',
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
                                      'ТТД: ${get.buyerBusiness?.regNumber}',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.buyerBusiness?.partner?.email}',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${get.buyerBusiness?.partner?.phone}',
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
                          OrderGoodsInfo(
                            data: get.lines,
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
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                get.deliveryNoteStatus == "DELIVERING"
                    ? Container(
                        decoration: BoxDecoration(
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
                              arguments:
                                  ProductGiveArguments(data: widget.data),
                            );
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
    );
  }
}
