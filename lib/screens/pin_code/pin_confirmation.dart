import 'package:dehub/api/auth_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class PinConfirmationArguments {
  String value;
  String oldPin;
  PinConfirmationArguments({
    required this.value,
    required this.oldPin,
  });
}

class PinConfirmation extends StatefulWidget {
  final String value;
  final String oldPin;
  static const routeName = '/PinConfirmation';
  const PinConfirmation({
    Key? key,
    required this.oldPin,
    required this.value,
  }) : super(key: key);

  @override
  State<PinConfirmation> createState() => _PinConfirmationState();
}

class _PinConfirmationState extends State<PinConfirmation> {
  User user = User();

  onSubmit(String value) async {
    if (user.hasPin == true && widget.value == value) {
      var res = await AuthApi().changePin(
        User(oldPin: widget.oldPin, pin: value),
      );
      if (res == true) {
        showCustomDialog(context, 'Пин код амжилттай солигдлоо', true,
            onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      }
      print('=====change=====');
    } else if (widget.value != value) {
      showCustomDialog(
        context,
        'Пин код таарахгүй байна дахин оролдоно уу',
        false,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } else {
      var res = await AuthApi().createPin(
        User(pin: value),
      );
      if (res == true) {
        showCustomDialog(context, 'Пин код амжилттай үүсгэлээ', true,
            onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      }
      print('======create=======');
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 150,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: transparent,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.arrow_back_ios_new,
                  color: buttonColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(
                    color: buttonColor,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Пин код давтан оруулна уу',
              style: TextStyle(
                color: grey2,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Pinput(
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              length: 6,
              onCompleted: (value) => onSubmit(value),
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
