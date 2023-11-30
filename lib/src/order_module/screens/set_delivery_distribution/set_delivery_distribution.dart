import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SetDeliveryDistributionArguments {
  String id;
  SetDeliveryDistributionArguments({
    required this.id,
  });
}

class SetDeliveryDistribution extends StatefulWidget {
  final String id;
  static const routeName = '/SetDeliveryDistribution';
  const SetDeliveryDistribution({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<SetDeliveryDistribution> createState() =>
      _SetDeliveryDistributionState();
}

class _SetDeliveryDistributionState extends State<SetDeliveryDistribution> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime shipmentDate = DateTime.now();
  General general = General();
  String staff = 'Сонгох';
  String? staffId;

  onSubmit() {
    showCustomDialog(
      context,
      "Амжилттай хуваариллаа",
      true,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leadingWidth: 130,
        leading: CustomBackButton(color: orderColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Харилцагчийн мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Худалдан авагч",
              secondText: 'Биг супермаркет',
              secondTextColor: orderColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Хүлээн авах салбар",
              secondText: 'Биг супермаркет',
              secondTextColor: orderColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Бүсчлэл",
              secondText: 'Биг супермаркет',
              secondTextColor: orderColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Чиглэл",
              secondText: 'Биг супермаркет',
              secondTextColor: orderColor,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Хүргэлт',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Эхлэх огноо",
              secondText: '${DateFormat('yyyy-MM-dd').format(startDate)}',
              secondTextColor: orderColor,
              onClick: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: white,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Болсон',
                              style: TextStyle(
                                fontSize: 12,
                                color: black,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                          Expanded(
                            child: CupertinoDatePicker(
                              minimumDate:
                                  startDate.subtract(Duration(hours: 1)),
                              initialDateTime: startDate,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() {
                                  startDate = newDate;
                                  if (startDate.difference(endDate).inHours >
                                      12) {
                                    setState(() {
                                      endDate = newDate;
                                    });
                                  }
                                  if (startDate
                                          .difference(shipmentDate)
                                          .inHours >
                                      12) {
                                    setState(() {
                                      shipmentDate = newDate;
                                    });
                                  }
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
              arrowColor: orderColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Хүлээлгэж өгөх",
              secondText: '${DateFormat('yyyy-MM-dd').format(endDate)}',
              secondTextColor: orderColor,
              onClick: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: white,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Болсон',
                              style: TextStyle(
                                fontSize: 12,
                                color: black,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                          Expanded(
                            child: CupertinoDatePicker(
                              minimumDate: startDate,
                              initialDateTime: startDate,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() => endDate = newDate);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              arrowColor: orderColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Ачилт хийх",
              secondText: '${DateFormat('yyyy-MM-dd').format(shipmentDate)}',
              secondTextColor: orderColor,
              onClick: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: white,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Болсон',
                              style: TextStyle(
                                fontSize: 12,
                                color: black,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                          Expanded(
                            child: CupertinoDatePicker(
                              minimumDate: startDate,
                              initialDateTime: startDate,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() => shipmentDate = newDate);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              arrowColor: orderColor,
            ),
            FieldCard(
              color: white,
              marginHorizontal: 15,
              marginVertical: 10,
              labelText: "Хүргэлт хариуцсан",
              secondText: '${staff}',
              secondTextColor: orderColor,
              onClick: () {
                show();
              },
              arrowColor: orderColor,
            ),
            SizedBox(
              height: 100,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  onSubmit();
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 150,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: orderColor),
                    borderRadius: BorderRadius.circular(5),
                    color: white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/zahialga.svg',
                        colorFilter:
                            ColorFilter.mode(orderColor, BlendMode.srcIn),
                        height: 17,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Хуваарилах',
                        style: TextStyle(color: orderColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  show() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 20),
                  child: Text(
                    'Хариуцсан ажилтан сонгох',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  children: general.staffs!
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              staff = "${e.lastName} ${e.firstName}";
                              staffId = e.id.toString();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: transparent,
                            child: Row(
                              children: [
                                e.avatar == null
                                    ? CircleAvatar(
                                        radius: 12,
                                        backgroundImage:
                                            AssetImage('images/map.jpg'),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: grey2,
                                        radius: 12,
                                        backgroundImage:
                                            NetworkImage('${e.avatar}'),
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${e.lastName} ${e.firstName}',
                                  style: TextStyle(
                                    color: black.withOpacity(0.7),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
