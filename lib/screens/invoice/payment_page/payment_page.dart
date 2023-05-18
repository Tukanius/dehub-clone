import 'package:dehub/models/bank_accounts.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/screens/invoice/payment_page/payment_approval_page.dart';
import 'package:dehub/screens/invoice/payment_page/qpay_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class PaymentPage extends StatefulWidget {
  static const routeName = '/paymentpage';
  Invoice data;
  String id;
  PaymentPage({
    super.key,
    required this.data,
    required this.id,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with AfterLayoutMixin {
  bool value = false;
  Invoice invoice = Invoice();
  TextEditingController textController = TextEditingController();
  TextEditingController menuText = TextEditingController();

  String? selectedValue;
  String? selectedMethod;

  afterFirstLayout(BuildContext context) {
    print(general.paymentMethod);
  }

  fillAmount() {
    setState(() {
      textController.text = "${widget.data.amountToPay}";
    });
  }

  onSubmit() {
    selectedMethod == "B2B"
        ? Navigator.of(context).pushNamed(PaymentApprovalPage.routeName,
            arguments: PaymentApprovalPageArguments(
              method: selectedMethod.toString(),
              id: widget.id,
              refCode: widget.data.refCode,
              creditAccountId: selectedValue.toString(),
              amount: double.parse(textController.text),
            ))
        : Navigator.of(context).pushNamed(QpayPage.routeName);
  }

  General general = General();

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).general;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: invoiceColor,
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              'images/close.svg',
            ),
          ),
        ),
        title: Text(
          '${widget.data.refCode} - Төлөх',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                color: white,
                child: Column(
                  children: [
                    Row(
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
                              '${widget.data.amountToPay}',
                              style: TextStyle(color: invoiceColor),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
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
                              '${widget.data.amountToPay}',
                              style: TextStyle(color: invoiceColor),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  'ТӨЛБӨР ХҮЛЭЭН АВАХ',
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
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                color: white,
                child: Column(
                  children: [
                    Row(
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
                              '${widget.data.receiverBusiness!.profileName}',
                              style: TextStyle(color: invoiceColor),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                              '${widget.data.receiverAcc!.number}',
                              style: TextStyle(color: invoiceColor),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  'ТӨЛБӨР ТӨЛӨХ АРГА',
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: FormBuilderDropdown(
                        hint: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'images/bank.svg',
                                color: invoiceColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Холбосон дансаар",
                                style: TextStyle(
                                    fontSize: 14, color: invoiceColor),
                              ),
                            ],
                          ),
                        ),
                        icon: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.arrow_drop_down,
                            color: black,
                          ),
                        ),
                        name: 'paymentMethod',
                        onChanged: (value) async {
                          setState(() {
                            selectedMethod = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: white, width: 0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: white, width: 0),
                          ),
                        ),
                        items: general.paymentMethod!
                            .map(
                              (item) => DropdownMenuItem(
                                value: item.code,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      item.code == "B2B"
                                          ? SizedBox()
                                          : item.code == "QPAY"
                                              ? Container(
                                                  margin: const EdgeInsets.only(
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
                                                          const EdgeInsets.only(
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
                                                                  right: 10),
                                                          child:
                                                              SvgPicture.asset(
                                                            'images/bank_card.svg',
                                                            color: invoiceColor,
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
                    ),
                    selectedMethod == "B2B"
                        ? SizedBox(
                            height: 50,
                            child: FormBuilderDropdown(
                              hint: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  "Данс сонгоно уу",
                                  style: TextStyle(
                                      fontSize: 14, color: invoiceColor),
                                ),
                              ),
                              icon: Container(
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  color: black,
                                ),
                              ),
                              name: 'number',
                              onChanged: (value) async {
                                selectedValue = value;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: white, width: 0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: white, width: 0),
                                ),
                              ),
                              items: general.bankAccounts!
                                  .map(
                                    (item) => DropdownMenuItem(
                                      value: item.id,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image(
                                                  image: NetworkImage(
                                                    '${item.icon}',
                                                  ),
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
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
                            ),
                          )
                        : selectedMethod == "QPAY"
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(QpayPage.routeName);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20),
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
                                              decoration:
                                                  TextDecoration.underline,
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
                                    padding: const EdgeInsets.only(left: 20),
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
                                                decoration:
                                                    TextDecoration.underline,
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
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            child: const Text(
                                              "Төлбөрийн хэрэгсэл сонгоно уу",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: invoiceColor,
                                              ),
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
                              style: TextStyle(fontSize: 12, color: grey2),
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
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: invoiceColor),
                    ),
                  ),
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
                    onSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
