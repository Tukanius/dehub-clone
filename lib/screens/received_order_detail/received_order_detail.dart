import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/screens/new_order/add_attachment.dart';
import 'package:dehub/screens/new_order/add_row.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';

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

  @override
  afterFirstLayout(BuildContext context) async {
    order = await OrderApi().orderGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  onSubmit(bool isApprove) async {
    approve.approve = isApprove;
    await OrderApi().respond(widget.id, approve);
    Navigator.of(context).pop();
  }

  review(bool isReview) async {
    approve.review = isReview;
    await OrderApi().review(widget.id, approve);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Icon(
              Icons.arrow_back_ios_new,
              color: orderColor,
            ),
          ),
        ),
        title: Text(
          'Хүлээн авсан захиалга',
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
                            Text(
                              'PO-290812',
                              style: TextStyle(
                                color: orderColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD HH:mm")}',
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
                              'Bolormaa.B',
                              style: TextStyle(
                                color: orderColor,
                              ),
                            )
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
                            Text(
                              '${order.receiverBusiness?.profileName}',
                              style: TextStyle(
                                color: orderColor,
                                fontWeight: FontWeight.w500,
                              ),
                            )
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
                        Text(
                          '${order.receiverBusiness?.refCode}',
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
                        Text(
                          'Партнер нэр',
                          style: TextStyle(color: buttonColor),
                        ),
                        Row(
                          children: [
                            Text(
                              '${order.receiverBusiness?.partner?.businessName}, ',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${order.receiverBusiness?.partner?.refCode}',
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
                          'ТТД',
                          style: TextStyle(color: buttonColor),
                        ),
                        Text(
                          '6324512',
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
                          'Төлбөрийн нөхцөл',
                          style: TextStyle(color: buttonColor),
                        ),
                        Text(
                          '${order.paymentTerm?.description}',
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
                        Text(
                          '${order.receiverStaff?.firstName}',
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
                        Row(
                          children: [
                            Text(
                              'Солих',
                              style: TextStyle(
                                color: orderColor,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.calendar_month,
                              color: orderColor,
                              size: 16,
                            )
                          ],
                        )
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
                            data: e,
                          ),
                        )
                        .toList(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Нэмэлтээр',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AddRow.routeName);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Мөр нэмэх',
                            style: TextStyle(
                              color: orderColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                          '...төрөл',
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
                          '...ширхэг',
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
                      'Нэмэлт тэмдэглэл',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
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
                      'Хавсралт нэмэх',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AddAttachment.routeName);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset('images/attachment_add.svg'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Нэмэх',
                            style: TextStyle(
                              color: orderColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                              'Үзэх',
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
                              '8,820,000.00₮',
                              style: TextStyle(
                                color: orderColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        order.orderStatus == "REGISTERED"
                            ? Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (order.orderStatus == "REGISTERED") {
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
                                      if (order.orderStatus == "REGISTERED") {
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
