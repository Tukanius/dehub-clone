import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 170),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: paymentColor,
                        width: 3,
                      ),
                    ),
                    child: Container(
                      child: SvgPicture.asset(
                        'images/check.svg',
                        color: paymentColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                    height: 15,
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
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomButton(
                  onClick: () {
                    Navigator.of(context).pop();
                    Navigator.of(ctx).pop();
                  },
                  labelColor: paymentColor,
                  labelText: 'Ойлголоо',
                ),
              ),
              SizedBox(
                height: 20,
              )
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
            color: paymentColor,
          ),
        ),
        title: Text(
          'Данс холбох',
          style: TextStyle(
            color: paymentColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Дансны мэдээлэл',
                style: TextStyle(
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              color: white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Банкны нэр',
                    style: TextStyle(
                      color: grey2,
                    ),
                  ),
                  Text(
                    'Голомт банк',
                    style: TextStyle(
                      color: paymentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
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
                children: [
                  Text(
                    'Дансны дугаар',
                    style: TextStyle(
                      color: grey2,
                    ),
                  ),
                  Text(
                    'Account Number',
                    style: TextStyle(
                      color: paymentColor,
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
                children: [
                  Text(
                    'Дансны нэр',
                    style: TextStyle(
                      color: grey2,
                    ),
                  ),
                  Text(
                    'Дансны нэр авто гаргах',
                    style: TextStyle(
                      color: grey2,
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
                children: [
                  Text(
                    'Дансны валют',
                    style: TextStyle(
                      color: grey2,
                    ),
                  ),
                  Text(
                    'Төгрөг',
                    style: TextStyle(
                      color: paymentColor,
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
                    'Үндсэн данс болгох',
                    style: TextStyle(fontSize: 14, color: grey2),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      activeColor: paymentColor,
                      value: isSwitched,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Та буруу дансанд орлого авахаас сэргийлэн оруулсан мэдээллээ сайтар шалгана уу.',
              style: TextStyle(fontSize: 14, color: grey3),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomButton(
                labelColor: paymentColor,
                labelText: 'Мэдээлэл зөв. Холбоё',
                onClick: () {
                  show(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
