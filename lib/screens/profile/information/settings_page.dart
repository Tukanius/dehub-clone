import 'package:dehub/api/auth_api.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/change_password/change_password.dart';
import 'package:dehub/screens/pin_code/new_pin.dart';
import 'package:dehub/screens/pin_code/pin_code.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User user = User();
  User dan = User();
  bool isSubmit = false;

  danVerify() async {
    try {
      setState(() {
        isSubmit = true;
      });
      dan = await AuthApi().danVerify();
      await launchUrl(dan.url!);
      setState(() {
        isSubmit = false;
      });
    } catch (e) {
      setState(() {
        isSubmit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).user;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10, top: 15),
            child: Text(
              'Нууцлал',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Нууц үг',
                  style: TextStyle(
                    color: dark,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ChangePassword.routeName);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: lightGrey,
                        ),
                        child: Text(
                          'Солих',
                          style: TextStyle(
                            color: networkColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      CupertinoIcons.lock,
                      color: networkColor,
                      size: 18,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ПИН код',
                  style: TextStyle(
                    color: dark,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (user.hasPin == true) {
                          Navigator.of(context).pushNamed(PinCode.routeName);
                        } else {
                          Navigator.of(context).pushNamed(
                            NewPin.routeName,
                            arguments: NewPinArguments(oldPin: ''),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: lightGrey,
                        ),
                        child: user.hasPin == false
                            ? Text(
                                'Үүсгэх',
                                style: TextStyle(
                                  color: networkColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                'Солих',
                                style: TextStyle(
                                  color: networkColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      CupertinoIcons.lock,
                      color: networkColor,
                      size: 18,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Иргэн баталгаажилт',
                  style: TextStyle(
                    color: dark,
                  ),
                ),
                Row(
                  children: [
                    isSubmit == false
                        ? GestureDetector(
                            onTap: () {
                              if (isSubmit == false) {
                                danVerify();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: lightGrey,
                              ),
                              child: Text(
                                'Баталгаажаагүй',
                                style: TextStyle(
                                  color: networkColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 14,
                            width: 14,
                            child: CircularProgressIndicator(
                              color: networkColor,
                              strokeWidth: 1,
                            ),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      CupertinoIcons.checkmark_alt_circle,
                      color: networkColor,
                      size: 18,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10, top: 15),
            child: Text(
              'Бусад тохиргоо',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Мэдэгдэл тохиргоо',
                  style: TextStyle(
                    color: dark,
                  ),
                ),
                Text(
                  "Тохируулах",
                  style: TextStyle(
                    color: networkColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Миний эрх',
                  style: TextStyle(
                    color: dark,
                  ),
                ),
                Text(
                  "Үзэх",
                  style: TextStyle(
                    color: networkColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Заавар авах',
                  style: TextStyle(
                    color: dark,
                  ),
                ),
                Text(
                  "Үзэх",
                  style: TextStyle(
                    color: networkColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
