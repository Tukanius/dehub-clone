import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/register-page/register-page.dart';
import 'package:dehub/screens/splash/splash_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginpage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool _isVisible = true;
  bool isCheck = false;
  bool saveUserName = false;
  bool isSubmit = false;

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        User save = User.fromJson(fbKey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false).login(save);
        await Provider.of<UserProvider>(context, listen: false).me(true);
        Navigator.of(context).pushNamed(SplashPage.routeName);
      } catch (e) {
        print('============ERROR================');
        debugPrint(e.toString());
        print('============ERROR================');
        setState(() {
          isSubmit = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 21,
                    ),
                    Text(
                      'DeHUB',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Үнэ цэн нэмсэн түншлэл',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image(
                      image: AssetImage('images/login.png'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilder(
                      key: fbKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Нэвтрэх код',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FormTextField(
                            name: "code",
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Системд нэвтрэх бизнесийн код",
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
                              FormBuilderValidators.required(
                                errorText: 'Бизнесийн код оруулна уу',
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Хэрэглэгчийн нэр',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FormTextField(
                            name: "email",
                            inputType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Хэрэглэгчийн нэрээ оруулна уу",
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
                              FormBuilderValidators.required(
                                errorText: 'Хэрэглэгчийн нэр оруулна уу',
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Нууц үг',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FormTextField(
                            name: "password",
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
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Нууц үгээ мартсан уу?',
                              style: TextStyle(
                                color: buttonColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
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
                          fillColor: MaterialStateProperty.resolveWith(
                              (states) => buttonColor),
                          value: saveUserName,
                          onChanged: (bool? value) {
                            setState(() {
                              saveUserName = value!;
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
                        onSubmit();
                      },
                      labelText: "Нэвтрэх",
                      labelColor: buttonColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Байгууллага бүртгэлгүй юу? ',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RegisterPage.routeName);
                          },
                          child: Text(
                            'БҮРТГҮҮЛЭХ',
                            style: TextStyle(
                              color: Color(0xff2E41FB),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
