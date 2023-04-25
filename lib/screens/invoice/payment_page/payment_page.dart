import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/screens/invoice/payment_page/payment_approval_page.dart';
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
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  String? selectedValue;

  afterFirstLayout(BuildContext context) {
    print(general.paymentMethod!.first.name);
  }

  fillAmount() {
    setState(() {
      textController.text = "${widget.data.amountToPay}";
    });
  }

  onChanged() {
    if (selectedValue is String) {
      setState(() {
        menuText.text = selectedValue!;
      });
    }
  }

  onSubmit() {
    Navigator.of(context).pushNamed(
      PaymentApprovalPage.routeName,
      arguments: PaymentApprovalPageArguments(
        id: widget.id,
        refCode: widget.data.refCode,
        creditAccountId: general.bankAccounts!.first.id.toString(),
        amount: double.parse(textController.text),
      ),
    );
  }

  General general = General();

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).general;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: brownButtonColor,
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
                              style: TextStyle(color: brownButtonColor),
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
                              style: TextStyle(color: brownButtonColor),
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
                                color: brownButtonColor,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${widget.data.receiverBusiness!.profileName}',
                              style: TextStyle(color: brownButtonColor),
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
                              style: TextStyle(color: brownButtonColor),
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
                            SvgPicture.asset('images/bank.svg'),
                            Text(
                              'Холбосон дансаар',
                              style: TextStyle(color: brownButtonColor),
                            ),
                          ],
                        ),
                        // DropdownButton(
                        //   items: general.bankAccounts!
                        //       .map(
                        //         (item) => DropdownMenuItem(
                        //           child: Text('${item.bankName}'),
                        //         ),
                        //       )
                        //       .toList(),
                        //   onChanged: onChanged(),
                        // )
                        // PopupMenuButton(
                        //   itemBuilder: (context) {
                        //     return general.paymentMethod!
                        //         .map(
                        //           (item) => PopupMenuItem(
                        //             child: Text('${item.name}'),
                        //           ),
                        //         )
                        //         .toList();
                        //   },
                        // ),

                        Column(
                          children: general.bankAccounts!
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item.bankName,
                                  child: SizedBox(
                                    height: 30,
                                    child: Text(
                                      '${item.id}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Бизнес тооцооны данс',
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '5432423098',
                              style: TextStyle(color: brownButtonColor),
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 25),
                    child: Text(
                      'Үлдэгдэл: 560,780.00 ₮',
                      style: TextStyle(
                        fontSize: 12,
                        color: grey2,
                      ),
                    ),
                  ),
                ],
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
              Form(
                key: fbKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: FormTextField(
                    name: "amount",
                    inputType: TextInputType.number,
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: brownButtonColor),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: white,
                    activeColor: brownButtonColor,
                    fillColor: MaterialStateProperty.resolveWith(
                      (states) => brownButtonColor,
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
              CustomButton(
                labelColor: brownButtonColor,
                labelText: 'Төлбөр зөвшөөрөх',
                onClick: () {
                  onSubmit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
