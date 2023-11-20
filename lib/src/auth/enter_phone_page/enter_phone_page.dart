import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/src/auth/receiver_otp_verify/receiver_otp_verify.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EnterPhonePageArguments {
  Order data;
  EnterPhonePageArguments({
    required this.data,
  });
}

class EnterPhonePage extends StatefulWidget {
  final Order data;
  static const routeName = '/EnterPhonePage';
  const EnterPhonePage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<EnterPhonePage> createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  Order receipt = Order();

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

  onSubmit(String phone) async {
    receipt = await OrderApi().receiptGetCode(widget.data.id!, phone);
    await Navigator.of(context).pushNamed(
      ReceiverOtpVerify.routeName,
      arguments: ReceiverOtpVerifyArguments(data: widget.data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: orderColor,
        elevation: 0,
        leadingWidth: 150,
        leading: CustomBackButton(color: white),
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
                'assets/svg/mobile.svg',
                colorFilter: ColorFilter.mode(orderColor, BlendMode.srcIn),
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
                  onCompleted: (value) => onSubmit(value),
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