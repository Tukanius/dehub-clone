import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSendCustomer extends StatefulWidget {
  static const routeName = '/OrderSendCustomer';
  const OrderSendCustomer({Key? key}) : super(key: key);

  @override
  State<OrderSendCustomer> createState() => _OrderSendCustomerState();
}

class _OrderSendCustomerState extends State<OrderSendCustomer> {
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
                'images/message_sent.svg',
                height: 25,
                width: 30,
                color: orderColor,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Хяналтад илгээх',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '№: SO-290812',
                style: TextStyle(
                  color: buttonColor,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Container(
                color: white,
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Захиалга бүртгэсэн',
                      style: TextStyle(color: buttonColor),
                    ),
                    Text(
                      'Batdorj, 9999-1111',
                      style: TextStyle(color: orderColor),
                    ),
                  ],
                ),
              ),
              Container(
                color: white,
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Харилцагч',
                      style: TextStyle(color: buttonColor),
                    ),
                    Text(
                      'Болор трэйд ХХК',
                      style: TextStyle(color: orderColor),
                    ),
                  ],
                ),
              ),
              Container(
                color: white,
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Захиалгын дүн',
                      style: TextStyle(color: buttonColor),
                    ),
                    Text(
                      '8,820,000.00₮',
                      style: TextStyle(color: orderColor),
                    ),
                  ],
                ),
              ),
              Container(
                color: white,
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Хүргэх огноо',
                      style: TextStyle(color: buttonColor),
                    ),
                    Text(
                      '2022-04-20',
                      style: TextStyle(color: orderColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Та ПИН кодоо оруулна уу',
                style: TextStyle(color: buttonColor),
              ),
              SizedBox(
                height: 35,
              ),
              Pinput(
                autofocus: true,
                keyboardType: TextInputType.number,
                obscureText: true,
                // onCompleted: (value) => checkPin(value),
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
              SizedBox(
                height: 100,
              ),
              CustomButton(
                onClick: () {},
                isGradient: false,
                labelColor: orderColor,
                labelText: "Хяналтад илгээе.",
                textColor: white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
