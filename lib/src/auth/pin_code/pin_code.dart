import 'package:dehub/api/auth_api.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/src/auth/pin_code/new_pin.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinCode extends StatefulWidget {
  static const routeName = "/PinCode";
  const PinCode({super.key});

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  TextEditingController controller = TextEditingController();

  onSubmit(String value) async {
    try {
      var res = await AuthApi().checkPin(
        User(pin: value),
      );
      if (res == true) {
        await Navigator.of(context).pushNamed(
          NewPin.routeName,
          arguments: NewPinArguments(oldPin: value),
        );
      }
    } catch (e) {
      setState(() {
        controller.text = "";
      });
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        surfaceTintColor: backgroundColor,
        iconTheme: const IconThemeData(color: buttonColor),
        centerTitle: true,
        title: const Text(
          'Пин код солих',
          style: TextStyle(
            color: buttonColor,
            fontSize: 18,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Хуучин пин код оруулна уу',
              style: TextStyle(
                color: grey2,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Pinput(
              autofocus: true,
              obscureText: true,
              controller: controller,
              keyboardType: TextInputType.number,
              length: 6,
              onCompleted: (value) => onSubmit(value),
              defaultPinTheme: PinTheme(
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(
                    color: const Color(0xffC6C6C8),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 50,
                width: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
