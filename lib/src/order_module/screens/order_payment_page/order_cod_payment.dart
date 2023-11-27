import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/qpay_page.dart';
// import 'package:dehub/src/order_invoice/order_invoice.dart';
import 'package:dehub/src/order_module/screens/order_cash_payment/order_cash_payment.dart';
import 'package:dehub/src/order_module/screens/order_invoice/order_invoice.dart';
import 'package:dehub/src/auth/pin_check/pin_check.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';

class OrderCodPaymentArguments {
  String id;
  OrderCodPaymentArguments({
    required this.id,
  });
}

class OrderCodPayment extends StatefulWidget {
  final String id;
  static const routeName = '/OrderCodPayment';
  const OrderCodPayment({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<OrderCodPayment> createState() => _OrderCodPaymentState();
}

class _OrderCodPaymentState extends State<OrderCodPayment>
    with AfterLayoutMixin {
  String? selectedMethod;
  String? selectedImage;
  General general = General();
  String? selectedValue;
  User user = User();
  bool isLoading = true;
  Invoice invoice = Invoice();
  List<Order> list = [];
  String bankNumber = 'Солих';
  String bankName = 'Банкны нэр';
  String accountName = 'Дансны нэр';

  @override
  afterFirstLayout(BuildContext context) async {
    invoice = await InvoiceApi().getInvoice(widget.id);
    setState(() {
      isLoading = false;
    });
    list = [
      Order(firstName: "Нэхэмжлэх №", lastName: "${invoice.refCode}"),
      Order(
          firstName: "Захиалгын дүн",
          lastName:
              "${Utils().formatCurrency(invoice.totalAmount.toString())} ₮"),
      Order(
          firstName: "Хүлээн авсан дүн",
          lastName:
              "${Utils().formatCurrency(invoice.totalAmount.toString())} ₮"),
      Order(
          firstName: "Төлсөн дүн",
          lastName:
              "${Utils().formatCurrency(invoice.paidAmount.toString())} ₮"),
      Order(
          firstName: "Нэхэмжлэлийн дүн",
          lastName:
              "${Utils().formatCurrency(invoice.totalAmount.toString())}₮"),
      Order(
          firstName: "Төлбөрийн нөхцөл",
          lastName: "${invoice.paymentTerm?.description}"),
      Order(
          firstName: "Төлөх огноо цаг",
          lastName: "${DateFormat("yyyy-MM-dd").format(invoice.paymentDate!)}"),
      Order(firstName: "Дансны дугаар", lastName: "123456789"),
      Order(firstName: "Дансны нэр", lastName: "Трэйд групп ХХК"),
      Order(firstName: "Банкны нэр", lastName: "Голомж банк"),
    ];
  }

  payment() async {
    try {
      await PaymentApi().qpay(
        Invoice(
          method: "B2B",
          amount: invoice.totalAmount,
          invoiceId: invoice.id,
          invoiceRefCode: invoice.refCode,
          receiverBusinessId: invoice.receiverBusinessId,
          description: invoice.refCode,
          creditAccountId: invoice.receiverAcc?.id,
          creditAccountBank: invoice.receiverAcc?.bankName,
          creditAccountName: invoice.receiverAcc?.name,
          creditAccountNumber: invoice.receiverAcc?.number,
          creditAccountCurrency: invoice.receiverAcc?.currency,
          debitAccountId: invoice.senderAcc?.id,
          debitAccountBank: invoice.senderAcc?.bankName,
          debitAccountName: invoice.senderAcc?.name,
          debitAccountNumber: invoice.senderAcc?.number,
          debitAccountCurrency: invoice.senderAcc?.currency,
        ),
      );
      showCustomDialog(
        context,
        "Төлбөр амжилттай төлөгдлөө",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  qpay() {
    Navigator.of(context).pushNamed(
      QpayPage.routeName,
      arguments: QpayPageArguments(
        color: orderColor,
        data: Invoice(
          method: "QPAY",
          invoiceId: invoice.id,
          invoiceRefCode: invoice.refCode,
          receiverBusinessId: invoice.receiverBusinessId,
          description: invoice.refCode,
          creditAccountId: invoice.receiverAcc?.id,
          creditAccountBank: invoice.receiverAcc?.bankName,
          creditAccountName: invoice.receiverAcc?.name,
          creditAccountNumber: invoice.receiverAcc?.number,
          creditAccountCurrency: invoice.receiverAcc?.currency,
          debitAccountId: invoice.senderAcc?.id,
          debitAccountBank: invoice.senderAcc?.bankName,
          debitAccountName: invoice.senderAcc?.name,
          debitAccountNumber: invoice.senderAcc?.number,
          debitAccountCurrency: invoice.senderAcc?.currency,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).orderGeneral;
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: transparent,
            child: Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
        ),
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
                  Column(
                    children: list
                        .map(
                          (e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              e.firstName == "Нэхэмжлэх №"
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
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
                                              horizontal: 15, vertical: 10),
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
                              selectedImage?[0] == "i"
                                  ? Image.asset(selectedImage.toString())
                                  : SvgPicture.asset(selectedImage.toString(),
                                      colorFilter: ColorFilter.mode(
                                          grey3, BlendMode.srcIn)),
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
                  selectedMethod == "Бизнес тооцооны дансаар"
                      ? Column(
                          children: [
                            FieldCard(
                              marginHorizontal: 15,
                              marginVertical: 15,
                              labelText: "Дансны дугаар",
                              secondText: "${bankNumber}",
                              color: white,
                              labelTextColor: grey2,
                              onClick: () {
                                selectBankAccount();
                              },
                              arrowColor: orderColor,
                              secondTextColor: orderColor,
                            ),
                            FieldCard(
                              marginHorizontal: 15,
                              marginVertical: 15,
                              labelText: "Банкны нэр",
                              secondText: "${bankName}",
                              color: white,
                              labelTextColor: grey2,
                              secondTextColor: orderColor,
                            ),
                            FieldCard(
                              marginHorizontal: 15,
                              marginVertical: 15,
                              labelText: "Дансны нэр",
                              secondText: "${accountName}",
                              color: white,
                              labelTextColor: grey2,
                              secondTextColor: orderColor,
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 70,
                  ),
                  invoice.paymentTerm?.configType == "INV_COD" ||
                          invoice.paymentTerm?.configType == "CIA"
                      ? CustomButton(
                          onClick: () {
                            if (selectedMethod == "QPay") {
                              qpay();
                            } else {
                              if (selectedMethod == "Бизнес тооцооны дансаар") {
                                Navigator.of(context).pushNamed(
                                    PinCheckScreen.routeName,
                                    arguments: PinCheckScreenArguments(
                                        onSubmit: payment,
                                        color: orderColor,
                                        labelText: "Захиалгын төлбөр төлөх"));
                              } else if (selectedMethod == "Бэлэн мөнгөөр") {
                                Navigator.of(context)
                                    .pushNamed(OrderCashPayment.routeName);
                              }
                            }
                          },
                          labelColor: orderColor,
                          labelText: "Ок, Төлбөр төлье.",
                        )
                      : Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CustomButton(
                                borderColor: orderColor,
                                onClick: () {
                                  if (selectedMethod == "Qpay") {
                                    qpay();
                                  } else {
                                    if (selectedMethod ==
                                        "Бизнес тооцооны дансаар") {
                                      Navigator.of(context).pushNamed(
                                        PinCheckScreen.routeName,
                                        arguments: PinCheckScreenArguments(
                                          onSubmit: payment,
                                          color: orderColor,
                                          labelText: "Захиалгын төлбөр төлөх",
                                        ),
                                      );
                                    } else if (selectedMethod ==
                                        "Бэлэн мөнгөөр") {
                                      Navigator.of(context).pushNamed(
                                          OrderCashPayment.routeName);
                                    }
                                  }
                                },
                                labelColor: white,
                                labelText: "Төлөх",
                                textColor: orderColor,
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
                        ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }

  List<Order> paymentMethodList = [
    Order(
      image: 'assets/svg/bank.svg',
      name: 'Бизнес тооцооны дансаар',
    ),
    Order(
      image: 'images/qpay_logo.png',
      name: 'Qpay',
    ),
    Order(
      image: 'images/social_pay_logo.png',
      name: 'Social Pay',
    ),
    Order(
      image: 'assets/svg/bank_card.svg',
      name: 'Картаар',
    ),
    Order(
      image: 'assets/svg/sanhuujilt.svg',
      name: 'Бэлэн мөнгөөр',
    ),
    Order(
      image: 'assets/svg/bank_account.svg',
      name: 'Дансаар',
    ),
  ];

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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: paymentMethodList
                      .map(
                        (data) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMethod = data.name;
                              selectedImage = data.image;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 25),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                data.image?[0] == 'a'
                                    ? SvgPicture.asset(
                                        '${data.image}',
                                        colorFilter: ColorFilter.mode(
                                            grey3, BlendMode.srcIn),
                                      )
                                    : Image.asset('${data.image}'),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${data.name}",
                                  style: TextStyle(color: grey3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  selectBankAccount() {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (ctx) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 15, bottom: 30),
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Данс сонгох",
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: general.bankAccounts!
                      .map(
                        (data) => GestureDetector(
                          onTap: () {
                            setState(() {
                              bankName = data.bankName!;
                              bankNumber = data.number!;
                              accountName = data.name!;
                            });
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            color: white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${data.name}/${data.bankName}/'),
                                Text('${data.number}'),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
