import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class FinanceRequestArguments {
  String id;
  FinanceRequestArguments({
    required this.id,
  });
}

class FinanceRequest extends StatefulWidget {
  static const routeName = '/FinanceRequest';
  final String id;
  const FinanceRequest({
    super.key,
    required this.id,
  });

  @override
  State<FinanceRequest> createState() => _FinanceRequestState();
}

class _FinanceRequestState extends State<FinanceRequest> {
  final defaultPinTheme = PinTheme(
    height: 60,
    width: 50,
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
        iconTheme: const IconThemeData(color: userColor),
        title: const Text(
          'Finance модулийн хүсэлт',
          style: TextStyle(
            color: userColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: userColor.withOpacity(.1),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Та санхүүжилтийн үйлчилгээ авах Finance системд хандаж ажиллах эрх хүсэх гэж байна. Та итгэлтэй байвал ПИН кодоо оруулж баталгаажуулна уу.',
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: const Text('Хүсэлт илгээх банк'),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey2.withOpacity(0.3)),
                color: white,
              ),
              child: Text(widget.id),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: const Text('ПИН код оруулж батагаажуулна уу'),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Pinput(
                autofocus: true,
                keyboardType: TextInputType.number,
                obscureText: true,
                onCompleted: (value) async {},
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
          ],
        ),
      ),
    );
  }
}
