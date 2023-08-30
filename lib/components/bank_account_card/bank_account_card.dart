import 'package:dehub/screens/account_info_page/account_info_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';

class BankAccountCard extends StatefulWidget {
  final Function()? onClick;
  const BankAccountCard({Key? key, this.onClick}) : super(key: key);

  @override
  _BankAccountCardState createState() => _BankAccountCardState();
}

class _BankAccountCardState extends State<BankAccountCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AccountInfoPage.routeName);
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  Color(0xffFF4B9A),
                  Color(0xffAD61FF),
                  Color(0xff5CDFCB),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('images/golomt_logo.svg'),
                  SvgPicture.asset('images/star.svg'),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Дансны нэр',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '550****3154',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Үлдэгдэл',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        '1,250,800.00 ₮',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('images/income.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset('images/outgoing.svg'),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
