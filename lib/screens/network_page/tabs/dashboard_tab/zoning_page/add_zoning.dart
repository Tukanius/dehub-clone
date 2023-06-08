import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddZoning extends StatefulWidget {
  const AddZoning({super.key});

  @override
  State<AddZoning> createState() => _AddZoningState();
}

class _AddZoningState extends State<AddZoning> {
  @override
  Widget build(BuildContext context) {
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
          'Бүсчлэл',
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Бүсийн код',
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
                          horizontal: 15, vertical: 10),
                      color: white,
                      child: Text(
                        'Нэр',
                        style: TextStyle(color: dark),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLength: 20,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: networkColor,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
}
