import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/order_invoice/order_invoice.dart';
import 'package:dehub/screens/order_cash_payment/order_cash_payment.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderPaymentPage extends StatefulWidget {
  static const routeName = '/OrderPaymentPage';
  const OrderPaymentPage({Key? key}) : super(key: key);

  @override
  State<OrderPaymentPage> createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage> {
  String? selectedMethod;
  General general = General();
  String? selectedValue;
  User user = User();

  List<Order> list = [
    Order(firstName: "Нэхэмжлэх №", lastName: "INV_243242"),
    Order(firstName: "Захиалгын дүн", lastName: "161,000 ₮"),
    Order(firstName: "Хүлээн авсан дүн", lastName: "141,000 ₮"),
    Order(firstName: "Төлсөн дүн", lastName: "0 ₮"),
    Order(firstName: "Нэхэмжлэлийн дүн", lastName: "141,000₮"),
    Order(firstName: "Төлбөрийн нөхцөл", lastName: "INV 20 хоног"),
    Order(firstName: "Төлөх огноо цаг", lastName: "2023-03-19 15:00"),
    Order(firstName: "Дансны дугаар", lastName: "123456789"),
    Order(firstName: "Дансны нэр", lastName: "Трэйд групп ХХК"),
    Order(firstName: "Банкны нэр", lastName: "Голомж банк"),
  ];

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).orderGeneral;
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: orderColor,
        title: Text(
          'Захиалгын төлбөр төлөх',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: list
                  .map(
                    (e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        e.firstName == "Нэхэмжлэх №"
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Төлбөрийн мэдээлэл',
                                  style: TextStyle(
                                    color: grey2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : e.firstName == "Дансны дугаар"
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      'Төлбөр авах данс',
                                      style: TextStyle(
                                        color: grey2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                        FieldCard(
                          marginHorizontal: 15,
                          marginVertical: 15,
                          labelText: e.firstName,
                          secondText: e.lastName,
                          color: white,
                          labelTextColor: grey2,
                          secondTextColor: orderColor,
                          hasThirdText: false,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Text(
                'Төлбөрийн хэлбэр',
                style: TextStyle(
                  color: grey2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModal();
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                color: white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        selectedMethod == "Дансаар"
                            ? SvgPicture.asset(
                                'images/bank_account.svg',
                              )
                            : selectedMethod == 'QPay'
                                ? Image(
                                    image: AssetImage('images/qpay_logo.png'),
                                  )
                                : selectedMethod == "Social Pay"
                                    ? Image(
                                        image: AssetImage(
                                            'images/social_pay_logo.png'),
                                      )
                                    : selectedMethod == "Картаар"
                                        ? SvgPicture.asset(
                                            'images/bank_card.svg',
                                            color: grey3,
                                          )
                                        : selectedMethod == "Бэлэн мөнгөөр"
                                            ? SvgPicture.asset(
                                                'images/sanhuujilt.svg',
                                                height: 20,
                                                color: grey3,
                                              )
                                            : selectedMethod ==
                                                    "Бизнес тооцооны дансаар"
                                                ? SvgPicture.asset(
                                                    'images/bank.svg',
                                                    color: grey3,
                                                  )
                                                : SizedBox(),
                        SizedBox(
                          width: selectedMethod == null ? 0 : 15,
                        ),
                        selectedMethod == null
                            ? Text(
                                'Төлбөрийн хэрэгсэл сонгоно уу',
                                style: TextStyle(
                                  color: grey2,
                                ),
                              )
                            : Text(
                                '${selectedMethod}',
                                style: TextStyle(
                                  color: grey2,
                                ),
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Солих',
                          style: TextStyle(color: orderColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: orderColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 15,
              labelText: "Дансны дугаар",
              secondText: "Солих",
              color: white,
              labelTextColor: grey2,
              secondTextColor: orderColor,
              hasThirdText: false,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 15,
              labelText: "Банкны нэр",
              secondText: "Голомт банк",
              color: white,
              labelTextColor: grey2,
              secondTextColor: orderColor,
              hasThirdText: false,
            ),
            FieldCard(
              marginHorizontal: 15,
              marginVertical: 15,
              labelText: "Дансны нэр",
              secondText: "Трэйд групп ХХК",
              color: white,
              labelTextColor: grey2,
              secondTextColor: orderColor,
              hasThirdText: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Үлдэгдэл: 560,780 ₮',
                    style: TextStyle(
                      color: grey2,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Үлдэгдэл хүрэлцэнэ',
                    style: TextStyle(
                      color: green,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            user.currentBusiness?.type != "SUPPLIER"
                ? Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: orderColor),
                          ),
                          child: CustomButton(
                            onClick: () {},
                            labelColor: white,
                            labelText: "Төлөх",
                            textColor: orderColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomButton(
                          onClick: () {
                            Navigator.of(context)
                                .pushNamed(OrderInvoice.routeName);
                          },
                          labelColor: orderColor,
                          labelText: "Нэхэмжлэх",
                          textColor: white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  )
                : CustomButton(
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(OrderCashPayment.routeName);
                    },
                    labelColor: orderColor,
                    labelText: "Ок. Төлбөр төлье.",
                  ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  showModal() {
    showModalBottomSheet(
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                selectedMethod == null
                    ? Text(
                        'Төлбөрийн хэлбэр сонгох',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        'Төлбөрийн хэлбэр солих',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMethod = "Бизнес тооцооны дансаар";
                    });
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'images/bank.svg',
                        color: grey3,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Бизнес тооцооны дансаар",
                        style: TextStyle(color: grey3),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMethod = "QPay";
                    });
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Image(
                        image: AssetImage('images/qpay_logo.png'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "QPay",
                        style: TextStyle(color: grey3),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMethod = "Social Pay";
                    });
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Image(
                        image: AssetImage('images/social_pay_logo.png'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Social Pay",
                        style: TextStyle(color: grey3),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMethod = "Картаар";
                    });
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'images/bank_card.svg',
                        color: grey3,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Картаар",
                        style: TextStyle(color: grey3),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMethod = "Бэлэн мөнгөөр";
                    });
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'images/sanhuujilt.svg',
                        color: grey3,
                        height: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Бэлэн мөнгөөр",
                        style: TextStyle(color: grey3),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMethod = 'Дансаар';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'images/bank_account.svg',
                        color: grey3,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Дансаар",
                        style: TextStyle(color: grey3),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
