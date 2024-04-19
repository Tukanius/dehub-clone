import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/src/order_module/components/order_product_card/order_product_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/dropship_create/dropship_create.dart';
import 'package:dehub/src/order_module/screens/received_order_detail/components/bottom.dart';
import 'package:dehub/utils/permission.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    super.key,
    required this.listenController,
    required this.id,
  });

  @override
  State<ReceivedOrderDetail> createState() => _ReceivedOrderDetailState();
}

class _ReceivedOrderDetailState extends State<ReceivedOrderDetail>
    with AfterLayoutMixin {
  Order order = Order();
  bool isLoading = true;
  User user = User();
  double? totalAmount;
  General general = General();
  List<Order> splitList = [];

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

  orderStatus() {
    final res = general.orderStatus!
        .firstWhere((element) => element.code == order.orderStatus);
    return res;
  }

  splitCreate() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    List<String>? ids = [];
    if (Permission().check(user, "ORD_SPLIT")) {
      try {
        loading.loading(true);
        for (var data in splitList) {
          ids.add(data.id!);
        }
        await OrderApi().splitCreate(
          Order(ids: ids),
          widget.id,
        );
        loading.loading(false);
        showCustomDialog(context, "Амжилттай", true, onPressed: () {
          Navigator.of(context).pop();
        });
      } catch (e) {
        loading.loading(false);
      }
    } else {
      showCustomDialog(context, "Хандах эрх хүрэлцэхгүй байна", false);
    }
  }

  dropshipping() {
    List<Order> data =
        splitList.where((element) => element.isDropshipping == false).toList();
    if (Permission().check(user, "ORD_DRSHP")) {
      if (data.isEmpty) {
        Navigator.of(context).pushNamed(
          DropshipCreate.routeName,
          arguments: DropshipCreateArguments(
            id: widget.id,
            lines: splitList,
          ),
        );
      } else {
        showCustomDialog(
          context,
          "(${data.map((e) => "${e.skuCode}").join(', ')}) эдгээр бараанууд dropship хийх эрхгүй байна",
          false,
        );
      }
    } else {
      showCustomDialog(context, "Хандах эрх хүрэлцэхгүй байна", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    general = Provider.of<GeneralProvider>(context, listen: true).orderGeneral;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: white,
          surfaceTintColor: white,
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(color: orderColor),
          title: const Text(
            'Захиалгын дэлгэрэнгүй',
            style: TextStyle(
              color: orderColor,
              fontSize: 17,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: splitList.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (Permission().check(user, "ORD_SPLIT"))
                    GestureDetector(
                      onTap: () {
                        List<Order> data = splitList
                            .where((element) => element.isSplit == false)
                            .toList();
                        if (data.isEmpty) {
                          Navigator.of(context).pushNamed(
                            PinCheckScreen.routeName,
                            arguments: PinCheckScreenArguments(
                              onSubmit: splitCreate,
                              color: orderColor,
                              labelText: 'Захиалга салгах',
                            ),
                          );
                        } else {
                          showCustomDialog(
                            context,
                            "(${data.map((e) => "${e.name}").join(', ')}) эдгээр бараа захиалга салгах эрхгүй байна",
                            false,
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: orderColor),
                          borderRadius: BorderRadius.circular(5),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 1,
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Захиалга салгах',
                          style: TextStyle(
                            color: orderColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (Permission().check(user, "ORD_DRSHP"))
                    GestureDetector(
                      onTap: dropshipping,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: orderColor,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 1,
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Dropship захиалах',
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            : null,
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
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    order.type == "SALES" &&
                                            order.salesCode != null
                                        ? Text(
                                            '${order.salesCode}',
                                            style: const TextStyle(
                                              color: orderColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : order.type == "PURCHASE" &&
                                                order.purchaseCode != null
                                            ? Text(
                                                '${order.purchaseCode}',
                                                style: const TextStyle(
                                                  color: orderColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            : const SizedBox(),
                                    Text(
                                      DateFormat("yyyy-MM-dd")
                                          .format(order.createdAt!),
                                      style: const TextStyle(
                                        color: buttonColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      child: Text(
                                        user.currentBusiness?.type ==
                                                        "SUPPLIER" &&
                                                    order.type == "SALES" ||
                                                user.currentBusiness?.type ==
                                                        "BUYER" &&
                                                    order.type == "PURCHASE"
                                            ? '${orderStatus().sentName}'
                                            : '${orderStatus().receivedName}',
                                        style: TextStyle(
                                          color: Color(int.parse(
                                                  orderStatus()
                                                      .color
                                                      .substring(1, 7),
                                                  radix: 16) +
                                              0xff000000),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${user.firstName}',
                                      style: const TextStyle(
                                        color: orderColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const Text(
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    user.currentBusiness?.type == "SUPPLIER"
                                        ? Text(
                                            '${order.receiverBusiness?.profileName}',
                                            style: const TextStyle(
                                              color: orderColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : Text(
                                            '${order.senderBusiness?.profileName}',
                                            style: const TextStyle(
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
                                const Expanded(
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
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat'),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${order.receiverBusiness?.partner?.businessName} ',
                                                style: const TextStyle(
                                                  color: buttonColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${order.receiverBusiness?.partner?.refCode}',
                                                style: const TextStyle(
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
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat'),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${order.senderBusiness?.partner?.businessName} ',
                                                style: const TextStyle(
                                                  color: buttonColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${order.senderBusiness?.partner?.refCode}',
                                                style: const TextStyle(
                                                  color: orderColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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
                          const FieldCard(
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
                            child: const Text(
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
                                const Text(
                                  'Хүлээн авах салбар нэр',
                                  style: TextStyle(
                                    color: buttonColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${order.receiverBranch?.name}',
                                    style: const TextStyle(
                                      color: orderColor,
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
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: lightGrey,
                                  ),
                                  height: 42,
                                  width: 42,
                                  child: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    '${order.receiverBranch?.branchAddress}',
                                    style: const TextStyle(
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
                            secondText:
                                '${order.receiverStaff?.lastName?[0]}. ${order.receiverStaff?.firstName}',
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
                            secondText: DateFormat("yyyy-MM-dd").format(
                                DateTime.parse(order.deliveryDate.toString())),
                            arrowColor: orderColor,
                            color: white,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: const Text(
                              'ЗАХИАЛГЫН ЗҮЙЛ',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Column(
                            children: order.lines!.map((data) {
                              bool possible =
                                  (order.orderStatus == "AUTHORIZED" &&
                                          data.isSplit == false &&
                                          order.salesType != "SPLIT" &&
                                          data.isLoadable == false &&
                                          order.salesType != "DROPSHIPPING" &&
                                          order.salesType != "BACKORDER") ||
                                      (data.isDropshipping == true &&
                                          order.orderStatus == "AUTHORIZED" &&
                                          data.isSplit == false &&
                                          order.salesType != "DROPSHIPPING" &&
                                          order.salesType != "SPLIT" &&
                                          order.salesType != "BACKORDER");
                              return Column(
                                children: [
                                  OrderProductCard(
                                    onClick: () {
                                      if (possible) {
                                        if (splitList.contains(data)) {
                                          setState(() {
                                            splitList.removeWhere((element) =>
                                                element.id == data.id);
                                          });
                                        } else {
                                          setState(() {
                                            splitList.add(data);
                                          });
                                        }
                                      }
                                    },
                                    checkbox: () {
                                      if (possible) {
                                        if (splitList.contains(data)) {
                                          setState(() {
                                            splitList.removeWhere((element) =>
                                                element.id == data.id);
                                          });
                                        } else {
                                          setState(() {
                                            splitList.add(data);
                                          });
                                        }
                                      }
                                    },
                                    readOnly: true,
                                    data: data,
                                    list: possible ? splitList : null,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          if (order.additionalLines!.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: const Text(
                                'Нэмэлтээр',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          if (order.additionalLines!.isNotEmpty)
                            Column(
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
                                                style: const TextStyle(
                                                  color: buttonColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                item.description ?? '-',
                                                style: const TextStyle(
                                                  color: coolGrey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${item.quantity}${item.unit?[0].toLowerCase()} x ${Utils().formatCurrency("${item.price}")}₮',
                                                style: const TextStyle(
                                                  color: buttonColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${Utils().formatCurrency(item.totalAmount.toString())}₮',
                                                style: const TextStyle(
                                                  color: orderColor,
                                                ),
                                              ),
                                            ],
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
                            child: const Text(
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
                            labelText: 'Хөнгөлөлтийн дүн',
                            secondTextColor: orderColor,
                            secondText:
                                '${Utils().formatCurrency(order.discountValue.toString())}₮',
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
                          if (order.paymentTerm?.configType == "CIA" &&
                              order.paymentTerm?.configType == "CBD")
                            const FieldCard(
                              labelTextColor: buttonColor,
                              paddingHorizontal: 15,
                              paddingVertical: 10,
                              labelText: 'Төлбөр баталгаажуулалт',
                              secondTextColor: orderColor,
                              secondText: 'XXX,XXX,XXX.XX₮',
                              arrowColor: orderColor,
                              color: white,
                            ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            color: white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Төлөх сүүлийн огноо',
                                  style: TextStyle(
                                    color: buttonColor,
                                  ),
                                ),
                                Text(
                                  DateFormat("yyyy-MM-dd").format(
                                      DateTime.parse(
                                          order.deliveryDate.toString())),
                                  style: const TextStyle(
                                    color: orderColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: const Text(
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
                              child: const Text(''),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: const Text(
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
                          if (order.attachments!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: const Text(
                                    'Нэмэлт хавсралтууд',
                                    style: TextStyle(
                                      color: buttonColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: order.attachments!
                                      .map(
                                        (data) => attachmentCard(
                                          data,
                                          () {
                                            launchUrl(
                                                Uri.parse(data.url.toString()));
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (splitList.isEmpty)
                    Bottom(
                      totalAmount: order.totalAmount!,
                      listenController: widget.listenController,
                      id: widget.id,
                      order: order,
                    ),
                  if (splitList.isNotEmpty)
                    const SizedBox(
                      height: 70,
                    ),
                ],
              ),
      ),
    );
  }

  Widget attachmentCard(Order data, Function() onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
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
                  style: const TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${data.description}',
                  style: const TextStyle(
                    color: coolGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              color: transparent,
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Харах',
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
          ],
        ),
      ),
    );
  }
}
