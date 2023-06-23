import 'dart:async';

import 'package:dehub/screens/otp_page/otp-phone-verify.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class OtpVerifyPage extends StatefulWidget {
  static const routeName = 'OtpVerifyPage';
  const OtpVerifyPage({Key? key}) : super(key: key);

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  int _counter = 120;
  TextEditingController controller = TextEditingController();
  bool isGetCode = false;
  bool isSubmit = false;
  late Timer _timer;
  String username = "";

  String intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    String result = "$m:$s";
    return result;
  }

  void _startTimer() async {
    if (isSubmit == true) {
      setState(() {
        isGetCode = false;
      });
      _counter = 120;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    } else {
      setState(() {
        isGetCode = false;
      });
      _counter = 120;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var text = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Таны ',
        style: TextStyle(color: buttonColor),
        children: const <TextSpan>[
          TextSpan(
            text: 'burd***gd@gmail.com ',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          TextSpan(
            text:
                'хаягт и-мэйл баталгаажуулах 6 оронтой код илгээсэн. Та түүнийг доор оруулна уу',
            style: TextStyle(color: buttonColor),
          ),
        ],
      ),
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leadingWidth: 150,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_back_ios_new,
                color: buttonColor,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Буцах',
                style: TextStyle(
                  color: buttonColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: SvgPicture.asset('images/otp-verify.svg'),
            ),
            SizedBox(
              height: 10,
            ),
            text,
            SizedBox(
              height: 15,
            ),
            Pinput(
              defaultPinTheme: PinTheme(
                height: 60,
                width: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: buttonColor, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              length: 6,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 15,
            ),
            if (isGetCode == false)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Дахин код авах ',
                    style: TextStyle(fontSize: 14.0, color: buttonColor),
                  ),
                  Text(
                    '0${intToTimeLeft(_counter)} ',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.blue,
                    ),
                  ),
                  const Text(
                    'секунд',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.blue,
                    ),
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isSubmit = true;
                      });
                      _startTimer();
                    },
                    child: Column(
                      children: const [
                        Icon(
                          Icons.refresh,
                          color: buttonColor,
                        ),
                        Text(
                          "Код дахин авах",
                          style: TextStyle(color: white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Дахин илгээх',
              style: TextStyle(
                color: buttonColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              onClick: () {
                Navigator.of(context).pushNamed(OtpPhoneVerify.routeName);
              },
              labelColor: buttonColor,
              labelText: 'И-мэйл баталгаажуулах',
              textColor: white,
            ),
          ],
        ),
      ),
    );
  }
}

String? validateEmail(String value, context) {
  RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value.isEmpty) {
    return 'И-Мейлээ оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'И-Мейлээ шалгана уу';
    } else {
      return null;
    }
  }
}
