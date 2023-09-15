import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/screens/auth/check-biometric.dart';
import 'package:dehub/screens/register-page/register-page.dart';
import 'package:dehub/screens/splash/splash_page.dart';
import 'package:dehub/utils/secure_storage.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginpage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  final SecureStorage secureStorage = SecureStorage();
  TextEditingController codeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  String fingerPrintIcon = "images/finger-print.svg";
  String faceIdIcon = "images/face-id.svg";
  bool _isVisible = true;
  bool isCheck = false;
  bool saveUserName = false;
  bool isLoading = false;
  bool isSubmit = false;
  bool activeBio = false;
  bool isBioMetric = false;
  String bioType = '';
  bool saveIsUsername = false;

  @override
  afterFirstLayout(BuildContext context) async {
    Future<String?> futureResult = secureStorage.getBioMetric();
    String result = await futureResult ?? "";
    if (result == "true") {
      setState(() {
        isBioMetric = true;
      });
    }
    // ···
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    setState(() {
      activeBio = canAuthenticate;
    });

    if (activeBio == true) {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.face)) {
        setState(() {
          bioType = "FACE";
        });
      } else {}
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        setState(() {
          bioType = "FINGER_PRINT";
        });
      }
      if (isBioMetric == false) {
        String? username = await UserProvider().getUsername();
        if (username == null || username == "") {
          setState(() {
            saveIsUsername = false;
          });
        } else {
          setState(() {
            saveIsUsername = true;
          });
        }
        setState(() {
          emailController.text = username!;
        });
      }
    }
  }

  // onSubmit() async {
  //   if (fbKey.currentState!.saveAndValidate()) {
  //     try {
  //       setState(() {
  //         isSubmit = true;
  //       });
  //       User save = User.fromJson(fbKey.currentState!.value);
  //       await Provider.of<UserProvider>(context, listen: false).login(save);
  //       await Provider.of<UserProvider>(context, listen: false).me(true);
  //       Navigator.of(context).pushNamed(SplashPage.routeName);
  //       setState(() {
  //         isSubmit = false;
  //       });
  //     } catch (e) {
  //       print('============ERROR================');
  //       debugPrint(e.toString());
  //       print('============ERROR================');
  //       setState(() {
  //         isSubmit = false;
  //       });
  //     }
  //   }
  // }

  show(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: CupertinoActivityIndicator(
            color: mainColor,
            radius: 15,
          ),
        );
      },
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                        height: 70,
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
                              onChanged: (_) {
                                secureStorage.deleteAll();
                                setState(() {
                                  isBioMetric = false;
                                });
                              },
                              controller: codeController,
                              inputAction: TextInputAction.next,
                              onComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                              textColor: buttonColor,
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
                              onChanged: (p0) {
                                secureStorage.deleteAll();
                                setState(() {
                                  isBioMetric = false;
                                });
                              },
                              inputAction: TextInputAction.next,
                              labelText: 'Хэрэглэгчийн нэр',
                              onComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                              // labelStyle: TextStyle(
                              //   color: buttonColor,
                              //   fontWeight: FontWeight.w500,
                              //   fontSize: 14,
                              // ),
                              textColor: buttonColor,
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
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff44566C30),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: red),
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
                              onComplete: () {
                                _performLogin(context);
                              },
                              inputAction: TextInputAction.done,
                              textColor: buttonColor,
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
                        height: 30,
                      ),
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //       fillColor: MaterialStateProperty.resolveWith(
                      //           (states) => buttonColor),
                      //       value: saveUserName,
                      //       onChanged: (bool? value) {
                      //         setState(() {
                      //           saveUserName = value!;
                      //         });
                      //       },
                      //     ),
                      //     Text(
                      //       'Нэвтрэх мэдээлэл сануулах',
                      //       style: TextStyle(
                      //         color: grey2,
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: 16,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 42,
                      // ),
                      CustomButton(
                        isLoading: isSubmit,
                        onClick: () {
                          _performLogin(context);

                          // show(context);
                        },
                        labelText: "Нэвтрэх",
                        labelColor: buttonColor,
                      ),
                      if (isBioMetric == true)
                        GestureDetector(
                          onTap: () {
                            loginBio();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(top: 30),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 5,
                                  color: black,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5),
                              color: buttonColor,
                            ),
                            child: SvgPicture.asset(
                              bioType == "FACE" ? faceIdIcon : fingerPrintIcon,
                              color: white,
                            ),
                          ),
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
      ),
      onWillPop: () async {
        final shouldPop = await showMyDialog();
        return shouldPop!;
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
  void _performLogin(BuildContext context) async {
    final String code;
    final String email;
    final String password;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (fbKey.currentState!.saveAndValidate()) {
      code = fbKey.currentState?.fields['code']?.value;
      email = fbKey.currentState?.fields['email']?.value;
      password = fbKey.currentState?.fields['password']?.value;
      try {
        setState(() {
          isSubmit = true;
        });
        User save = User.fromJson(fbKey.currentState!.value);
        UserProvider().setEmail(save.email.toString());
        await Provider.of<UserProvider>(context, listen: false).login(save);
        await _storeCredentials(code, email, password);
        if (activeBio == true && availableBiometrics.isNotEmpty) {
          Navigator.of(context).pushNamed(CheckBiometric.routeName);
        } else {
          Navigator.of(context).pushNamed(SplashPage.routeName);
        }
      } catch (e) {
        print(e.toString());
        setState(() {
          isSubmit = false;
        });
      }
    }
  }

  Future<void> loginBio() async {
    bool authenticated = false;
    User save = User();
    try {
      setState(() {
        isSubmit = true;
      });
      authenticated = await auth.authenticate(
        localizedReason: '',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated == true) {
        Future<String?> code = secureStorage.getCode();
        Future<String?> email = secureStorage.getEmail();
        Future<String?> password = secureStorage.getPassWord();
        String resultCode = await code ?? "";
        String resultEmail = await email ?? "";
        String resultPassword = await password ?? "";
        save.code = resultEmail;
        save.email = resultCode;
        save.password = resultPassword;
        await Provider.of<UserProvider>(context, listen: false).login(save);
        Navigator.of(context).pushNamed(SplashPage.routeName);
      }
      setState(() {
        isSubmit = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        isSubmit = false;
      });
      return;
    }
    if (!mounted) {
      return;
    }
  }

  _storeCredentials(String code, String email, String password) async {
    await secureStorage.setCode(code);
    await secureStorage.setEmail(email);
    await secureStorage.setPassWord(password);
  }
}
