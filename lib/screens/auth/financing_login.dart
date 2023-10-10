import 'package:dehub/models/partner.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/financing_page/financing_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';

class FinancingLogin extends StatefulWidget {
  static const routeName = 'FinancingLogin';
  const FinancingLogin({Key? key}) : super(key: key);

  @override
  State<FinancingLogin> createState() => _FinancingLoginState();
}

class _FinancingLoginState extends State<FinancingLogin> with AfterLayoutMixin {
  bool _isVisible = true;
  Partner partner = Partner();

  @override
  afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    partner = Provider.of<UserProvider>(context, listen: true).partnerUser;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            financingColor.withOpacity(0.1),
            financingColor.withOpacity(0.4),
            financingColor.withOpacity(0.7),
            financingColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: transparent,
        appBar: AppBar(
          backgroundColor: transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Icon(
                Icons.arrow_back_ios_new,
                color: white,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Funder Logo',
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Санхүүжилт модул тавтай морил',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Lottie.asset('assets/lottie/financing-login.json', height: 250),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Татвар төлөгчийн дугаар: ',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${partner.user?.currentBusiness?.regNumber}',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Партнерийн код: ',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${partner.partner?.refCode}',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Бизнесийн код: ',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${partner.user?.currentBusiness?.refCode}',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Хэрэглэгчийн нэр: ',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${partner.partner?.email}',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FormBuilder(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Нэвтрэх нэр',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FormTextField(
                        name: 'login',
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Нэвтрэх нэр",
                          hintStyle: TextStyle(
                            color: grey2,
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff44566C30),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: red),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Нууц үг',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FormTextField(
                        name: 'password',
                        inputType: TextInputType.text,
                        obscureText: _isVisible,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            child: _isVisible == true
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    color: grey2,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: grey2,
                                  ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Нууц үгээ оруулна уу",
                          hintStyle: TextStyle(
                            color: grey2,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff44566C30),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, top: 10, bottom: 50),
                alignment: Alignment.centerRight,
                child: Text(
                  'Нууц үгээ мартсан уу?',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CustomButton(
                onClick: () {
                  Navigator.of(context).pushNamed(FinancingPage.routeName);
                },
                labelColor: white,
                labelText: 'Нэвтрэх',
                textColor: buttonColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
