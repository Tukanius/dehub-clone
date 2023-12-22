import 'package:dehub/api/business_api.dart';
import 'package:dehub/components/controller/listen.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
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

class _NewConditionPageState extends State<NewConditionPage> {
  String currentOption = "INV_NET_X";
  int? selectedRadioValue;
  int? index;
  int? indexMonth;
  int? indexDay;
  General general = General();
  BusinessStaffs business = BusinessStaffs();

  onSubmit() async {
    business.configType = currentOption;
    business.condition = 'INV_CONFIG';
    business.expireDayCount = currentOption == "INV_NET_X" ? (index) : null;
    await BusinessApi().createPaymentTerm(business);
    widget.listenController.changeVariable('invoiceConditionCreate');
    showCustomDialog(
      context,
      "Төлбөрийн нөхцөл амжилттай нэмлээ",
      true,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    selectedRadioValue = 0;
  }

  setSelectedRadioValue(int value) {
    setState(() {
      selectedRadioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).businessGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        surfaceTintColor: white,
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
              children: general.paymentTermConfigTypes!
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
                        value: general.paymentTermConfigTypes?.indexOf(e),
                        groupValue: selectedRadioValue,
                        onChanged: (value) {
                          setSelectedRadioValue(value!);
                          currentOption = e.code.toString();
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
                                          for (var i = 0; i < 31; i++)
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
                                          '${this.index}',
                                          style: TextStyle(color: networkColor),
                                        ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/edit.svg',
                                    colorFilter: ColorFilter.mode(
                                        networkColor, BlendMode.srcIn),
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
                    child: CustomButton(
                      borderColor: networkColor,
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
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
