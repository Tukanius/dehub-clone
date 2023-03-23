import 'package:dehub/screens/main/main_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginpage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isVisible = true;
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 80, width: 80, color: buttonColor),
                  SizedBox(
                    height: 21,
                  ),
                  Text(
                    'Системд нэвтрэх',
                    style: TextStyle(
                      color: grey2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FormBuilder(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Бизнэсийн код',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Системд нэвтрэх бизнесийн код",
                              hintStyle: TextStyle(
                                color: grey2,
                                fontWeight: FontWeight.w500,
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
                              FormBuilderValidators.required(
                                  errorText: 'Бизнесийн код оруулна уу'),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Хэрэглэгчийн нэр',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Хэрэглэгчийн нэрээ оруулна уу",
                              hintStyle: TextStyle(
                                color: grey2,
                                fontWeight: FontWeight.w500,
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
                              FormBuilderValidators.required(
                                  errorText: 'Хэрэглэгчийн нэр оруулна уу'),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Нууц үг',
                          style: TextStyle(
                            color: grey3,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: _isVisible,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                                icon: _isVisible == true
                                    ? Icon(
                                        Icons.visibility_off_outlined,
                                        color: Color(0xff44566C),
                                      )
                                    : Icon(
                                        Icons.visibility_outlined,
                                        color: Color(0xff44566C),
                                      ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Нууц үгээ оруулна уу",
                              hintStyle: TextStyle(
                                color: grey2,
                                fontWeight: FontWeight.w500,
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
                              FormBuilderValidators.required(
                                errorText: 'Нууц үгээ оруулна уу',
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Нууц үгээ мартсан уу?',
                            style: TextStyle(
                                color: buttonColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        // checkColor: buttonColor,
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => buttonColor),
                        value: isCheck,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheck = value!;
                          });
                        },
                      ),
                      Text(
                        'Нэвтрэх мэдээлэл сануулах',
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  CustomButton(
                    onClick: () {
                      Navigator.of(context).pushNamed(MainPage.routeName);
                    },
                    labelText: "Нэвтрэх",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
