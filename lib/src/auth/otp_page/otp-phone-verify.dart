import 'dart:async';

import 'package:dehub/api/partner_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/otp_page/create_password.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class OtpPhoneVerifyArguments {
  String phone;
  OtpPhoneVerifyArguments({
    required this.phone,
  });
}

class OtpPhoneVerify extends StatefulWidget {
  final String phone;
  static const routeName = '/OtpPhoneVerify';
  const OtpPhoneVerify({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<OtpPhoneVerify> createState() => _OtpPhoneVerifyState();
}

class _OtpPhoneVerifyState extends State<OtpPhoneVerify> with AfterLayoutMixin {
  int _counter = 120;
  TextEditingController controller = TextEditingController();
  bool isGetCode = false;
  bool isSubmit = false;
  late Timer _timer;
  String username = "";
  User user = User();
  User otpVerify = User();
  bool isLoading = true;

  @override
  afterFirstLayout(BuildContext context) async {
    user = await PartnerApi().getPhoneOtp("FORGOT");
    setState(() {
      isLoading = false;
    });
    _startTimer();
  }

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
      _counter = 180;
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
      _counter = 180;
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

  onSubmit(value) async {
    otpVerify.otpMethod = "FORGOT";
    otpVerify.otpCode = value;
    await Provider.of<UserProvider>(context, listen: false).phoneOtp(otpVerify);
    await Navigator.of(context).pushNamed(CreatePasswordPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
        leadingWidth: 150,
        leading: CustomBackButton(color: buttonColor),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: buttonColor,
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: SvgPicture.asset('assets/svg/otp-phone.svg'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      '${user.message}',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Pinput(
                    onCompleted: (value) {
                      onSubmit(value);
                    },
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
                  // CustomButton(
                  //   onClick: () {
                  //     onSubmit(value)
                  //   },
                  //   labelColor: buttonColor,
                  //   labelText: 'Утас баталгаажуулах',
                  //   textColor: white,
                  // ),
                ],
              ),
            ),
    );
  }
}
