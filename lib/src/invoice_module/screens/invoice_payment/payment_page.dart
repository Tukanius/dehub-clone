import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/payment_method.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/payment_approval_page.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/qpay_page.dart';
import 'package:dehub/utils/utils.dart';
// import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class InvoicePaymentPageArguments {
  Invoice data;
  String id;
  InvoicePaymentPageArguments({
    required this.data,
    required this.id,
  });
}

class InvoicePaymentPage extends StatefulWidget {
  static const routeName = '/InvoicePaymentPage';
  final Invoice data;
  final String id;
  const InvoicePaymentPage({
    super.key,
    required this.data,
    required this.id,
  });

  @override
  State<InvoicePaymentPage> createState() => _InvoicePaymentPageState();
}

class _InvoicePaymentPageState extends State<InvoicePaymentPage>
    with AfterLayoutMixin {
  bool value = false;
  Invoice invoice = Invoice();
  TextEditingController textController = TextEditingController();
  TextEditingController menuText = TextEditingController();
  bool isLoading = true;
  String? selectedValue;
  String? selectedMethod;
  Invoice selectedBank = Invoice();
  General general = General();
  List<PaymentMethod> methods = [];
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();

  @override
  afterFirstLayout(BuildContext context) {
    methods = general.paymentMethod!
        .where((element) => element.code == "B2B" || element.code == "QPAY")
        .toList();
    setState(() {
      isLoading = false;
    });
  }

  fillAmount() {
    setState(() {
      textController.text = "${widget.data.amountToPay?.toInt()}";
    });
  }

  onSubmit() {
    if (selectedMethod == "B2B") {
      if (fbkey.currentState!.saveAndValidate()) {
        Navigator.of(context).pushNamed(
          PaymentApprovalPage.routeName,
          arguments: PaymentApprovalPageArguments(
            data: widget.data,
            amount: double.parse(textController.text),
          ),
        );
      }
    } else {
      Navigator.of(context).pushNamed(
        QpayPage.routeName,
        arguments: QpayPageArguments(
          color: invoiceColor,
          data: Invoice(
            invoiceId: widget.data.id,
            invoiceRefCode: widget.data.refCode,
            receiverBusinessId: widget.data.type == "PURCHASE"
                ? widget.data.receiverBusinessId
                : widget.data.senderBusinessId,
            description: widget.data.refCode,
            creditAccountId: widget.data.receiverAcc?.id,
            creditAccountBank: widget.data.receiverAcc?.bankName,
            creditAccountName: widget.data.receiverAcc?.name,
            creditAccountNumber: widget.data.receiverAcc?.number,
            creditAccountCurrency: widget.data.receiverAcc?.currency,
            debitAccountId: widget.data.senderAcc?.id,
            debitAccountBank: widget.data.senderAcc?.bankName,
            debitAccountName: widget.data.senderAcc?.name,
            debitAccountNumber: widget.data.senderAcc?.number,
            debitAccountCurrency: widget.data.senderAcc?.currency,
          ),
        ),
      );
    }
  }

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
          '${widget.data.refCode} - Төлөх',
          style: const TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: invoiceColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'ТӨЛБӨРИЙН МЭДЭЭЛЭЛ',
                      style: TextStyle(
                        color: grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Батлагдсан дүн',
                        ),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.data.confirmedAmount.toString())}₮',
                              style: const TextStyle(color: invoiceColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
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
                        const Text(
                          'Төлбөл зохих',
                        ),
                        Row(
                          children: [
                            Text(
                              '${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
                              style: const TextStyle(color: invoiceColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
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
                    child: const Text(
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
                            const Icon(
                              Icons.perm_contact_cal_outlined,
                              color: invoiceColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${widget.data.senderBusiness?.profileName}',
                              style: const TextStyle(color: invoiceColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
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
                        const Text(
                          'Дансны дугаар',
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.data.senderAcc?.number}',
                              style: const TextStyle(color: invoiceColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
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
                    child: const Text(
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
                            decoration: const BoxDecoration(
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
                            hintStyle: const TextStyle(
                                fontSize: 14, color: invoiceColor),
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
                          items: methods
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item.code,
                                  child: Row(
                                    children: [
                                      item.code == "B2B"
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              child: SvgPicture.asset(
                                                'assets/svg/bank_card.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        invoiceColor,
                                                        BlendMode.srcIn),
                                              ),
                                            )
                                          : Container(
                                              margin: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              height: 20,
                                              width: 20,
                                              child: const Image(
                                                image: AssetImage(
                                                  'images/qpay_logo.png',
                                                ),
                                              ),
                                            ),
                                      Text(
                                        '${item.name}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        selectedMethod == "B2B"
                            ? FormBuilderDropdown(
                                icon: Container(
                                  decoration: const BoxDecoration(
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
                                  hintStyle: const TextStyle(
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
                                        onTap: () {},
                                        value: item.id,
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
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '${item.bankName}',
                                                  style: const TextStyle(
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
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Төлөлт хийх заавар',
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
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
                                                icon: const Icon(
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
                                            const Text(
                                              'Төлөлт хийх заавар',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
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
                                                  icon: const Icon(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Төлөлт хийх заавар',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
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
                                                      icon: const Icon(
                                                        Icons.arrow_forward_ios,
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
                                            child: const Row(
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
                  const SizedBox(
                    height: 20,
                  ),
                  if (selectedMethod == "B2B")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Төлөх төлбөрийн дүн',
                            style: TextStyle(
                              color: black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: FormBuilder(
                            key: fbkey,
                            child: FormTextField(
                              name: "amount",
                              inputType: TextInputType.number,
                              controller: textController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
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
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: white,
                              activeColor: invoiceColor,
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
                            const Text(
                              'Төлбөл зохих дүнгээр',
                              style: TextStyle(
                                color: grey2,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (selectedMethod != null)
                    CustomButton(
                      labelColor: invoiceColor,
                      labelText: 'Төлбөр зөвшөөрөх',
                      onClick: () {
                        onSubmit();
                      },
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}
