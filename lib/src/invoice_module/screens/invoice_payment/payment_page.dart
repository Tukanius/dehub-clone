import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/bank_accounts.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/payment_method.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/src/invoice_module/screens/invoice_payment/qpay_page.dart';
import 'package:dehub/utils/currency_formatter.dart';
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
import 'package:url_launcher/url_launcher.dart';

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
  BankAccounts account = BankAccounts(id: '');
  String? selectedMethod;
  String? selectedMethodCode;
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
      textController.text =
          Utils().formatCurrency("${widget.data.amountToPay}");
    });
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (selectedMethodCode == "B2B") {
      if (fbkey.currentState!.saveAndValidate()) {
        if (account.number != null) {
          try {
            Invoice res = Invoice();
            loading.loading(true);
            res = await PaymentApi().pay(
              Invoice(
                method: "B2B",
                invoiceId: widget.data.id,
                invoiceRefCode: widget.data.refCode,
                receiverBusinessId: widget.data.type == "PURCHASE"
                    ? widget.data.receiverBusinessId
                    : widget.data.senderBusinessId,
                description: widget.data.refCode,
                creditAccountId: account.id,
                creditAccountBank: account.bankName,
                creditAccountName: account.name,
                creditAccountNumber: account.number,
                creditAccountCurrency: account.currency,
                debitAccountId: widget.data.senderAcc?.id,
                debitAccountBank: widget.data.senderAcc?.bankName,
                debitAccountName: widget.data.senderAcc?.name,
                debitAccountNumber: widget.data.senderAcc?.number,
                debitAccountCurrency: widget.data.senderAcc?.currency,
                amount: double.parse(
                  Utils().parseCurrency(textController.text),
                ),
              ),
            );
            loading.loading(false);
            if (res.url != null) {
              showCustomDialog(context, "Данс баталгаажуулна уу", false,
                  onPressed: () {
                launchUrl(res.url!);
              });
            }
          } catch (e) {
            loading.loading(false);
          }
        } else {
          showCustomDialog(context, "Данс сонгоно уу", false);
        }
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
    general =
        Provider.of<GeneralProvider>(context, listen: true).invoiceGeneral;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                    GestureDetector(
                      onTap: () {
                        paymentTermSelect();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        color: white,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                selectedMethod ??
                                    'Төлбөрийн хэрэглсэл сонгон уу',
                                style: const TextStyle(color: invoiceColor),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: black,
                              size: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                    if (selectedMethodCode == "B2B")
                      GestureDetector(
                        onTap: () {
                          selectBankAccount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          color: white,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  account.number != null
                                      ? '${account.number} / ${account.bankName}'
                                      : 'Данс сонгоно уу',
                                  style: const TextStyle(color: invoiceColor),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: black,
                                size: 12,
                              )
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (selectedMethodCode == "B2B")
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
                                name: "amount1",
                                inputFormatters: [CurrencyInputFormatter()],
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
      ),
    );
  }

  paymentTermSelect() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
              children: methods
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMethod = e.name;
                          selectedMethodCode = e.code;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: transparent,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text("${e.name}"),
                      ),
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }

  selectBankAccount() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
              children: general.bankAccounts!
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          account = e;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: transparent,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundImage: NetworkImage('${e.icon}'),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${e.number} / ${e.bankName}"),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }
}
