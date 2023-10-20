import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/order_additional_line/order_additional_line.dart';
import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:dehub/components/possible-schedule/possible-schedule-card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/new_order/add_attachment.dart';
import 'package:dehub/screens/new_order/order_add_row.dart';
import 'package:dehub/screens/new_order/change_branch_name.dart';
import 'package:dehub/screens/new_order/product_choose/product_choose_in_pieces/product_choose.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/screens/new_order/customer_choose.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/models/order.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

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
  DateTime dateTime = DateTime.now();
  Order productOrder = Order();
  Order additionalRows = Order();
  Order order = Order();
  User user = User();
  Order createOrder = Order();
  Order receiverBranch = Order();
  String selectedDate = '';
  FilePickerResult? result;
  List<Order> product = [];
  List<Order> packageProduct = [];
  List<Order> data = [];
  List<Order> additionalLines = [];
  List<FilePickerResult> files = [];
  ListenController receiverBranchController = ListenController();
  ListenController customerListenController = ListenController();
  ListenController additionalRowsListenController = ListenController();
  ListenController productListenController = ListenController();
  TextEditingController shippingAmountController = TextEditingController();
  ScrollController scrollController = ScrollController();
  ListenController pickedFile = ListenController();
  ListenController productInPackageController = ListenController();
  // List<Order> packageProduct = [];
  double totalVatAmount = 0;
  double totalTaxAmount = 0;
  double totalAmount = 0;
  double finalAmount = 0;
  bool isCheck = false;
  bool selectedDateValidate = false;
  var dateKey = GlobalKey();

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

  validateCheck(bool toReview, bool send) {
    if (isCheck == false && selectedDate == '') {
      // scrollController.animateTo(
      //   scrollController.position.minScrollExtent + 300,
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.ease,
      // );
      Scrollable.ensureVisible(dateKey.currentContext!,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        selectedDateValidate = true;
      });
    } else {
      onSubmit(toReview, send);
    }
  }

  onSubmit(bool toReview, bool send) async {
    // try {
    for (var i = 0; i < product.length; i++) {
      data[i] = Order();
      data[i].variantId = product[i].id;
      data[i].quantity = product[i].quantity;
      print(product[i].toJson());
    }
    // createOrder.businessId = order.id;
    // createOrder.receiverBranchId =
    //     receiverBranch.id ?? order.receiverBranches?.first.id;
    // createOrder.deliveryDate = isCheck == false
    //     ? DateTime.parse(selectedDate.toString())
    //     : DateTime.parse(dateTime.toString());
    // createOrder.deliveryType =
    //     isCheck == false ? "DEFAULT_DATE" : "CUSTOM_DATE";
    // createOrder.receiverStaffId = order.receiverStaff?.id;
    // createOrder.lines = data;
    // createOrder.discountType = "AMOUNT";
    // createOrder.attachments = files;
    // createOrder.discountValue = 0;
    // createOrder.toReview = toReview;
    // createOrder.send = send;
    await OrderApi().createOrder(Order(
      businessId: order.id,
      receiverBranchId: receiverBranch.id ?? order.receiverBranches?.first.id,
      deliveryDate:
          isCheck == false ? selectedDate.toString() : dateTime.toString(),
      deliveryType: isCheck == false ? "DEFAULT_DATE" : "CUSTOM_DATE",
      receiverStaffId: order.receiverStaff?.id,
      lines: data,
      discountType: "AMOUNT",
      attachments: files,
      discountValue: 0,
      toReview: toReview,
      send: send,
    ));
    showCustomDialog(
      context,
      "Захиалга амжилттай илгээгдлээ",
      true,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // } catch (e) {
    // debugPrint('==========e========');
    // debugPrint(e.toString());
    // debugPrint('==========e========');
    // }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
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
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: orderColor,
            ),
          ),
        ),
        title: const Text(
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
          preferredSize: const Size.fromHeight(2),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: orderColor,
              ),
            )
          : SingleChildScrollView(
              controller: scrollController,
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
                            const Text(
                              'SO-290812',
                              style: TextStyle(
                                color: transparent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD HH:mm")}',
                              style: const TextStyle(
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
                              child: const Text(
                                'Түр төлөв',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              '${user.firstName}',
                              style: const TextStyle(
                                color: orderColor,
                              ),
                            )
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
                                shape: BoxShape.circle,
                                color: grey,
                              ),
                              child: customer.logo != null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        '${customer.logo}',
                                        scale: 1,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          AssetImage('images/avatar.png'),
                                    ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            customer.partner?.businessName != null
                                ? Text(
                                    '${customer.partner?.businessName}',
                                    style: const TextStyle(
                                      color: orderColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : const Text(
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
                                    customerListenController,
                              ),
                            );
                          },
                          child: Container(
                            color: transparent,
                            child: const Row(
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
                        const Text(
                          'Бизнес код',
                          style: TextStyle(color: buttonColor),
                        ),
                        customer.refCode != null
                            ? Text(
                                '${customer.refCode}',
                                style: const TextStyle(
                                  color: orderColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const Text(
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
                        const Text(
                          'Партнер нэр',
                          style: TextStyle(color: buttonColor),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customer.partnerName != null
                                  ? Expanded(
                                      child: Text(
                                        '${customer.partnerName},',
                                        style: const TextStyle(
                                          color: buttonColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    )
                                  : const Text(
                                      'Партнер нэр, ',
                                      style: TextStyle(
                                        color: buttonColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              customer.partner?.refCode != null
                                  ? Text(
                                      ' ${customer.partner?.refCode}',
                                      style: const TextStyle(
                                        color: orderColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : const Text(
                                      '#PartnerRef',
                                      style: TextStyle(
                                        color: orderColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ],
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
                        const Text(
                          'ТТД',
                          style: TextStyle(color: buttonColor),
                        ),
                        customer.regNumber != null
                            ? Text(
                                '${customer.regNumber}',
                                style: const TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const Text(
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
                        const Expanded(
                          child: Text(
                            'Төлбөрийн нөхцөл',
                            style: TextStyle(color: buttonColor),
                          ),
                        ),
                        Expanded(
                          child: order.paymentTerm?.description != null
                              ? Text(
                                  '${order.paymentTerm?.description}',
                                  style: const TextStyle(
                                    color: buttonColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.end,
                                )
                              : Text(
                                  'Төлбөрийн нөхцөл',
                                  style: const TextStyle(
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
                        const Text(
                          'НӨАТ төлөгч эсэх',
                          style: TextStyle(color: buttonColor),
                        ),
                        order.isVatPayer == true
                            ? const Text(
                                'Тийм',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const Text(
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
                        const Text(
                          'Менежер',
                          style: TextStyle(color: buttonColor),
                        ),
                        order.receiverStaff?.id != null
                            ? Text(
                                '${order.receiverStaff?.firstName}',
                                style: const TextStyle(
                                  color: orderColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const Text(
                                'Менежер',
                                style: const TextStyle(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
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
                                      Navigator.of(context).pushNamed(
                                        ChangeBranchNamePage.routeName,
                                        arguments:
                                            ChangeBranchNamePageArguments(
                                          data: order.receiverBranches!,
                                          receiverBranchController:
                                              receiverBranchController,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      color: transparent,
                                      child: const Row(
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
                                : const SizedBox()
                            : const SizedBox(),
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
                          child: order.receiverBranches != null
                              ? order.receiverBranches?.length == 0
                                  ? const Text(
                                      'Салбар тохируулаагүй байна',
                                      style: TextStyle(
                                        color: red,
                                      ),
                                    )
                                  : receiverBranch.branchAddress == null
                                      ? Text(
                                          '${order.receiverBranches?.first.branchAddress}',
                                          style: const TextStyle(
                                            color: buttonColor,
                                          ),
                                        )
                                      : Text(
                                          '${receiverBranch.branchAddress}',
                                          style: const TextStyle(
                                            color: buttonColor,
                                          ),
                                        )
                              : const Text(
                                  'Харилцагч сонгоно уу',
                                  style: TextStyle(
                                    color: orderColor,
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
                        const Text(
                          'Хүлээн авах ажилтан',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        order.receiverStaff?.firstName != null
                            ? Row(
                                children: [
                                  Text(
                                    '${order.receiverStaff?.firstName}',
                                    style: const TextStyle(
                                      color: orderColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: orderColor,
                                    size: 14,
                                  )
                                ],
                              )
                            : Text(
                                'Хүлээн авах ажилтан',
                                style: const TextStyle(
                                  color: orderColor,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                            color: orderColor,
                            width: 2,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        activeColor: orderColor,
                        value: isCheck,
                        onChanged: (value) {
                          setState(() {
                            isCheck = value!;
                          });
                        },
                      ),
                      Text('Хуваарьт өдөрөөс бусад өдөр сонгох')
                    ],
                  ),
                  isCheck == false
                      ? Container(
                          key: dateKey,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15),
                          color: white,
                          margin: const EdgeInsets.only(bottom: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Хамгийн ойрхон хүргэх боломжтой хуваарьт өдөр',
                                style: TextStyle(
                                  color: grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  childAspectRatio: 1 / 0.6,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 10,
                                  shrinkWrap: true,
                                  crossAxisCount: 3,
                                  children: dates
                                      .map(
                                        (e) => PossibleScheduleCard(
                                          validate: selectedDateValidate,
                                          formattedDate: DateFormat("EEEE")
                                              .format(DateTime.parse(e)),
                                          isSelected: selectedDate == e,
                                          onClick: () {
                                            setState(() {
                                              selectedDateValidate = false;
                                              selectedDate = e;
                                            });
                                          },
                                          data: e,
                                        ),
                                      )
                                      .toList()),
                            ],
                          ),
                        )
                      : Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: grey,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      color: white,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Болсон',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: black,
                                                fontFamily: "Montserrat",
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: CupertinoDatePicker(
                                              minimumDate: DateTime.now()
                                                  .subtract(
                                                      const Duration(days: 1)),
                                              initialDateTime: dateTime,
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              use24hFormat: true,
                                              showDayOfWeek: true,
                                              onDateTimeChanged:
                                                  (DateTime newDate) {
                                                setState(
                                                    () => dateTime = newDate);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                  '${dateTime.year} - ${dateTime.month} - ${dateTime.day}'),
                            ),
                          ),
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
                                  isPackage: false,
                                  businessId: customer.id!,
                                  packageListenController:
                                      productInPackageController,
                                  productListenController:
                                      productListenController,
                                ),
                              );
                            },
                            child: const Text(
                              'Мөр нэмэх',
                              style: TextStyle(
                                color: orderColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (customer.id != null) {
                                Navigator.of(context).pushNamed(
                                  ProductChoose.routeName,
                                  arguments: ProductChooseArguments(
                                    isPackage: true,
                                    businessId: customer.id!,
                                    packageListenController:
                                        productInPackageController,
                                    productListenController:
                                        productListenController,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: orderColor,
                                    shape: StadiumBorder(),
                                    content: Center(
                                      child: Text('Харилцагч сонгоно уу!'),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Row(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: product
                        .map(
                          (item) => OrderProductCard(
                            readOnly: false,
                            onClick: () {},
                            onCloseClick: () {
                              setState(() {
                                product.removeWhere(
                                    (element) => element.id == item.id);
                                data.removeWhere(
                                    (element) => element.id == item.id);
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
                    child: const Text(
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
                        OrderAddRow.routeName,
                        arguments: OrderAddRowArguments(
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
                      child: const Row(
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
                        .map(
                          (e) => Column(
                            children: [
                              OrderAdditionalLine(
                                data: e,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                            ],
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
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Захиалгад буй',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        Text(
                          '${product.length}',
                          style: const TextStyle(
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
                        const Text(
                          'Нийт тоо ширхэг',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        product.isNotEmpty
                            ? Text(
                                '${product.map((e) => e.quantity).reduce((value, element) => value! + element!).toString()}',
                                style: const TextStyle(
                                  color: orderColor,
                                ),
                              )
                            : const Text(
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
                          '${Utils().formatCurrency(totalVatAmount.toString())}₮',
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
                          '${Utils().formatCurrency(totalTaxAmount.toString())}₮',
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
                    child: const Row(
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
                        const Text(
                          'Захиалгын нийт дүн',
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        product.isNotEmpty
                            ? Text(
                                '${Utils().formatCurrency(totalAmount.toString())}₮',
                                style: const TextStyle(
                                  color: orderColor,
                                ),
                              )
                            : const Text(
                                '0₮',
                                style: TextStyle(
                                  color: orderColor,
                                ),
                              )
                      ],
                    ),
                  ),
                  FormTextField(
                    inputType: TextInputType.number,
                    name: 'shippingAmount',
                    textAlign: TextAlign.end,
                    textColor: orderColor,
                    onChanged: (p0) {
                      setState(() {
                        finalAmount = totalAmount;
                        finalAmount = finalAmount +
                            (double.tryParse(shippingAmountController.text) ??
                                0);
                      });
                    },
                    controller: shippingAmountController,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                  const FormTextField(
                    name: 'discountAmount',
                    textAlign: TextAlign.end,
                    textColor: orderColor,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                          '${finalAmount}₮',
                          style: TextStyle(
                            color: orderColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  order.paymentTerm?.configType == "CIA" ||
                          order.paymentTerm?.configType == 'CBD'
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          color: white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Row(
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
                        )
                      : SizedBox(),
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
                    color: white,
                    padding: const EdgeInsets.all(15),
                    child: const FormTextField(
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
                    child: const Text(
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
                    child: const FormTextField(
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
                    child: const Text(
                      'Хавсралт нэмэх',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AddAttachment.routeName,
                        arguments:
                            AddAttachmentArguments(pickedFile: pickedFile),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/attachment_add.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Нэмэх',
                            style: TextStyle(
                              color: orderColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: files
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(15),
                            color: white,
                            child: Text('${e}'),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 70, left: 15, right: 15, top: 15),
                    decoration: const BoxDecoration(
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
                        const Text(
                          'Нийт дүн: ',
                          style: TextStyle(color: orderColor),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (data.isNotEmpty) {
                                  // onSubmit(false, false);
                                  validateCheck(false, false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: orderColor,
                                      shape: StadiumBorder(),
                                      content: Center(
                                        child: Text('Бараа сонгоно уу!'),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: SizedBox(
                                height: 32,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/save.svg',
                                      color: orderColor,
                                    ),
                                    const Text(
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
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context)
                                //     .pushNamed(OrderSendPage.routeName);
                                if (data.isNotEmpty) {
                                  // onSubmit(true, false);
                                  validateCheck(true, false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: orderColor,
                                      shape: StadiumBorder(),
                                      content: Center(
                                        child: Text('Бараа сонгоно уу!'),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 32,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/control.svg',
                                      color: orderColor,
                                    ),
                                    const Text(
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
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (data.isNotEmpty) {
                                  // onSubmit(true, true);
                                  validateCheck(true, true);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: orderColor,
                                      shape: StadiumBorder(),
                                      content: Center(
                                        child: Text('Бараа сонгоно уу!'),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                color: transparent,
                                height: 32,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/message_sent.svg',
                                      color: orderColor,
                                    ),
                                    const Text(
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
    pickedFile.addListener(() {
      result = pickedFile.result;
      setState(() {
        files.add(result!);
      });
    });
    productInPackageController.addListener(() async {
      packageProduct = productInPackageController.productInPackage!;
      for (var element = 0; element < packageProduct.length; element++) {
        setState(() {
          product.add(packageProduct.elementAt(element));
          data.add(packageProduct.elementAt(element));
        });
      }
    });
    productListenController.addListener(() {
      productOrder = productListenController.productOrder!;
      getTotalAmount();
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

  List<String> dates = [
    "${DateTime.now().add(const Duration(days: 1))}",
    "${DateTime.now().add(const Duration(days: 2))}",
    "${DateTime.now().add(const Duration(days: 3))}",
    "${DateTime.now().add(const Duration(days: 4))}",
    "${DateTime.now().add(const Duration(days: 5))}",
    "${DateTime.now().add(const Duration(days: 6))}",
  ];

  getTotalAmount() {
    setState(() {
      product.add(productOrder);
      data.add(productOrder);
      double vat = product.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.quantity! * element.vatAmount!));
      totalVatAmount = vat;
      double tax = product.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.quantity! * element.taxAmount!));
      totalTaxAmount = tax;
      double total = product.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.quantity! * element.price!));
      totalAmount = total + tax + vat;
      finalAmount = totalAmount;
    });
  }
}
