import 'dart:io';
import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:dehub/components/scaffold_messenger/scaffold_messenger.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/src/order_module/screens/new_order/new_order.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class ReceivedOrderDetailArguments {
  ListenController listenController;
  String id;
  ReceivedOrderDetailArguments({
    required this.listenController,
    required this.id,
  });
}

class ReceivedOrderDetail extends StatefulWidget {
  final ListenController listenController;
  final String id;
  static const routeName = '/ReceivedOrderDetail';
  const ReceivedOrderDetail({
    Key? key,
    required this.listenController,
    required this.id,
  }) : super(key: key);

  @override
  State<ReceivedOrderDetail> createState() => _ReceivedOrderDetailState();
}

class _ReceivedOrderDetailState extends State<ReceivedOrderDetail>
    with AfterLayoutMixin {
  Order order = Order();
  Order approve = Order();
  bool isLoading = true;
  double? progress;
  User user = User();
  double? totalAmount;
  General general = General();

  @override
  afterFirstLayout(BuildContext context) async {
    order = await OrderApi().orderGet(widget.id);
    totalAmount = order.lines!
        .map((e) => e.quantity! * e.price!)
        .reduce((value, element) => value + element);
    setState(() {
      isLoading = false;
    });
  }

  respond(bool isApprove) async {
    approve.approve = isApprove;
    await OrderApi().respond(widget.id, approve);
    showCustomDialog(
      context,
      isApprove == true ? "Амжилттай зөвшөөрлөө" : 'Татгалзлаа',
      isApprove,
      onPressed: () {
        widget.listenController.changeVariable('respond');
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

  create() async {
    Order create = Order();
    create.orderId = order.id;
    await OrderApi().deliveryManagementCreate(create);
    showCustomDialog(
      context,
      "Амжилттай",
      true,
      onPressed: () {
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
    showCustomDialog(
      context,
      isReview == true ? "Амжилттай" : 'Татгалзлаа',
      isReview,
      onPressed: () {
        widget.listenController.changeVariable('review');
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

  orderStatus() {
    final res = general.orderStatus!
        .firstWhere((element) => element.code == order.orderStatus);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    general = Provider.of<GeneralProvider>(context, listen: true).orderGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: transparent,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: orderColor,
            ),
          ),
        ),
        title: Text(
          'Захиалгын дэлгэрэнгүй',
          style: TextStyle(
            color: orderColor,
            fontSize: 17,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            order.type == "SALES" && order.salesCode != null
                                ? Text(
                                    '${order.salesCode}',
                                    style: TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : order.type == "PURCHASE" &&
                                        order.purchaseCode != null
                                    ? Text(
                                        '${order.purchaseCode}',
                                        style: TextStyle(
                                          color: orderColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : SizedBox(),
                            Text(
                              '${DateFormat("yyyy-MM-dd").format(order.createdAt!)}',
                              style: TextStyle(
                                color: buttonColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Color(int.parse(
                                              orderStatus()
                                                  .color
                                                  .substring(1, 7),
                                              radix: 16) +
                                          0xff000000)
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                                    user.currentBusiness?.type == "SUPPLIER" &&
                                            order.type == "SALES"
                                        ? Text(
                                            '${orderStatus().sentName}',
                                            style: TextStyle(
                                              color: Color(int.parse(
                                                      orderStatus()
                                                          .color
                                                          .substring(1, 7),
                                                      radix: 16) +
                                                  0xff000000),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : Text(
                                            '${orderStatus().receivedName}',
                                            style: TextStyle(
                                              color: Color(int.parse(
                                                      orderStatus()
                                                          .color
                                                          .substring(1, 7),
                                                      radix: 16) +
                                                  0xff000000),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                            Text(
                              '${user.firstName}',
                              style: TextStyle(
                                color: orderColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Харилцагчийн мэдээлэл',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: grey,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            user.currentBusiness?.type == "SUPPLIER"
                                ? Text(
                                    '${order.receiverBusiness?.profileName}',
                                    style: TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    '${order.senderBusiness?.profileName}',
                                    style: TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    marginBottom: 3,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Бизнес код',
                    secondTextColor: orderColor,
                    secondText: user.currentBusiness?.type == "SUPPLIER"
                        ? '${order.receiverBusiness?.refCode}'
                        : '${order.senderBusiness?.refCode}',
                    color: white,
                    secondTextFontWeight: FontWeight.w500,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Партнер нэр',
                            style: TextStyle(color: buttonColor),
                          ),
                        ),
                        user.currentBusiness?.type == "SUPPLIER"
                            ? Expanded(
                                child: RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                    style: TextStyle(fontFamily: 'Montserrat'),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${order.receiverBusiness?.partner?.businessName} ',
                                        style: TextStyle(
                                          color: buttonColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${order.receiverBusiness?.partner?.refCode}',
                                        style: TextStyle(
                                          color: orderColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                    style: TextStyle(fontFamily: 'Montserrat'),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${order.senderBusiness?.partner?.businessName} ',
                                        style: TextStyle(
                                          color: buttonColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${order.senderBusiness?.partner?.refCode}',
                                        style: TextStyle(
                                          color: orderColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    marginBottom: 3,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'ТТД',
                    secondTextColor: buttonColor,
                    secondText: user.currentBusiness?.type == "SUPPLIER"
                        ? '${order.receiverBusiness?.regNumber}'
                        : '${order.senderBusiness?.regNumber}',
                    color: white,
                    secondTextFontWeight: FontWeight.w500,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    marginBottom: 3,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Төлбөрийн нөхцөл',
                    secondTextColor: buttonColor,
                    secondText: '${order.paymentTerm?.description}',
                    color: white,
                    secondTextFontWeight: FontWeight.w500,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    marginBottom: 3,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'НӨАТ төлөгч эсэх',
                    secondTextColor: buttonColor,
                    secondText: 'Тийм',
                    color: white,
                    secondTextFontWeight: FontWeight.w500,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    marginBottom: 3,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Менежер',
                    secondTextColor: orderColor,
                    secondText: user.currentBusiness?.type == "BUYER"
                        ? '${order.buyerStaff?.firstName}'
                        : '${order.supplierStaff?.firstName}',
                    color: white,
                    secondTextFontWeight: FontWeight.w500,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Хүлээн авах хаяг',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'Хүлээн авах салбар нэр',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightGrey,
                          ),
                          height: 42,
                          width: 42,
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'БЗД, 15-р хороо, 3-р гудамж, Гоё байрны 1 давхар, Баялаг хүнс дэлгүүр',
                            style: TextStyle(
                              color: buttonColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    marginBottom: 3,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Хүлээн авах ажилтан',
                    secondTextColor: orderColor,
                    secondText: 'B.Bolormaa',
                    onClick: () {},
                    arrowColor: orderColor,
                    color: white,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    marginBottom: 3,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Хүлээн авах өдөр',
                    secondTextColor: orderColor,
                    secondText:
                        '${DateFormat("yyyy-MM-dd").format(DateTime.parse(order.deliveryDate.toString()))}',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'ЗАХИАЛГЫН ЗҮЙЛ',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Column(
                    children: order.lines!
                        .map(
                          (e) => Column(
                            children: [
                              OrderProductCard(
                                readOnly: true,
                                data: e,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  order.additionalLines?.length != 0
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            'Нэмэлтээр',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : SizedBox(),
                  order.additionalLines?.length != 0
                      ? Column(
                          children: order.additionalLines!
                              .map(
                                (item) => Container(
                                  margin: const EdgeInsets.only(bottom: 3),
                                  color: white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item.name}',
                                            style: TextStyle(
                                              color: buttonColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          item.description != null
                                              ? Text(
                                                  '${item.description}',
                                                  style: TextStyle(
                                                    color: coolGrey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              : Text(
                                                  '-',
                                                  style: TextStyle(
                                                    color: coolGrey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                        ],
                                      ),
                                      Text(
                                        '${Utils().formatCurrency(item.totalAmount.toString())}₮',
                                        style: TextStyle(
                                          color: orderColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : SizedBox(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'НЭГТГЭЛ',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Захиалгад буй',
                    secondTextColor: orderColor,
                    secondText: '${order.lines?.length}',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Нийт тоо ширхэг',
                    secondTextColor: orderColor,
                    secondText:
                        '${order.lines?.fold(0, (previousValue, element) => previousValue + element.quantity!)} ширхэг',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Тооцсон НӨАТ',
                    secondTextColor: orderColor,
                    secondText:
                        '${Utils().formatCurrency(order.lineVatAmount.toString())}₮',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Тооцсон НХАТ',
                    secondTextColor: orderColor,
                    secondText:
                        '${Utils().formatCurrency(order.lineTaxAmount.toString())}₮',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Тооцсон хөнгөлөлт',
                    secondTextColor: orderColor,
                    secondText:
                        '${Utils().formatCurrency(order.lineTotalDiscountAmount.toString())}₮',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Захиалгын нийт дүн',
                    secondTextColor: orderColor,
                    secondText:
                        '${Utils().formatCurrency(order.orderAmount.toString())}₮',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Хүргэлтийн төлбөр',
                    secondTextColor: orderColor,
                    secondText:
                        '${Utils().formatCurrency(order.shippingAmount.toString())}₮',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'Үнийн дүнгийн хөнгөлөлт',
                    secondTextColor: orderColor,
                    secondText:
                        '${Utils().formatCurrency(order.lineTotalDiscountAmount.toString())}₮',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  FieldCard(
                    labelTextColor: buttonColor,
                    paddingHorizontal: 15,
                    paddingVertical: 10,
                    labelText: 'НИЙТ ТӨЛБӨР',
                    secondTextColor: orderColor,
                    secondText:
                        '${Utils().formatCurrency(order.totalAmount.toString())}₮',
                    arrowColor: orderColor,
                    color: white,
                  ),
                  order.paymentTerm?.configType == "CIA" &&
                          order.paymentTerm?.configType == "CBD"
                      ? FieldCard(
                          labelTextColor: buttonColor,
                          paddingHorizontal: 15,
                          paddingVertical: 10,
                          labelText: 'Төлбөр баталгаажуулалт',
                          secondTextColor: orderColor,
                          secondText: 'XXX,XXX,XXX.XX₮',
                          arrowColor: orderColor,
                          color: white,
                        )
                      : SizedBox(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Төлөх сүүлийн огноо',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          '${DateFormat("yyyy-MM-dd").format(DateTime.parse(order.deliveryDate.toString()))}',
                          style: TextStyle(
                            color: orderColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Харилцагчийн нэмэлт хүсэлт',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    height: 120,
                    color: white,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: grey),
                      ),
                      child: Text(''),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Нэмэлт тэмдэглэл',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    height: 120,
                    color: white,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: grey),
                      ),
                    ),
                  ),
                  order.attachments?.length != 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                'Нэмэлт хавсралтууд',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Column(
                              children: order.attachments!
                                  .map((data) => attachmentCard(data, () {
                                        downloadFile(data);
                                      }))
                                  .toList(),
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 70, left: 15, right: 15, top: 15),
                    decoration: BoxDecoration(
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
                            Text(
                              'Нийт дүн: ',
                              style: TextStyle(color: orderColor),
                            ),
                            Text(
                              '${Utils().formatCurrency(totalAmount.toString())}₮',
                              style: TextStyle(
                                color: orderColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        user.currentBusiness?.type == "SUPPLIER" &&
                                order.type == "SALES" &&
                                order.orderStatus == "REGISTERED"
                            ? Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      onSubmit(false, "Татгалзах",
                                          (approve) => review(false));
                                    },
                                    child: Container(
                                      height: 36,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/alert-circle.svg',
                                          ),
                                          Text(
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
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      onSubmit(true, "SO үүсгэх",
                                          (approve) => review(true));
                                    },
                                    child: Container(
                                      height: 36,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/create-so.svg',
                                            colorFilter: ColorFilter.mode(
                                                orderColor, BlendMode.srcIn),
                                          ),
                                          Text(
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )
                            : user.currentBusiness?.type == "SUPPLIER" &&
                                    order.type == "PURCHASE" &&
                                    order.orderStatus == "REVIEWED"
                                ? Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          onSubmit(false, "Захиалга цуцлах",
                                              (approve) => respond(false));
                                        },
                                        child: Container(
                                          height: 36,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/alert-circle.svg',
                                              ),
                                              Text(
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
                                      SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          onSubmit(true, "Захиалга зөвшөөрөх",
                                              (approve) => respond(true));
                                        },
                                        child: Container(
                                          height: 36,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/create-so.svg',
                                                colorFilter: ColorFilter.mode(
                                                    orderColor,
                                                    BlendMode.srcIn),
                                              ),
                                              Text(
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
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )
                                : user.currentBusiness?.type == "BUYER" &&
                                        order.type == "PURCHASE" &&
                                        order.orderStatus == "REGISTERED"
                                    ? Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              onSubmit(false, "Татгалзах",
                                                  (approve) => review(false));
                                            },
                                            child: Container(
                                              height: 36,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svg/alert-circle.svg',
                                                  ),
                                                  Text(
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
                                          SizedBox(
                                            width: 15,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              onSubmit(true, "SO үүсгэх",
                                                  (approve) => review(true));
                                            },
                                            child: Container(
                                              height: 36,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svg/create-so.svg',
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            orderColor,
                                                            BlendMode.srcIn),
                                                  ),
                                                  Text(
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
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      )
                                    : user.currentBusiness?.type == "BUYER" &&
                                            order.type == "SALES" &&
                                            order.orderStatus == "REVIEWED"
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
                                                child: Container(
                                                  height: 36,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/alert-circle.svg',
                                                      ),
                                                      Text(
                                                        'Татгалзах',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffFE2413),
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  onSubmit(
                                                      true,
                                                      "Захиалга зөвшөөрөх",
                                                      (approve) =>
                                                          respond(true));
                                                },
                                                child: Container(
                                                  height: 36,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/create-so.svg',
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                orderColor,
                                                                BlendMode
                                                                    .srcIn),
                                                      ),
                                                      Text(
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
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          )
                                        : user.currentBusiness?.type ==
                                                    "SUPPLIER" &&
                                                order.deliveryNote == null &&
                                                order.orderStatus ==
                                                    "AUTHORIZED"
                                            ? GestureDetector(
                                                onTap: () {
                                                  onSubmit(
                                                    true,
                                                    "Хүргэлт хуваарилах",
                                                    (approve) => create(),
                                                  );
                                                },
                                                child: Container(
                                                  height: 36,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/create-so.svg',
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                orderColor,
                                                                BlendMode
                                                                    .srcIn),
                                                      ),
                                                      Text(
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
                                            : order.orderStatus == "DRAFT"
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                        NewOrder.routeName,
                                                        arguments:
                                                            NewOrderArguments(
                                                          data: order,
                                                          id: order
                                                              .receiverBusinessId,
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      color: transparent,
                                                      child: Column(
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
                                                : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> downloadFile(Order data) async {
    if (Platform.isIOS) {
      try {
        Dio dio = Dio();
        Response response = await dio.get(
          data.url!,
          options: Options(
            responseType: ResponseType.bytes,
          ),
        );
        String tempPath = (await getDownloadsDirectory())!.path;
        File file = File(tempPath);
        await file.writeAsBytes(response.data, flush: true);
        CustomScaffoldMessenger(
          context,
          color: orderColor,
          labelText: 'Амжилттай татагдлаа',
        );
      } catch (e) {
        CustomScaffoldMessenger(
          context,
          color: red,
          labelText: 'Алдаа гарлаа!',
        );
      }
    } else {
      FileDownloader.downloadFile(
        url: data.url.toString(),
        name: data.name,
        onProgress: (fileName, _progress) {
          setState(() {
            progress = _progress;
          });
        },
        onDownloadCompleted: (path) {
          setState(() {
            progress = null;
          });
        },
      );
    }
  }

  Widget attachmentCard(Order data, Function() onClick) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.name}',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${data.description}',
                style: TextStyle(
                  color: coolGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onClick,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              color: transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  progress != null
                      ? Text(
                          'Татаж байна',
                          style: TextStyle(
                            color: orderColor,
                          ),
                        )
                      : Text(
                          'Татах',
                          style: TextStyle(
                            color: orderColor,
                          ),
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: orderColor,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
