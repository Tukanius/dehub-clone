import 'package:dehub/api/auth_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/ChangePassword';
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isVisible = true;
  bool isVisible1 = true;
  bool isVisible2 = true;
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  User user = User();

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      user = User.fromJson(fbKey.currentState!.value);
      await AuthApi().createPassword(user);
      showCustomDialog(
        context,
        "Нууц үг амилттай солигдлоо",
        true,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: buttonColor),
        centerTitle: true,
        title: Text(
          'Нууц үг солих',
          style: TextStyle(
            color: buttonColor,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FormBuilder(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                FormBuilder(
                  key: fbKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Хуучин нууц үг',
                        style: TextStyle(
                          color: buttonColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FormTextField(
                        onComplete: () {
                          FocusScope.of(context).nextFocus();
                          FocusScope.of(context).nextFocus();
                        },
                        name: "oldPassword",
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
                                ? Icon(
                                    Icons.visibility_off,
                                    color: buttonColor,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: buttonColor,
                                  ),
                          ),
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
                          (value) {
                            return validatePassword(value.toString(), context);
                          }
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                        onComplete: () {
                          FocusScope.of(context).nextFocus();
                          FocusScope.of(context).nextFocus();
                        },
                        name: "password",
                        inputType: TextInputType.text,
                        obscureText: isVisible1,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible1 = !isVisible1;
                              });
                            },
                            icon: isVisible1 == true
                                ? Icon(
                                    Icons.visibility_off,
                                    color: buttonColor,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: buttonColor,
                                  ),
                          ),
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
                        onComplete: () {
                          onSubmit();
                        },
                        obscureText: isVisible2,
                        name: "passwordVerify",
                        inputType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible2 = !isVisible2;
                              });
                            },
                            icon: isVisible2 == true
                                ? Icon(
                                    Icons.visibility_off,
                                    color: buttonColor,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: buttonColor,
                                  ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Нууц үг давтан оруулна уу",
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
                    onSubmit();
                  },
                  labelColor: buttonColor,
                  labelText: 'Нууц үг солих',
                  textColor: white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validatePassword(String value, context) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value.isEmpty) {
    return 'Нууц үгээ оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Нууц үг багадаа 1 том үсэг 1 тэмдэгт авна';
    } else {
      return null;
    }
  }
}
