import 'package:dehub/api/auth_api.dart';
import 'package:dehub/components/back_button/back_button.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class CreatePasswordPageArguments {
  String type;
  CreatePasswordPageArguments({
    required this.type,
  });
}

class CreatePasswordPage extends StatefulWidget {
  static const routeName = '/CreatePasswordPage';
  final String type;
  const CreatePasswordPage({
    super.key,
    required this.type,
  });

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  TextEditingController controller = TextEditingController();
  bool isVisible = true;
  bool isVisible1 = true;
  User user = User();

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        user = User.fromJson(fbKey.currentState!.value);
        loading.loading(true);
        await AuthApi().createPassword(user);
        loading.loading(false);
        showCustomDialog(
          context,
          widget.type == 'FORGOT'
              ? 'Нууц үг амжилттай солилоо'
              : 'Таны бүртгэл амжилттай үүслээ. Цахим хаягт ирсэн бизнесийн кодоор нэвтэрнэ үү.',
          true,
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            if (widget.type != "FORGOT") {
              Navigator.of(context).pop();
            }
          },
        );
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
        leadingWidth: 150,
        leading: const CustomBackButton(color: buttonColor),
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
                child: SvgPicture.asset('assets/svg/create-password.svg'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Та аппд нэвтрэх нууц үгээ үүсгэнэ үү.',
              style: TextStyle(color: buttonColor),
            ),
            const SizedBox(
              height: 15,
            ),
            FormBuilder(
              key: fbKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Нууц үг',
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FormTextField(
                    name: "password",
                    inputType: TextInputType.text,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible == true
                            ? const Icon(
                                Icons.visibility_off,
                                color: buttonColor,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: buttonColor,
                              ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
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
                      (value) {
                        return validatePassword(value.toString(), context);
                      }
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Дахин оруулна уу',
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FormTextField(
                    obscureText: isVisible1,
                    name: "passwordVerify",
                    inputType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible1 = !isVisible1;
                          });
                        },
                        icon: isVisible1 == true
                            ? const Icon(
                                Icons.visibility_off,
                                color: buttonColor,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: buttonColor,
                              ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Нууц үг давтан оруулна уу",
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
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              onClick: () {
                onSubmit();
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
