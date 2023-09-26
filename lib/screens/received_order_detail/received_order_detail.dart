import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class ReceivedOrderDetailArguments {
  String id;
  ReceivedOrderDetailArguments({
    required this.id,
  });
}

class ReceivedOrderDetail extends StatefulWidget {
  final String id;
  static const routeName = '/ReceivedOrderDetail';
  const ReceivedOrderDetail({
    Key? key,
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
  User user = User();
  double? totalAmount;

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

  onSubmit(bool isApprove) async {
    approve.approve = isApprove;
    await OrderApi().respond(widget.id, approve);
    showCustomDialog(
      context,
      "Амжилттай зөвшөөрлөө",
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  review(bool isReview) async {
    approve.review = isReview;
    await OrderApi().review(widget.id, approve);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
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
                            user.currentBusiness?.type == "SUPPLIER"
                                ? Text(
                                    '${order.salesCode}',
                                    style: TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    '${order.purchaseCode}',
                                    style: TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            Text(
                              '${Moment.parse(order.createdAt.toString()).format("YYYY-MM-DD HH:mm")}',
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
                                color: lightGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Түр төлөв',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бизнес код',
                          style: TextStyle(color: buttonColor),
                        ),
                        user.currentBusiness?.type == "SUPPLIER"
                            ? Text(
                                '${order.receiverBusiness?.refCode}',
                                style: TextStyle(
                                  color: orderColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                '${order.senderBusiness?.refCode}',
                                style: TextStyle(
                                  color: orderColor,
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ТТД',
                          style: TextStyle(color: buttonColor),
                        ),
                        user.currentBusiness?.type == "SUPPLIER"
                            ? Text(
                                '${order.receiverBusiness?.regNumber}',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                '${order.senderBusiness?.regNumber}',
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
                        Expanded(
                          child: Text(
                            'Төлбөрийн нөхцөл',
                            style: TextStyle(color: buttonColor),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${order.paymentTerm?.description}',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.end,
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
                        Text(
                          'НӨАТ төлөгч эсэх',
                          style: TextStyle(color: buttonColor),
                        ),
                        Text(
                          'Тийм',
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
                        Text(
                          'Менежер',
                          style: TextStyle(color: buttonColor),
                        ),
                        user.currentBusiness?.type == "BUYER"
                            ? Text(
                                '${order.buyerStaff?.firstName}',
                                style: TextStyle(
                                  color: orderColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                '${order.supplierStaff?.firstName}',
                                style: TextStyle(
                                  color: orderColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ],
                    ),
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Хүлээн авах ажилтан',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'B.Bolormaa',
                              style: TextStyle(
                                color: orderColor,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: orderColor,
                              size: 14,
                            )
                          ],
                        )
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
                        Text(
                          'Хүлээн авах өдөр',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${Moment.parse(order.deliveryDate.toString()).format("YYYY-MM-DD HH:mm")}',
                          style: TextStyle(color: orderColor),
                        ),
                      ],
                    ),
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
                          (e) => OrderProductCard(
                            readOnly: true,
                            data: e,
                          ),
                        )
                        .toList(),
                  ),
                  order.additionalLines!.isNotEmpty
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
                  Column(
                    children: order.additionalLines!
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            color: white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Бараа, ажлын нэр',
                                      style: TextStyle(
                                        color: buttonColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '20км-с дээш газарт',
                                      style: TextStyle(
                                        color: coolGrey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '20,000.00₮',
                                  style: TextStyle(
                                    color: orderColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
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
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Захиалгад буй',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          '${order.lines?.length}',
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
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Нийт тоо ширхэг',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          '${order.lines?.fold(0, (previousValue, element) => previousValue + element.quantity!)} ширхэг',
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
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Тооцсон НӨАТ',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          'XXX,XXX,XXX.XX₮',
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
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Тооцсон НХАТ',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          'XXX,XXX,XXX.XX₮',
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
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Тооцсон хөнгөлөлт',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          'XXX,XXX,XXX.XX₮',
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
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Захиалгын нийт дүн',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          'XXX,XXX,XXX.XX₮',
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
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Хүргэлтийн төлбөр',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          'XXX,XXX,XXX.XX₮',
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
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Үнийн дүнгийн хөнгөлөлт',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          'XXX,XXX,XXX.XX₮',
                          style: TextStyle(
                            color: orderColor,
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
                        Text(
                          'НИЙТ ТӨЛБӨР',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          'XXX,XXX,XXX.XX₮',
                          style: TextStyle(
                            color: orderColor,
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
                        Text(
                          'Төлбөр баталгаажуулалт',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          'XXX,XXX,XXX.XX₮',
                          style: TextStyle(
                            color: orderColor,
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
                        Text(
                          'Төлөх сүүлийн огноо',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            color: orderColor,
                          ),
                        ),
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
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed(AddAttachment.routeName);
                  //   },
                  //   child: Container(
                  //     margin: const EdgeInsets.only(bottom: 3),
                  //     color: white,
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 15, vertical: 10),
                  //     child: Row(
                  //       children: [
                  //         SvgPicture.asset('images/attachment_add.svg'),
                  //         SizedBox(
                  //           width: 5,
                  //         ),
                  //         Text(
                  //           'Нэмэх',
                  //           style: TextStyle(
                  //             color: orderColor,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Файлын нэр',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Тайлбар мэдээлэл, тайлбар',
                              style: TextStyle(
                                color: coolGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
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
                      ],
                    ),
                  ),
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
                        user.currentBusiness?.type == "SUPPLIER"
                            ? order.orderStatus == "REGISTERED"
                                ? Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (order.orderStatus ==
                                              "REGISTERED") {
                                            review(false);
                                          } else {
                                            onSubmit(true);
                                          }
                                        },
                                        child: Container(
                                          height: 36,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SvgPicture.asset(
                                                'images/alert-circle.svg',
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
                                          if (order.orderStatus ==
                                              "REGISTERED") {
                                            review(true);
                                          } else {
                                            onSubmit(true);
                                          }
                                        },
                                        child: Container(
                                          height: 36,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SvgPicture.asset(
                                                'images/create-so.svg',
                                                color: orderColor,
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
                                : SizedBox()
                            : order.orderStatus == "REVIEWED"
                                ? Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (order.orderStatus ==
                                              "REGISTERED") {
                                            review(false);
                                          } else {
                                            onSubmit(true);
                                          }
                                        },
                                        child: Container(
                                          height: 36,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SvgPicture.asset(
                                                'images/alert-circle.svg',
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
                                          if (order.orderStatus ==
                                              "REGISTERED") {
                                            review(true);
                                          } else {
                                            onSubmit(true);
                                          }
                                        },
                                        child: Container(
                                          height: 36,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SvgPicture.asset(
                                                'images/create-so.svg',
                                                color: orderColor,
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
                                : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
