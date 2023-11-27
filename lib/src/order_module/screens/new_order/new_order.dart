import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/order_additional_line/order_additional_line.dart';
import 'package:dehub/components/order_product_card/order_product_card.dart';
import 'package:dehub/components/possible-schedule/possible-schedule-card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/checkout-provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/order_module/screens/new_order/add_attachment/add_attachment.dart';
import 'package:dehub/src/order_module/screens/new_order/add_row/order_add_row.dart';
import 'package:dehub/src/order_module/screens/new_order/change_branch/change_branch_name.dart';
import 'package:dehub/src/order_module/screens/new_order/order_send/order_send_page.dart';
import 'package:dehub/src/order_module/screens/new_order/product_choose/product_choose.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/src/order_module/screens/new_order/customer_choose/customer_choose.dart';
import 'package:after_layout/after_layout.dart';
import 'package:dehub/models/order.dart';
import 'package:provider/provider.dart';

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
  DateTime? selectedDate;
  Order result = Order();
  // Lists
  List<Order> product = [];
  List<Order> additionalLines = [];
  List<Order> asdf = [];
  List<Order> files = [];
  // Controllers
  ListenController quantityController = ListenController();
  ListenController receiverBranchController = ListenController();
  ListenController customerListenController = ListenController();
  ListenController additionalRowsListenController = ListenController();
  ListenController pickedFile = ListenController();
  ListenController productInPackageController = ListenController();
  ScrollController scrollController = ScrollController();
  TextEditingController shippingAmountController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  // Amounts
  double discountAmount = 0;
  double shippingAmount = 0;
  double additionalRowAmount = 0;
  double finalAmount = 0;
  //
  var dateKey = GlobalKey();
  var customerKey = GlobalKey();
  var productKey = GlobalKey();
  bool isCheck = false;
  // Validates
  bool selectedDateValidate = false;
  bool customerValidate = false;

  @override
  afterFirstLayout(BuildContext context) async {
    Provider.of<CheckOutProvider>(context, listen: false).clearCart();
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
    if (isCheck == false && selectedDate == null) {
      Scrollable.ensureVisible(dateKey.currentContext!,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        selectedDateValidate = true;
      });
    }
    if (customer.id == null) {
      Scrollable.ensureVisible(customerKey.currentContext!,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        customerValidate = true;
      });
    }
    if (selectedDateValidate == false && customerValidate == false) {
      if (product.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: orderColor,
            shape: StadiumBorder(),
            content: Center(
              child: Text('Бараа нэмнэ үү!'),
            ),
          ),
        );
      } else {
        Navigator.of(context).pushNamed(
          OrderSendPage.routeName,
          arguments: OrderSendPageArguments(
            data: Order(
              image: send == true
                  ? "assets/svg/message_sent.svg"
                  : 'assets/svg/order_send.svg',
              name: send == true ? 'Илгээх' : 'Хяналтад илгээх',
              partnerName: '${customer.partner?.businessName}',
              amountToPay: finalAmount,
              deliveryDate: isCheck == false
                  ? selectedDate.toString()
                  : dateTime.toString(),
            ),
            onSubmit: () {
              onSubmit(toReview, send);
            },
          ),
        );
      }
    }
  }

  onSubmit(bool toReview, bool send) async {
    List<Order> data = [];
    for (var i = 0; i < product.length; i++) {
      data.add(
        Order(
          variantId: product[i].id,
          quantity: product[i].quantity,
        ),
      );
    }
    print(data.first.toJson());
    print(data.last.toJson());
    print(data.length);
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
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final source = Provider.of<CheckOutProvider>(context, listen: true);
    finalAmount = source.finalAmount;
    product = Provider.of<CheckOutProvider>(context, listen: true).order;
    user = Provider.of<UserProvider>(context, listen: true).orderMe;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                                '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now())}',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          OrderCustomerChoose.routeName,
                          arguments: OrderCustomerChooseArguments(
                            customerListenController: customerListenController,
                          ),
                        );
                      },
                      child: Container(
                        key: customerKey,
                        margin: const EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                          color: white,
                          border: Border.all(
                              color:
                                  customerValidate == true ? red : transparent,
                              width: customerValidate == true ? 1 : 0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                customer.logo != null
                                    ? CircleAvatar(
                                        radius: 12,
                                        backgroundImage: NetworkImage(
                                          '${customer.logo}',
                                          scale: 1,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 12,
                                        backgroundImage:
                                            AssetImage('images/avatar.png'),
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
                                    : Text(
                                        'Харилцагч сонгох',
                                        style: TextStyle(
                                          color: customerValidate == true
                                              ? red
                                              : orderColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                              ],
                            ),
                            Container(
                              color: transparent,
                              child: Row(
                                children: [
                                  Text(
                                    'Солих',
                                    style: TextStyle(
                                      color: customerValidate == true
                                          ? red
                                          : orderColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: customerValidate == true
                                        ? red
                                        : orderColor,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Бизнес код",
                      secondText: customer.refCode != null
                          ? "${customer.refCode}"
                          : "#BusRef",
                      secondTextColor: orderColor,
                      secondTextFontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text('Партнер нэр'),
                          ),
                          Expanded(
                            flex: 5,
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  customer.partnerName != null
                                      ? TextSpan(
                                          text: '${customer.partnerName},',
                                          style: TextStyle(color: buttonColor),
                                        )
                                      : TextSpan(
                                          text: 'Партнер нэр,',
                                          style: TextStyle(color: buttonColor),
                                        ),
                                  customer.partner?.refCode != null
                                      ? TextSpan(
                                          text: ' ${customer.partner?.refCode}',
                                          style: TextStyle(color: orderColor),
                                        )
                                      : TextSpan(
                                          text: ' #PartnerRef',
                                          style: TextStyle(color: orderColor),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "ТТД",
                      secondText: customer.regNumber != null
                          ? "${customer.regNumber}"
                          : "ТТД",
                      secondTextColor: buttonColor,
                      secondTextFontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 3),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Төлбөрийн нөхцөл",
                      secondText: order.paymentTerm?.description != null
                          ? "${order.paymentTerm?.description}"
                          : "Төлбөрийн нөхцөл",
                      secondTextColor: buttonColor,
                      secondTextFontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 3),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "НӨАТ төлөгч эсэх",
                      secondText: order.isVatPayer == true ? "Тийм" : "Үгүй",
                      secondTextColor: buttonColor,
                      secondTextFontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 3),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Менежер",
                      secondText: order.receiverStaff != null
                          ? "${order.receiverStaff?.firstName}"
                          : "Менежер",
                      secondTextColor: orderColor,
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
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Хүлээн авах салбар",
                      secondText: order.receiverBranches != null &&
                              order.receiverBranches!.length > 1
                          ? "Солих"
                          : '',
                      secondTextColor: orderColor,
                      onClick: order.receiverBranches != null &&
                              order.receiverBranches!.length > 1
                          ? () {
                              Navigator.of(context).pushNamed(
                                ChangeBranchNamePage.routeName,
                                arguments: ChangeBranchNamePageArguments(
                                  data: order.receiverBranches!,
                                  receiverBranchController:
                                      receiverBranchController,
                                ),
                              );
                            }
                          : null,
                      fontWeight: FontWeight.w500,
                      labelTextColor: buttonColor,
                    ),
                    const SizedBox(height: 3),
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
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Хүлээн авах ажилтан",
                      secondText: order.receiverStaff?.firstName != null
                          ? "${order.receiverStaff?.firstName}"
                          : "Хүлээн авах ажилтан",
                      secondTextColor: orderColor,
                      onClick: () {},
                      arrowColor: orderColor,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 3),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    childAspectRatio: 1 / 0.6,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 10,
                                    shrinkWrap: true,
                                    crossAxisCount: 3,
                                    children: dates
                                        .map(
                                          (e) => PossibleScheduleCard(
                                            validate: selectedDateValidate,
                                            formattedDate:
                                                DateFormat("EEEE").format(e),
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
                                                    .subtract(const Duration(
                                                        days: 1)),
                                                initialDateTime: dateTime,
                                                mode: CupertinoDatePickerMode
                                                    .date,
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
                        key: productKey,
                        margin: const EdgeInsets.only(bottom: 3),
                        color: white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (customer.id != null) {
                                  Navigator.of(context).pushNamed(
                                    ProductChoose.routeName,
                                    arguments: ProductChooseArguments(
                                      listenController: quantityController,
                                      isPackage: false,
                                      businessId: customer.id!,
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
                              child: Text(
                                'Ширхэгээр нэмэх',
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
                                      listenController: quantityController,
                                      isPackage: true,
                                      businessId: customer.id!,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: product
                          .map(
                            (item) => OrderProductCard(
                              listenController: quantityController,
                              readOnly: false,
                              isPackage: false,
                              onClick: () {
                                FocusScope.of(context).unfocus();
                              },
                              onCloseClick: () {
                                Provider.of<CheckOutProvider>(context,
                                        listen: false)
                                    .orderRemoveCart(item);
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
                                  onClick: () {
                                    int index = additionalLines.indexWhere(
                                        (element) => element.name == e.name);
                                    setState(() {
                                      additionalLines.removeAt(index);
                                    });
                                    source.additional = additionalLines;
                                    source.totalAmounts(
                                      product,
                                      double.tryParse(
                                              shippingAmountController.text) ??
                                          0,
                                      double.tryParse(
                                              discountAmountController.text) ??
                                          0,
                                    );
                                  },
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
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Захиалгад буй",
                      secondText: "${product.length}",
                      secondTextColor: orderColor,
                      arrowColor: orderColor,
                    ),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Нийт тоо ширхэг",
                      secondText: product.isNotEmpty
                          ? '${product.map((e) => e.quantity).reduce((value, element) => value! + element!).toString()}'
                          : '0',
                      secondTextColor: orderColor,
                      arrowColor: orderColor,
                    ),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Тооцсон НӨАТ",
                      secondText:
                          "${Utils().formatCurrency(source.totalVatAmount.toString())}₮",
                      secondTextColor: orderColor,
                      arrowColor: orderColor,
                    ),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Тооцсон НХАТ",
                      secondText:
                          "${Utils().formatCurrency(source.totalTaxAmount.toString())}₮",
                      secondTextColor: orderColor,
                      arrowColor: orderColor,
                    ),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Захиалгын нийт дүн",
                      secondText:
                          '${Utils().formatCurrency(source.total.toString())}₮',
                      secondTextColor: orderColor,
                      arrowColor: orderColor,
                    ),
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "Нэмэлтээр",
                      secondText:
                          '${Utils().formatCurrency(source.additionalRowAmount.toString())}₮',
                      secondTextColor: orderColor,
                      arrowColor: orderColor,
                    ),
                    FormTextField(
                      inputType: TextInputType.number,
                      name: 'shippingAmount',
                      textAlign: TextAlign.end,
                      textColor: orderColor,
                      onChanged: (value) {
                        setState(() {
                          shippingAmount = double.tryParse(value) ?? 0;
                          source.shippingAmount = double.tryParse(value) ?? 0;
                          source.totalAmounts(
                              product, shippingAmount, discountAmount);
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
                    FormTextField(
                      onChanged: (value) {
                        setState(() {
                          discountAmount = double.tryParse(value) ?? 0;
                          source.discountAmount = double.tryParse(value) ?? 0;
                          source.totalAmounts(
                              product, shippingAmount, discountAmount);
                        });
                      },
                      controller: discountAmountController,
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
                    FieldCard(
                      marginHorizontal: 15,
                      marginVertical: 10,
                      color: white,
                      labelText: "НИЙТ ТӨЛБӨР",
                      secondText:
                          '${Utils().formatCurrency(source.finalAmount.toString())}₮',
                      secondTextColor: orderColor,
                      arrowColor: orderColor,
                    ),
                    order.paymentTerm?.configType == "CIA" ||
                            order.paymentTerm?.configType == 'CBD'
                        ? Container(
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
                                order.paymentTerm?.advancePercent != null
                                    ? Text(
                                        '${Utils().formatCurrency((source.finalAmount * (order.paymentTerm!.advancePercent! ~/ 100)).toString())}₮',
                                        style: TextStyle(
                                          color: orderColor,
                                        ),
                                      )
                                    : Text(
                                        "${Utils().formatCurrency(source.finalAmount.toString())}",
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
                    files.length != 3
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: const Text(
                              'Хавсралт нэмэх',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : SizedBox(),
                    GestureDetector(
                      onTap: () {
                        if (files.length != 3)
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
                            files.length != 3
                                ? const Text(
                                    'Нэмэх',
                                    style: TextStyle(
                                      color: orderColor,
                                    ),
                                  )
                                : const Text(
                                    'Хавсрагасан файлууд',
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
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Нэр: ${e.name}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text('Тайлбар: ${e.description}'),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      int index = files.indexWhere(
                                          (element) => element.url == e.url);
                                      setState(() {
                                        files.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 10),
                                      height: 30,
                                      width: 30,
                                      child: SvgPicture.asset(
                                        'assets/svg/close.svg',
                                        colorFilter: ColorFilter.mode(
                                            grey2, BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Нийт дүн: ',
                                style: TextStyle(color: orderColor),
                              ),
                              Text(
                                '${Utils().formatCurrency(source.finalAmount.toString())}₮',
                                style: TextStyle(
                                  color: orderColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (product.length == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: orderColor,
                                        shape: StadiumBorder(),
                                        content: Center(
                                          child: Text('Харилцагч сонгоно уу!'),
                                        ),
                                      ),
                                    );
                                  } else {
                                    validateCheck(false, false);
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
                                        colorFilter: ColorFilter.mode(
                                            orderColor, BlendMode.srcIn),
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
                                  validateCheck(true, false);
                                },
                                child: Container(
                                  height: 32,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/control.svg',
                                        colorFilter: ColorFilter.mode(
                                            orderColor, BlendMode.srcIn),
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
                                  validateCheck(true, true);
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
                                        colorFilter: ColorFilter.mode(
                                            orderColor, BlendMode.srcIn),
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
      ),
    );
  }

  @override
  void initState() {
    quantityController.addListener(() {
      setState(() {
        product = product;
        Provider.of<CheckOutProvider>(context, listen: false).totalAmounts(
          product,
          double.tryParse(shippingAmountController.text) ?? 0,
          double.tryParse(discountAmountController.text) ?? 0,
        );
      });
    });
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
        customerValidate = false;
      });
    });
    pickedFile.addListener(() {
      result = pickedFile.file!;
      setState(() {
        files.add(result);
      });
    });
    additionalRowsListenController.addListener(() {
      additionalRows = additionalRowsListenController.additionalRows!;
      setState(() {
        additionalLines.add(additionalRows);
        Provider.of<CheckOutProvider>(context, listen: false).additional =
            additionalLines;
        Provider.of<CheckOutProvider>(context, listen: false).totalAmounts(
          product,
          double.tryParse(shippingAmountController.text) ?? 0,
          double.tryParse(discountAmountController.text) ?? 0,
        );
      });
    });
    receiverBranchController.addListener(() {
      setState(() {
        receiverBranch = receiverBranchController.receiverBranch!;
      });
    });
    super.initState();
  }

  List<DateTime> dates = [
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 3)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
    DateTime.now().add(const Duration(days: 6)),
  ];
}
