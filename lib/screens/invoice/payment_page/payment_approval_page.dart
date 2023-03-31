import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentApprovalPage extends StatefulWidget {
  static const routeName = '/paymentapprovalpage';
  const PaymentApprovalPage({Key? key}) : super(key: key);

  @override
  State<PaymentApprovalPage> createState() => _PaymentApprovalPageState();

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
    );
  }
}

class _PaymentApprovalPageState extends State<PaymentApprovalPage> {
  show(ctx) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: brownButtonColor,
                    width: 3,
                  ),
                ),
                child: SvgPicture.asset(
                  'images/check.svg',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Амжилттай',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: black,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Таны INV-23987 дугаартай нэхэмжлэхийн 200,000.00 ₮-ийн төлөлт амжилттай хийгдлээ.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff2C3D7A),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomButton(
                  onClick: () {
                    Navigator.of(context).pop();
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                  },
                  labelColor: brownButtonColor,
                  labelText: 'Ойлголоо',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final formKey = GlobalKey<FormState>();
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
        backgroundColor: brownButtonColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: brownButtonColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: SvgPicture.asset(
                  'images/send.svg',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Нэхэмжлэх төлөх',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xff2C3D7A),
            ),
          ),
          Text(
            'Лавлах код: 32165421',
            style: TextStyle(
              color: Color(0xff00000000).withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Text(
            'Төлөлт батлах ПИН кодоо оруулна уу.',
            style: TextStyle(
              color: Color(0xff657786),
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    length: 6,
                    validator: (value) {
                      return value == '222222'
                          ? show(context)
                          : "Пин коп буруу байна";
                    },
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
