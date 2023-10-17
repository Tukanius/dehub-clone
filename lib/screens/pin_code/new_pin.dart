import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/pin_code/pin_confirmation.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class NewPinArguments {
  String oldPin;
  NewPinArguments({
    required this.oldPin,
  });
}

class NewPin extends StatefulWidget {
  final String oldPin;
  static const routeName = '/NewPin';
  const NewPin({
    Key? key,
    required this.oldPin,
  }) : super(key: key);

  @override
  State<NewPin> createState() => _NewPinState();
}

class _NewPinState extends State<NewPin> {
  User user = User();
  TextEditingController pinController = TextEditingController();

  onSubmit(String value) async {
    Navigator.of(context).pushNamed(
      PinConfirmation.routeName,
      arguments: PinConfirmationArguments(
        value: value,
        oldPin: widget.oldPin,
      ),
    );
    setState(() {
      pinController.text = '';
    });
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
            user.hasPin == true
                ? Text(
                    'Шинэ пин код оруулна уу',
                    style: TextStyle(
                      color: grey2,
                      fontSize: 16,
                    ),
                  )
                : Text(
                    'Пин код оруулна уу',
                    style: TextStyle(
                      color: grey2,
                      fontSize: 16,
                    ),
                  ),
            SizedBox(
              height: 25,
            ),
            Pinput(
              controller: pinController,
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
