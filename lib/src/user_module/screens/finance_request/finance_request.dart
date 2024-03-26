import 'package:dehub/api/auth_api.dart';
import 'package:dehub/api/user_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class FinanceRequestArguments {
  String bank;
  String name;
  ListenController listenController;
  FinanceRequestArguments({
    required this.bank,
    required this.name,
    required this.listenController,
  });
}

class FinanceRequest extends StatefulWidget {
  static const routeName = '/FinanceRequest';
  final String bank;
  final String name;
  final ListenController listenController;
  const FinanceRequest({
    super.key,
    required this.listenController,
    required this.name,
    required this.bank,
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

  onSubmit(String value) async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      var res = await AuthApi().checkPin(User(pin: value));
      if (res == true) {
        await UserApi().financeRoleCreate(
          User(bank: widget.bank),
        );
        widget.listenController.changeVariable(value);
        loading.loading(false);
        showCustomDialog(context, 'Амжилттай хүсэлт илгээлээ', true,
            onPressed: () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      loading.loading(false);
    }
  }

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
              child: Text(widget.name),
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
                onCompleted: (value) async {
                  onSubmit(value);
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
            ),
          ],
        ),
      ),
    );
  }
}
