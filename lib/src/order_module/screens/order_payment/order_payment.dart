import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/qpay_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class OrderPayment extends StatefulWidget {
  static const routeName = '/OrderPayment';
  OrderPayment({
    super.key,
  });

  @override
  State<OrderPayment> createState() => _OrderPaymentState();
}

class _OrderPaymentState extends State<OrderPayment> with AfterLayoutMixin {
  bool value = false;
  Invoice invoice = Invoice();
  TextEditingController textController = TextEditingController();
  TextEditingController menuText = TextEditingController();
  bool isLoading = true;
  String? selectedValue;
  String? selectedMethod;
  General general = General();

  afterFirstLayout(BuildContext context) {
    setState(() {
      isLoading = false;
    });
  }

  fillAmount() {
    setState(() {
      // textController.text = "${widget.data.amountToPay}";
    });
  }

  // onSubmit() {
  //   selectedMethod == "B2B"
  //       ? Navigator.of(context).pushNamed(PaymentApprovalPage.routeName,
  //           arguments: PaymentApprovalPageArguments(
  //             method: selectedMethod.toString(),
  //             id: widget.id,
  //             refCode: widget.data.refCode,
  //             creditAccountId: selectedValue.toString(),
  //             amount: double.parse(textController.text),
  //           ))
  //       : Navigator.of(context).pushNamed(QpayPage.routeName);
  // }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).general;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: invoiceColor,
        surfaceTintColor: invoiceColor,
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              'assets/svg/close.svg',
            ),
          ),
        ),
        title: Text(
          'asdf',
          // ${widget.data.refCode} - Төлөх',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: invoiceColor,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        'ТӨЛБӨРИЙН МЭДЭЭЛЭЛ',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Нэхэмжлэх үлдэгдэл',
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '',
                                // ${Utils().formatCurrency(widget.data.amountToPay.toString())}',
                                style: TextStyle(color: invoiceColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: white,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Төлбөл зохих',
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'asdf',
                                // ${Utils().formatCurrency(widget.data.amountToPay.toString())}',
                                style: TextStyle(color: invoiceColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: Text(
                        'ТӨЛБӨР ХҮЛЭЭН АВАХ',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      color: white,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.perm_contact_cal_outlined,
                                  color: invoiceColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'asdf',
                                // ${widget.data.receiverBusiness!.profileName}',
                                style: TextStyle(color: invoiceColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: white,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Дансны дугаар',
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'bsd',
                                // ${widget.data.receiverAcc!.number}',
                                style: TextStyle(color: invoiceColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: Text(
                        'ТӨЛБӨР ТӨЛӨХ АРГА',
                        style: TextStyle(
                          color: grey3,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      color: white,
                      child: Column(
                        children: [
                          FormBuilderDropdown(
                            icon: Container(
                              decoration: BoxDecoration(
                                color: white,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: black,
                                size: 12,
                              ),
                            ),
                            name: 'paymentMethod',
                            onChanged: (value) async {
                              setState(() {
                                selectedMethod = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Төлбөрийн хэрэгсэл сонгох',
                              hintStyle:
                                  TextStyle(fontSize: 14, color: invoiceColor),
                              filled: true,
                              fillColor: white,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: general.paymentMethod!
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item.code,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          item.code == "B2B"
                                              ? SizedBox()
                                              : item.code == "QPAY"
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                        right: 10,
                                                      ),
                                                      height: 20,
                                                      width: 20,
                                                      child: Image(
                                                        image: AssetImage(
                                                          'images/qpay_logo.png',
                                                        ),
                                                      ),
                                                    )
                                                  : item.code == "SOCIAL_PAY"
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 10,
                                                          ),
                                                          height: 20,
                                                          width: 20,
                                                          child: Image(
                                                            image: AssetImage(
                                                              'images/social_pay_logo.png',
                                                            ),
                                                          ),
                                                        )
                                                      : item.code == "BANK_CARD"
                                                          ? Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          10),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/svg/bank_card.svg',
                                                                colorFilter: ColorFilter.mode(
                                                                    invoiceColor,
                                                                    BlendMode
                                                                        .srcIn),
                                                              ),
                                                            )
                                                          : SizedBox(),
                                          Text(
                                            '${item.name}',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          selectedMethod == "B2B"
                              ? FormBuilderDropdown(
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: black,
                                      size: 14,
                                    ),
                                  ),
                                  name: 'number',
                                  onChanged: (value) async {
                                    selectedValue = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Дансны дугаар сонгоно уу',
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: invoiceColor),
                                    filled: true,
                                    fillColor: white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 15),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  items: general.bankAccounts!
                                      .map(
                                        (item) => DropdownMenuItem(
                                          value: item.id,
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    // Image(
                                                    //   image: NetworkImage(
                                                    //     '${item.icon}',
                                                    //   ),
                                                    //   height: 20,
                                                    // ),
                                                    Text(
                                                      '${item.bankName}',
                                                      style: TextStyle(
                                                        color: black,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${item.number}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: invoiceColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              : selectedMethod == "QPAY"
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(QpayPage.routeName);
                                      },
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Төлөлт хийх заавар',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Заавар татах',
                                                  style: TextStyle(
                                                    color: invoiceColor,
                                                    fontSize: 14,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 12,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : selectedMethod == "SOCIAL_PAY"
                                      ? Container(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Төлөлт хийх заавар',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Заавар татах',
                                                    style: TextStyle(
                                                      color: invoiceColor,
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      : selectedMethod == "BANK_CARD"
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Төлөлт хийх заавар',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Заавар татах',
                                                        style: TextStyle(
                                                          color: invoiceColor,
                                                          fontSize: 14,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          : Container(
                                              color: white,
                                              padding: const EdgeInsets.all(15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Төлбөрийн хэрэгсэл сонгоно уу",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: invoiceColor,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Үлдэгдэл: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: grey2,
                            ),
                          ),
                          Row(
                            children: general.bankAccounts!
                                .map(
                                  (item) => Text(
                                    '${item.balance}',
                                    style:
                                        TextStyle(fontSize: 12, color: grey2),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Үлдэгдэл хүрэлцэнэ',
                          style: TextStyle(
                            color: green,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Төлөх төлбөрийн дүн',
                        style: TextStyle(
                          color: black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: FormTextField(
                        name: "amount",
                        inputType: TextInputType.number,
                        controller: textController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: invoiceColor),
                          ),
                        ),
                        validators: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Төлбөрийн дүн оруулна уу')
                        ]),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: white,
                          activeColor: invoiceColor,
                          fillColor: MaterialStateProperty.resolveWith(
                            (states) => invoiceColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          value: value,
                          onChanged: (value1) {
                            fillAmount();
                            if (value == true) {
                              textController.text = "";
                            }
                            setState(() {
                              value = value1!;
                            });
                          },
                        ),
                        Text(
                          'Төлбөл зохих дүнгээр',
                          style: TextStyle(
                            color: grey2,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButton(
                        labelColor: invoiceColor,
                        labelText: 'Төлбөр зөвшөөрөх',
                        onClick: () {
                          // onSubmit();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
