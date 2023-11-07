import 'package:dehub/api/partner_api.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/screens/otp_page/otp_page.dart';
import 'package:dehub/utils/is_device_size.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:dehub/widgets/register-number/letter.dart';
import 'package:dehub/widgets/register-number/letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/RegisterPage';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  TextEditingController regnumController = TextEditingController();
  bool isCheck = true;
  bool isCheck1 = false;
  User user = User();
  User otpverify = User();
  String registerNo = "";
  List<String> letters = [
    CYRILLIC_ALPHABETS_LIST[0],
    CYRILLIC_ALPHABETS_LIST[0]
  ];

  void onChangeLetter(String item, index) {
    Navigator.pop(context);

    setState(() {
      letters[index] = item;
    });
  }

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        user = User.fromJson(fbKey.currentState!.value);
        user.type = isCheck == true ? "COMPANY" : "CITIZEN";
        user.regNumber = isCheck1 == true
            ? "${letters.join()}${regnumController.text}"
            : fbKey.currentState?.fields['regNumber']?.value;
        otpverify = await PartnerApi().register(user);
        await Navigator.of(context).pushNamed(OtpVerifyPage.routeName,
            arguments: OtpVerifyPageArguments(
              verifyId: otpverify.verifyId!,
              email: user.email!,
              phone: user.phone!,
            ));
      } catch (e) {
        debugPrint(e.toString());
        debugPrint('======error======');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 150,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_back_ios_new,
                color: buttonColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Буцах',
                style: TextStyle(
                  color: buttonColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Партнераар бүртгүүлэх',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Бүртгүүлэх төрөл сонгоно уу.',
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: buttonColor,
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => buttonColor),
                        value: isCheck,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isCheck = newValue!;
                            isCheck1 = isCheck == true ? false : true;
                          });
                        },
                      ),
                      Text(
                        'Хуулийн этгээд',
                        style: TextStyle(
                          color: buttonColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: buttonColor,
                        fillColor: MaterialStateProperty.resolveWith(
                            (states) => buttonColor),
                        value: isCheck1,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isCheck1 = newValue!;
                            isCheck = isCheck1 == true ? false : true;
                          });
                        },
                      ),
                      Text(
                        'Хувь хүн',
                        style: TextStyle(
                          color: buttonColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              isCheck == true
                  ? Text(
                      'Татвар төлөгчийн дугаар',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Text(
                      'Регистерийн дугаар',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              SizedBox(
                height: 5,
              ),
              FormBuilder(
                key: fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isCheck1 == true
                        ? Row(
                            children: [
                              RegisterLetters(
                                width: DeviceSize.width(3, context),
                                height: DeviceSize.height(90, context),
                                oneTitle: "Регистер сонгох",
                                hideOnPressed: false,
                                title: letters[0],
                                backgroundColor: white,
                                textColor: black,
                                length: CYRILLIC_ALPHABETS_LIST.length,
                                itemBuilder: (ctx, i) => RegisterLetter(
                                  radius: Radius.circular(3),
                                  color: white,
                                  text: CYRILLIC_ALPHABETS_LIST[i],
                                  onPressed: () {
                                    onChangeLetter(
                                        CYRILLIC_ALPHABETS_LIST[i], 0);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              RegisterLetters(
                                width: DeviceSize.width(3, context),
                                height: DeviceSize.height(90, context),
                                title: letters[1],
                                oneTitle: "Регистер сонгох",
                                hideOnPressed: false,
                                backgroundColor: white,
                                textColor: black,
                                length: CYRILLIC_ALPHABETS_LIST.length,
                                itemBuilder: (ctx, i) => RegisterLetter(
                                  radius: Radius.circular(3),
                                  color: white,
                                  text: CYRILLIC_ALPHABETS_LIST[i],
                                  onPressed: () {
                                    onChangeLetter(
                                        CYRILLIC_ALPHABETS_LIST[i], 1);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: FormTextField(
                                  textColor: black,
                                  onChanged: (value) {
                                    setState(() {
                                      registerNo = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Регистер №',
                                    fillColor: white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xff44566C30),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: red),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  controller: regnumController,
                                  inputType: TextInputType.number,
                                  name: 'registerNumber',
                                  hintText: 'Регистерийн дугаар',
                                  color: transparent,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          )
                        : FormTextField(
                            textColor: buttonColor,
                            name: "regNumber",
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: buttonColor,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "ТТД буюу регистрийн дугаар",
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
                                errorText: 'Татвар төлөгчийн дугаар оруулна уу',
                              ),
                            ]),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Аж ахуйн нэгжийн нэр',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FormTextField(
                      textColor: buttonColor,
                      name: "businessName",
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Аж ахуйн нэгжийн нэр",
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
                      validator: FormBuilderValidators.compose(
                        [
                          (value) {
                            return validateName(value.toString(), context);
                          }
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Таны нэр',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FormTextField(
                      textColor: buttonColor,
                      name: "firstName",
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Өөрийн нэр",
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
                          return validateName(value.toString(), context);
                        }
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Таны и-мэйл',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FormTextField(
                      name: "email",
                      inputType: TextInputType.text,
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Таны гар утас',
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FormTextField(
                      name: "phone",
                      inputType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Гар утасны дугаар",
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
                          return validatePhone(value.toString(), context);
                        }
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                onClick: () {
                  onSubmit();
                },
                labelColor: buttonColor,
                labelText: "Бүртгүүлэх",
                textColor: white,
              ),
              SizedBox(
                height: 50,
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

String? validateName(String name, BuildContext context) {
  RegExp isValidName = RegExp(r'(^[а-яА-ЯӨөҮүЁёӨө -]+$)');
  if (name.isEmpty) {
    return "Нэр оруулна уу";
  } else {
    if (!isValidName.hasMatch(name)) {
      return "Зөвхөн крилл үсэг ашиглана";
    } else {
      return null;
    }
  }
}

String? validatePhone(String value, context) {
  RegExp regex = RegExp(r'[(9|8]{1}[0-9]{7}$');
  if (value.isEmpty) {
    return 'Утасны дугаараа оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Утасны дугаараа шалгана уу';
    } else {
      return null;
    }
  }
}
