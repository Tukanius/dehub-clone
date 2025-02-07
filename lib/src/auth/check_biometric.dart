import 'package:dehub/src/splash/splash_page.dart';
import 'package:dehub/utils/secure_storage.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:after_layout/after_layout.dart';

class CheckBiometric extends StatefulWidget {
  static const routeName = 'biocheck';

  const CheckBiometric({super.key});

  @override
  CheckBiometricState createState() => CheckBiometricState();
}

class CheckBiometricState extends State<CheckBiometric> with AfterLayoutMixin {
  bool isLoading = false;
  final LocalAuthentication auth = LocalAuthentication();
  final SecureStorage secureStorage = SecureStorage();
  bool bioMetric = false;
  String fingerPrintIcon = "assets/svg/finger-print.svg";
  String faceIdIcon = "assets/svg/face-id.svg";
  String bioType = "";

  Future<void> _authenticate() async {
    try {
      setState(() {
        isLoading = true;
      });
      bioMetric = await auth.authenticate(
        localizedReason: 'Баталгаажуулалт',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });
      return;
    }
    if (!mounted) {
      return;
    }

    secureStorage.setBioMetric(bioMetric);

    Navigator.of(context).pushNamed(SplashPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 80),
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: white,
                    ),
                    alignment: Alignment.center,
                    child: bioType == "FACE"
                        ? SvgPicture.asset(
                            faceIdIcon,
                            colorFilter: const ColorFilter.mode(
                                buttonColor, BlendMode.srcIn),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(
                            fingerPrintIcon,
                            colorFilter: const ColorFilter.mode(
                                buttonColor, BlendMode.srcIn),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Та тохиргоог идэвхжүүлснээр цаашид апп руу нэвтрэхэд нэвтрэх нэр нууц үг хийх шаардлагагүй.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: buttonColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    borderColor: buttonColor,
                    labelColor: backgroundColor,
                    labelText: "Алгасах",
                    textColor: buttonColor,
                    onClick: () {
                      Navigator.of(context).pushNamed(SplashPage.routeName);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    labelColor: buttonColor,
                    labelText: "Зөвшөөрөх",
                    textColor: white,
                    onClick: () {
                      _authenticate();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  afterFirstLayout(BuildContext context) async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      setState(() {
        bioType = "FACE";
      });
    }
    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      setState(() {
        bioType = "FINGER_PRINT";
      });
    }
    if (availableBiometrics.contains(BiometricType.iris)) {
      setState(() {
        bioType = "IRIS";
      });
    }
    if (availableBiometrics.contains(BiometricType.strong)) {
      setState(() {
        bioType = "STRONG";
      });
    }
    if (availableBiometrics.contains(BiometricType.weak)) {
      setState(() {
        bioType = "WEAK";
      });
    }
  }
}
