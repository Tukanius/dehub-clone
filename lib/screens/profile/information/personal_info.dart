import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/splash/splash_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class PersonalInfo extends StatefulWidget {
  static const routeName = '/personalinfo';
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> with AfterLayoutMixin {
  User partnerUser = User();
  User user = User();

  afterFirstLayout(BuildContext context) async {}

  logout() async {
    await Provider.of<UserProvider>(context, listen: false).logout();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SplashPage()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    partnerUser = Provider.of<UserProvider>(context, listen: true).partnerUser;
    user = Provider.of<UserProvider>(context, listen: true).user;
    print('=================PARTNERUSER===============');
    print(partnerUser.toJson());
    print('=================PARTNERUSER===============');

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Хувийн мэдээлэл',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: grey3,
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
                        partnerUser.user!.username.toString(),
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
                      'Бизнесийн код',
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
                        partnerUser.user!.businessId.toString(),
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
                      child: Text(
                        '${partnerUser.user!.lastName}',
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
                        '${partnerUser.user!.firstName}',
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
                      'Утасны дугаар',
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
                            '${partnerUser.user!.phone}',
                            style: TextStyle(
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                        ),
                        partnerUser.user!.isPhoneVerified == false
                            ? Container(
                                margin:
                                    const EdgeInsets.only(top: 5, right: 10),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Баталгаажаагүй',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.only(top: 5, right: 10),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Баталгаажсан',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: green,
                                  ),
                                ),
                              ),
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
                            '${partnerUser.user!.email}',
                            style: TextStyle(
                              fontSize: 14,
                              color: grey3,
                            ),
                          ),
                        ),
                        partnerUser.user!.isEmailVerified == true
                            ? Container(
                                alignment: Alignment.centerRight,
                                margin:
                                    const EdgeInsets.only(top: 5, right: 10),
                                child: Text(
                                  'Баталгаажсан',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: green,
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.centerRight,
                                margin:
                                    const EdgeInsets.only(top: 5, right: 10),
                                child: Text(
                                  'Баталгаажаагүй',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                      ],
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
                        'Гүйцэтгэх захирал',
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
                      child: Text(
                        '${partnerUser.user!.registerNo}',
                        style: TextStyle(
                          fontSize: 14,
                          color: grey3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        partnerUser.user!.isDanVerified == false
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                                height: 20,
                                width: 120,
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
                              )
                            : SizedBox(),
                        partnerUser.user!.isDanVerified != false
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
                      height: 42,
                    ),
                    CustomButton(
                      onClick: () {
                        logout();
                      },
                      labelText: 'Системээс гарах',
                      labelColor: buttonColor,
                    ),
                    SizedBox(
                      height: 20,
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
