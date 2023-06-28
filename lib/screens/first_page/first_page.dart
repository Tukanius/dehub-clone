import 'dart:async';

import 'package:dehub/components/invoice_approve_card/invoice_approve_card.dart';
import 'package:dehub/components/modules_card/modules_card.dart';
import 'package:dehub/components/schedule_card/schedule_card.dart';
import 'package:dehub/components/take_give_card/take_give_card.dart';
import 'package:dehub/components/tutorial_card/tutorial_card.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/menu/menu_page.dart';
import 'package:dehub/screens/profile/profile_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:after_layout/after_layout.dart';

class FirstPage extends StatefulWidget {
  static const routeName = '/firstpage';
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

User user = User();
Partner partnerUser = Partner();

show(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        margin: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DeHUB платформд татай морил!',
                style: TextStyle(
                  color: buttonColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Та платформд бизнесээ төлөөлөх админаар бүртгүүлсэн байна. Та админ хэрэглэгчээр нэвтрэхдээ дараах мэдээллээр нэвтэрнэ. Мартуузаа',
                style: TextStyle(color: buttonColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Нэвтрэх код',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: buttonColor.withOpacity(0.3),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  'PR-2132324',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Хэрэглэгчийн нэр',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: buttonColor.withOpacity(0.3),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  'Username',
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Та байгууллагыг төлөөлөх админ хэрэглэгчийн хувьд одоо ингэх ёстой',
                style: TextStyle(color: buttonColor),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: SvgPicture.asset('images/blue-star.svg'),
              ),
              Text(
                'Хэрэглэгчийн зөвлөх',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Хэрэглэгчийн зөвлөх танд туслаад ингэнэ ингэнэ. йдыобрөйдылобрө',
                style: TextStyle(color: buttonColor),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                onClick: () {
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pop();
                },
                labelColor: buttonColor,
                labelText: 'Ок. Зөвлөгөө авъя.',
                textColor: white,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Гэрээлэх алхамууд',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'йбдөлор йдылобөр  дйлыробөдлйы ор др йдлоырбө дл йдлыобрө',
                style: TextStyle(color: buttonColor),
              ),
              SizedBox(
                height: 25,
              ),
              SvgPicture.asset(
                'images/dollar-sign.svg',
                color: Color(0xff1B5EAA),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _FirstPageState extends State<FirstPage> with AfterLayoutMixin {
  bool isNew = false;

  @override
  afterFirstLayout(BuildContext context) {
    // show(context);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    partnerUser = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return WillPopScope(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            actions: [
              SvgPicture.asset(
                'images/notification.svg',
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfilePage.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    child: user.avatar == null
                        ? CircleAvatar(
                            radius: 13,
                            child: ClipOval(
                              child: Image(
                                  image: NetworkImage(
                                'https://i0.wp.com/a.slack-edge.com/df10d/img/avatars/ava_0024-192.png?ssl=1',
                              )),
                            ),
                          )
                        : CircleAvatar(
                            radius: 13,
                            backgroundImage: NetworkImage('${user.avatar}'),
                          ),
                  ),
                ),
              ),
            ],
            backgroundColor: buttonColor,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(MenuPage.routeName);
              },
              child: Container(
                color: buttonColor,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SvgPicture.asset('images/menu.svg'),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 50),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: buttonColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${partnerUser.user?.currentBusiness?.partnerName}',
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${partnerUser.user?.currentBusiness?.type}: ",
                                style: TextStyle(
                                  color: Color(0xffFEBC11),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${partnerUser.user?.currentBusiness?.partnerName}",
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ModulesCard(),
                  ],
                ),
                isNew == false
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            color: white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: partnerUser
                                                .user?.currentBusiness?.type ==
                                            "SUPPLIER"
                                        ? Text(
                                            "Өнөөдөр хүлээлгэн өгөх",
                                            style: TextStyle(
                                              color: buttonColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : Text(
                                            "Өнөөдөр хүлээн авах",
                                            style: TextStyle(
                                              color: buttonColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                SizedBox(
                                  height: 15,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      TakeGiveCard(),
                                      TakeGiveCard(),
                                      TakeGiveCard(),
                                      TakeGiveCard(),
                                      TakeGiveCard(),
                                      TakeGiveCard(),
                                      TakeGiveCard(),
                                      TakeGiveCard(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'images/dot-calendar.svg'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '2023-03-23',
                                        style: TextStyle(
                                          color: buttonColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ScheduleCard(),
                                    ScheduleCard(),
                                    ScheduleCard(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(
                              'Батлах хүлээж буй',
                              style: TextStyle(
                                color: buttonColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              '${Moment.parse(DateTime.now().toString()).format("YYYY-MM-DD")}',
                              style: TextStyle(
                                color: blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InvoiceApproveCard(),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Text(
                              'DeHUB платформд тавтай морил!',
                              style: TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SvgPicture.asset('images/new-player.svg'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Та партнерийн тохиргоогоо бүрэн гүйцэт хийнэ үү',
                              style: TextStyle(color: buttonColor),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Заавартай танилцах',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TutorialCard(),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        final shoudPop = await showMyDialog();
        return shoudPop!;
      },
    );
  }

  Future<bool?> showMyDialog() => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Та Апп-аас гарах гэж байна'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Болих'),
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(
                  red.withOpacity(0.1),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'Гарах',
                style: TextStyle(color: red),
              ),
            ),
          ],
        ),
      );
}
