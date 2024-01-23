import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSendCustomer extends StatefulWidget {
  static const routeName = '/OrderSendCustomer';
  const OrderSendCustomer({super.key});

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
        color: const Color(0xffC6C6C8),
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
        surfaceTintColor: white,
        elevation: 0,
        leadingWidth: 150,
        leading: const CustomBackButton(color: orderColor),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'assets/svg/message_sent.svg',
                height: 25,
                width: 30,
                colorFilter: const ColorFilter.mode(orderColor, BlendMode.srcIn),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Хяналтад илгээх',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                '№: SO-290812',
                style: TextStyle(
                  color: buttonColor,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Container(
                color: white,
                padding: const EdgeInsets.all(15),
                child: const Row(
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
                child: const Row(
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
                child: const Row(
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
                child: const Row(
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
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Та ПИН кодоо оруулна уу',
                style: TextStyle(color: buttonColor),
              ),
              const SizedBox(
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
              const SizedBox(
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
