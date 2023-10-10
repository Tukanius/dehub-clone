import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:provider/provider.dart';

class BankAccountCard extends StatefulWidget {
  final Function()? onClick;
  final Payment? data;
  const BankAccountCard({
    Key? key,
    this.data,
    this.onClick,
  }) : super(key: key);

  @override
  _BankAccountCardState createState() => _BankAccountCardState();
}

class _BankAccountCardState extends State<BankAccountCard> {
  General general = General();

  bankName() {
    var result = general.bankNames!
        .firstWhere((e) => e.code == widget.data?.bankName)
        .name;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).paymentGeneral;
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: widget.data?.bankName == "KHAN"
                    ? [
                        Color(0xff084438),
                        Color(0xff285c49),
                        Color(0xffe18849),
                      ]
                    : widget.data?.bankName == "GOLOMT"
                        ? [
                            Color(0xffFF4B9A),
                            Color(0xffAD61FF),
                            Color(0xff5CDFCB),
                          ]
                        : widget.data?.bankName == "ARIG"
                            ? [
                                Color(0xff6c2f84),
                                Color(0xffec247c),
                                Color(0xffea282b),
                                Color(0xfffbaf42),
                                Color(0xff8bc541),
                                Color(0xff3f9e3e),
                                Color(0xff74cdf4),
                              ]
                            : [
                                Color(0xff084438),
                                Color(0xff084438),
                              ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${widget.data?.icon}',
                              scale: 1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        bankName().toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset('assets/svg/star.svg'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.data?.name}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${widget.data?.number}',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Үндсэн эсэх :',
                        style: TextStyle(fontSize: 10),
                      ),
                      widget.data?.isDefault == true
                          ? Text(
                              'Тийм',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            )
                          : Text(
                              'Үгүй',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/income.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset('assets/svg/outgoing.svg'),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
