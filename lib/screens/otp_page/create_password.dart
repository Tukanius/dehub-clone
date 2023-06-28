import 'dart:async';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreatePasswordPage extends StatefulWidget {
  static const routeName = '/CreatePasswordPage';
  const CreatePasswordPage({Key? key}) : super(key: key);

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  int _counter = 120;
  TextEditingController controller = TextEditingController();
  bool isGetCode = false;
  bool isSubmit = false;
  late Timer _timer;
  String username = "";

  String intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    String result = "$m:$s";
    return result;
  }

  void _startTimer() async {
    if (isSubmit == true) {
      setState(() {
        isGetCode = false;
      });
      _counter = 120;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    } else {
      setState(() {
        isGetCode = false;
      });
      _counter = 120;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leadingWidth: 150,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_back_ios_new,
                color: buttonColor,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Буцах',
                style: TextStyle(
                  color: buttonColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: SvgPicture.asset('images/create-password.svg'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Та аппд нэвтрэх нууц үгээ үүсгэнэ үү.',
              style: TextStyle(color: buttonColor),
            ),
            SizedBox(
              height: 15,
            ),
            FormBuilder(
              key: fbKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Нууц үг',
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FormTextField(
                    name: "password",
                    inputType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Нууц үгээ оруулна уу",
                      hintStyle: TextStyle(
                        color: grey2,
                        fontSize: 14,
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
                    validator: FormBuilderValidators.compose([
                      (value) {
                        return validatePassword(value.toString(), context);
                      }
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Дахин оруулна уу',
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FormTextField(
                    name: "passwordVerify",
                    inputType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Дахин оруулна уу",
                      hintStyle: TextStyle(
                        color: grey2,
                        fontSize: 14,
                      ),
                      suffixIcon: Icon(Icons.visibility_off),
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
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Нууц үг давтан оруулна уу',
                      ),
                      (value) {
                        if (fbKey.currentState?.fields['password']?.value !=
                            value) {
                          return "Нууц үг таарахгүй байна";
                        }
                        return null;
                      }
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              onClick: () {
                // Navigator.of(context).pushNamed(FirstPage.routeName);
              },
              labelColor: buttonColor,
              labelText: 'Нууц үг үүсгэх',
              textColor: white,
            ),
          ],
        ),
      ),
    );
  }
}

String? validatePassword(String value, context) {
  RegExp regex = RegExp(r'^.{6,20}$');
  if (value.isEmpty) {
    return 'Нууц үгээ оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Нууц үг нь дор хаяж 6 тэмдэгтээс бүрдэх ёстой';
    } else {
      return null;
    }
  }
}
