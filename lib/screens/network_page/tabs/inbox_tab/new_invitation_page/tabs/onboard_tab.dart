import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class OnboardTab extends StatefulWidget {
  const OnboardTab({super.key});

  @override
  State<OnboardTab> createState() => _OnboardTabState();
}

class _OnboardTabState extends State<OnboardTab> {
  List<String> items = ['Хуулийн этгээд', 'Иргэн'];

  bool isSwitch = false;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Үндсэн мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Төрөл',
                    style: TextStyle(color: dark),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                      isExpanded: false,
                      dropdownColor: white,
                      value: selectedValue,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(
                        () => this.selectedValue = value,
                      ),
                    ),
                  ),
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
                          horizontal: 15, vertical: 15),
                      color: white,
                      child: Text(
                        'ТТД',
                        style: TextStyle(color: dark),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLength: 4,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                        color: networkColor,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '32',
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
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Улсын бүртгэл гэрчилгээ',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'State_Certificate',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'А.а.нэгжийн хэлбэр',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Аж ахуй нэгжийн хэлбэр',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'А.а.нэгжийн хэлбэр/Латин/',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Латин нэр',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'А.а.нэгжийн хэлбэр',
                    style: TextStyle(color: dark),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                      isExpanded: false,
                      dropdownColor: white,
                      value: selectedValue,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(
                        () => this.selectedValue = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Улсын харъяалал',
                    style: TextStyle(color: dark),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                      isExpanded: false,
                      dropdownColor: white,
                      value: selectedValue,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(
                        () => this.selectedValue = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Өмчийн хэлбэр',
                    style: TextStyle(color: dark),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                      isExpanded: false,
                      dropdownColor: white,
                      value: selectedValue,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(
                        () => this.selectedValue = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Буцаан дуудах эсэх',
                    style: TextStyle(color: dark),
                  ),
                  Transform.scale(
                    scale: 0.9,
                    child: CupertinoSwitch(
                      activeColor: networkColor,
                      value: isSwitch,
                      onChanged: (value) => setState(
                        () {
                          isSwitch = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Хаягийн мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Аймаг, нийслэл',
                    style: TextStyle(color: dark),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                      isExpanded: false,
                      dropdownColor: white,
                      value: selectedValue,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(
                        () => this.selectedValue = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Дүүрэг, сум',
                    style: TextStyle(color: dark),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                      isExpanded: false,
                      dropdownColor: white,
                      value: selectedValue,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(
                        () => this.selectedValue = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Хороо',
                    style: TextStyle(color: dark),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                      isExpanded: false,
                      dropdownColor: white,
                      value: selectedValue,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(
                        () => this.selectedValue = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Баг, хороолол',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Цолмон хороолол',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Байр, байшин',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Цолмон хороолол',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Хаалга, тоот',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Цолмон хороолол',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Байршлын мэдээлэл',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Image(
                image: AssetImage('images/map.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Уртраг',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    '90.23',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Өргөрөг',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    '45.52',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Урилга авах хүн',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Урилга авах хүний нэр',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Нэр оруулах',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Утасны дугаар №1',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'Утасны дугаар',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'И-мэйл хаяг №1',
                    style: TextStyle(color: dark),
                  ),
                  Text(
                    'И-Мэйл',
                    style: TextStyle(color: networkColor),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Урилгын тайлбар',
                style: TextStyle(
                  color: grey3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              height: 130,
              color: white,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: grey3, width: 0.5),
                ),
              ),
            ),
            SizedBox(
              height: 30,
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
                      onClick: () {},
                      labelColor: backgroundColor,
                      labelText: 'Буцах',
                      textColor: networkColor,
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
                      labelColor: networkColor,
                      labelText: 'Илгээх',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
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
        ),
      );
}
