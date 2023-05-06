import 'package:dehub/api/auth_api.dart';
import 'package:dehub/api/general_api.dart';
import 'package:dehub/api/invoice_api.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/invoice.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class PaymentApprovalPageArguments {
  String creditAccountId;
  String id;
  double amount;
  String? refCode;
  String? method;
  PaymentApprovalPageArguments({
    this.method,
    this.refCode,
    required this.creditAccountId,
    required this.id,
    required this.amount,
  });
}

class PaymentApprovalPage extends StatefulWidget {
  static const routeName = '/paymentapprovalpage';
  String id;
  String? method;
  String creditAccountId;
  double amount;
  String? refCode;
  PaymentApprovalPage({
    Key? key,
    required this.method,
    required this.amount,
    required this.creditAccountId,
    required this.refCode,
    required this.id,
  }) : super(key: key);

  @override
  State<PaymentApprovalPage> createState() => _PaymentApprovalPageState();
}

class _PaymentApprovalPageState extends State<PaymentApprovalPage>
    with AfterLayoutMixin {
  show(ctx) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 170),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 23),
                    margin: const EdgeInsets.only(top: 30),
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
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Таны ${widget.refCode} дугаартай нэхэмжлэхийн ${widget.amount.toString()} ₮-ийн төлөлт амжилттай хийгдлээ.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff2C3D7A),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
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

  User user = User();
  Invoice invoice = Invoice();

  afterFirstLayout(BuildContext context) async {
    var res =
        await Provider.of<GeneralProvider>(context, listen: false).general;
  }

  checkPin(value) async {
    user.pin = value;
    var res = await AuthApi().checkPin(user);

    if (res == true) {
      try {
        invoice.creditAccountId = widget.creditAccountId;
        invoice.amount = widget.amount;
        invoice.method = widget.method.toString();
        print('================METHOD===============');
        print(invoice.method.toString());
        print('================METHOD===============');
        print(invoice.toJson());
        await InvoiceApi().pay(widget.id, invoice);
        await show(context);
      } catch (e) {
        print("=================ERROR======================");
        print(e.toString());
        print("=================ERROR======================");
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
            Text(widget.id),
            Text(widget.amount.toString()),
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
