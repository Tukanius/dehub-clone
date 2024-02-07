import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/check_biometric.dart';
import 'package:dehub/src/auth/register-page/register_page.dart';
import 'package:dehub/src/splash/splash_page.dart';
import 'package:dehub/utils/secure_storage.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
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
  String fingerPrintIcon = "assets/svg/finger-print.svg";
  String faceIdIcon = "assets/svg/face-id.svg";
  bool _isVisible = true;
  bool saveCode = false;
  bool isLoading = false;
  bool isSubmit = false;
  bool activeBio = false;
  bool isBioMetric = false;
  String bioType = '';

  @override
  afterFirstLayout(BuildContext context) async {
    Future<String?> futureResult = secureStorage.getBioMetric();
    String result = await futureResult ?? "";
    if (result == "true") {
      setState(() {
        isBioMetric = true;
      });
    }
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
        String? code = await UserProvider().getCode();
        String? username = await UserProvider().getEmail();
        if (code == null || code == "") {
          setState(() {
            saveCode = false;
          });
        } else {
          setState(() {
            saveCode = true;
          });
        }
        setState(() {
          codeController.text = code!;
          emailController.text = username!;
        });
      }
    }
  }

  show(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(
          child: CupertinoActivityIndicator(
            color: mainColor,
            radius: 15,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          showMyDialog();
        },
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
                        const SizedBox(
                          height: 70,
                        ),
                        const Text(
                          'DeHUB',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Үнэ цэн нэмсэн түншлэл',
                          style: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Image(
                          image: AssetImage('images/login.png'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormBuilder(
                          key: fbKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Нэвтрэх код',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Системд нэвтрэх бизнесийн код",
                                  hintStyle: const TextStyle(
                                    color: grey2,
                                    fontSize: 14,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: grey2.withOpacity(0.3),
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: red),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
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
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                'Хэрэглэгчийн нэр',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
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
                                controller: emailController,
                                textColor: buttonColor,
                                name: "username",
                                inputType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Хэрэглэгчийн нэрээ оруулна уу",
                                  hintStyle: const TextStyle(
                                    color: grey2,
                                    fontSize: 14,
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: grey2.withOpacity(0.3),
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: red),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
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
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                'Нууц үг',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FormTextField(
                                onComplete: isSubmit == false
                                    ? () {
                                        _performLogin(context);
                                      }
                                    : () {},
                                inputAction: TextInputAction.done,
                                textColor: buttonColor,
                                name: "password",
                                inputType: TextInputType.text,
                                obscureText: _isVisible,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                    child: _isVisible == true
                                        ? const Icon(
                                            Icons.visibility_off_outlined,
                                            color: grey2,
                                          )
                                        : const Icon(
                                            Icons.visibility_outlined,
                                            color: grey2,
                                          ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Нууц үгээ оруулна уу",
                                  hintStyle: const TextStyle(
                                    color: grey2,
                                    fontSize: 14,
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: grey2.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
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
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: const Text(
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
                        const SizedBox(
                          height: 30,
                        ),
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
                                boxShadow: const [
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
                                bioType == "FACE"
                                    ? faceIdIcon
                                    : fingerPrintIcon,
                                colorFilter: const ColorFilter.mode(
                                    white, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
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
                              child: const Text(
                                'БҮРТГҮҮЛЭХ',
                                style: TextStyle(
                                  color: Color(0xff2E41FB),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
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
      ),
    );
  }

  Future<bool?> showMyDialog() => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Та Апп-аас гарах гэж байна'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Болих'),
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
              child: const Text(
                'Гарах',
                style: TextStyle(color: red),
              ),
            ),
          ],
        ),
      );
  void _performLogin(BuildContext context) async {
    final String code;
    final String username;
    final String password;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (fbKey.currentState!.saveAndValidate()) {
      code = fbKey.currentState?.fields['code']?.value;
      username = fbKey.currentState?.fields['username']?.value;
      password = fbKey.currentState?.fields['password']?.value;
      try {
        setState(() {
          isSubmit = true;
        });
        User save = User.fromJson(fbKey.currentState!.value);
        UserProvider().setEmail(save.username.toString());
        UserProvider().setCode(save.code.toString());
        await Provider.of<UserProvider>(context, listen: false).login(save);
        await _storeCredentials(code, username, password);
        if (activeBio == true && availableBiometrics.isNotEmpty) {
          Navigator.of(context).pushNamed(CheckBiometric.routeName);
        } else {
          Navigator.of(context).pushNamed(SplashPage.routeName);
        }
        setState(() {
          isSubmit = false;
        });
      } catch (e) {
        debugPrint(e.toString());
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
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated == true) {
        Future<String?> code = secureStorage.getCode();
        Future<String?> username = secureStorage.getEmail();
        Future<String?> password = secureStorage.getPassWord();
        String resultCode = await code ?? "";
        String resultEmail = await username ?? "";
        String resultPassword = await password ?? "";
        save.code = resultCode;
        save.username = resultEmail;
        save.password = resultPassword;
        await Provider.of<UserProvider>(context, listen: false).login(save);
        Navigator.of(context).pushNamed(SplashPage.routeName);
      }
      setState(() {
        isSubmit = false;
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      setState(() {
        isSubmit = false;
      });
      return;
    }
    if (!mounted) {
      return;
    }
  }

  _storeCredentials(String code, String username, String password) async {
    await secureStorage.setCode(code);
    await secureStorage.setEmail(username);
    await secureStorage.setPassWord(password);
  }
}
