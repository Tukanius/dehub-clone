import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/order_additional_line/order_additional_line.dart';
import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:dehub/components/possible-schedule/possible-schedule-card.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/new_order/add_attachment.dart';
import 'package:dehub/screens/new_order/add_row.dart';
import 'package:dehub/screens/new_order/change_branch_name.dart';
import 'package:dehub/screens/new_order/product_choose/product_choose_in_pieces/product_choose.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/screens/new_order/customer_choose.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/models/order.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NewOrderArguments {
  String? id;
  NewOrderArguments({
    this.id,
  });
}

class NewOrder extends StatefulWidget {
  final String? id;
  static const routeName = '/NewOrder';
  const NewOrder({
    this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> with AfterLayoutMixin {
  bool isLoading = true;
  Order customer = Order();
  Order productOrder = Order();
  Order additionalRows = Order();
  Order order = Order();
  Partner partner = Partner();
  Order createOrder = Order();
  Order receiverBranch = Order();
  String selectedDate = '';
  List<Order> product = [];
  List<Order> data = [];
  List<Order> additionalLines = [];
  ListenController receiverBranchController = ListenController();
  ListenController customerListenController = ListenController();
  ListenController additionalRowsListenController = ListenController();
  ListenController productListenController = ListenController();

  @override
  afterFirstLayout(BuildContext context) async {
    if (widget.id != null) {
      customer = await OrderApi().networkGet(widget.id!);
      setState(() {
        order = customer;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  List<String> dates = [
    "${DateTime.now().add(Duration(days: 1))}",
    "${DateTime.now().add(Duration(days: 2))}",
    "${DateTime.now().add(Duration(days: 3))}",
    "${DateTime.now().add(Duration(days: 4))}",
    "${DateTime.now().add(Duration(days: 5))}",
    "${DateTime.now().add(Duration(days: 6))}",
  ];

  showSuccess(ctx) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 75),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Амжилттай',
                      style: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Захиалга амжилттай илгээгдлээ.',
                      textAlign: TextAlign.center,
                    ),
                    ButtonBar(
                      buttonMinWidth: 100,
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: const Text(
                            "Буцах",
                            style: TextStyle(color: dark),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Lottie.asset('images/success.json', height: 150, repeat: false),
            ],
          ),
        );
      },
    );
  }

  totalPrice() {
    setState(() {});
  }

  int quantity = 0;

  totalQuantity() async {
    setState(() {
      quantity = product
          .map((e) => e.quantity)
          .reduce((value, element) => value! + element!)!;
    });
  }

  onSubmit(bool toReview, bool send) async {
    try {
      for (var i = 0; i < product.length; i++) {
        data[i] = Order();
        data[i].variantId = product[i].id;
        data[i].quantity = product[i].quantity;
      }
      createOrder.businessId = order.id;
      createOrder.receiverBranchId = order.receiverBranches?.first.id;
      createOrder.deliveryType = "DEFAULT_DATE";
      createOrder.receiverStaffId = order.receiverStaff?.id;
      createOrder.lines = data;
      createOrder.discountType = "AMOUNT";
      createOrder.discountValue = 0;
      createOrder.toReview = toReview;
      createOrder.send = send;
      createOrder.additionalLines = additionalLines;
      await OrderApi().createOrder(createOrder);
      showSuccess(context);
    } catch (e) {
      print('==========e========');
      print(e.toString());
      print('==========e========');
    }
  }

  @override
  Widget build(BuildContext context) {
    partner = Provider.of<UserProvider>(context, listen: true).partnerUser;
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
          'Шинэ захиалга',
          style: TextStyle(
            color: orderColor,
            fontSize: 17,
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            color: orderColor,
            height: 1,
          ),
          preferredSize: Size.fromHeight(2),
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
                              'SO-290812',
                              style: TextStyle(
                                color: transparent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD HH:mm")}',
                              style: TextStyle(
                                color: buttonColor,
                              ),
                              textAlign: TextAlign.end,
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
                              '${partner.user?.firstName}',
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
                            customer.partner?.businessName != null
                                ? Text(
                                    '${customer.partner?.businessName}',
                                    style: TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    'Харилцагч сонгох',
                                    style: TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                OrderCustomerChoose.routeName,
                                arguments: OrderCustomerChooseArguments(
                                    customerListenController:
                                        customerListenController));
                          },
                          child: Container(
                            color: transparent,
                            child: Row(
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
                                  Icons.arrow_forward_ios,
                                  color: orderColor,
                                  size: 14,
                                )
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
                          'Бизнес код',
                          style: TextStyle(color: buttonColor),
                        ),
                        customer.refCode != null
                            ? Text(
                                '${customer.refCode}',
                                style: TextStyle(
                                  color: orderColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                '#BusRef',
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
                            customer.partnerName != null
                                ? Text(
                                    '${customer.partnerName}, ',
                                    style: TextStyle(
                                      color: buttonColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    'Партнер нэр, ',
                                    style: TextStyle(
                                      color: buttonColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            customer.partner?.refCode != null
                                ? Text(
                                    '${customer.partner?.refCode}',
                                    style: TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    '#PartnerRef',
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
                        customer.regNumber != null
                            ? Text(
                                '${customer.regNumber}',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                'ТТД',
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
                        order.isVatPayer == true
                            ? Text(
                                'Тийм',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                'Үгүй',
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
                        order.receiverStaff != null || order.receiverStaff != {}
                            ? Text(
                                '${order.receiverStaff?.firstName}',
                                style: TextStyle(
                                  color: orderColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(''),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Хүлээн авах салбар',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        order.receiverBranches != null
                            ? order.receiverBranches!.length > 1
                                ? GestureDetector(
                                    onTap: () {
                                      if (order.receiverBranches!.length > 1) {
                                        Navigator.of(context).pushNamed(
                                          ChangeBranchNamePage.routeName,
                                          arguments:
                                              ChangeBranchNamePageArguments(
                                            data: order.receiverBranches!,
                                            receiverBranchController:
                                                receiverBranchController,
                                          ),
                                        );
                                      } else {
                                        print('asdf');
                                      }
                                    },
                                    child: Container(
                                      color: transparent,
                                      child: Row(
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
                                            Icons.arrow_forward_ios,
                                            color: orderColor,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox()
                            : SizedBox(),
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
                          child: order.receiverBranches != null
                              ? receiverBranch != {}
                                  ? Text(
                                      '${order.receiverBranches?.first.branchAddress}',
                                      style: TextStyle(
                                        color: buttonColor,
                                      ),
                                    )
                                  : Text(
                                      '${receiverBranch.branchAddress}',
                                      style: TextStyle(
                                        color: buttonColor,
                                      ),
                                    )
                              : Text(
                                  'Салбар тохируулаагүй байна !',
                                  style: TextStyle(
                                    color: red,
                                  ),
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
                          'Хүлээн авах ажилтан',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${order.receiverStaff?.firstName}',
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
                            selectedDate == ''
                                ? order.deliveryDate != null
                                    ? Text(
                                        '${Moment.parse(order.deliveryDate.toString()).format("YYYY-MM-DD")}',
                                        style: TextStyle(
                                          color: orderColor,
                                        ),
                                      )
                                    : Text('')
                                : Text(
                                    '${Moment.parse(selectedDate).format("YYYY-MM-DD")}',
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
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    color: white,
                    margin: const EdgeInsets.only(bottom: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Хамгийн ойрхон хүргэх боломжтой хуваарьт өдөр',
                          style: TextStyle(
                            color: grey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            childAspectRatio: 1 / 0.6,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            children: dates
                                .map(
                                  (e) => PossibleScheduleCard(
                                    formattedDate: DateFormat("EEEE")
                                        .format(DateTime.parse(e)),
                                    isSelected: selectedDate == e,
                                    onClick: () {
                                      setState(() {
                                        selectedDate = e;
                                      });
                                    },
                                    data: e,
                                  ),
                                )
                                .toList()),
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
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ProductChoose.routeName,
                                arguments: ProductChooseArguments(
                                  businessId: customer.id!,
                                  productListenController:
                                      productListenController,
                                ),
                              );
                            },
                            child: Text(
                              'Мөр нэмэх',
                              style: TextStyle(
                                color: orderColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ProductChoose.routeName,
                                arguments: ProductChooseArguments(
                                  isPackage: true,
                                  businessId: customer.id!,
                                  productListenController:
                                      productListenController,
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Багцаар нэмэх',
                                  style: TextStyle(
                                    color: orderColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.download_for_offline_outlined,
                                  color: orderColor,
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: product
                        .map(
                          (item) => OrderProductCard(
                            onCloseClick: () {
                              setState(() {
                                product.removeWhere((element) =>
                                    element.salesCode == item.salesCode);
                                data.removeWhere((element) =>
                                    element.salesCode == item.salesCode);
                              });
                            },
                            data: item,
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
                      Navigator.of(context).pushNamed(
                        AddRow.routeName,
                        arguments: AddRowArguments(
                          additionalRowsListenController:
                              additionalRowsListenController,
                        ),
                      );
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
                  Column(
                    children: additionalLines
                        .map((e) => Column(
                              children: [
                                OrderAdditionalLine(
                                  data: e,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ))
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
                          '${product.length}',
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
                        product.isNotEmpty
                            ? Text(
                                '${product.map((e) => e.quantity).reduce((value, element) => value! + element!).toString()}',
                                style: TextStyle(
                                  color: orderColor,
                                ),
                              )
                            : Text(
                                '0',
                                style: TextStyle(
                                  color: orderColor,
                                ),
                              )
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
                          '0₮',
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
                          '0₮',
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
                          '0₮',
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
                        product.isNotEmpty
                            ? Text(
                                '${product.fold(0, (previousValue, element) => previousValue + (element.price!.toInt() * element.quantity!.toInt()))}₮',
                                style: TextStyle(
                                  color: orderColor,
                                ),
                              )
                            : Text(
                                '0₮',
                                style: TextStyle(
                                  color: orderColor,
                                ),
                              )
                      ],
                    ),
                  ),
                  FormTextField(
                    name: 'shippingAmount',
                    textAlign: TextAlign.end,
                    textColor: orderColor,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Хүргэлтийн төлбөр',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      hintText: "Энд оруулна уу",
                      hintStyle: TextStyle(color: orderColor),
                      filled: true,
                      fillColor: white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.zero,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                    ),
                  ),
                  FormTextField(
                    name: 'discountAmount',
                    textAlign: TextAlign.end,
                    textColor: orderColor,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Үнийн дүнгийн хөнгөлөлт',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      hintText: "Энд оруулна уу",
                      hintStyle: TextStyle(color: orderColor),
                      filled: true,
                      fillColor: white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.zero,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
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
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: FormTextField(
                      textAlign: TextAlign.left,
                      name: 'additional',
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        fillColor: white,
                        filled: true,
                        hintStyle: TextStyle(
                          color: orderColor,
                        ),
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
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: FormTextField(
                      textAlign: TextAlign.left,
                      name: 'description',
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        fillColor: white,
                        filled: true,
                        hintStyle: TextStyle(
                          color: orderColor,
                        ),
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
                        Text(
                          'Нийт дүн: ',
                          style: TextStyle(color: orderColor),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                onSubmit(false, false);
                              },
                              child: Container(
                                height: 32,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'images/save.svg',
                                      color: orderColor,
                                    ),
                                    Text(
                                      'Хадгалах',
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
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context)
                                //     .pushNamed(OrderSendPage.routeName);
                                onSubmit(true, false);
                              },
                              child: Container(
                                height: 32,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'images/control.svg',
                                      color: orderColor,
                                    ),
                                    Text(
                                      'Хянуулах',
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
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context)
                                //     .pushNamed(OrderSendCustomer.routeName);
                                onSubmit(true, true);
                              },
                              child: Container(
                                color: transparent,
                                height: 32,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'images/message_sent.svg',
                                      color: orderColor,
                                    ),
                                    Text(
                                      'Илгээх',
                                      style: TextStyle(
                                        color: orderColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    customerListenController.addListener(() async {
      setState(() {
        customer = customerListenController.customerOrder!;
      });
      setState(() {
        isLoading = true;
      });
      var res = await OrderApi().networkGet(customer.id!);
      setState(() {
        order = res;
        isLoading = false;
      });
    });
    productListenController.addListener(() {
      productOrder = productListenController.productOrder!;
      setState(() {
        product.add(productOrder);
        data.add(productOrder);
      });
    });
    additionalRowsListenController.addListener(() {
      additionalRows = additionalRowsListenController.additionalRows!;
      setState(() {
        additionalLines.add(additionalRows);
      });
    });
    receiverBranchController.addListener(() {
      setState(() {
        receiverBranch = receiverBranchController.receiverBranch!;
      });
    });
    super.initState();
  }
}
