import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class RequestApprovalPage extends StatefulWidget {
  static const routeName = '/RequestApprovalPage';
  const RequestApprovalPage({super.key});

  @override
  State<RequestApprovalPage> createState() => _RequestApprovalPageState();
}

class _RequestApprovalPageState extends State<RequestApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          elevation: 0,
          leadingWidth: 100,
          leading: CustomBackButton(
            color: financingColor,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 55,
            ),
            Text(
              'SCF хүсэлт батлах',
              style: TextStyle(
                color: grey2,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Та SCF хүсэлт батлах гэж байна. Та мэдээллээ сайтар шалгана уу.',
              style: TextStyle(
                color: grey2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Батлах ПИН кодоо оруулна уу.',
              style: TextStyle(color: grey2, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 30,
            ),
            Pinput(
              obscureText: true,
              keyboardType: TextInputType.number,
              length: 6,
              defaultPinTheme: PinTheme(
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(
                    color: Color(0xffC6C6C8),
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
