import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/models/business-staffs.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewConditionPageArguments {
  ListenController listenController;
  NewConditionPageArguments({
    required this.listenController,
  });
}

class NewConditionPage extends StatefulWidget {
  final ListenController listenController;

  static const routeName = '/NewConditionPage';
  const NewConditionPage({required this.listenController, Key? key})
      : super(key: key);

  @override
  State<NewConditionPage> createState() => _NewConditionPageState();
}

List<String> options = [
  'Баталснаас хойш 10 хоногт төлөх',
  "Баталсан дариу төлөх",
  "Баталсан сарын сүүлийн өдөр төлөх",
  "Баталсны дараа Х-ны өдөр төлөх",
  "Тайлбар мэдээлэл",
];

class _NewConditionPageState extends State<NewConditionPage> {
  String currentOption = "";
  int? selectedRadioValue;
  int? index;
  int? indexMonth;
  int? indexDay;
  General general = General();
  BusinessStaffs business = BusinessStaffs();

  onSubmit() async {
    business.termRule = currentOption;
    business.orderConfirmTerm = "INV_NET2";
    business.expireDayCount = 10;
    business.month = 2;
    business.paymentDay = (index! + 1);
    print(index);
    await BusinessApi().createPaymentTerm(business);
    widget.listenController.changeVariable('invoiceConditionCreate');
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    selectedRadioValue = 1;
  }

  setSelectedRadioValue(int value) {
    setState(() {
      selectedRadioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    general = Provider.of<GeneralProvider>(context, listen: false).general;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        iconTheme: IconThemeData(color: networkColor),
        title: Text(
          'Нэхэмжлэх - шинэ нөхцөл',
          style: TextStyle(
            color: networkColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Нөхцөлийг сонгоно уу',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              children: general.paymentTermRules!
                  .map(
                    (e) => Container(
                      color: white,
                      child: RadioListTile(
                        title: Text(
                          '${e.text}',
                          style: TextStyle(color: dark, fontSize: 14),
                        ),
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => networkColor),
                        value: general.paymentTermRules?.indexOf(e),
                        groupValue: selectedRadioValue,
                        onChanged: (value) {
                          setSelectedRadioValue(value!);
                          currentOption = e.code.toString();
                          print(currentOption);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
            currentOption == "INV_NET_X"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          'Нэмэлт тохиргоо',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Container(
                                color: white,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
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
                                      child: CupertinoPicker(
                                        itemExtent: 30,
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            this.index = index;
                                          });
                                        },
                                        children: [
                                          for (var i = 1; i < 31; i++)
                                            Center(
                                              child: Text('${i}'),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          color: white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Хоногийн тоо',
                                style: TextStyle(color: dark),
                              ),
                              Row(
                                children: [
                                  this.index == null
                                      ? Text(
                                          '0',
                                          style: TextStyle(color: networkColor),
                                        )
                                      : Text(
                                          '${this.index! + 1}',
                                          style: TextStyle(color: networkColor),
                                        ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    'images/edit.svg',
                                    color: networkColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : currentOption == "INV_SOM"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              'Нэмэлт тохиргоо',
                              style: TextStyle(
                                color: grey3,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: white,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Болсон',
                                            style:
                                                TextStyle(color: networkColor),
                                          ),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                            itemExtent: 30,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                this.indexMonth = index;
                                                print(indexMonth);
                                              });
                                            },
                                            children: [
                                              for (var i = 1; i < 13; i++)
                                                Center(
                                                  child: Text('${i}'),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              color: white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Сар',
                                    style: TextStyle(color: dark),
                                  ),
                                  Row(
                                    children: [
                                      this.indexMonth == null
                                          ? Text(
                                              '0',
                                              style: TextStyle(
                                                  color: networkColor),
                                            )
                                          : Text(
                                              '${this.indexMonth! + 1}',
                                              style: TextStyle(
                                                  color: networkColor),
                                            ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset(
                                        'images/edit.svg',
                                        color: networkColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: white,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Болсон',
                                            style:
                                                TextStyle(color: networkColor),
                                          ),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                            itemExtent: 30,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                this.indexDay = index;
                                                print(indexDay);
                                              });
                                            },
                                            children: [
                                              for (var i = 1; i < 31; i++)
                                                Center(
                                                  child: Text('${i}'),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              color: white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Хоногийн тоо',
                                    style: TextStyle(color: dark),
                                  ),
                                  Row(
                                    children: [
                                      this.indexDay == null
                                          ? Text(
                                              '0',
                                              style: TextStyle(
                                                  color: networkColor),
                                            )
                                          : Text(
                                              '${this.indexDay! + 1}',
                                              style: TextStyle(
                                                  color: networkColor),
                                            ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset(
                                        'images/edit.svg',
                                        color: networkColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: networkColor),
                    ),
                    child: CustomButton(
                      labelText: 'Буцах',
                      labelColor: backgroundColor,
                      textColor: networkColor,
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 2.5, right: 10),
                    child: CustomButton(
                      labelColor: networkColor,
                      labelText: 'Хадгалах',
                      onClick: () {
                        onSubmit();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
