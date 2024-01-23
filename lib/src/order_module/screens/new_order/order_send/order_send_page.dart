import 'package:dehub/api/auth_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/models/order.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/utils/utils.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderSendPageArguments {
  Order data;
  Function() onSubmit;
  OrderSendPageArguments({
    required this.data,
    required this.onSubmit,
  });
}

class OrderSendPage extends StatefulWidget {
  final Order data;
  final Function() onSubmit;
  static const routeName = '/OrderSendPage';
  const OrderSendPage({
    super.key,
    required this.data,
    required this.onSubmit,
  });

  @override
  State<OrderSendPage> createState() => _OrderSendPageState();
}

class _OrderSendPageState extends State<OrderSendPage> {
  User user = User();
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
    user = Provider.of<UserProvider>(context, listen: true).orderMe;

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
                '${widget.data.image}',
                colorFilter: const ColorFilter.mode(orderColor, BlendMode.srcIn),
                height: 40,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${widget.data.name}',
                style: const TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Container(
                color: white,
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Захиалга бүртгэсэн',
                      style: TextStyle(color: buttonColor),
                    ),
                    Text(
                      '${user.lastName?[0]}.${user.firstName}',
                      style: const TextStyle(color: orderColor),
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
                    const Text(
                      'Харилцагч',
                      style: TextStyle(color: buttonColor),
                    ),
                    Text(
                      '${widget.data.partnerName}',
                      style: const TextStyle(color: orderColor),
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
                    const Text(
                      'Захиалгын дүн',
                      style: TextStyle(color: buttonColor),
                    ),
                    Text(
                      '${Utils().formatCurrency(widget.data.amountToPay.toString())}₮',
                      style: const TextStyle(color: orderColor),
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
                    const Text(
                      'Хүргэх огноо',
                      style: TextStyle(color: buttonColor),
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.data.deliveryDate.toString())),
                      style: const TextStyle(color: orderColor),
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
                onCompleted: (value) async {
                  try {
                    var res = await AuthApi().checkPin(User(pin: value));
                    if (res == true) {
                      widget.onSubmit();
                    }
                  } catch (e) {
                    debugPrint('orderSendError==========>');
                    debugPrint(e.toString());
                    debugPrint('orderSendError==========>');
                  }
                },
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
            ],
          ),
        ),
      ),
    );
  }
}
