import 'package:dehub/screens/receiver_otp_verify/receiver_otp_verify.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EnterPhonePage extends StatefulWidget {
  static const routeName = '/EnterPhonePage';
  const EnterPhonePage({Key? key}) : super(key: key);

  @override
  State<EnterPhonePage> createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  final defaultPinTheme = PinTheme(
    height: 40,
    width: 30,
    decoration: BoxDecoration(
      color: white,
      border: Border.all(
        color: Color(0xffC6C6C8),
      ),
      borderRadius: BorderRadius.circular(5),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: orderColor,
        elevation: 0,
        leadingWidth: 150,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: transparent,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_back_ios_new,
                  color: white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'images/mobile.svg',
                color: orderColor,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 100,
                ),
                child: Text(
                  'Хүлээн авагчийн утасны дугаар оруулна уу',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Pinput(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  onCompleted: (value) => Navigator.of(context)
                      .pushNamed(ReceiverOtpVerify.routeName),
                  length: 8,
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  defaultPinTheme: defaultPinTheme,
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: white,
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Дээрх утсанд код ирнэ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
