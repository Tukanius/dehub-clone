import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActiveTab extends StatefulWidget {
  const ActiveTab({super.key});

  @override
  State<ActiveTab> createState() => _ActiveTabState();
}

class _ActiveTabState extends State<ActiveTab> {
  DateTime? dateTime;
  DateTime? expireDate;

  @override
  void initState() {
    dateTime = DateTime.now();
    expireDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Харилцагч мэдээлэл',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Партнерийн нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'PartnerName',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Партнер код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'PartnerRef#',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бизнесийн нэр',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'BusinessName',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бизнес код',
                  style: TextStyle(color: dark),
                ),
                Text(
                  'BusRef#',
                  style: TextStyle(color: networkColor),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Төлбөрийн нөхцөл тохируулах',
              style: TextStyle(
                color: grey3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Төлбөрийн хэлбэр',
                  style: TextStyle(color: dark),
                ),
                Row(
                  children: [
                    Text(
                      'Хэлбэр сонгох',
                      style: TextStyle(color: networkColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: grey3,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Төлбөрийн нөхцөл',
                  style: TextStyle(color: dark),
                ),
                Row(
                  children: [
                    Text(
                      'Нөхцөл сонгох',
                      style: TextStyle(color: networkColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: grey3,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Болсон',
                            style: TextStyle(color: networkColor),
                          ),
                        ),
                        Expanded(
                          child: CupertinoDatePicker(
                            initialDateTime: dateTime,
                            onDateTimeChanged: (date) {
                              setState(() {
                                dateTime = date;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Эхлэх огноо',
                    style: TextStyle(color: dark),
                  ),
                  Row(
                    children: [
                      Text(
                        'Огноо, цаг|',
                        style: TextStyle(color: networkColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset('images/calendar1.svg'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      color: white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Болсон',
                              style: TextStyle(color: networkColor),
                            ),
                          ),
                          Expanded(
                            child: CupertinoDatePicker(
                              initialDateTime: dateTime,
                              onDateTimeChanged: (date) {
                                setState(() {
                                  expireDate = date;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Дуусах огноо',
                    style: TextStyle(color: dark),
                  ),
                  Row(
                    children: [
                      Text(
                        '${expireDate!.month} - ${expireDate!.day}, ${expireDate!.hour}|',
                        style: TextStyle(color: networkColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset('images/calendar1.svg'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 2.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: networkColor,
                    ),
                  ),
                  child: CustomButton(
                    onClick: () {},
                    labelText: 'буцах',
                    textColor: networkColor,
                    labelColor: backgroundColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10, left: 2.5),
                  child: CustomButton(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    labelText: 'Батлах',
                    labelColor: networkColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
