import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/models/user.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/providers/user_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkAccountPage extends StatefulWidget {
  static const routeName = "/LinkAccountPage";
  const LinkAccountPage({super.key});

  @override
  LinkAccountPageState createState() => LinkAccountPageState();
}

class LinkAccountPageState extends State<LinkAccountPage> {
  bool isSwitched = false;
  bool bankValidate = false;
  TextEditingController numberController = TextEditingController();
  TextEditingController shortNameController = TextEditingController();
  GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  Payment check = Payment();
  String bankName = 'Банк сонгох';
  String? bankCode;
  bool numberValidate = false;
  bool shortnameValidate = false;
  String? accountName = "Дансны нэр авто гарна";
  General general = General();
  User user = User();

  checkValidate() {
    if (bankName == "Банк сонгох") {
      setState(() {
        bankValidate = true;
      });
    }
    if (bankValidate == false) {
      onSubmit();
    }
  }

  checkAccount() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      loading.loading(true);
      var res = await PaymentApi().bankAccountCheck(
        Payment(
          bankName: "$bankCode",
          number: numberController.text,
        ),
      );
      loading.loading(false);
      setState(() {
        check = res;
      });
      if (check.url != null) {
        launchUrl(check.url!);
      }
    } catch (e) {
      loading.loading(false);
    }
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        loading.loading(true);
        await PaymentApi().addBankAccount(
          Payment(
            bankName: bankCode,
            number: numberController.text,
            shortName: shortNameController.text,
            isDefault: isSwitched,
          ),
        );
        await Provider.of<GeneralProvider>(context, listen: false)
            .businessInit(false);
        loading.loading(false);
        showCustomDialog(
          context,
          "Данс амжилттай нэмлээ",
          true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      } catch (e) {
        loading.loading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).paymentMe;
    general =
        Provider.of<GeneralProvider>(context, listen: false).paymentGeneral;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          iconTheme: const IconThemeData(color: paymentColor),
          title: const Text(
            'Данс холбох',
            style: TextStyle(
              color: paymentColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text(
                    'Дансны мэдээлэл',
                    style: TextStyle(
                      color: dark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    bankModal();
                  },
                  child: Container(
                    color: white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Банкны нэр',
                          style: TextStyle(
                            color: grey2,
                          ),
                        ),
                        Text(
                          bankName,
                          style: const TextStyle(
                            color: paymentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (bankValidate == true)
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 8),
                    child: const Text(
                      'Заавал сонгоно',
                      style: TextStyle(
                        color: red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                FormBuilder(
                  key: fbKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormTextField(
                        maxLenght: 10,
                        showCounter: false,
                        controller: numberController,
                        inputType: TextInputType.number,
                        textColor: paymentColor,
                        name: 'number',
                        onChanged: (value) {
                          setState(() {
                            check = Payment();
                          });
                          if (value != "") {
                            setState(() {
                              numberValidate = false;
                            });
                          } else {
                            setState(() {
                              numberValidate = true;
                            });
                          }
                          if (numberController.text.length == 10) {
                            checkAccount();
                          }
                        },
                        readOnly: bankName == "Банк сонгох",
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: const Text(
                              'Дансны дугаар',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          hintStyle: const TextStyle(color: paymentColor),
                          hintText: 'Энд оруулна уу',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          fillColor: white,
                          filled: true,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна'),
                        ]),
                      ),
                      Container(
                        color: white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Дансны нэр',
                              style: TextStyle(
                                color: grey2,
                              ),
                            ),
                            Text(
                              check.accountName != null
                                  ? "${check.accountName}"
                                  : 'Дансны нэр',
                              style: const TextStyle(
                                color: grey2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FormTextField(
                        controller: shortNameController,
                        textColor: paymentColor,
                        name: 'shortName',
                        onChanged: (value) {
                          if (value != "") {
                            setState(() {
                              shortnameValidate = false;
                            });
                          } else {
                            setState(() {
                              shortnameValidate = true;
                            });
                          }
                        },
                        readOnly: bankName == "Банк сонгох",
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: const Text(
                              'Богино нэр',
                              style: TextStyle(color: grey2),
                            ),
                          ),
                          hintStyle: const TextStyle(color: paymentColor),
                          hintText: 'Энд оруулна уу',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          fillColor: white,
                          filled: true,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Заавал оруулна'),
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Үндсэн данс болгох',
                        style: TextStyle(fontSize: 14, color: grey2),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          activeColor: paymentColor,
                          value: isSwitched,
                          onChanged: (bool value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Та буруу дансанд орлого авахаас сэргийлэн оруулсан мэдээллээ сайтар шалгана уу. Буруу данс сонгосоноос үүсэх алдаанд DeHUB платформ хариуцлага хүлээхгүйг анхаарна уу!!!',
                  style: TextStyle(fontSize: 14, color: grey3),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomButton(
                    labelColor: paymentColor,
                    labelText: 'Мэдээлэл зөв. Холбоё',
                    onClick: () {
                      checkValidate();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bankModal() {
    showModalBottomSheet(
      backgroundColor: white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: const Text(
                  "БАНК СОНГОХ",
                  style: TextStyle(
                    color: grey2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    bankName = 'Голомт банк';
                    bankCode = 'GOLOMT';
                    bankValidate = false;
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  color: white,
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://play-lh.googleusercontent.com/9tUBesUsI4UIkpgO1MPIMLFvhDa_4vZE75TrVAUHFA7a0bJ7IIgeyh2r1QXs9VlmXmkX',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Голомт банк'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
