import 'package:dehub/models/user.dart';
import 'package:dehub/providers/finance_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/src/auth/otp_page/otp_page.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class PasswordRecoveryArguments {
  Color color;
  PasswordRecoveryArguments({
    required this.color,
  });
}

class PasswordRecovery extends StatefulWidget {
  static const routeName = '/PasswordRecovery';
  final Color color;
  const PasswordRecovery({
    super.key,
    required this.color,
  });

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();

  onSubmit() async {
    final source = Provider.of<FinanceProvider>(context, listen: false);
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        User data = User.fromJson(fbkey.currentState!.value);
        if (widget.color != buttonColor) {
          loading.loading(true);
          await Provider.of<UserProvider>(context, listen: false)
              .financeForgot(data, source.url);
          loading.loading(false);
          await Navigator.of(context).pushNamed(
            OtpVerifyPage.routeName,
            arguments: OtpVerifyPageArguments(
              phone: '',
              email: fbkey.currentState!.fields['email']!.value,
              verifyId: 'FINANCE',
            ),
          );
        } else {
          loading.loading(true);
          await Provider.of<UserProvider>(context, listen: false).forgot(data);
          loading.loading(false);
          await Navigator.of(context).pushNamed(
            OtpVerifyPage.routeName,
            arguments: OtpVerifyPageArguments(
              phone: '',
              email: fbkey.currentState!.fields['email']!.value,
              verifyId: 'CORE',
            ),
          );
        }
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(
            'Нууц үг сэргээх',
            style: TextStyle(
              color: widget.color,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: IconThemeData(color: widget.color),
          backgroundColor: white,
          surfaceTintColor: white,
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: fbkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Хэрэглэгчийн нэр'),
                  ),
                  FormTextField(
                    textColor: grey2,
                    name: 'username',
                    decoration: InputDecoration(
                      hintText: 'Энд оруулна уу',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: white,
                      filled: true,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Заавал оруулна',
                      ),
                    ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text('Хэрэглэгчийн И-мэйл'),
                  ),
                  FormTextField(
                    textColor: grey2,
                    name: 'email',
                    decoration: InputDecoration(
                      hintText: 'Энд оруулна уу',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey2.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      isDense: true,
                      fillColor: white,
                      filled: true,
                    ),
                    validator: FormBuilderValidators.compose([
                      (value) => validateEmail(value.toString(), context),
                    ]),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  CustomButton(
                    onClick: onSubmit,
                    labelColor: widget.color,
                    labelText: "Нууц үг сэргээх",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      'Таны и-мэйл хаягт нууц үг сэргээх линк очно.',
                      style: TextStyle(
                        color: grey2,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
