import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/screens/order_payment_page/order_payment_page.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReceiverOtpVerify extends StatefulWidget {
  static const routeName = '/ReceiverOtpVerify';
  const ReceiverOtpVerify({Key? key}) : super(key: key);

  @override
  State<ReceiverOtpVerify> createState() => _ReceiverOtpVerifyState();
}

class _ReceiverOtpVerifyState extends State<ReceiverOtpVerify> {
  final defaultPinTheme = PinTheme(
    height: 50,
    width: 45,
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
        backgroundColor: white,
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
                  color: orderColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                    color: orderColor,
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
                'images/lock.svg',
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
                  'Хүлээн авагч ажилтаны утсанд ирсэн 6 оронтой кодыг оруулна уу',
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
                child: Pinput(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  onCompleted: (value) => showCustomDialog(
                    context,
                    "Таны хүргэлтийг хүлээж авснаа амжилттай баталгаажууллаа",
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(OrderPaymentPage.routeName);
                    },
                  ),
                  length: 6,
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
            ],
          ),
        ),
      ),
    );
  }
}
