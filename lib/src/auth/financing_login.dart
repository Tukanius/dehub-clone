import 'package:dehub/models/finance.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/password_recovery/password_recovery.dart';
import 'package:dehub/src/finance_module/financing_page/financing_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:after_layout/after_layout.dart';

class FinancingLogin extends StatefulWidget {
  static const routeName = '/FinancingLogin';
  const FinancingLogin({super.key});

  @override
  State<FinancingLogin> createState() => _FinancingLoginState();
}

class _FinancingLoginState extends State<FinancingLogin> with AfterLayoutMixin {
  bool _isVisible = true;
  User user = User();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  bool isLoading = true;

  onSubmit() async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        loading.loading(true);
        Finance data = Finance.fromJson(fbKey.currentState!.value);
        data.businessRef = user.currentBusiness?.refCode;
        await Provider.of<UserProvider>(context, listen: false)
            .financeLogin(source.url, data);
        loading.loading(false);
        await Navigator.of(context).pushNamed(FinancingPage.routeName);
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    try {
      final source = Provider.of<FinanceProvider>(context, listen: false);
      await Provider.of<GeneralProvider>(context, listen: false)
          .financeInit(source.url, false);
      await Navigator.of(context).pushNamed(FinancingPage.routeName);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    final source = Provider.of<FinanceProvider>(context, listen: true);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: source.currentColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.5),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(15),
                    color: transparent,
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: white,
                    ),
                  ),
                ),
                Text(
                  source.bankName,
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Санхүүжилт модул тавтай морил',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Lottie.asset('assets/lottie/financing-login.json',
                    height: isLoading == true ? 300 : 200),
                if (isLoading == false)
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'И-мэйл: ',
                              style: TextStyle(
                                  color: white, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '${user.email}',
                              style: const TextStyle(
                                  color: white, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      FormBuilder(
                        key: fbKey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Татвар төлөгчийн дугаар',
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FormTextField(
                                inputType: TextInputType.number,
                                onComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                                name: 'regNumber',
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Татвар төлөгчийн дугаар",
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
                                      errorText:
                                          'Татвар төлөгчийн дугаар оруулна уу'),
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Хэрэглэгчийн нэр',
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FormTextField(
                                inputType: TextInputType.emailAddress,
                                onComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                                name: 'username',
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Хэрэглэгчийн нэр",
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
                                      errorText: 'Хэрэглэгчийн нэр оруулна уу'),
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Нууц үг',
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FormTextField(
                                onComplete: () {
                                  onSubmit();
                                },
                                name: 'password',
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
                                    errorText: 'Нууц үг оруулна уу',
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            PasswordRecovery.routeName,
                            arguments: PasswordRecoveryArguments(
                              color: source.currentColor,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              right: 15, top: 10, bottom: 10),
                          margin: const EdgeInsets.only(bottom: 40),
                          alignment: Alignment.centerRight,
                          color: transparent,
                          child: const Text(
                            'Нууц үгээ мартсан уу?',
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        onClick: () {
                          onSubmit();
                        },
                        labelColor: white,
                        labelText: 'Нэвтрэх',
                        textColor: buttonColor,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String value, context) {
  RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value.isEmpty) {
    return 'И-Мейлээ оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'И-Мейлээ шалгана уу';
    } else {
      return null;
    }
  }
}
