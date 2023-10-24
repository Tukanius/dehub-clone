import 'package:dehub/api/auth_api.dart';
import 'package:dehub/models/partner.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalInfo extends StatefulWidget {
  static const routeName = '/personalinfo';

  PersonalInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> with AfterLayoutMixin {
  User user = User();
  bool isLoading = false;
  User dan = User();
  bool isSubmit = false;
  Partner partner = Partner();

  afterFirstLayout(BuildContext context) async {}

  danVerify() async {
    setState(() {
      isSubmit = true;
    });
    dan = await AuthApi().danVerify();
    await launchUrl(dan.url!);
    setState(() {
      isSubmit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    partner = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: black,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey,
                            offset: Offset(0, 5),
                          ),
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey,
                            offset: Offset(5, 0),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: user.avatar == null
                            ? Image.network(
                                '${user.avatar}',
                                fit: BoxFit.cover,
                              )
                            : Image.asset('images/avatar.png'),
                      ),
                    ),
                    Positioned(
                      bottom: -23,
                      right: -15,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffC4C4C4),
                          ),
                          child: Icon(
                            CupertinoIcons.photo_camera,
                            color: white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  '${partner.user?.currentBusiness?.profileNameEng}',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, color: grey3),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${user.firstName}, ${user.phone}',
                  style: TextStyle(
                    fontSize: 16,
                    color: grey3,
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                'Хувийн мэдээлэл',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: grey3,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Хэрэглэгчийн нэр',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
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
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey3),
                      ),
                      child: Text(
                        user.username.toString(),
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
                      'Регист №',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
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
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey3),
                        ),
                        child: user.registerNo != null
                            ? Text(
                                '${user.registerNo}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey3,
                                ),
                              )
                            : Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: grey3,
                                ),
                              )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ургын овог',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
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
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey3),
                      ),
                      child: Text(
                        "Боржигон",
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
                      'Эцэг/Эхийн нэр',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
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
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey3),
                      ),
                      child: user.lastName != null
                          ? Text(
                              '${user.lastName}',
                              style: TextStyle(
                                fontSize: 14,
                                color: grey3,
                              ),
                            )
                          : Text(
                              '-',
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
                      'Өөрийн нэр',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
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
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey3),
                      ),
                      child: Text(
                        '${user.firstName}',
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
                      'Харъяалах нэгж',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
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
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey3),
                      ),
                      child: Text(
                        'Борлуулалтын алба',
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
                      'Албан тушаал',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
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
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: grey3),
                      ),
                      child: Text(
                        'Худалдааны төлөөлөгч',
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
                        'Холбоо барих',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: grey3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Утасны дугаар №1',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: grey3),
                          ),
                          child: Text(
                            '${user.phone}',
                            style: TextStyle(
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                        ),
                        // user.isPhoneVerified == false
                        //     ? Container(
                        //         margin:
                        //             const EdgeInsets.only(top: 5, right: 10),
                        //         alignment: Alignment.centerRight,
                        //         child: Text(
                        //           'Баталгаажаагүй',
                        //           style: TextStyle(
                        //             fontSize: 12,
                        //             color: Colors.red,
                        //           ),
                        //         ),
                        //       )
                        //     : Container(
                        //         margin:
                        //             const EdgeInsets.only(top: 5, right: 10),
                        //         alignment: Alignment.centerRight,
                        //         child: Text(
                        //           'Баталгаажсан',
                        //           style: TextStyle(
                        //             fontSize: 12,
                        //             color: green,
                        //           ),
                        //         ),
                        //       ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'И-мэйл хаяг',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: grey3),
                          ),
                          child: Text(
                            '${user.email}',
                            style: TextStyle(
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                        ),
                        // user.isEmailVerified == true
                        //     ? Container(
                        //         alignment: Alignment.centerRight,
                        //         margin:
                        //             const EdgeInsets.only(top: 5, right: 10),
                        //         child: Text(
                        //           'Баталгаажсан',
                        //           style: TextStyle(
                        //             fontSize: 12,
                        //             color: green,
                        //           ),
                        //         ),
                        //       )
                        //     : Container(
                        //         alignment: Alignment.centerRight,
                        //         margin:
                        //             const EdgeInsets.only(top: 5, right: 10),
                        //         child: Text(
                        //           'Баталгаажаагүй',
                        //           style: TextStyle(
                        //             fontSize: 12,
                        //             color: Colors.red,
                        //           ),
                        //         ),
                        //       )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Утасны дугаар №2',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: grey3),
                          ),
                          child: Text(
                            '-',
                            style: TextStyle(
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Утасны дугаар №3',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: grey3,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: grey3),
                          ),
                          child: Text(
                            '-',
                            style: TextStyle(
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        user.isDanVerified == false
                            ? GestureDetector(
                                onTap: () {
                                  if (isSubmit == false) {
                                    danVerify();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xffADC6FF),
                                      )),
                                  child: Text(
                                    'Баталгаажуулъя',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: buttonColor,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        user.isDanVerified != false
                            ? Text(
                                'Дан систем баталгаажсан',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: green,
                                ),
                              )
                            : Text(
                                'Дан систем баталгаажаагүй',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: red,
                                ),
                              )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
