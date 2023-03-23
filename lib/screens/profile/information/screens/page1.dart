import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Page1 extends StatefulWidget {
  const Page1({
    Key? key,
  }) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int? selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setselectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12, top: 40),
                  alignment: Alignment.centerLeft,
                  child: CircularPercentIndicator(
                    radius: 20,
                    percent: 0.3,
                    progressColor: buttonColor,
                    center: Text('30%'),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 35),
                      child: Text(
                        'Дэлгэрэх хүнс ХХК',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: grey3,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 6, top: 10),
                      child: Text(
                        'Bolor Delguur',
                        style: TextStyle(
                          fontSize: 16,
                          color: grey3,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                'ЕРӨНХИЙ МЭДЭЭЛЭЛ',
                style: TextStyle(
                  color: Color(
                    0xff636E72,
                  ),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                'DeHUB код',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 3, right: 12),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                'Авто олгосон код',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                'Аж ахуйн нэгжийн нэр',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 3, right: 12),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                'Гангамөрөн',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                'Аж ахуйн нэгжийн нэр /Англи үсэг/',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 3, right: 12),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                'Gangamurun',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                'Аж ахуйн нэгжийн хэлбэр',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 3, right: 12),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                'Хязгаарлагдмал хариуцлагатай компани',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                'Регистрийн дугаар',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 3, right: 12),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                'Татвар төлөгчийн регистрийн дугаар',
                style: TextStyle(
                  fontSize: 14,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'НӨАТ төлөгч эсэх :',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xff263238),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: 1,
                  activeColor: buttonColor,
                  groupValue: selectedRadio,
                  onChanged: (val) {
                    setselectedRadio(val!);
                  },
                ),
                Text('Тийм'),
                Radio(
                  value: 2,
                  activeColor: buttonColor,
                  groupValue: selectedRadio,
                  onChanged: (val) {
                    setselectedRadio(val!);
                  },
                ),
                Text('Үгүй'),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
