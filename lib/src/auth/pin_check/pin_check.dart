import 'package:dehub/api/auth_api.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class PinCheckScreenArguments {
  Color color;
  String labelText;
  Function() onSubmit;
  String? description;
  PinCheckScreenArguments({
    required this.onSubmit,
    required this.color,
    required this.labelText,
    this.description,
  });
}

class PinCheckScreen extends StatefulWidget {
  final Color color;
  final String labelText;
  final Function() onSubmit;
  final String? description;
  static const routeName = '/PinCheckScreen';
  const PinCheckScreen({
    super.key,
    this.description,
    required this.onSubmit,
    required this.labelText,
    required this.color,
  });

  @override
  State<PinCheckScreen> createState() => _PinCheckScreenState();
}

class _PinCheckScreenState extends State<PinCheckScreen> {
  bool isSubmit = false;

  final defaultPinTheme = PinTheme(
    height: 60,
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
    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            surfaceTintColor: widget.color,
            backgroundColor: widget.color,
            elevation: 0,
            iconTheme: const IconThemeData(color: white),
            title: const Text(
              'Баталгаажуулах',
              style: TextStyle(
                color: white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'assets/svg/lock.svg',
                  colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    widget.labelText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cool,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: widget.description != null ? 20 : 0,
                ),
                if (widget.description != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      '${widget.description}',
                      style: const TextStyle(
                        color: cool,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(
                  height: 50,
                ),
                Pinput(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  onCompleted: (value) async {
                    try {
                      setState(() {
                        isSubmit = true;
                      });
                      var res = await AuthApi().checkPin(User(pin: value));
                      if (res == true) {
                        await widget.onSubmit();
                      }
                      setState(() {
                        isSubmit = false;
                      });
                    } catch (e) {
                      setState(() {
                        isSubmit = false;
                      });
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
        ),
        if (isSubmit == true)
          Container(
            color: black.withOpacity(0.3),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const CupertinoActivityIndicator(
              color: black,
              radius: 16,
            ),
          ),
      ],
    );
  }
}
