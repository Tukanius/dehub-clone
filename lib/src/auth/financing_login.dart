import 'package:dehub/models/finance.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/finance_module/financing_page/financing_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:after_layout/after_layout.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FinancingLogin extends StatefulWidget {
  static const routeName = 'FinancingLogin';
  const FinancingLogin({Key? key}) : super(key: key);

  @override
  State<FinancingLogin> createState() => _FinancingLoginState();
}

class _FinancingLoginState extends State<FinancingLogin> with AfterLayoutMixin {
  bool _isVisible = true;
  User user = User();
  bool isSubmit = false;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  @override
  afterFirstLayout(BuildContext context) async {
    try {
      await Provider.of<UserProvider>(context, listen: false).financeMe();
      Navigator.of(context).pushNamed(FinancingPage.routeName);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        Finance data = Finance.fromJson(fbKey.currentState!.value);
        data.businessRef = user.currentBusiness?.refCode;
        data.partnerRef = user.currentBusiness?.partner?.refCode;
        await Provider.of<UserProvider>(context, listen: false)
            .financeLogin(data);
        await Navigator.of(context).pushNamed(FinancingPage.routeName);
        setState(() {
          isSubmit = false;
        });
      } catch (e) {
        setState(() {
          isSubmit = false;
        });
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      backgroundColor: financingColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: white,
                  ),
                ),
              ),
              const Text(
                'Funder Logo',
                style: TextStyle(
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
              Lottie.asset('assets/lottie/financing-login.json', height: 250),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'И-мэйл: ',
                      style:
                          TextStyle(color: white, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${user.email}',
                      style:
                          TextStyle(color: white, fontWeight: FontWeight.w500),
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
                        'И-мэйл',
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
                          FocusScope.of(context).nextFocus();
                        },
                        name: 'email',
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "И-мэйл",
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
                          (value) {
                            return validateEmail(value.toString(), context);
                          }
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
                            errorText: 'Нууц үг оруулна уу',
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, top: 10, bottom: 50),
                alignment: Alignment.centerRight,
                child: const Text(
                  'Нууц үгээ мартсан уу?',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CustomButton(
                isLoading: isSubmit,
                onClick: () {
                  onSubmit();
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
