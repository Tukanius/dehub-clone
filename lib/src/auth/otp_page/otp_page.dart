import 'dart:async';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/otp_page/create_password.dart';
import 'package:dehub/src/auth/otp_page/otp_phone_verify.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class OtpVerifyPageArguments {
  String phone;
  String email;
  String verifyId;
  OtpVerifyPageArguments({
    required this.phone,
    required this.email,
    required this.verifyId,
  });
}

class OtpVerifyPage extends StatefulWidget {
  final String phone;
  final String verifyId;
  final String email;
  static const routeName = '/OtpVerifyPage';
  const OtpVerifyPage({
    super.key,
    required this.phone,
    required this.email,
    required this.verifyId,
  });

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> with AfterLayoutMixin {
  int _counter = 120;
  TextEditingController controller = TextEditingController();
  bool isGetCode = false;
  bool isSubmit = false;
  late Timer _timer;
  String username = "";

  @override
  afterFirstLayout(BuildContext context) {
    _startTimer();
  }

  checkOtp(value) async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    User user = User();
    try {
      if (widget.verifyId == '') {
        user.otpCode = value;
        user.verifyId = widget.verifyId;
        loading.loading(true);
        await Provider.of<UserProvider>(context, listen: false).mailOtp(user);
        loading.loading(false);
        await Navigator.of(context).pushNamed(
          OtpPhoneVerify.routeName,
          arguments: OtpPhoneVerifyArguments(phone: widget.phone),
        );
      } else if (widget.verifyId == "CORE") {
        user.otpMethod = 'FORGOT';
        user.otpCode = value;
        loading.loading(true);
        await Provider.of<UserProvider>(context, listen: false).forgotOtp(user);
        loading.loading(false);
        await Navigator.of(context).pushNamed(
          CreatePasswordPage.routeName,
          arguments: CreatePasswordPageArguments(type: "FORGOT"),
        );
      } else {
        user.otpMethod = 'FORGOT';
        user.otpCode = value;
        loading.loading(true);
        await Provider.of<UserProvider>(context, listen: false)
            .financeForgotOtp(user, source.url);
        loading.loading(false);
        await Navigator.of(context).pushNamed(
          CreatePasswordPage.routeName,
          arguments: CreatePasswordPageArguments(type: "FORGOT"),
        );
      }
      loading.loading(false);
    } catch (e) {
      loading.loading(false);
    }
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
        style: const TextStyle(color: buttonColor, fontFamily: 'Montserrat'),
        children: <TextSpan>[
          TextSpan(
            text: '${widget.email} ',
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
          const TextSpan(
            text:
                'хаягт и-мэйл баталгаажуулах 6 оронтой код илгээсэн. Та түүнийг доор оруулна уу',
          ),
        ],
      ),
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
        leadingWidth: 150,
        leading: const CustomBackButton(color: buttonColor),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: SvgPicture.asset('assets/svg/otp-verify.svg'),
            ),
            const SizedBox(
              height: 10,
            ),
            text,
            const SizedBox(
              height: 15,
            ),
            Pinput(
              onCompleted: (value) {
                checkOtp(value);
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
            const SizedBox(
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
                    child: const Column(
                      children: [
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
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
