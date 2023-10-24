import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
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
                    Text(
                      '*****',
                      style: TextStyle(
                        color: green,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: lightGrey,
                      ),
                      child: Text(
                        'Үүсгээгүй',
                        style: TextStyle(
                          color: networkColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
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
                  'Нууц үг',
                  style: TextStyle(
                    color: dark,
                  ),
                ),
                Row(
                  children: [
                    Container(
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
