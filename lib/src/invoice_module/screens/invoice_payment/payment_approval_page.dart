import 'package:dehub/api/auth_api.dart';
import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PaymentApprovalPageArguments {
  Invoice data;
  double amount;
  PaymentApprovalPageArguments({
    required this.amount,
    required this.data,
  });
}

class PaymentApprovalPage extends StatefulWidget {
  static const routeName = '/paymentapprovalpage';
  final Invoice data;
  final double amount;
  PaymentApprovalPage({
    Key? key,
    required this.data,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentApprovalPage> createState() => _PaymentApprovalPageState();
}

class _PaymentApprovalPageState extends State<PaymentApprovalPage> {
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

  User user = User();
  Invoice invoice = Invoice();

  checkPin(value) async {
    user.pin = value;
    var res = await AuthApi().checkPin(user);

    if (res == true) {
      try {
        await PaymentApi().qpay(
          Invoice(
            method: "B2B",
            amount: widget.amount,
            invoiceId: widget.data.id,
            invoiceRefCode: widget.data.refCode,
            receiverBusinessId: widget.data.receiverBusinessId,
            description: widget.data.refCode,
            creditAccountId: widget.data.receiverAcc?.id,
            creditAccountBank: widget.data.receiverAcc?.bankName,
            creditAccountName: widget.data.receiverAcc?.name,
            creditAccountNumber: widget.data.receiverAcc?.number,
            creditAccountCurrency: widget.data.receiverAcc?.currency,
            debitAccountId: widget.data.senderAcc?.id,
            debitAccountBank: widget.data.senderAcc?.bankName,
            debitAccountName: widget.data.senderAcc?.name,
            debitAccountNumber: widget.data.senderAcc?.number,
            debitAccountCurrency: widget.data.senderAcc?.currency,
          ),
        );
        showCustomDialog(
          context,
          'Таны ${widget.data.refCode} дугаартай нэхэмжлэхийн ${widget.amount.toString()} ₮-ийн төлөлт амжилттай хийгдлээ.',
          true,
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      } catch (e) {
        debugPrint("=================ERROR======================");
        debugPrint(e.toString());
        debugPrint("=================ERROR======================");
      }
    }
  }

  General general = General();

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: true).general;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: invoiceColor,
        surfaceTintColor: invoiceColor,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: invoiceColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/send.svg',
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
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      onCompleted: (value) => checkPin(value),
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
          ],
        ),
      ),
    );
  }
}
