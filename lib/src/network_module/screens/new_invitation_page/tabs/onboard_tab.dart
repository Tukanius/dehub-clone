import 'package:dehub/api/business_api.dart';
import 'package:dehub/models/business_network.dart';
import 'package:dehub/models/general.dart';
import 'package:dehub/models/zip_codes.dart';
import 'package:dehub/providers/general_provider.dart';
import 'package:dehub/providers/loading_provider.dart';
import 'package:dehub/utils/validations.dart';
import 'package:dehub/widgets/dialog_manager/colors.dart';
import 'package:flutter/material.dart';
import 'package:dehub/components/field_card/field_card.dart';
import 'package:dehub/widgets/form_textfield.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dehub/widgets/custom_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class OnboardTab extends StatefulWidget {
  const OnboardTab({super.key});

  @override
  State<OnboardTab> createState() => _OnboardTabState();
}

class _OnboardTabState extends State<OnboardTab> {
  List<String> items = ['Хуулийн этгээд', 'Иргэн'];
  List<String> countries = ['Монгол'];
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool isSwitch = false;
  String? type = "Сонгох";
  String? selectedCountry = "Сонгох";
  String? provinceName = "Сонгох";
  String? districtName = "Сонгох";
  String? legalEntityTypeName = "Сонгох";
  String? equityName = "Сонгох";
  String? khorooName = "Сонгох";
  String? provinceCode = '';
  String? equityCode = '';
  String? legalEntityTypeCode = '';
  String? districtCode = '';
  String? khorooCode = '';
  General general = General();
  bool khorooValidate = false;
  bool equityValidate = false;
  bool legalEntityValidate = false;
  bool districtValidate = false;
  bool provinceValidate = false;
  bool countryValidate = false;
  bool typeValidate = false;
  List<ZipCodes> provinces = [];
  List<ZipCodes> districts = [];
  List<ZipCodes> khoroos = [];
  var legalKey = GlobalKey();
  var khorooKey = GlobalKey();
  var equityKey = GlobalKey();
  var typeKey = GlobalKey();
  var districtkey = GlobalKey();
  var provinceKey = GlobalKey();
  var countryKey = GlobalKey();

  validateCheck() {
    if (khorooName == "Сонгох") {
      Scrollable.ensureVisible(
        khorooKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() {
        khorooValidate = true;
      });
    }
    if (districtName == "Сонгох") {
      Scrollable.ensureVisible(
        districtkey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() {
        districtValidate = true;
      });
    }
    if (provinceName == "Сонгох") {
      Scrollable.ensureVisible(
        provinceKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() {
        provinceValidate = true;
      });
    }
    if (equityName == "Сонгох") {
      Scrollable.ensureVisible(
        equityKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() {
        equityValidate = true;
      });
    }
    if (selectedCountry == "Сонгох") {
      Scrollable.ensureVisible(
        countryKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() {
        countryValidate = true;
      });
    }
    if (legalEntityTypeName == "Сонгох") {
      Scrollable.ensureVisible(
        legalKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() {
        legalEntityValidate = true;
      });
    }
    if (type == "Сонгох") {
      Scrollable.ensureVisible(
        typeKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() {
        typeValidate = true;
      });
    }
    if (formKey.currentState!.saveAndValidate() &&
        typeValidate == false &&
        countryValidate == false &&
        provinceValidate == false &&
        districtValidate == false &&
        legalEntityValidate == false &&
        equityValidate == false &&
        khorooValidate == false) {
      onSubmit();
    }
  }

  onSubmit() async {
    final loading = Provider.of<LoadingProvider>(context, listen: false);
    try {
      BusinessNetwork data =
          BusinessNetwork.fromJson(formKey.currentState!.value);
      data.type = type == "Иргэн" ? "CITIZEN" : "COMPANY";
      data.legalEntityType = legalEntityTypeCode;
      data.country = selectedCountry;
      data.district = districtCode;
      data.equityType = equityCode;
      data.province = provinceCode;
      data.khoroo = khorooCode;
      data.locationLat = 90.45;
      data.locationLng = 45.45;
      loading.loading(true);
      await BusinessApi().createOnboard(data);
      loading.loading(false);
    } catch (e) {
      loading.loading(false);
    }
  }

  getProvince() {
    provinces =
        general.zipCodes!.where((element) => element.parent == "0").toList();
    return provinces;
  }

  getDistrict() {
    districts = general.zipCodes!
        .where((element) => element.parent == provinceCode)
        .toList();
    return districts;
  }

  getKhoroo() {
    khoroos = general.zipCodes!
        .where((element) => element.parent == districtCode)
        .toList();
    return khoroos;
  }

  @override
  void initState() {
    descriptionController.text =
        'Сайн байна уу, Тантай DeHUB бизнесийн сүлжээнд холбогдож, хамтран ажиллах хүсэлтэй байна.';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    general =
        Provider.of<GeneralProvider>(context, listen: true).businessGeneral;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Үндсэн мэдээлэл',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FieldCard(
                fbKey: typeKey,
                paddingHorizontal: 15,
                paddingVertical: 15,
                color: white,
                labelText: "Төрөл",
                secondText: type,
                secondTextColor: networkColor,
                arrowColor: grey2,
                onClick: () {
                  show();
                },
              ),
              if (typeValidate == true)
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 8),
                  child: const Text(
                    'Заавал оруулна',
                    style: TextStyle(
                      color: red,
                      fontSize: 12,
                    ),
                  ),
                ),
              FormTextField(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                inputType: TextInputType.number,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "regNumber",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('ТТД'),
                      Text(
                        '*',
                        style: TextStyle(color: red),
                      ),
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  (value) {
                    return validateRegNumber(value.toString(), context);
                  }
                ]),
              ),
              FormTextField(
                inputType: TextInputType.text,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "businessName",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('А.а.нэгжийн нэр'),
                      Text(
                        '*',
                        style: TextStyle(color: red),
                      )
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  (value) {
                    return validateCryllic(value.toString(), context);
                  }
                ]),
              ),
              FormTextField(
                inputType: TextInputType.text,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "businessNameEng",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('А.а.нэгжийн нэр/Латин/'),
                      Text(
                        '*',
                        style: TextStyle(color: red),
                      )
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Заавал оруулна'),
                ]),
              ),
              FieldCard(
                fbKey: legalKey,
                paddingHorizontal: 15,
                paddingVertical: 15,
                color: white,
                labelText: "А.а.нэгжийн хэлбэр",
                secondText: legalEntityTypeName,
                secondTextColor: networkColor,
                arrowColor: grey2,
                onClick: () {
                  legalEntityType();
                },
              ),
              if (legalEntityValidate == true)
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 8),
                  child: const Text(
                    'Заавал оруулна',
                    style: TextStyle(
                      color: red,
                      fontSize: 12,
                    ),
                  ),
                ),
              FieldCard(
                fbKey: countryKey,
                paddingHorizontal: 15,
                paddingVertical: 15,
                color: white,
                labelText: "Улсын харъяалал",
                secondText: selectedCountry,
                secondTextColor: networkColor,
                arrowColor: grey2,
                onClick: () {
                  country();
                },
              ),
              if (countryValidate == true)
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 8),
                  child: const Text(
                    'Заавал оруулна',
                    style: TextStyle(
                      color: red,
                      fontSize: 12,
                    ),
                  ),
                ),
              FieldCard(
                fbKey: equityKey,
                paddingHorizontal: 15,
                paddingVertical: 15,
                color: white,
                labelText: "Өмчийн хэлбэр",
                secondText: equityName,
                secondTextColor: networkColor,
                arrowColor: grey2,
                onClick: () {
                  equityType();
                },
              ),
              if (equityValidate == true)
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 8),
                  child: const Text(
                    'Заавал оруулна',
                    style: TextStyle(
                      color: red,
                      fontSize: 12,
                    ),
                  ),
                ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Хаягийн мэдээлэл',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FieldCard(
                fbKey: provinceKey,
                paddingHorizontal: 15,
                paddingVertical: 15,
                color: white,
                labelText: "Аймаг/Нийслэл",
                secondText: provinceName,
                secondTextColor: networkColor,
                arrowColor: grey2,
                onClick: () {
                  getProvince();
                  province();
                },
              ),
              if (provinceValidate == true)
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 8),
                  child: const Text(
                    'Заавал оруулна',
                    style: TextStyle(
                      color: red,
                      fontSize: 12,
                    ),
                  ),
                ),
              FieldCard(
                fbKey: districtkey,
                paddingHorizontal: 15,
                paddingVertical: 15,
                color: white,
                labelText: "Дүүрэг/Сум",
                secondText: districtName,
                secondTextColor: networkColor,
                arrowColor: grey2,
                onClick: () {
                  getDistrict();
                  district();
                },
              ),
              if (districtValidate == true)
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 8),
                  child: const Text(
                    'Заавал оруулна',
                    style: TextStyle(
                      color: red,
                      fontSize: 12,
                    ),
                  ),
                ),
              FieldCard(
                fbKey: khorooKey,
                paddingHorizontal: 15,
                paddingVertical: 15,
                color: white,
                labelText: "Хороо/Баг",
                secondText: khorooName,
                secondTextColor: networkColor,
                arrowColor: grey2,
                onClick: () {
                  getKhoroo();
                  khoroo();
                },
              ),
              if (khorooValidate == true)
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 8),
                  child: const Text(
                    'Заавал оруулна',
                    style: TextStyle(
                      color: red,
                      fontSize: 12,
                    ),
                  ),
                ),
              FormTextField(
                inputType: TextInputType.text,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "khoroolol",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('Хороолол'),
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Заавал оруулна'),
                ]),
              ),
              FormTextField(
                inputType: TextInputType.text,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "khotkhonBair",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('Хотхон байр'),
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Заавал оруулна'),
                ]),
              ),
              FormTextField(
                inputType: TextInputType.text,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "khashaaDavkhar",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('Хашаа давхар'),
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Заавал оруулна'),
                ]),
              ),
              FormTextField(
                inputType: TextInputType.text,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "khaalgaDugaar",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('Хаалга дугаар'),
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Заавал оруулна'),
                ]),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Байршлын мэдээлэл',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: const Image(
                  image: AssetImage('images/map.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Уртраг',
                      style: TextStyle(color: dark),
                    ),
                    Text(
                      '90.23',
                      style: TextStyle(color: networkColor),
                    )
                  ],
                ),
              ),
              Container(
                color: white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Өргөрөг',
                      style: TextStyle(color: dark),
                    ),
                    Text(
                      '45.52',
                      style: TextStyle(color: networkColor),
                    )
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Урилга авах хүн',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FormTextField(
                inputType: TextInputType.text,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "firstName",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('Урилга авах хүний нэр'),
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  (value) {
                    return validateCryllic(value.toString(), context);
                  },
                ]),
              ),
              FormTextField(
                inputType: TextInputType.number,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "userPhone",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('Утасны дугаар №1'),
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  (value) {
                    return validatePhone(value.toString(), context);
                  }
                ]),
              ),
              FormTextField(
                inputType: TextInputType.emailAddress,
                textColor: networkColor,
                textAlign: TextAlign.end,
                name: "userEmail",
                decoration: const InputDecoration(
                  hintText: 'Энд оруулна уу',
                  hintStyle: TextStyle(color: networkColor),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('И-мэйл хаяг №1'),
                    ],
                  ),
                  fillColor: white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  (value) {
                    return validateEmail(value.toString(), context);
                  }
                ]),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: const Text(
                  'Урилгын тайлбар',
                  style: TextStyle(
                    color: grey3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                color: white,
                padding: const EdgeInsets.all(15),
                child: FormTextField(
                  controller: descriptionController,
                  textAlign: TextAlign.left,
                  name: 'toMessage',
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: grey),
                    ),
                    fillColor: white,
                    filled: true,
                    hintStyle: TextStyle(
                      color: grey2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 2.5),
                      child: CustomButton(
                        borderColor: networkColor,
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                        labelColor: backgroundColor,
                        labelText: 'Буцах',
                        textColor: networkColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, left: 2.5),
                      child: CustomButton(
                        onClick: () {
                          validateCheck();
                        },
                        labelColor: networkColor,
                        labelText: 'Илгээх',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  show() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                alignment: Alignment.center,
                child: const Text(
                  'Төрөл сонгох',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: items
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            type = e;
                            typeValidate = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          color: transparent,
                          margin: const EdgeInsets.only(left: 15, bottom: 10),
                          child: Text(e),
                        ),
                      ),
                    )
                    .toList(),
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

  country() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                alignment: Alignment.center,
                child: const Text(
                  'Төрөл сонгох',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: countries
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCountry = e;
                            countryValidate = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          color: transparent,
                          margin: const EdgeInsets.only(left: 15, bottom: 10),
                          child: Text(e),
                        ),
                      ),
                    )
                    .toList(),
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

  province() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                alignment: Alignment.center,
                child: const Text(
                  'Аймаг/Нийслэл',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: provinces
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            provinceName = e.name;
                            provinceCode = e.code;
                            provinceValidate = false;
                            districtName = "Сонгох";
                            khorooName = 'Сонгох';
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            color: transparent,
                            margin: const EdgeInsets.only(left: 15, bottom: 10),
                            child: Text('${e.name}')),
                      ),
                    )
                    .toList(),
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

  legalEntityType() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                alignment: Alignment.center,
                child: const Text(
                  'Аж ахуй нэгжийн хэлбэр',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: general.legalEntityTypes!
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            legalEntityTypeName = e.name;
                            legalEntityTypeCode = e.code;
                            legalEntityValidate = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            color: transparent,
                            margin: const EdgeInsets.only(left: 15, bottom: 10),
                            child: Text('${e.name}')),
                      ),
                    )
                    .toList(),
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

  equityType() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                alignment: Alignment.center,
                child: const Text(
                  'Өмчийн хэлбэр',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: general.equityTypes!
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            equityName = e.name;
                            equityCode = e.code;
                            equityValidate = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            color: transparent,
                            margin: const EdgeInsets.only(left: 15, bottom: 10),
                            child: Text('${e.name}')),
                      ),
                    )
                    .toList(),
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

  district() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                alignment: Alignment.center,
                child: const Text(
                  'Сум/Дүүрэг',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: districts
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            districtCode = e.code;
                            districtName = e.name;
                            khorooName = 'Сонгох';
                            districtValidate = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            color: transparent,
                            margin: const EdgeInsets.only(left: 15, bottom: 10),
                            child: Text('${e.name}')),
                      ),
                    )
                    .toList(),
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

  khoroo() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: white,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                alignment: Alignment.center,
                child: const Text(
                  'Хороо/Баг',
                  style: TextStyle(
                    color: grey2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: khoroos
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            khorooName = e.name;
                            khorooCode = e.code;
                            khorooValidate = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            color: transparent,
                            margin: const EdgeInsets.only(left: 15, bottom: 10),
                            child: Text('${e.name}')),
                      ),
                    )
                    .toList(),
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

String? validateRegNumber(String value, context) {
  RegExp regex = RegExp(r'^\d{7}$');
  if (value.isEmpty) {
    return "Регистерийн дугаар оруулна уу";
  } else {
    if (!regex.hasMatch(value)) {
      return "Регистерийн дугаар буруу байна";
    } else {
      return null;
    }
  }
}
