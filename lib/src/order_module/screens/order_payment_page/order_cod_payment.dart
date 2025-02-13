import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/result.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/qpay_page.dart';
// import 'package:dehub/src/order_invoice/order_invoice.dart';
import 'package:dehub/src/order_module/screens/order_invoice/order_invoice.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCodPaymentArguments {
  List<Order> lines;
  String id;
  OrderCodPaymentArguments({
    required this.id,
    required this.lines,
  });
}

class OrderCodPayment extends StatefulWidget {
  final String id;
  final List<Order> lines;
  static const routeName = '/OrderCodPayment';
  const OrderCodPayment({
    super.key,
    required this.lines,
    required this.id,
  });

  @override
  State<OrderCodPayment> createState() => _OrderCodPaymentState();
}

class _OrderCodPaymentState extends State<OrderCodPayment>
    with AfterLayoutMixin {
  String? selectedMethod;
  String? selectedImage;
  bool isLoading = true;
  Invoice invoice = Invoice();
  Invoice account = Invoice();
  List<Order> list = [];
  Result accounts = Result(rows: []);

  @override
  afterFirstLayout(BuildContext context) async {
    invoice = await InvoiceApi().getInvoice(widget.id);
    accounts = await PaymentApi().bankAccountSelect();
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
          lastName: DateFormat("yyyy-MM-dd").format(invoice.paymentDate!)),
      Order(
          firstName: "Дансны дугаар", lastName: "${invoice.senderAcc?.number}"),
      Order(firstName: "Дансны нэр", lastName: "${invoice.senderAcc?.name}"),
      Order(
          firstName: "Банкны нэр", lastName: "${invoice.senderAcc?.bankName}"),
    ];
  }

  payment() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (selectedMethod != null) {
      Invoice data = Invoice();
      data.amount = invoice.paymentTerm?.advancePercent != null
          ? (invoice.totalAmount! * invoice.paymentTerm!.advancePercent!) / 100
          : invoice.totalAmount;
      data.invoiceId = invoice.id;
      data.invoiceRefCode = invoice.refCode;
      data.receiverBusinessId = invoice.senderBusinessId;
      data.description = invoice.refCode;
      data.creditAccountId = account.id;
      data.creditAccountBank = account.bankName;
      data.creditAccountName = account.name;
      data.creditAccountNumber = account.number;
      data.creditAccountCurrency = account.currency;
      data.debitAccountId = invoice.senderAcc?.id;
      data.debitAccountBank = invoice.senderAcc?.bankName;
      data.debitAccountName = invoice.senderAcc?.name;
      data.debitAccountNumber = invoice.senderAcc?.number;
      data.debitAccountCurrency = invoice.senderAcc?.currency;
      try {
        if (selectedMethod != "Qpay") {
          Invoice pay = Invoice();
          if (account.id != null) {
            data.method = 'B2B';
            loading.loading(true);
            pay = await PaymentApi().pay(data);
            loading.loading(false);
            if (pay.url == null) {
              showCustomDialog(context, "Төлбөр амжилттай төлөгдлөө", true,
                  onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            } else {
              showCustomDialog(context, "Данс баталгаажуулна уу", false,
                  onPressed: () {
                launchUrl(pay.url!);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            }
          } else {
            showCustomDialog(context, "Төлбөр төлөх данс сонгоно уу", false);
          }
        } else {
          await Navigator.of(context).pushNamed(
            QpayPage.routeName,
            arguments: QpayPageArguments(
              color: orderColor,
              data: data,
            ),
          );
        }
      } catch (e) {
        loading.loading(false);
      }
    } else {
      showCustomDialog(context, "Төлбөрийн хэрэгсэл сонгоно уу", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        elevation: 0,
        backgroundColor: orderColor,
        surfaceTintColor: orderColor,
        title: const Text(
          'Захиалгын төлбөр төлөх',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading == true
          ? const Center(
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
                                      child: const Text(
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
                                          child: const Text(
                                            'Төлбөр авах данс',
                                            style: TextStyle(
                                              color: grey2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                              FieldCard(
                                paddingHorizontal: 15,
                                paddingVertical: 15,
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
                    child: const Text(
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
                              if (selectedImage != null)
                                selectedImage?[0] == "i"
                                    ? Image.asset(selectedImage.toString())
                                    : SvgPicture.asset(selectedImage.toString(),
                                        colorFilter: const ColorFilter.mode(
                                            grey3, BlendMode.srcIn)),
                              SizedBox(
                                width: selectedMethod == null ? 0 : 15,
                              ),
                              selectedMethod == null
                                  ? const Text(
                                      'Төлбөрийн хэрэгсэл сонгоно уу',
                                      style: TextStyle(
                                        color: grey2,
                                      ),
                                    )
                                  : Text(
                                      '$selectedMethod',
                                      style: const TextStyle(
                                        color: grey2,
                                      ),
                                    ),
                            ],
                          ),
                          const Row(
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
                  if (selectedMethod == "Бизнес тооцооны дансаар")
                    Column(
                      children: [
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 15,
                          labelText: "Дансны дугаар",
                          secondText: account.number,
                          color: white,
                          labelTextColor: grey2,
                          onClick: () {
                            selectBankAccount();
                          },
                          arrowColor: orderColor,
                          secondTextColor: orderColor,
                        ),
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 15,
                          labelText: "Банкны нэр",
                          secondText: account.bankName,
                          color: white,
                          labelTextColor: grey2,
                          secondTextColor: orderColor,
                        ),
                        FieldCard(
                          paddingHorizontal: 15,
                          paddingVertical: 15,
                          labelText: "Дансны нэр",
                          secondText: account.name,
                          color: white,
                          labelTextColor: grey2,
                          secondTextColor: orderColor,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 70,
                  ),
                  invoice.paymentTerm?.configType == "INV_COD" ||
                          invoice.paymentTerm?.configType == "CIA" ||
                          invoice.paymentTerm?.configType == "CBD"
                      ? CustomButton(
                          onClick: payment,
                          labelColor: orderColor,
                          labelText: "Ок, Төлбөр төлье.",
                        )
                      : Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CustomButton(
                                borderColor: orderColor,
                                onClick: payment,
                                labelColor: white,
                                labelText: "Төлөх",
                                textColor: orderColor,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: CustomButton(
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    OrderInvoice.routeName,
                                    arguments: OrderInvoiceArguments(
                                      lines: widget.lines,
                                      data: invoice,
                                    ),
                                  );
                                },
                                labelColor: orderColor,
                                labelText: "Нэхэмжлэх",
                                textColor: white,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                  const SizedBox(
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
  ];

  showModal() {
    showModalBottomSheet(
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  selectedMethod == null
                      ? 'Төлбөрийн хэлбэр сонгох'
                      : 'Төлбөрийн хэлбэр солих',
                  style: const TextStyle(
                    color: grey2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                            color: transparent,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                data.image?[0] == 'a'
                                    ? SvgPicture.asset(
                                        '${data.image}',
                                        colorFilter: const ColorFilter.mode(
                                            grey3, BlendMode.srcIn),
                                      )
                                    : Image.asset('${data.image}'),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${data.name}",
                                  style: const TextStyle(color: grey3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
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
      shape: const RoundedRectangleBorder(
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
                  child: const Text(
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
                  children: accounts.rows!
                      .map(
                        (data) => GestureDetector(
                          onTap: () {
                            setState(() {
                              account = data;
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
