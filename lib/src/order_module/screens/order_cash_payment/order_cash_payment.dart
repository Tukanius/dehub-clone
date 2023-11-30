import 'package:dehub/components/close_button/close_button.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/src/order_module/screens/order_cash_approval/order_cash_approval.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';

class OrderCashPaymentArguments {
  Invoice data;
  OrderCashPaymentArguments({
    required this.data,
  });
}

class OrderCashPayment extends StatefulWidget {
  final Invoice data;
  static const routeName = '/OrderCashPayment';
  const OrderCashPayment({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<OrderCashPayment> createState() => _OrderCashPaymentState();
}

class _OrderCashPaymentState extends State<OrderCashPayment>
    with AfterLayoutMixin {
  bool isLoading = true;
  List<Invoice> list = [];
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController paidAmountController = TextEditingController();
  TextEditingController differenceController = TextEditingController();
  double paidAmount = 0;
  double totalAmount = 0;
  double amount = 0;

  @override
  afterFirstLayout(BuildContext context) {
    list = [
      Invoice(
        firstName: "Нэхэмжлэх №",
        lastName: "${widget.data.refCode}",
      ),
      Invoice(
        firstName: "Нэхэмжлэх дүн",
        lastName:
            "${Utils().formatCurrency(widget.data.totalAmount.toString())}₮",
      ),
      Invoice(
        firstName: "Төлсөн дүн",
        lastName:
            "${Utils().formatCurrency(widget.data.paidAmount.toString())}₮",
      ),
      Invoice(
        firstName: "Төлөх дүн",
        lastName:
            "${Utils().formatCurrency(widget.data.amountToPay.toString())}₮",
      ),
      Invoice(
        firstName: "Төлөх огноо, цаг",
        lastName:
            "${DateFormat("yyyy-MM-dd HH:mm").format(widget.data.paymentDate!)}",
      ),
    ];
    updateAmount();
    setState(() {
      isLoading = false;
    });
  }

  updateAmount() {
    setState(() {
      paidAmount = totalAmount - amount;
      // totalAmountController.text = Utils().formatCurrency("${totalAmount}");
      paidAmountController.text =
          "${Utils().formatCurrency(paidAmount.toString())}₮";
      differenceController.text =
          "${Utils().formatCurrency((widget.data.amountToPay! + widget.data.paidAmount! - paidAmount).toString())}₮";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: CustomCloseButton(),
        backgroundColor: orderColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Захиалгын төлбөр төлөх',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading == true
          ? SizedBox()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Төлбөрийн мэдээлэл',
                      style: TextStyle(
                        color: grey2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: list
                        .map(
                          (e) => FieldCard(
                            marginHorizontal: 15,
                            marginVertical: 15,
                            color: white,
                            labelText: e.firstName,
                            secondText: e.lastName,
                            labelTextColor: grey2,
                            secondTextColor: orderColor,
                          ),
                        )
                        .toList(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Төлбөрийн хэлбэр',
                      style: TextStyle(
                        color: grey2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: white,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/sanhuujilt.svg',
                          colorFilter:
                              ColorFilter.mode(orderColor, BlendMode.srcIn),
                          height: 20,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Бэлэн мөнгөөр',
                          style: TextStyle(color: orderColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Бэлэн тооцоо',
                      style: TextStyle(
                        color: grey2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    color: white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Олгосон мөнгөн дүн",
                            style: TextStyle(
                              color: dark,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: FormTextField(
                            onChanged: (value) {
                              setState(() {
                                totalAmount = double.tryParse(value) ?? 0;
                                // totalAmountController.text =
                                //     Utils().formatCurrency(value.toString());
                              });
                              updateAmount();
                            },
                            controller: totalAmountController,
                            inputType: TextInputType.number,
                            textColor: orderColor,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: TextStyle(color: orderColor),
                              hintText: "0",
                              isDense: true,
                            ),
                            name: "totalAmount",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Авсан хариулт",
                            style: TextStyle(
                              color: dark,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: FormTextField(
                            onChanged: (value) {
                              setState(() {
                                amount = double.tryParse(value) ?? 0;
                              });
                              updateAmount();
                            },
                            inputType: TextInputType.number,
                            textColor: orderColor,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: TextStyle(color: orderColor),
                              hintText: "0",
                              isDense: true,
                            ),
                            name: "amount",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Төлсөн дүн",
                            style: TextStyle(
                              color: dark,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: FormTextField(
                            readOnly: true,
                            controller: paidAmountController,
                            inputType: TextInputType.number,
                            textColor: orderColor,
                            textAlign: TextAlign.center,
                            name: "paidAmount",
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: orderColor),
                              hintText: "0",
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Зөрүү",
                            style: TextStyle(
                              color: dark,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: FormTextField(
                            onChanged: (value) {
                              updateAmount();
                            },
                            controller: differenceController,
                            inputType: TextInputType.number,
                            textColor: orderColor,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide.none,
                              ),
                              hintText: "0",
                              hintStyle: TextStyle(color: orderColor),
                              isDense: true,
                            ),
                            name: "difference",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  CustomButton(
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed(OrderCashApproval.routeName);
                    },
                    labelColor: orderColor,
                    labelText: 'Бэлэн төлбөр батлуулах',
                  ),
                ],
              ),
            ),
    );
  }
}
