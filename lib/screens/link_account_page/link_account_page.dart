import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LinkAccountPage extends StatefulWidget {
  static const routeName = "/linkaccountpage";
  const LinkAccountPage({Key? key}) : super(key: key);

  @override
  _LinkAccountPageState createState() => _LinkAccountPageState();
}

class _LinkAccountPageState extends State<LinkAccountPage> {
  show(ctx) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: neonGreen,
                    width: 3,
                  ),
                ),
                child: Container(
                  child: SvgPicture.asset(
                    'images/check.svg',
                    color: neonGreen,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Амжилттай',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: black,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Та бизнес тооцооны  дансаа амжилттай холболоо.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff2C3D7A),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomButton(
                  onClick: () {
                    Navigator.of(context).pop();
                    Navigator.of(ctx).pop();
                  },
                  labelColor: neonGreen,
                  labelText: 'Ойлголоо',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: black,
          ),
        ),
        title: Text(
          'Данс холбох',
          style: TextStyle(color: black, fontSize: 18),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            color: neonGreen,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(3.0),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Хэрэглэгчийн нэр',
              style: TextStyle(
                fontSize: 16,
                color: black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                'Голомт банк',
                style: TextStyle(
                  fontSize: 16,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Дансны дугаар',
              style: TextStyle(
                fontSize: 16,
                color: black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                '3216546513',
                style: TextStyle(
                  fontSize: 16,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Дансны нэр',
              style: TextStyle(
                fontSize: 16,
                color: black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                'DELGEREH KHUNS',
                style: TextStyle(
                  fontSize: 16,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Дансны валют',
              style: TextStyle(
                fontSize: 16,
                color: black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: grey3),
              ),
              child: Text(
                'MNT',
                style: TextStyle(
                  fontSize: 16,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: isSwitched,
                    onChanged: (bool value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                ),
                Text(
                  'Үндсэн данс болгох',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Та буруу дансанд орлого авахаас сэргийлэн оруулсан мэдээллээ сайтар шалгана уу.',
              style: TextStyle(fontSize: 14, color: grey3),
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              labelColor: neonGreen,
              labelText: 'Мэдээлэл зөв. Холбоё',
              onClick: () {
                show(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
