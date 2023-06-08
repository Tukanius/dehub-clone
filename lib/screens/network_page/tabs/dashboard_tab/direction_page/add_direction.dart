import 'package:dehub/models/general.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddDirection extends StatefulWidget {
  const AddDirection({super.key});

  @override
  State<AddDirection> createState() => _AddDirectionState();
}

class _AddDirectionState extends State<AddDirection> {
  List<String> items = ['Хуулийн этгээд', 'Иргэн'];

  bool isSwitch = false;
  String? selectedValue;

  onSubmit() async {}

  General general = General();

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).businessGeneral;
    print('==========GENERAL======');
    print(general.distributionAreas);
    print('==========GENERAL======');
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: networkColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(13),
            child: SvgPicture.asset('images/close.svg'),
          ),
        ),
        title: Text(
          'Чиглэл',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
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
                'Мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Чиглэлийн код',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Авто үүснэ',
                    style: TextStyle(
                      color: networkColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      color: white,
                      child: Text(
                        'Чиглэлийн Нэр',
                        style: TextStyle(color: dark),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: FormTextField(
                        textAlign: TextAlign.end,
                        inputType: TextInputType.text,
                        showCounter: false,
                        name: 'distributionArea',
                        maxLenght: 30,
                        decoration: InputDecoration(
                          hintText: 'Гараас оруулах',
                          hintStyle: TextStyle(
                            color: networkColor,
                          ),
                          filled: true,
                          fillColor: white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   color: white,
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Бүсийн нэр',
            //         style: TextStyle(color: dark),
            //       ),
            //       DropdownButtonHideUnderline(
            //         child: DropdownButton(
            //           icon: Container(
            //             margin: const EdgeInsets.only(left: 10),
            //             child: Icon(
            //               Icons.arrow_forward_ios,
            //               size: 14,
            //             ),
            //           ),
            //           isExpanded: false,
            //           dropdownColor: white,
            //           value: selectedValue,
            //           items: general.distributionAreas!
            //               .map((item) => DropdownMenuItem(
            //                     value: item,
            //                     child: Text(
            //                       item.toString(),
            //                       style: TextStyle(
            //                         color: networkColor,
            //                         fontSize: 14,
            //                       ),
            //                       textAlign: TextAlign.center,
            //                     ),
            //                   ))
            //               .toList(),
            //           onChanged: (value) => setState(
            //             () => this.selectedValue = value.toString(),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Бүсийн код',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Авто гарах',
                    style: TextStyle(
                      color: networkColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Тайлбар',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              color: white,
              padding: EdgeInsets.all(15),
              height: 125,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: grey3.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Бүртгэсэн огноо, цаг',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    '2023-04-08 16:24 PM',
                    style: TextStyle(
                      color: dark,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Бүртгэсэн ажилтан',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Username',
                    style: TextStyle(
                      color: networkColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Статус',
                    style: TextStyle(color: dark),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: grey2.withOpacity(0.1),
                    ),
                    child: Text(
                      'Түр төлөв',
                      style: TextStyle(
                        color: grey2,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
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
                      labelColor: backgroundColor,
                      textColor: networkColor,
                      onClick: () {},
                      labelText: "Буцах",
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 2.5, right: 10),
                    child: CustomButton(
                      labelColor: networkColor,
                      labelText: 'Хадгалах',
                      onClick: () {},
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            color: networkColor,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      );
}
