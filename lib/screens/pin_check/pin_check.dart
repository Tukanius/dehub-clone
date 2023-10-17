import 'package:dehub/api/auth_api.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class PinCheckScreenArguments {
  Color color;
  String labelText;
  Function() onSubmit;
  PinCheckScreenArguments({
    required this.onSubmit,
    required this.color,
    required this.labelText,
  });
}

class PinCheckScreen extends StatefulWidget {
  final Color color;
  final String labelText;
  final Function() onSubmit;
  static const routeName = '/PinCheckScreen';
  const PinCheckScreen({
    Key? key,
    required this.onSubmit,
    required this.labelText,
    required this.color,
  }) : super(key: key);

  @override
  State<PinCheckScreen> createState() => _PinCheckScreenState();
}

class _PinCheckScreenState extends State<PinCheckScreen> {
  final defaultPinTheme = PinTheme(
    height: 60,
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
        backgroundColor: widget.color,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: transparent,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: white,
            ),
          ),
        ),
        title: Text(
          'Баталгаажуулах',
          style: TextStyle(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            SvgPicture.asset(
              'assets/svg/lock.svg',
              color: widget.color,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                '${widget.labelText}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cool,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Pinput(
              autofocus: true,
              keyboardType: TextInputType.number,
              obscureText: true,
              onCompleted: (value) async {
                var res = await AuthApi().checkPin(User(pin: value));

                if (res == true) {
                  await widget.onSubmit();
                  print(widget.onSubmit.toString());
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
          ],
        ),
      ),
    );
  }
}
