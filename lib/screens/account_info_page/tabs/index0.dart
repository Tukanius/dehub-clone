import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/custom_switch/custom_switch.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:moment_dart/moment_dart.dart';

class Index0 extends StatefulWidget {
  final String id;
  const Index0({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _Index0State createState() => _Index0State();
}

class _Index0State extends State<Index0> with AfterLayoutMixin {
  bool isSwitch = false;
  Payment get = Payment();
  General general = General();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    get = await PaymentApi().bankAccountGet(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  bankName() {
    var res = general.bankNames!
        .firstWhere((element) => element.code == get.bankName)
        .name;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).paymentGeneral;
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(color: paymentColor),
          )
        : SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5,
                      left: 15,
                    ),
                    child: Text(
                      'ЕРӨНХИЙ МЭДЭЭЛЭЛ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: grey3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Дансны товч нэр',
                          style: TextStyle(color: dark),
                        ),
                        Row(
                          children: [
                            Text(
                              '${get.shortName}',
                              style: TextStyle(color: paymentColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset('assets/svg/edit.svg'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Банкны нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${bankName()}',
                          style: TextStyle(color: paymentColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Дансны нэр',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${get.name}',
                          style: TextStyle(color: paymentColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Дансны дугаар',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${get.number}',
                          style: TextStyle(color: paymentColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Container(
                  //   color: white,
                  //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Дансны валют',
                  //         style: TextStyle(color: dark),
                  //       ),
                  //       Text(
                  //         'Төгрөг',
                  //         style: TextStyle(color: paymentColor),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   color: white,
                  //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Одоогийн үлдэгдэл',
                  //         style: TextStyle(color: dark),
                  //       ),
                  //       Text(
                  //         '30,000.00 ₮',
                  //         style: TextStyle(color: paymentColor),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      'БҮРТГЭЛИЙН МЭДЭЭЛЭЛ',
                      style:
                          TextStyle(color: grey3, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бүртгэсэн ажилтан',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${get.regUser?.firstName}',
                          style: TextStyle(color: paymentColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Бүртгэсэн огноо',
                          style: TextStyle(color: dark),
                        ),
                        Text(
                          '${Moment.parse(get.createdAt.toString()).format("YYYY-MM-DD")}',
                          style: TextStyle(color: paymentColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CustomSwitch(
                        color: paymentColor,
                        isDefault: get.isDefault,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Үндсэн данс',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
