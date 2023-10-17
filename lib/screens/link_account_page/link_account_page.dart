import 'package:dehub/api/payment_api.dart';
import 'package:dehub/components/show_success_dialog/show_success_dialog.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/payment.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LinkAccountPage extends StatefulWidget {
  static const routeName = "/linkaccountpage";
  const LinkAccountPage({Key? key}) : super(key: key);

  @override
  _LinkAccountPageState createState() => _LinkAccountPageState();
}

class _LinkAccountPageState extends State<LinkAccountPage> {
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

  checkValidate() {
    if (bankName == "Банк сонгох") {
      setState(() {
        bankValidate = true;
      });
    }
  }

  checkAccount() async {
    check = await PaymentApi().bankAccountCheck(
      Payment(
        bankName: "${bankCode}",
        number: '${numberController.text}',
      ),
    );
  }

  onSubmit() async {
    if (fbKey.currentState!.saveAndValidate()) {
      try {
        await PaymentApi().addBankAccount(
          Payment(
            bankName: bankCode,
            number: numberController.text,
            shortName: shortNameController.text,
            isDefault: isSwitched,
          ),
        );
        showCustomDialog(
          context,
          "Данс амжилттай нэмлээ",
          true,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      setState(() {
        bankValidate = true;
      });
    }
  }

  bankModal() {
    showModalBottomSheet(
      backgroundColor: white,
      context: context,
      shape: RoundedRectangleBorder(
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
                child: Text(
                  "БАНК СОНГОХ",
                  style: TextStyle(
                    color: grey2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: general.bankNames!
                    .map(
                      (data) => GestureDetector(
                        onTap: () {
                          setState(() {
                            bankName = data.name!;
                            bankCode = data.code!;
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
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${data.icon}',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('${data.name}'),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: false).paymentGeneral;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: paymentColor,
          ),
        ),
        title: Text(
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
                child: Text(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Банкны нэр',
                        style: TextStyle(
                          color: grey2,
                        ),
                      ),
                      Text(
                        '${bankName}',
                        style: TextStyle(
                          color: paymentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bankValidate == true
                  ? Container(
                      margin: const EdgeInsets.only(left: 15, top: 8),
                      child: Text(
                        'Заавал сонгоно',
                        style: TextStyle(
                          color: red,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : SizedBox(),
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
                          child: Text(
                            'Дансны дугаар',
                            style: TextStyle(color: grey2),
                          ),
                        ),
                        hintStyle: TextStyle(color: paymentColor),
                        hintText: 'Энд оруулна уу',
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        border: OutlineInputBorder(
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
                          Text(
                            'Дансны нэр',
                            style: TextStyle(
                              color: grey2,
                            ),
                          ),
                          Text(
                            '${accountName}',
                            style: TextStyle(
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
                          child: Text(
                            'Богино нэр',
                            style: TextStyle(color: grey2),
                          ),
                        ),
                        hintStyle: TextStyle(color: paymentColor),
                        hintText: 'Энд оруулна уу',
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        border: OutlineInputBorder(
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
                    Text(
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
              SizedBox(
                height: 20,
              ),
              Text(
                'Та буруу дансанд орлого авахаас сэргийлэн оруулсан мэдээллээ сайтар шалгана уу. Буруу данс сонгосоноос үүсэх алдаанд DeHUB платформ хариуцлага хүлээхгүйг анхаарна уу!!!',
                style: TextStyle(fontSize: 14, color: grey3),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomButton(
                  labelColor: paymentColor,
                  labelText: 'Мэдээлэл зөв. Холбоё',
                  onClick: () {
                    // checkValidate();
                    onSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
