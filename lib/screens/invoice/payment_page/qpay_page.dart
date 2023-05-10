import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QpayPage extends StatefulWidget {
  static const routeName = 'QpayPage';
  const QpayPage({super.key});

  @override
  State<QpayPage> createState() => _QpayPageState();
}

class _QpayPageState extends State<QpayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: Text(
          'qPay-р төлөх',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          color: white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: invoiceColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Төлөлт хийх заавар',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Та доорх QR кодыг банк апп-р уншуулах эсвэл банкаа сонгож АПП-р төлнө уу.',
                  style: TextStyle(
                    color: grey3,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SvgPicture.asset('images/qrCode.svg'),
              SizedBox(
                height: 15,
              ),
              Text(
                'Банкны апп дуудаж төлөх',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // ListView(
              //   shrinkWrap: true,
              //   scrollDirection: Axis.horizontal,
              //   children: [
              //     Container(),
              //     Container(),
              //     Container(),
              //   ],
              // ),
              CustomButton(
                onClick: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                labelColor: invoiceColor,
                labelText: 'Төлбөр шалгах',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
