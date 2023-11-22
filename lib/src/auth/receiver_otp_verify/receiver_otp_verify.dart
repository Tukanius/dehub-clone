import 'package:dehub/api/order_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReceiverOtpVerifyArguments {
  Order data;
  ReceiverOtpVerifyArguments({
    required this.data,
  });
}

class ReceiverOtpVerify extends StatefulWidget {
  final Order data;
  static const routeName = '/ReceiverOtpVerify';
  const ReceiverOtpVerify({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ReceiverOtpVerify> createState() => _ReceiverOtpVerifyState();
}

class _ReceiverOtpVerifyState extends State<ReceiverOtpVerify> {
  User user = User();
  Order order = Order();

  onSubmit(Order code) async {
    order = await OrderApi().receiptConfirm('${widget.data.id}', code);
    showCustomDialog(
      context,
      "Таны хүргэлтийг хүлээж авснаа амжилттай баталгаажууллаа",
      true,
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

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
    user = Provider.of<UserProvider>(context, listen: false).orderMe;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leadingWidth: 150,
        leading: CustomBackButton(color: orderColor),
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
                'assets/svg/lock.svg',
                colorFilter: ColorFilter.mode(orderColor, BlendMode.srcIn),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 100,
                ),
                child: user.currentBusiness?.type == "SUPPLIER"
                    ? Text(
                        'Хүлээн авагч ажилтаны утсанд ирсэн 6 оронтой кодыг оруулна уу',
                        style: TextStyle(
                          color: buttonColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        'Захиалга хүлээн авснаа баталгаажуулан ПИН кодоо оруулна уу.',
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
                  onCompleted: (value) => onSubmit(Order(code: value)),
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
