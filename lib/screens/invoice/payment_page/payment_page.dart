import 'package:dehub/screens/invoice/payment_page/payment_approval_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentPage extends StatefulWidget {
  static const routeName = '/paymentpage';
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
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
          'INV - 23987 - төлөлт',
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
                              '417,450.00 ₮',
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
                              '417,450.00 ₮',
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
                              'Supplier Business Name',
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
                              '2923423098',
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
                            Container(
                              child: SvgPicture.asset(
                                'images/bank.svg',
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Холбосон дансаар',
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: brownButtonColor),
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
                  Navigator.of(context)
                      .pushNamed(PaymentApprovalPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
